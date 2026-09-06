-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bounty_pk_gate.lua

module("logicconfig.config.t_bounty_pk_gate", package.seeall)

local title = {
	gateId = 1,
	gateName = 2,
	enterCost = 3,
	roundCost = 4,
	limit = 5
}
local dataList = {
	{
		1,
		82054063,
		200,
		{
			100,
			400,
			300
		},
		1000
	},
	{
		2,
		82054064,
		400,
		{
			200,
			800,
			600
		},
		2000
	},
	{
		3,
		82054065,
		1000,
		{
			500,
			2000,
			1500
		},
		5000
	}
}
local t_bounty_pk_gate = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_bounty_pk_gate.dataList = dataList

local multiLanguageCells = {
	gateName = true
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

return t_bounty_pk_gate
