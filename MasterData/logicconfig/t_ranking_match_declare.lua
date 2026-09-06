-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ranking_match_declare.lua

module("logicconfig.config.t_ranking_match_declare", package.seeall)

local title = {
	id = 1,
	desc = 3,
	type = 2
}
local dataList = {
	{
		1,
		1,
		"哎哟，不错哦"
	},
	{
		2,
		1,
		"你打得真好~"
	},
	{
		3,
		1,
		"你应该就比蚂蚁强一点点"
	},
	{
		4,
		1,
		"胜负早在我意料之中"
	},
	{
		5,
		1,
		"你还需要再练练"
	},
	{
		1,
		2,
		"不要太得意"
	},
	{
		2,
		2,
		"下次一定会战胜你"
	},
	{
		3,
		2,
		"这次用错阵容了"
	},
	{
		4,
		2,
		"胜败乃兵家常事"
	},
	{
		5,
		2,
		"下次我就是你的滑铁卢"
	}
}
local t_ranking_match_declare = {
	{
		dataList[1],
		dataList[6]
	},
	{
		dataList[2],
		dataList[7]
	},
	{
		dataList[3],
		dataList[8]
	},
	{
		dataList[4],
		dataList[9]
	},
	{
		dataList[5],
		dataList[10]
	}
}

t_ranking_match_declare.dataList = dataList

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

return t_ranking_match_declare
