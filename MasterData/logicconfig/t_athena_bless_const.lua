-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_athena_bless_const.lua

module("logicconfig.config.t_athena_bless_const", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"athena_desc1",
		"触发赤焰龙皇祝福，获得增益效果"
	},
	{
		"athena_desc2",
		"<color=#C54949>即日起至7月1号</color>活动期间赤焰龙皇祝福限时生效。针对所有玩法上阵<color=#C54949>赤焰龙皇</color>（包括穿戴皮肤），该精灵有暴击率+35%、生命+20%的增益效果。"
	},
	{
		"athena_desc3",
		"500"
	},
	{
		"athena_desc4",
		"4500"
	},
	{
		"athena_desc5",
		"10326"
	},
	{
		"athena_desc6",
		"1600"
	},
	{
		"athena_title",
		"龙皇祝福"
	},
	{
		"athena_levelshow",
		"0"
	},
	{
		"athena_buffname",
		"龙皇祝福"
	},
	{
		"athena_award",
		"4:10000052:0"
	},
	{
		"athena_awardtxt",
		"累计可获得30000个潜能药水+15张神唤券"
	}
}
local t_athena_bless_const = {
	athena_desc1 = dataList[1],
	athena_desc2 = dataList[2],
	athena_desc3 = dataList[3],
	athena_desc4 = dataList[4],
	athena_desc5 = dataList[5],
	athena_desc6 = dataList[6],
	athena_title = dataList[7],
	athena_levelshow = dataList[8],
	athena_buffname = dataList[9],
	athena_award = dataList[10],
	athena_awardtxt = dataList[11]
}

t_athena_bless_const.dataList = dataList

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

return t_athena_bless_const
