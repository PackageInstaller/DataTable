-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_king_mo_yan_clg_phase.lua

module("logicconfig.config.t_origin_king_mo_yan_clg_phase", package.seeall)

local title = {
	xLength = 3,
	fireCount = 6,
	phaseId = 2,
	itemPointIds = 7,
	yLength = 4,
	prize = 8,
	activityId = 1,
	flowerCount = 5
}
local dataList = {
	{
		559001,
		1,
		8,
		4,
		8,
		6,
		{
			2,
			4,
			6,
			9,
			11,
			13,
			15,
			17,
			19,
			21,
			23,
			18,
			20,
			22,
			28,
			30
		},
		"4:510700:20"
	},
	{
		559001,
		2,
		8,
		4,
		12,
		8,
		{
			2,
			4,
			6,
			9,
			11,
			13,
			15,
			17,
			19,
			21,
			23,
			18,
			20,
			22,
			28,
			30
		},
		"4:510700:30"
	},
	{
		559001,
		3,
		8,
		4,
		16,
		12,
		{
			2,
			4,
			6,
			9,
			11,
			13,
			15,
			17,
			19,
			21,
			23,
			18,
			20,
			22,
			28,
			30
		},
		"4:510700:50"
	}
}
local t_origin_king_mo_yan_clg_phase = {
	[559001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_king_mo_yan_clg_phase.dataList = dataList

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

return t_origin_king_mo_yan_clg_phase
