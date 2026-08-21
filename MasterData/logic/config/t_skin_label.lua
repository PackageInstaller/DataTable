-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_skin_label.lua

module("logic.config.t_skin_label", package.seeall)

local title = {
	id = 1,
	name = 3,
	desc = 4,
	type = 2
}
local dataList = {
	{
		100001,
		1,
		"外观",
		"全新的专属时装"
	},
	{
		100002,
		1,
		"外观",
		"全新的女仆装作战服"
	},
	{
		200001,
		2,
		"特效",
		"全新的普攻特效"
	},
	{
		200002,
		2,
		"特效",
		"全新的特殊技特效"
	},
	{
		300001,
		3,
		"配音",
		"全新的普攻配音"
	},
	{
		300002,
		3,
		"配音",
		"全新的特殊技配音"
	},
	{
		400001,
		4,
		"动作",
		"全新的胜利动作"
	},
	{
		400002,
		4,
		"动作",
		"全新的主界面动作"
	}
}
local t_skin_label = {}

t_skin_label.dataList = dataList

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
	t_skin_label[v[1]] = v

	setmetatable(v, mt)
end

return t_skin_label
