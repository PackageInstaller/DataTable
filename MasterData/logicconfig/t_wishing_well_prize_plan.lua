-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wishing_well_prize_plan.lua

module("logicconfig.config.t_wishing_well_prize_plan", package.seeall)

local title = {
	prizeId = 2,
	prize = 3,
	prizePlanId = 1
}
local dataList = {
	{
		101,
		1,
		"4:100001:1"
	},
	{
		101,
		2,
		"4:100002:1"
	},
	{
		101,
		3,
		"4:100003:1"
	},
	{
		101,
		4,
		"4:100004:1"
	},
	{
		102,
		1,
		"4:100001:1"
	},
	{
		102,
		2,
		"4:100002:1"
	},
	{
		102,
		3,
		"4:100003:1"
	},
	{
		102,
		4,
		"4:100004:1"
	},
	{
		201,
		1,
		"4:100001:1"
	},
	{
		201,
		2,
		"4:100002:1"
	},
	{
		201,
		3,
		"4:100003:1"
	},
	{
		201,
		4,
		"4:100004:1"
	},
	{
		202,
		1,
		"4:100001:1"
	},
	{
		202,
		2,
		"4:100002:1"
	},
	{
		202,
		3,
		"4:100003:1"
	},
	{
		202,
		4,
		"4:100004:1"
	},
	{
		301,
		1,
		"4:100001:1"
	},
	{
		301,
		2,
		"4:100002:1"
	},
	{
		301,
		3,
		"4:100003:1"
	},
	{
		301,
		4,
		"4:100004:1"
	},
	{
		302,
		1,
		"4:100001:1"
	},
	{
		302,
		2,
		"4:100002:1"
	},
	{
		302,
		3,
		"4:100003:1"
	},
	{
		302,
		4,
		"4:100004:1"
	}
}
local t_wishing_well_prize_plan = {
	[101] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[102] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[201] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[202] = {
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	},
	[301] = {
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	},
	[302] = {
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	}
}

t_wishing_well_prize_plan.dataList = dataList

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

return t_wishing_well_prize_plan
