-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_crazy_partner_layout.lua

module("logicconfig.config.t_crazy_partner_layout", package.seeall)

local title = {
	challengeId = 3,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		153001,
		1,
		1
	},
	{
		153001,
		2,
		2
	},
	{
		153001,
		3,
		3
	},
	{
		153001,
		4,
		4
	},
	{
		153001,
		5,
		5
	},
	{
		153001,
		6,
		6
	},
	{
		153001,
		7,
		1
	},
	{
		153001,
		8,
		2
	},
	{
		153001,
		9,
		3
	},
	{
		153001,
		10,
		4
	},
	{
		153001,
		11,
		5
	},
	{
		153001,
		12,
		6
	},
	{
		153001,
		13,
		1
	},
	{
		153001,
		14,
		2
	},
	{
		153001,
		15,
		3
	},
	{
		153001,
		16,
		4
	},
	{
		153001,
		17,
		5
	},
	{
		153001,
		18,
		6
	},
	{
		153001,
		19,
		1
	},
	{
		153001,
		20,
		2
	},
	{
		153001,
		21,
		3
	}
}
local t_crazy_partner_layout = {
	[153001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21]
	}
}

t_crazy_partner_layout.dataList = dataList

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

return t_crazy_partner_layout
