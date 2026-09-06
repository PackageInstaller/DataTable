-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_teshamu_sign_in_buff.lua

module("logicconfig.config.t_teshamu_sign_in_buff", package.seeall)

local title = {
	desc = 3,
	signInBuffPlanId = 1,
	level = 2
}
local dataList = {
	{
		288002,
		1,
		"最大生命&全属性+10%"
	},
	{
		288002,
		2,
		"最大生命&全属性+30%"
	},
	{
		288002,
		3,
		"最大生命&全属性+50%"
	},
	{
		288002,
		4,
		"最大生命&全属性+150%"
	},
	{
		288002,
		5,
		"最大生命&全属性+300%"
	},
	{
		288002,
		6,
		"最大生命&全属性+500%"
	},
	{
		288002,
		7,
		"最大生命&全属性+800%"
	}
}
local t_teshamu_sign_in_buff = {
	[288002] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_teshamu_sign_in_buff.dataList = dataList

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

return t_teshamu_sign_in_buff
