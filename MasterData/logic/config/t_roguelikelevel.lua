-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelikelevel.lua

module("logic.config.t_roguelikelevel", package.seeall)

local title = {
	id = 1,
	name = 3,
	effectIds = 4,
	target = 5,
	level = 2
}
local dataList = {
	{
		100,
		10000,
		"安全",
		nil,
		"跨过迷雾之地"
	},
	{
		101,
		10100,
		"安全",
		nil,
		"了解斯考浦城"
	},
	{
		101,
		10101,
		"稳定",
		{
			70012003
		},
		"进入案发现场"
	},
	{
		101,
		10102,
		"棘手",
		{
			70011002
		},
		"调查异常源头"
	},
	{
		101,
		10103,
		"危险",
		{
			70011007
		},
		"谨记！秘密调查！"
	},
	{
		101,
		10104,
		"灾厄",
		nil,
		"最终的真相"
	}
}
local t_roguelikelevel = {}

t_roguelikelevel.dataList = dataList

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
	t_roguelikelevel[v[2]] = v

	setmetatable(v, mt)
end

return t_roguelikelevel
