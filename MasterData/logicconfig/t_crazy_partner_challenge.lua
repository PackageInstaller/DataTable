-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_crazy_partner_challenge.lua

module("logicconfig.config.t_crazy_partner_challenge", package.seeall)

local title = {
	challengeId = 1,
	scorePlanId = 5,
	systemPetPlanId = 4,
	creepsMasterId = 3,
	difficulty = 2,
	taskId = 6
}
local dataList = {
	{
		1,
		1,
		101,
		1,
		101,
		101
	},
	{
		1,
		2,
		102,
		1,
		102,
		102
	},
	{
		1,
		3,
		103,
		1,
		103,
		103
	},
	{
		2,
		1,
		201,
		1,
		201,
		201
	},
	{
		2,
		2,
		202,
		1,
		202,
		202
	},
	{
		2,
		3,
		203,
		1,
		203,
		203
	},
	{
		3,
		1,
		301,
		1,
		301,
		301
	},
	{
		3,
		2,
		302,
		1,
		302,
		302
	},
	{
		3,
		3,
		303,
		1,
		303,
		303
	},
	{
		4,
		1,
		401,
		1,
		401,
		401
	},
	{
		4,
		2,
		402,
		1,
		402,
		402
	},
	{
		4,
		3,
		403,
		1,
		403,
		403
	},
	{
		5,
		1,
		501,
		1,
		501,
		501
	},
	{
		5,
		2,
		502,
		1,
		502,
		502
	},
	{
		5,
		3,
		503,
		1,
		503,
		503
	},
	{
		6,
		1,
		601,
		1,
		601,
		601
	},
	{
		6,
		2,
		602,
		1,
		602,
		602
	},
	{
		6,
		3,
		603,
		1,
		603,
		603
	}
}
local t_crazy_partner_challenge = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15]
	},
	{
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_crazy_partner_challenge.dataList = dataList

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

return t_crazy_partner_challenge
