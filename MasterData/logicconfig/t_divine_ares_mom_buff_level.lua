-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ares_mom_buff_level.lua

module("logicconfig.config.t_divine_ares_mom_buff_level", package.seeall)

local title = {
	buffDesc = 3,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		369001,
		1,
		"己阵全属性+10%"
	},
	{
		369001,
		2,
		"己阵全属性+30%"
	},
	{
		369001,
		3,
		"己阵全属性+50%"
	},
	{
		369001,
		4,
		"己阵全属性+100%"
	},
	{
		369001,
		5,
		"己阵全属性+300%"
	},
	{
		369001,
		6,
		"己阵全属性+500%"
	},
	{
		369001,
		7,
		"己阵全属性+1000%"
	}
}
local t_divine_ares_mom_buff_level = {
	[369001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_divine_ares_mom_buff_level.dataList = dataList

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

return t_divine_ares_mom_buff_level
