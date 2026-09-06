-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_challenge_guard.lua

module("logicconfig.config.t_holy_challenge_guard", package.seeall)

local title = {
	challengeId = 1,
	supportPetId = 2,
	storyId = 4,
	petId = 3,
	recommendZdl = 5
}
local dataList = {
	{
		1,
		1000000001,
		10016,
		5010001,
		5000
	},
	{
		2,
		1000000002,
		10018,
		5010002,
		8000
	},
	{
		3,
		1000000003,
		10017,
		5010005,
		11000
	},
	{
		4,
		1000000004,
		10019,
		5010004,
		14000
	},
	{
		5,
		1000000005,
		10072,
		5010006,
		17000
	},
	{
		6,
		1000000006,
		10020,
		5010003,
		20000
	}
}
local t_holy_challenge_guard = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_holy_challenge_guard.dataList = dataList

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

return t_holy_challenge_guard
