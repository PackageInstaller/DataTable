-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dark_mm_challenge_buff.lua

module("logicconfig.config.t_origin_dark_mm_challenge_buff", package.seeall)

local title = {
	mmRaceNum = 2,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		603001,
		1,
		"己阵全属性+<color=#20b376>60%</color>，己阵精灵获得源起梦之队标签和源起哆啦梦梦之力"
	},
	{
		603001,
		2,
		"己阵全属性+<color=#20b376>130%</color>，己阵精灵获得源起梦之队标签和源起哆啦和源起暗黑梦梦之力"
	},
	{
		603001,
		3,
		"己阵全属性+<color=#20b376>250%</color>，己阵精灵获得源起梦之队标签和源起哆啦，源起暗黑和源起炼金梦梦之力"
	},
	{
		603001,
		4,
		"己阵全属性+<color=#20b376>500%</color>，己阵精灵获得源起梦之队标签和源起哆啦，源起暗黑，源起炼金和源起热血梦梦之力"
	},
	{
		603001,
		5,
		"己阵全属性+<color=#20b376>800%</color>，己阵精灵获得源起梦之队标签和源起哆啦，源起暗黑，源起炼金，源起热血和源起爱心梦梦之力"
	},
	{
		603001,
		6,
		"己阵全属性+<color=#20b376>1000%</color>，己阵精灵获得源起梦之队标签和源起哆啦，源起暗黑，源起炼金，源起热血和源起爱心梦梦之力"
	}
}
local t_origin_dark_mm_challenge_buff = {
	[603001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_origin_dark_mm_challenge_buff.dataList = dataList

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

return t_origin_dark_mm_challenge_buff
