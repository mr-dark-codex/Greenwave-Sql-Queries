-- Calculate sectionwise energy consumption - month, year, equipment, energy, energy_app, pf
with
    ft(DateAndTime, Millitm, TagIndex, Val, Status, Marker)
    as
    (
        select *
        from [SupriyoDB].[dbo].[FloatTable_test]
        where
		month(DateAndTime)=12 and year(DateAndTime)=2020
    ),
    merged([Month], [Year], TagName, TagIndex, Val, Diff)
    as
    (
        select
            month(ft.DateAndTime),
            year(ft.DateAndTime),
            TagName,
            tt.TagIndex,
            Val,
            coalesce(Val,0.0)-lag(coalesce(Val,0.0)) over (partition by TagName order by DateAndTime)
        from
            [SupriyoDB].[dbo].[TagTable] tt left join ft on tt.TagIndex=ft.TagIndex
        where
		(TagName like '%\Energy%' or TagName like '%PF') and Val>0
    ),
    formatted([Month], [Year], TagIndex, [EquipAndTag], Val, Diff)
    as
    (
        select coalesce([Month],12), coalesce([Year],2020),
            TagIndex,
            substring(TagName,len(TagName)-charindex('\',reverse(TagName),charindex('\',reverse(TagName))+1)+2,len(TagName)),
            Val, Diff
        from
            merged
    ),
    energyTotal([Month], [Year], [Tag], [Equipment], [Total])
    as
    (
        select [Month], [Year],
            substring(EquipAndTag,charindex('\',EquipAndTag)+1,len(EquipAndTag)),
            substring(EquipAndTag,0,charindex('\',EquipAndTag)),
            sum(diff)
        from formatted
        group by [Month],[Year],[EquipAndTag]
    ),
    averages([Month], [Year], [Tag], [Equipment], [Avg])
    as
    (
        select [Month], [Year],
            substring(EquipAndTag,charindex('\',EquipAndTag)+1,len(EquipAndTag)),
            substring(EquipAndTag,0,charindex('\',EquipAndTag)),
            avg([Val])
        from formatted
        group by [Month],[Year],[EquipAndTag]
    )

select pt.[Month], pt.[Year], pt.[Equipment], [Energy] AS EnergyConsumption, [Energy_App] as AverageEnergyApp, [PF] as AveragePF
from energyTotal
pivot(
	sum(Total)
	for Tag In (Energy)
) as pt
    left join
    averages pivot(
	avg([Avg])
	for Tag In (Energy_App,PF)
) as ps on pt.Equipment=ps.Equipment