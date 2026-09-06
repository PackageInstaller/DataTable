-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_log.lua

module("logicconfig.config.t_family_log", package.seeall)

local title = {
	id = 1,
	content = 3,
	desc = 2
}
local dataList = {
	{
		1,
		"加入家族",
		"{un}加入了家族"
	},
	{
		2,
		"离开家族",
		"{un}离开了家族"
	},
	{
		3,
		"家族升级",
		"大家共同努力，家族升级至{l}级"
	},
	{
		4,
		"修改职位",
		"{un}被任命为{fm_role}职位"
	},
	{
		5,
		"家族捐献",
		"{un}捐献了{c}家族幸运值"
	},
	{
		6,
		"挑战魔王",
		"{un}向{b}发起了挑战，并造成了{d}伤害"
	},
	{
		7,
		"开启魔王",
		"{un}开启了家族魔王{b}，大家可以向他发起挑战了"
	},
	{
		8,
		"创建家族",
		"[{fn}]家族已经成功创建"
	},
	{
		9,
		"家族维护",
		"家族维护扣除{c}家族资金"
	},
	{
		10,
		"开启宴会",
		"{un}  开启宴会扣除{c}家族资金"
	},
	{
		11,
		"激活家族图腾",
		"{un} 激活家族图腾扣除{c}家族资金"
	},
	{
		12,
		"发送邮件",
		"{un} 发送全员邮件扣除{c}家族资金"
	},
	{
		13,
		"发送招募信息",
		"{un}  在本服发送招募信息扣除{c}家族资金"
	},
	{
		14,
		"激活家族图腾",
		"{un} 激活家族图腾扣除{c}家族资金"
	}
}
local t_family_log = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14]
}

t_family_log.dataList = dataList

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

return t_family_log
