-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_studio_plan_limit.lua

module("logic.config.t_air_studio_plan_limit", package.seeall)

local title = {
	planLimit = 2,
	id = 1,
	condition = 3
}
local dataList = {
	{
		1,
		10
	},
	{
		2,
		12,
		{
			{
				value = "2",
				type = "createLv"
			}
		}
	},
	{
		3,
		16,
		{
			{
				value = "5",
				type = "createLv"
			}
		}
	},
	{
		4,
		20,
		{
			{
				value = "8",
				type = "createLv"
			}
		}
	},
	{
		5,
		24,
		{
			{
				value = "10",
				type = "createLv"
			}
		}
	},
	{
		6,
		28,
		{
			{
				value = "12",
				type = "createLv"
			}
		}
	},
	{
		7,
		32,
		{
			{
				value = "15",
				type = "createLv"
			}
		}
	},
	{
		8,
		36,
		{
			{
				value = "18",
				type = "createLv"
			}
		}
	},
	{
		9,
		40,
		{
			{
				value = "20",
				type = "createLv"
			}
		}
	}
}
local t_air_studio_plan_limit = {}

t_air_studio_plan_limit.dataList = dataList

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
	t_air_studio_plan_limit[v[1]] = v

	setmetatable(v, mt)
end

return t_air_studio_plan_limit
