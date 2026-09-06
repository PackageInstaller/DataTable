-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_nuo_birthday_rank_rule.lua

module("logicconfig.config.t_xiao_nuo_birthday_rank_rule", package.seeall)

local title = {
	id = 1,
	imgName = 2,
	desc = 3
}
local dataList = {
	{
		1,
		"board_lsqtz_16",
		"从起始方块处开始拖动，开始一口气挑战！"
	},
	{
		2,
		"board_lsqtz_14",
		"如果不小心走错路了，原路返回即可~"
	},
	{
		3,
		"board_lsqtz_15",
		"一口气填满所有方块，就能通过考验啦！"
	},
	{
		4,
		"board_lsqtz_13",
		"别忘了在倒计时内冲刺，获得更多礼物噢~"
	}
}
local t_xiao_nuo_birthday_rank_rule = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_xiao_nuo_birthday_rank_rule.dataList = dataList

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

return t_xiao_nuo_birthday_rank_rule
