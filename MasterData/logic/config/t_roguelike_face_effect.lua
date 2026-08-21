-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_face_effect.lua

module("logic.config.t_roguelike_face_effect", package.seeall)

local title = {
	id = 1,
	name = 2,
	icon = 4,
	desc = 3
}
local dataList = {
	{
		1,
		"基础",
		"行动的投掷结果为有效的基础面面数",
		""
	},
	{
		2,
		"成功",
		"让投掷结果增加对应的级数",
		"7"
	},
	{
		3,
		"献祭",
		"让投掷结果增加对应的级数，同时扣除投掷者对应的生命值",
		"9"
	},
	{
		4,
		"蚀智",
		"让投掷结果增加对应的级数，同时扣除对应的理智值",
		"10"
	},
	{
		5,
		"流血",
		"扣除投掷者对应级数的生命值",
		"11"
	},
	{
		6,
		"恍惚",
		"扣除对应级数的理智值",
		"12"
	}
}
local t_roguelike_face_effect = {}

t_roguelike_face_effect.dataList = dataList

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
	t_roguelike_face_effect[v[1]] = v

	setmetatable(v, mt)
end

return t_roguelike_face_effect
