-- chunkname: @IQIGame\\Config\\CfgPureExhibitionActivitiesGlobalTable.lua

local CfgPureExhibitionActivitiesGlobalTable = {
	{
		Id = 1,
		BackGround = "/UI/_DailyActivityUI/SpringScavengerHunt_220331.prefab",
		Name = getI18NValue(180268098),
		Desc = getI18NValue(180268095),
		World1 = getI18NValue(180268097),
		World2 = getI18NValue(180268096)
	},
	{
		Id = 2,
		BackGround = "/UI/_DailyActivityUI/SpringScavengerHunt_220519.prefab",
		Name = getI18NValue(180283638),
		Desc = getI18NValue(180283635),
		World1 = getI18NValue(180283637),
		World2 = getI18NValue(180283636)
	},
	{
		Id = 3,
		BackGround = "/UI/_DailyActivityUI/SpringScavengerHunt_230210.prefab",
		Name = getI18NValue(180500235),
		Desc = getI18NValue(180500232),
		World1 = getI18NValue(180500234),
		World2 = getI18NValue(180500233)
	},
	{
		Id = 4,
		BackGround = "/UI/_DailyActivityUI/SpringScavengerHunt_230330.prefab",
		Name = getI18NValue(180514138),
		Desc = getI18NValue(180514135),
		World1 = getI18NValue(180514137),
		World2 = getI18NValue(180514136)
	}
}

setmetatable(CfgPureExhibitionActivitiesGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPureExhibitionActivitiesGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		World2 = "",
		Name = "",
		World1 = "",
		BackGround = "",
		Desc = ""
	}
}

for i, data in pairs(CfgPureExhibitionActivitiesGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPureExhibitionActivitiesGlobalTable
