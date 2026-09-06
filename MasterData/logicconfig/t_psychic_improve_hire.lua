-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_psychic_improve_hire.lua

module("logicconfig.config.t_psychic_improve_hire", package.seeall)

local title = {
	petRaceId = 4,
	reportBehavior = 5,
	hireId = 2,
	hirePlanId = 1,
	hireCard = 3
}
local dataList = {
	{
		1,
		1,
		"4:510109:1",
		"12005",
		201433
	},
	{
		1,
		2,
		"4:510110:1",
		"16008",
		201434
	},
	{
		1,
		3,
		"4:510111:1",
		"16009",
		201435
	},
	{
		1,
		4,
		"4:510112:1",
		"11007",
		201436
	},
	{
		2,
		1,
		"4:510194:1",
		"13005#11002#15006#16003#17006",
		0
	},
	{
		3,
		1,
		"4:510194:1",
		"13005#11002#15006#16003#17006",
		0
	},
	{
		4,
		1,
		"4:510267:1",
		"14020#12009#16019#15024#11012",
		0
	},
	{
		5,
		1,
		"4:510321:1",
		"12020#16026#17018#13014#11019",
		0
	}
}
local t_psychic_improve_hire = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5]
	},
	{
		dataList[6]
	},
	{
		dataList[7]
	},
	{
		dataList[8]
	}
}

t_psychic_improve_hire.dataList = dataList

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

return t_psychic_improve_hire
