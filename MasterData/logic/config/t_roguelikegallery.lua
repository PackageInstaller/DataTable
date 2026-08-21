-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelikegallery.lua

module("logic.config.t_roguelikegallery", package.seeall)

local title = {
	id = 1,
	name = 2,
	scriptId = 4,
	isCommunal = 3
}
local dataList = {
	{
		999,
		"印象图鉴",
		1,
		0
	},
	{
		101,
		"罪与罚",
		0,
		101
	}
}
local t_roguelikegallery = {}

t_roguelikegallery.dataList = dataList

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
	t_roguelikegallery[v[1]] = v

	setmetatable(v, mt)
end

return t_roguelikegallery
