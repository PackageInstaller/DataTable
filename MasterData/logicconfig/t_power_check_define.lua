-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_power_check_define.lua

module("logicconfig.config.t_power_check_define", package.seeall)

local title = {
	strategyId = 2,
	lowGiftIdList = 4,
	highGiftIdList = 5,
	id = 1,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		82007992,
		{
			50011
		},
		{
			50011
		}
	},
	{
		2,
		2,
		82007993,
		{
			50011
		},
		{
			50011
		}
	},
	{
		3,
		3,
		82007994,
		{
			50001,
			50004,
			50002
		},
		{
			50002,
			50003,
			50005
		}
	},
	{
		4,
		4,
		82007995,
		{
			50006,
			50009,
			50011
		},
		{
			50006,
			50009,
			50011
		}
	},
	{
		5,
		5,
		82007996,
		{
			50008
		},
		{
			50008
		}
	},
	{
		6,
		6,
		82007997,
		{
			50007
		},
		{
			50007
		}
	},
	{
		7,
		7,
		82007998
	},
	{
		8,
		8,
		82007999,
		{
			50007
		},
		{
			50007
		}
	},
	{
		9,
		9,
		82050991
	}
}
local t_power_check_define = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_power_check_define.dataList = dataList

local multiLanguageCells = {
	desc = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_power_check_define
