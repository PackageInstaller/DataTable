-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bounty_pk_round.lua

module("logicconfig.config.t_bounty_pk_round", package.seeall)

local title = {
	changeNum = 3,
	adjustTime = 4,
	betTime = 5,
	formNum = 2,
	round = 1
}
local dataList = {
	{
		1,
		3,
		0,
		30,
		30
	},
	{
		2,
		2,
		0,
		30,
		30
	},
	{
		3,
		0,
		2,
		30,
		30
	}
}
local t_bounty_pk_round = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_bounty_pk_round.dataList = dataList

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

return t_bounty_pk_round
