-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_chen_clg_normal_buff.lua

module("logicconfig.config.t_divine_chen_clg_normal_buff", package.seeall)

local title = {
	activityId = 1,
	buffId = 2,
	buffDesc = 3
}
local dataList = {
	{
		457001,
		1,
		"我方女性精灵\r\n每个大回合结束时+25点气势"
	},
	{
		457001,
		2,
		"我方女性精灵\r\n获得30%的免伤"
	},
	{
		457001,
		3,
		"我方女性精灵\r\n全属性+50%"
	},
	{
		457002,
		1,
		"我方女性精灵\r\n每个大回合结束时+25点气势"
	},
	{
		457002,
		2,
		"我方女性精灵\r\n获得30%的免伤"
	},
	{
		457002,
		3,
		"我方女性精灵\r\n全属性+50%"
	}
}
local t_divine_chen_clg_normal_buff = {
	[457001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[457002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_chen_clg_normal_buff.dataList = dataList

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

return t_divine_chen_clg_normal_buff
