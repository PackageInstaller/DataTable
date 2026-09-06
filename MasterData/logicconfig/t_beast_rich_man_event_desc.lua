-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_event_desc.lua

module("logicconfig.config.t_beast_rich_man_event_desc", package.seeall)

local title = {
	descInPos = 3,
	descOutsidePos = 4,
	useCardId = 5,
	activityId = 1,
	eventType = 2
}
local dataList = {
	{
		558001,
		1,
		"又到了纳税时间，请缴纳当前收益的%s%%(%s银票)作为税金，%s的发展离不开你的贡献！",
		"又到了纳税时间，请缴纳当前收益的一定比例作为税金，国度的发展离不开你的贡献！",
		3
	},
	{
		558001,
		2,
		"可以消耗一定银票邀请精灵在本活动中为你而战！",
		"可以消耗一定银票邀请精灵在本活动中为你而战！",
		0
	},
	{
		558001,
		3,
		"转盘抽奖有多个轮次，不放回抽取，抽奖无任何消耗",
		"转盘抽奖有多个轮次，不放回抽取，抽奖无任何消耗",
		0
	},
	{
		558001,
		4,
		"现在有一个千载难逢的投资机会！稳赚不赔，绝不让你亏钱！\n（若选择放弃则下一次落脚时会重新触发投资事件）",
		"现在有一个千载难逢的投资机会！稳赚不赔，绝不让你亏钱！\n（若选择放弃则下一次落脚时会重新触发投资事件）",
		0
	},
	{
		558001,
		5,
		"可购买、升级，落脚在相邻路径格子上时方可触发",
		"可购买、升级，落脚在相邻路径格子上时方可触发",
		4
	}
}
local t_beast_rich_man_event_desc = {
	[558001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_beast_rich_man_event_desc.dataList = dataList

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

return t_beast_rich_man_event_desc
