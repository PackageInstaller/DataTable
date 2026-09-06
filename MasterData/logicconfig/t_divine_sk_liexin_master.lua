-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_sk_liexin_master.lua

module("logicconfig.config.t_divine_sk_liexin_master", package.seeall)

local title = {
	description = 7,
	video = 8,
	name = 2,
	skipTime = 3,
	perfectWinId = 11,
	formCondition = 12,
	btlMode = 6,
	btlBg = 4,
	selfBuffProviderId = 13,
	enableGainExp = 14,
	winId = 10,
	creepsMasterId = 1,
	heroSkillId = 5,
	introdRaceId = 9
}
local dataList = {
	{
		101,
		"神曜烈心-1",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		102,
		"神曜烈心-2",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		103,
		"神曜烈心-3",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		104,
		"神曜烈心-4",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		105,
		"神曜烈心-5",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	}
}
local t_divine_sk_liexin_master = {
	[101] = dataList[1],
	[102] = dataList[2],
	[103] = dataList[3],
	[104] = dataList[4],
	[105] = dataList[5]
}

t_divine_sk_liexin_master.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_divine_sk_liexin_master
