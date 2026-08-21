-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_task_showbubble.lua

module("logic.config.t_roguelike_task_showbubble", package.seeall)

local title = {
	content = 3,
	actionName = 5,
	code = 1,
	factor = 2,
	voice = 4
}
local dataList = {
	{
		1,
		3,
		"梦境是愿望的满足之地。",
		"",
		"idle"
	},
	{
		2,
		3,
		"人们心甘情愿沉溺在虚构的幻想中。",
		"",
		"idle"
	},
	{
		4,
		4,
		"主管，不要迷失在记忆中。",
		"",
		"idle"
	},
	{
		5,
		4,
		"意识主体的记忆是痛苦的吗？我并不这样认为。",
		"",
		"idle"
	},
	{
		6,
		4,
		"潜意识是不被允许容于社会的人性本能及欲望。",
		"",
		"idle"
	}
}
local t_roguelike_task_showbubble = {}

t_roguelike_task_showbubble.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_roguelike_task_showbubble[v[1]] = v

	setmetatable(v, mt)
end

return t_roguelike_task_showbubble
