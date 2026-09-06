-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dragon_arya_clg_score_type.lua

module("logicconfig.config.t_origin_dragon_arya_clg_score_type", package.seeall)

local title = {
	scoreUnit = 4,
	buffCounterId = 3,
	desc = 5,
	activityId = 1,
	scoreType = 2
}
local dataList = {
	{
		573001,
		1,
		20072306,
		180,
		"己方精灵击杀1个目标"
	},
	{
		573001,
		2,
		20072308,
		30,
		"己方精灵释放1次超杀"
	},
	{
		573001,
		3,
		20072310,
		180,
		"己方精灵复活1次"
	},
	{
		573001,
		4,
		20072312,
		20,
		"己方精灵出手1次"
	},
	{
		573001,
		5,
		20072314,
		20,
		"己方精灵造成1次克制伤害"
	}
}
local t_origin_dragon_arya_clg_score_type = {
	[573001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_origin_dragon_arya_clg_score_type.dataList = dataList

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

return t_origin_dragon_arya_clg_score_type
