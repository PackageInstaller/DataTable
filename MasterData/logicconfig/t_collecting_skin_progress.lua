-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_collecting_skin_progress.lua

module("logicconfig.config.t_collecting_skin_progress", package.seeall)

local title = {
	dataBitId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		362001,
		1,
		1,
		"4:510295:1"
	},
	{
		362001,
		2,
		2,
		"4:510295:1"
	},
	{
		362001,
		3,
		4,
		"13:272:1"
	},
	{
		362001,
		4,
		6,
		"13:271:1"
	},
	{
		362002,
		1,
		1,
		"4:510302:1"
	},
	{
		362002,
		2,
		3,
		"4:510302:1"
	},
	{
		362002,
		3,
		5,
		"13:282:1"
	},
	{
		362003,
		1,
		1,
		"104:2:188"
	},
	{
		362003,
		2,
		3,
		"4:36:10"
	},
	{
		362003,
		3,
		5,
		"1:300051:-1:1"
	},
	{
		362004,
		1,
		1,
		"104:2:188"
	},
	{
		362004,
		2,
		2,
		"13:376:1"
	},
	{
		362004,
		3,
		3,
		"13:375:1"
	},
	{
		362004,
		4,
		4,
		"2:208:1"
	},
	{
		362005,
		1,
		2,
		"4:400004:20"
	},
	{
		362005,
		2,
		3,
		"14:479:1"
	},
	{
		362005,
		3,
		4,
		"2:276:1"
	},
	{
		362006,
		1,
		4,
		"4:400004:50"
	},
	{
		362006,
		2,
		7,
		"9:1300041:1"
	},
	{
		362007,
		1,
		3,
		"4:400004:50"
	},
	{
		362007,
		2,
		6,
		"9:1300055:1"
	},
	{
		362008,
		1,
		1,
		"4:36:10"
	},
	{
		362008,
		2,
		2,
		"4:400004:50"
	},
	{
		362008,
		3,
		3,
		"9:1300061:1"
	},
	{
		362009,
		1,
		1,
		"4:36:10"
	},
	{
		362009,
		2,
		3,
		"4:400004:50"
	},
	{
		362009,
		3,
		4,
		"9:1300062:1"
	}
}
local t_collecting_skin_progress = {
	[362001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[362002] = {
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[362003] = {
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[362004] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	},
	[362005] = {
		dataList[15],
		dataList[16],
		dataList[17]
	},
	[362006] = {
		dataList[18],
		dataList[19]
	},
	[362007] = {
		dataList[20],
		dataList[21]
	},
	[362008] = {
		dataList[22],
		dataList[23],
		dataList[24]
	},
	[362009] = {
		dataList[25],
		dataList[26],
		dataList[27]
	}
}

t_collecting_skin_progress.dataList = dataList

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

return t_collecting_skin_progress
