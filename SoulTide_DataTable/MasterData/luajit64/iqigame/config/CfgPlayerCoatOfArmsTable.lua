-- chunkname: @IQIGame\\Config\\CfgPlayerCoatOfArmsTable.lua

local CfgPlayerCoatOfArmsTable = {
	{
		Sort = 1,
		Prefab = "/UI/CoatOfArms/CoatOfArms_Default_01.prefab",
		Id = 1,
		Name = getI18NValue(180144582),
		Desc = getI18NValue(180144581)
	},
	{
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_Default_02.prefab",
		Sort = 2,
		Id = 2,
		Name = getI18NValue(180144584)
	},
	{
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_HolidayPack_Xmas_01.prefab",
		Sort = 3,
		Id = 3,
		Name = getI18NValue(180144586),
		Desc = getI18NValue(180258556)
	},
	{
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_Goods_collector.prefab",
		Sort = 4,
		Id = 4,
		Name = getI18NValue(180144588),
		Desc = getI18NValue(180144587)
	},
	{
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_Recruit_New_01.prefab",
		Sort = 5,
		Id = 5,
		Name = getI18NValue(180144590)
	},
	{
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_Recruit_Old_01.prefab",
		Sort = 6,
		Id = 6,
		Name = getI18NValue(180272622)
	},
	{
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_Event_HalfYear_JP_01.prefab",
		Sort = 7,
		Id = 7,
		Name = getI18NValue(180452286)
	},
	[110010] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_Fishing_01.prefab",
		Sort = 110010,
		Id = 110010,
		Name = getI18NValue(180284627)
	},
	[110020] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_Fishing_02.prefab",
		Sort = 110020,
		Id = 110020,
		Name = getI18NValue(180284628)
	},
	[111010] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_DualTeamExplore_01.prefab",
		Sort = 111010,
		Id = 111010,
		Name = getI18NValue(180299116)
	},
	[111020] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_DualTeamExplore2_01.prefab",
		Sort = 111020,
		Id = 111020,
		Name = getI18NValue(180507134)
	},
	[112010] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_Charge_01.prefab",
		Sort = 112010,
		Id = 112010,
		Name = getI18NValue(180440691)
	},
	[113010] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_EndlessPlus_1.prefab",
		Sort = 113010,
		Id = 113010,
		Name = getI18NValue(180498886)
	},
	[113020] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_EndlessPlus_2.prefab",
		Sort = 113020,
		Id = 113020,
		Name = getI18NValue(180498887)
	},
	[113030] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_EndlessPlus_3.prefab",
		Sort = 113030,
		Id = 113030,
		Name = getI18NValue(180498888)
	},
	[113040] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_EndlessPlus_4.prefab",
		Sort = 113040,
		Id = 113040,
		Name = getI18NValue(180498889)
	},
	[113050] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_EndlessPlus_5.prefab",
		Sort = 113050,
		Id = 113050,
		Name = getI18NValue(180498890)
	},
	[113060] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_EndlessPlus_6.prefab",
		Sort = 113060,
		Id = 113060,
		Name = getI18NValue(180498891)
	},
	[114010] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_PrivilegeCard_01.prefab",
		LimitiedDuration = 2592000,
		Id = 114010,
		Sort = 114010,
		Name = getI18NValue(180498892)
	},
	[115010] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_GalGame_S02_01.prefab",
		Sort = 115010,
		Id = 115010,
		Name = getI18NValue(180527426)
	},
	[116010] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_OperateEvent_Other_01.prefab",
		Sort = 116010,
		Id = 116010,
		Name = getI18NValue(180547092)
	},
	[116020] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_OperateEvent_Other_02.prefab",
		Sort = 116020,
		Id = 116020,
		Name = getI18NValue(180825907)
	},
	[116030] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_OperateEvent_Other_03.prefab",
		Sort = 116030,
		Id = 116030,
		Name = getI18NValue(180896197)
	},
	[117010] = {
		IsLock = true,
		Prefab = "/UI/CoatOfArms/CoatOfArms_SurvivalChallenge_01.prefab",
		Sort = 117010,
		Id = 117010,
		Name = getI18NValue(180920140)
	}
}

setmetatable(CfgPlayerCoatOfArmsTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPlayerCoatOfArmsTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Sort = 0,
		Name = "",
		Prefab = "",
		LimitiedDuration = 0,
		IsLock = false,
		Desc = ""
	}
}

for i, data in pairs(CfgPlayerCoatOfArmsTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPlayerCoatOfArmsTable
