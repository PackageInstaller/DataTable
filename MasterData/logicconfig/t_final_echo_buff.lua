-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_final_echo_buff.lua

module("logicconfig.config.t_final_echo_buff", package.seeall)

local title = {
	killOrder = 2,
	activityId = 1,
	buffDesc = 3
}
local dataList = {
	{
		495001,
		1,
		"暂未激活加成"
	},
	{
		495001,
		2,
		"BOSS减伤+20%"
	},
	{
		495001,
		3,
		"BOSS减伤+30%"
	},
	{
		495001,
		4,
		"BOSS减伤+50%"
	}
}
local t_final_echo_buff = {
	[495001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_final_echo_buff.dataList = dataList

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

return t_final_echo_buff
