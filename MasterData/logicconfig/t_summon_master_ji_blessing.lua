-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_ji_blessing.lua

module("logicconfig.config.t_summon_master_ji_blessing", package.seeall)

local title = {
	blessingId = 2,
	unlockDays = 3,
	activityId = 1,
	buffId = 4
}
local dataList = {
	{
		348001,
		1,
		1,
		16
	},
	{
		348001,
		2,
		2,
		17
	},
	{
		348001,
		3,
		3,
		18
	},
	{
		348001,
		4,
		4,
		19
	},
	{
		348001,
		5,
		5,
		20
	},
	{
		348001,
		6,
		6,
		21
	},
	{
		348001,
		7,
		7,
		22
	},
	{
		348001,
		8,
		8,
		23
	},
	{
		348001,
		9,
		9,
		24
	},
	{
		348001,
		10,
		10,
		25
	}
}
local t_summon_master_ji_blessing = {
	[348001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_summon_master_ji_blessing.dataList = dataList

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

return t_summon_master_ji_blessing
