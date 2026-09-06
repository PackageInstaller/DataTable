-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_limit_rank_define.lua

module("logicconfig.config.t_time_limit_rank_define", package.seeall)

local title = {
	rankPrizeId = 7,
	title = 3,
	promulgateDay = 2,
	rules = 9,
	refreshRules = 10,
	bg = 4,
	progressFormat = 6,
	progressName = 5,
	progressPrizeId = 8,
	id = 1
}
local dataList = {
	{
		9101,
		12,
		"霸王试炼",
		"bg_wanfa01.png",
		"最高伤害",
		"%d",
		3,
		3,
		"timelimitrank3",
		"提示：最高伤害达50万才可上榜，排行榜每10分钟刷新一次"
	},
	{
		9102,
		10,
		"宗师试炼",
		"bg_yxsl_01.png",
		"最高伤害",
		"%d",
		4,
		4,
		"timelimitrank4",
		"提示：最高伤害达50万才可上榜，排行榜每10分钟刷新一次"
	},
	{
		9103,
		8,
		"枭雄试炼",
		"bg_shilian.png",
		"最高伤害",
		"%d",
		5,
		5,
		"timelimitrank5",
		"提示：最高伤害达50万才可上榜，排行榜每10分钟刷新一次"
	},
	{
		9104,
		6,
		"天神试炼",
		"shijianzhilun/bg_sjzl01.png",
		"最高伤害",
		"%d",
		6,
		6,
		"timelimitrank6",
		"提示：最高伤害达50万才可上榜，排行榜每10分钟刷新一次"
	}
}
local t_time_limit_rank_define = {
	[9101] = dataList[1],
	[9102] = dataList[2],
	[9103] = dataList[3],
	[9104] = dataList[4]
}

t_time_limit_rank_define.dataList = dataList

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

return t_time_limit_rank_define
