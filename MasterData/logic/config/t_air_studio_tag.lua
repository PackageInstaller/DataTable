-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_studio_tag.lua

module("logic.config.t_air_studio_tag", package.seeall)

local title = {
	id = 1,
	typeName = 4,
	type = 3,
	tagName = 2
}
local dataList = {
	{
		1,
		"标准",
		1,
		"玩法类型"
	},
	{
		2,
		"强调位移",
		1,
		"玩法类型"
	},
	{
		3,
		"强调输出",
		1,
		"玩法类型"
	},
	{
		4,
		"强调生存",
		1,
		"玩法类型"
	},
	{
		5,
		"灵活走位",
		2,
		"设计类型"
	},
	{
		6,
		"伏兵满地",
		2,
		"设计类型"
	},
	{
		7,
		"正大光明",
		2,
		"设计类型"
	},
	{
		8,
		"遍地陷阱",
		2,
		"设计类型"
	},
	{
		9,
		"现实伤害",
		3,
		"输出类型"
	},
	{
		10,
		"精神伤害",
		3,
		"输出类型"
	},
	{
		11,
		"真实伤害",
		3,
		"输出类型"
	},
	{
		12,
		"混合伤害",
		3,
		"输出类型"
	},
	{
		13,
		"撤离",
		4,
		"胜负类型"
	},
	{
		14,
		"存活",
		4,
		"胜负类型"
	},
	{
		15,
		"暗杀",
		4,
		"胜负类型"
	},
	{
		16,
		"全歼",
		4,
		"胜负类型"
	}
}
local t_air_studio_tag = {}

t_air_studio_tag.dataList = dataList

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
	t_air_studio_tag[v[1]] = v

	setmetatable(v, mt)
end

return t_air_studio_tag
