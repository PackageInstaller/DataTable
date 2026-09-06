-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_stripe_hud.lua

module("logicconfig.config.t_holy_stripe_hud", package.seeall)

local title = {
	redpointIds = 8,
	name = 2,
	jumpTo = 6,
	jumpFuncIdTo = 5,
	id = 1,
	content = 7,
	desc = 3,
	jumpFuncId = 4,
	reportBehavior = 9
}
local dataList = {
	{
		1,
		"灵力狂潮",
		"莱莉丝、灵纹试用",
		0,
		"",
		"func#612",
		"24:100441:4#4:30006:60",
		"283",
		201006
	},
	{
		2,
		"登录豪礼",
		"登录签到领取灵纹",
		0,
		"",
		"func#614#birthdaywelfaresignextview",
		"4:510022:1#4:30006:20",
		"",
		201007
	},
	{
		3,
		"灵纹助力",
		"灵纹镶嵌战力飙升",
		0,
		"",
		"func#614#powersurge",
		"4:30006:24#4:40008:12",
		"",
		201008
	},
	{
		4,
		"灵纹战令",
		"海量灵纹道具",
		615,
		"func#3#passportlwview",
		"func#615",
		"4:1021:1#4:30006:706",
		"",
		201009
	},
	{
		5,
		"灵纹幻境",
		"参与活动获得灵纹",
		0,
		"",
		"func#611",
		"24:100241#4:30005",
		"",
		201010
	}
}
local t_holy_stripe_hud = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_holy_stripe_hud.dataList = dataList

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

return t_holy_stripe_hud
