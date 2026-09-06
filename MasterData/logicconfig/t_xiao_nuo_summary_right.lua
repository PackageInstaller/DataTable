-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_nuo_summary_right.lua

module("logicconfig.config.t_xiao_nuo_summary_right", package.seeall)

local title = {
	id = 1,
	tag = 3,
	jumpTo = 4,
	desc = 2
}
local dataList = {
	{
		1,
		"11月26日5:00-12月17日5:00\n冒险幻境每日前8次双倍掉落",
		"翻倍",
		"func#106&&report_behavior#200542"
	},
	{
		2,
		"11月26日5:00-12月10日5:00\n失落遗迹双倍掉落",
		"翻倍",
		"func#52&&report_behavior#200543"
	},
	{
		3,
		"11月26日5:00-12月3日5:00\n每日米淇淋餐厅体力领取翻倍",
		"翻倍",
		"func#3#supplyview&&report_behavior#200544"
	},
	{
		4,
		"11月26日5:00-12月10日5:00\n主线副本及冒险幻境挑战跳过仅需3s等待",
		"跳过",
		"func#47&&report_behavior#200545"
	},
	{
		5,
		"11月26日5:00-12月3日5:00\n体力恢复每天可购买次数增加5次",
		"体力",
		"func#57&&report_behavior#200546"
	},
	{
		6,
		"11月26日5:00-12月3日5:00\n9折召唤券&神唤券礼包每天可购买2次",
		"礼包",
		"func#425&&report_behavior#200547"
	},
	{
		7,
		"11月26日5:00-12月24日5:00\n活动期间内累计充值可领取额外奖励",
		"累充",
		"func#330#22008&&report_behavior#200548"
	}
}
local t_xiao_nuo_summary_right = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_xiao_nuo_summary_right.dataList = dataList

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

return t_xiao_nuo_summary_right
