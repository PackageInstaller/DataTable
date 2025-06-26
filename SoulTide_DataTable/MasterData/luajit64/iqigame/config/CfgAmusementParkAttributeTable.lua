-- chunkname: @IQIGame\\Config\\CfgAmusementParkAttributeTable.lua

local CfgAmusementParkAttributeTable = {
	{
		Group = 1,
		ImageIcon = "/Activity/AmusementPark/AmusementParkComIcon/AmusementPark_Att_01.png",
		MaxAttNum = 60,
		Tpye = 1,
		Id = 1,
		AttName = getI18NValue(180897092)
	},
	{
		Group = 1,
		ImageIcon = "/Activity/AmusementPark/AmusementParkComIcon/AmusementPark_Att_02.png",
		MaxAttNum = 60,
		Tpye = 2,
		Id = 2,
		AttName = getI18NValue(180897093)
	},
	{
		Group = 1,
		ImageIcon = "/Activity/AmusementPark/AmusementParkComIcon/AmusementPark_Att_03.png",
		MaxAttNum = 60,
		Tpye = 3,
		Id = 3,
		AttName = getI18NValue(180897094)
	},
	{
		Group = 1,
		ImageIcon = "/Activity/AmusementPark/AmusementParkComIcon/AmusementPark_Att_04.png",
		Tpye = 4,
		Id = 4,
		AttName = getI18NValue(180897095)
	},
	{
		Group = 1,
		ImageIcon = "/Activity/AmusementPark/AmusementParkComIcon/AmusementPark_Att_05.png",
		Tpye = 5,
		Id = 5,
		AttName = getI18NValue(180897096)
	},
	[7] = {
		Group = 1,
		ImageIcon = "/Activity/AmusementPark/AmusementParkComIcon/AmusementPark_Att_07.png",
		Tpye = 7,
		Id = 7,
		AttName = getI18NValue(180897098)
	},
	[8] = {
		Group = 1,
		ImageIcon = "/Activity/AmusementPark/AmusementParkComIcon/AmusementPark_Att_07.png",
		Tpye = 8,
		Id = 8,
		AttName = getI18NValue(180897099)
	},
	[9] = {
		Group = 1,
		ImageIcon = "/Activity/AmusementPark/AmusementParkComIcon/AmusementPark_Att_07.png",
		Tpye = 9,
		Id = 9,
		AttName = getI18NValue(180897100)
	},
	[10] = {
		Group = 1,
		ImageIcon = "/Activity/AmusementPark/AmusementParkComIcon/AmusementPark_Att_04.png",
		Tpye = 10,
		Id = 10,
		AttName = getI18NValue(180897101)
	},
	[11] = {
		Group = 1,
		ImageIcon = "/Activity/AmusementPark/AmusementParkComIcon/AmusementPark_Att_05.png",
		Tpye = 11,
		Id = 11,
		AttName = getI18NValue(180897102)
	},
	[13] = {
		Group = 1,
		ImageIcon = "/Activity/AmusementPark/AmusementParkComIcon/AmusementPark_Att_07.png",
		Tpye = 13,
		Id = 13,
		AttName = getI18NValue(180897104)
	},
	[14] = {
		Group = 1,
		ImageIcon = "/Activity/AmusementPark/AmusementParkComIcon/AmusementPark_Att_08.png",
		Tpye = 14,
		Id = 14,
		AttName = getI18NValue(180897105)
	}
}

setmetatable(CfgAmusementParkAttributeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgAmusementParkAttributeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		ImageIcon = "",
		AttName = "",
		MaxAttNum = 0,
		Tpye = 0
	}
}

for i, data in pairs(CfgAmusementParkAttributeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgAmusementParkAttributeTable
