-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_manager_const.lua

module("logic.config.t_house_manager_const", package.seeall)

local title = {
	floatValue = 3,
	key = 1,
	numValues = 5,
	strValue = 4,
	numValue = 2
}
local dataList = {
	{
		"ProductivityNeed",
		3000,
		0,
		""
	},
	{
		"ZoneUnlockOrder",
		0,
		0,
		"",
		{
			1201,
			1202,
			1204,
			1205,
			1206,
			1208,
			1209,
			1210,
			1212,
			1301,
			1302,
			1303,
			1304,
			1305,
			1306,
			1307,
			1308,
			1309,
			1310,
			1311,
			1312,
			1313,
			1314,
			1315,
			1316,
			1317,
			1318,
			1101,
			1102,
			1103,
			1104,
			1105,
			1106,
			1401,
			1402,
			1403,
			1404,
			1405,
			1406,
			1407,
			1408
		}
	},
	{
		"CharacterDefaultProduction",
		10,
		0,
		""
	},
	{
		"Product",
		1701001,
		0,
		""
	}
}
local t_house_manager_const = {}

t_house_manager_const.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_house_manager_const[v[1]] = v

	setmetatable(v, mt)
end

return t_house_manager_const
