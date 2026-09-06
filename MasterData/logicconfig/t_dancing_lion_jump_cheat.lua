-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dancing_lion_jump_cheat.lua

module("logicconfig.config.t_dancing_lion_jump_cheat", package.seeall)

local title = {
	score = 2,
	cheatPlanId = 1,
	percent = 3
}
local dataList = {
	{
		1,
		0,
		0
	},
	{
		1,
		40,
		30
	},
	{
		1,
		50,
		40
	},
	{
		1,
		70,
		50
	},
	{
		1,
		90,
		60
	},
	{
		1,
		110,
		70
	},
	{
		1,
		140,
		80
	},
	{
		1,
		170,
		90
	},
	{
		1,
		200,
		95
	}
}
local t_dancing_lion_jump_cheat = {
	{
		[0] = dataList[1],
		[40] = dataList[2],
		[50] = dataList[3],
		[70] = dataList[4],
		[90] = dataList[5],
		[110] = dataList[6],
		[140] = dataList[7],
		[170] = dataList[8],
		[200] = dataList[9]
	}
}

t_dancing_lion_jump_cheat.dataList = dataList

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

return t_dancing_lion_jump_cheat
