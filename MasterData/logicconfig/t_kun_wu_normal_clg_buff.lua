-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kun_wu_normal_clg_buff.lua

module("logicconfig.config.t_kun_wu_normal_clg_buff", package.seeall)

local title = {
	activityId = 1,
	buffName = 4,
	buffId = 2,
	desc = 3
}
local dataList = {
	{
		444001,
		1,
		"水属性\n+20%#草属性\n+40%#火属性\n+30%",
		"水#草#火"
	},
	{
		444001,
		2,
		"水属性\n+40%#草属性\n+30%#火属性\n+20%",
		"水#草#火"
	},
	{
		444001,
		3,
		"水属性\n+30%#草属性\n+20%#火属性\n+40%",
		"水#草#火"
	},
	{
		444001,
		4,
		"水属性\n+40%#草属性\n+40%#火属性\n+40%",
		"水#草#火"
	}
}
local t_kun_wu_normal_clg_buff = {
	[444001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_kun_wu_normal_clg_buff.dataList = dataList

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

return t_kun_wu_normal_clg_buff
