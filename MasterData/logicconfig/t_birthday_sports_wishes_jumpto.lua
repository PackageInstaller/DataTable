-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_birthday_sports_wishes_jumpto.lua

module("logicconfig.config.t_birthday_sports_wishes_jumpto", package.seeall)

local title = {
	name = 3,
	jumpTo = 4,
	id = 2,
	buffJumpPlanId = 1,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		"竞技场",
		"func#19",
		"挑战竞技场，验证自己的强度。"
	},
	{
		1,
		2,
		"高级竞技场",
		"func#171",
		"挑战高级竞技场，考验精灵搭配理解。"
	},
	{
		1,
		3,
		"排位赛",
		"func#69",
		"挑战排位赛，与势均力敌的对手比拼。"
	},
	{
		1,
		4,
		"极限排位赛",
		"func#75",
		"挑战极限排位赛，奋力迎战对手。"
	},
	{
		1,
		5,
		"巅峰赛",
		"func#729",
		"挑战巅峰赛，一起来场巅峰的对决吧"
	}
}
local t_birthday_sports_wishes_jumpto = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_birthday_sports_wishes_jumpto.dataList = dataList

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

return t_birthday_sports_wishes_jumpto
