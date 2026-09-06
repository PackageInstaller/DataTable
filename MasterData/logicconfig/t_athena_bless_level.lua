-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_athena_bless_level.lua

module("logicconfig.config.t_athena_bless_level", package.seeall)

local title = {
	score = 3,
	effResPath = 5,
	icon = 4,
	planId = 1,
	level = 2
}
local dataList = {
	{
		1,
		1,
		0,
		"bless1",
		""
	},
	{
		1,
		2,
		300,
		"bless2",
		"fx_ui_02_yadiannadezhufu"
	},
	{
		1,
		3,
		600,
		"bless3",
		"fx_ui_03_yadiannadezhufu"
	},
	{
		1,
		4,
		1200,
		"bless4",
		"fx_ui_04_yadiannadezhufu"
	},
	{
		1,
		5,
		2000,
		"bless5",
		"fx_ui_05_yadiannadezhufu"
	},
	{
		1,
		6,
		3000,
		"bless6",
		"fx_ui_06_yadiannadezhufu"
	},
	{
		2,
		1,
		0,
		"",
		""
	}
}
local t_athena_bless_level = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7]
	}
}

t_athena_bless_level.dataList = dataList

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

return t_athena_bless_level
