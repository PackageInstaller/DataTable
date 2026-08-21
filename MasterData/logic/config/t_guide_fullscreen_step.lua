-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_guide_fullscreen_step.lua

module("logic.config.t_guide_fullscreen_step", package.seeall)

local title = {
	id = 1
}
local dataList = {
	{
		"300101"
	},
	{
		"300102"
	},
	{
		"300103"
	},
	{
		"400101"
	},
	{
		"400102"
	},
	{
		"400103"
	},
	{
		"400104"
	},
	{
		"410101"
	},
	{
		"410102"
	},
	{
		"410103"
	},
	{
		"410104"
	},
	{
		"410105"
	},
	{
		"410106"
	},
	{
		"410107"
	},
	{
		"410108"
	},
	{
		"410109"
	},
	{
		"410110"
	},
	{
		"410111"
	},
	{
		"410112"
	},
	{
		"410113"
	},
	{
		"410201"
	},
	{
		"410202"
	},
	{
		"410203"
	},
	{
		"410204"
	},
	{
		"410205"
	},
	{
		"410206"
	},
	{
		"410207"
	},
	{
		"410208"
	},
	{
		"410301"
	},
	{
		"410302"
	},
	{
		"410303"
	},
	{
		"410304"
	},
	{
		"410305"
	},
	{
		"410306"
	},
	{
		"410307"
	},
	{
		"410308"
	},
	{
		"410309"
	},
	{
		"410310"
	}
}
local t_guide_fullscreen_step = {}

t_guide_fullscreen_step.dataList = dataList

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
	t_guide_fullscreen_step[v[1]] = v

	setmetatable(v, mt)
end

return t_guide_fullscreen_step
