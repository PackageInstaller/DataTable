-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_wheel_explain.lua

module("logicconfig.config.t_time_wheel_explain", package.seeall)

local title = {
	id = 1,
	tip = 4,
	content = 3,
	titleName = 2
}
local dataList = {
	{
		1,
		"时间消逝",
		"1、初始为<color=#C54949>超能</color>、<color=#C54949>幻兽</color>、<color=#C54949>初代</color>品质的精灵，需至少有1只达到<color=#C54949>觉醒VI</color>后，其余<color=#C54949>非觉醒VI</color>同名精灵才可进行消逝；\r\n（勾选“显示满图鉴精灵”后，若精灵图鉴已升至<color=#C54949>最高</color>，则背包中不需要拥有该<color=#C54949>觉醒VI</color>的精灵也可以进行选中消逝）\r\n2、消逝完成后，被消逝的精灵将会消失，返还<color=#C54949>精灵之尘</color>，以及<color=#C54949>全部</color>觉醒和养成资源，并卸下所有装备、星神；\r\n3、<color=#C54949>已锁定</color>的精灵需要二次确认后才可以消逝。",
		"1，初始为<color=#C54949>超能</color>、<color=#C54949>幻兽</color>、<color=#C54949>初代</color>品质的精灵，需至少有1只达到<color=#C54949>觉醒VI</color>后，其余<color=#C54949>非觉醒VI</color>同名精灵才可进行消逝；\r\n（勾选“图鉴达到最高可消逝”后，若精灵图鉴已升至<color=#C54949>最高</color>，则背包中不需要拥有该<color=#C54949>觉醒VI</color>的精灵也可以进行消逝）\r\n2、消逝完成后，被消逝的精灵将会消失，返还<color=#C54949>精灵之尘</color>，以及<color=#C54949>全部</color>觉醒和养成资源，并卸下所有装备、星神；\r\n3、<color=#C54949>已锁定</color>的精灵需要二次确认后才可以消逝。"
	},
	{
		2,
		"时间重置",
		"1、将选中的精灵的<color=#C54949>等级</color>、<color=#C54949>天赋等级</color>、<color=#C54949>潜能等级</color>和<color=#C54949>星神等级</color>，重置回<color=#C54949>初始等级</color>，但<color=#C54949>觉醒等级不变</color>，同时返还<color=#C54949>全部养成资源</color>，并卸下所有装备；\r\n2、精灵重置每天有<color=#C54949>次数限制</color>，限制次数随<color=#C54949>训练师等级</color>提升逐渐增多；\r\n3、连续进行重置，会使精灵重置进入冷却时间，冷却时间最多不超过<color=#C54949>120分钟</color>；\r\n4、重置<color=#C54949>不会</color>将穿戴了红色星神的星神<color=#C54949>卸下</color>。",
		"1、将选中的精灵的<color=#C54949>等级</color>、<color=#C54949>天赋等级</color>、<color=#C54949>潜能等级</color>和<color=#C54949>星神等级</color>，重置回<color=#C54949>初始等级</color>，但<color=#C54949>觉醒等级不变</color>，同时返还<color=#C54949>全部养成资源</color>，并卸下所有装备；\r\n2、精灵重置每天有<color=#C54949>次数限制</color>，限制次数随<color=#C54949>训练师等级</color>提升逐渐增多；\r\n3、连续进行重置，会使精灵重置进入冷却时间，冷却时间最多不超过<color=#C54949>120分钟</color>；\r\n4、重置<color=#C54949>不会</color>将穿戴了红色星神的星神<color=#C54949>卸下</color>。"
	},
	{
		3,
		"时间倒退",
		"1、大于等于<color=#C54949>觉醒I</color>的<color=#C54949>传说品质</color>精灵，可进行倒退；\n2、倒退完成后，选中的精灵倒退回<color=#C54949>未觉醒</color>状态，返还消耗的<color=#C54949>所有</color>同名未觉醒的精灵和养成资源，并卸下所有装备和星神（放入背包）。\n倒退后，<color=#C54949>神曜神格的进度</color>将保留在<color=#C54949>所有返还</color>精灵身上。",
		"1、大于等于<color=#C54949>觉醒I</color>的<color=#C54949>传说品质</color>精灵，可进行倒退；\n2、倒退完成后，选中的精灵倒退回<color=#C54949>未觉醒</color>状态，返还消耗的<color=#C54949>所有</color>同名未觉醒的精灵和养成资源，并卸下所有装备和星神（放入背包）。\n倒退后，<color=#C54949>神曜神格的进度</color>将保留在<color=#C54949>所有返还</color>精灵身上。"
	},
	{
		4,
		"时间溯源",
		"1、<color=#C54949>传说</color>精灵觉醒等级达到<color=#C54949>觉醒Ⅵ</color>，重复获得该精灵或者同名精灵专属魂，可使用时间溯源转化为<color=#C54949>溯源币</color>；\n2、溯源币可用在溯源商店兑换道具奖励。",
		"1、<color=#C54949>传说</color>精灵觉醒等级达到<color=#C54949>觉醒Ⅵ</color>，重复获得该精灵或者同名精灵专属魂，可使用时间溯源转化为<color=#C54949>溯源币</color>；\n2、溯源币可用在溯源商店兑换道具奖励。"
	}
}
local t_time_wheel_explain = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_time_wheel_explain.dataList = dataList

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

return t_time_wheel_explain
