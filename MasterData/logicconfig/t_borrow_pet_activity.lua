-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_borrow_pet_activity.lua

module("logicconfig.config.t_borrow_pet_activity", package.seeall)

local title = {
	tips = 4,
	weeklyBorrowTimes = 3,
	planId = 2,
	activityId = 1
}
local dataList = {
	{
		411001,
		1,
		1,
		"borrow_player_tips_1"
	},
	{
		411002,
		2,
		1,
		"borrow_player_tips_1"
	},
	{
		411003,
		3,
		1,
		"borrow_player_tips_1"
	},
	{
		411004,
		4,
		1,
		"borrow_player_tips_1"
	},
	{
		411005,
		5,
		1,
		"borrow_player_tips_1"
	},
	{
		411006,
		6,
		1,
		"borrow_player_tips_1"
	},
	{
		411007,
		7,
		1,
		"borrow_player_tips_1"
	},
	{
		411008,
		8,
		1,
		"borrow_player_tips_1"
	},
	{
		411009,
		9,
		1,
		"borrow_player_tips_1"
	},
	{
		411010,
		10,
		1,
		"borrow_player_tips_1"
	},
	{
		411011,
		11,
		1,
		"borrow_player_tips_1"
	},
	{
		411012,
		12,
		1,
		"borrow_player_tips_1"
	},
	{
		411013,
		13,
		1,
		"borrow_player_tips_1"
	},
	{
		411014,
		14,
		1,
		"borrow_player_tips_1"
	},
	{
		411015,
		15,
		1,
		"borrow_player_tips_1"
	},
	{
		411016,
		16,
		1,
		"borrow_player_tips_1"
	},
	{
		411017,
		17,
		1,
		"borrow_player_tips_1"
	},
	{
		411018,
		18,
		1,
		"borrow_player_tips_1"
	},
	{
		411019,
		19,
		1,
		"borrow_player_tips_1"
	},
	{
		411020,
		20,
		1,
		"borrow_player_tips_1"
	},
	{
		411021,
		21,
		1,
		"borrow_player_tips_1"
	},
	{
		411022,
		22,
		1,
		"borrow_player_tips_1"
	},
	{
		411023,
		23,
		1,
		"borrow_player_tips_1"
	}
}
local t_borrow_pet_activity = {
	[411001] = dataList[1],
	[411002] = dataList[2],
	[411003] = dataList[3],
	[411004] = dataList[4],
	[411005] = dataList[5],
	[411006] = dataList[6],
	[411007] = dataList[7],
	[411008] = dataList[8],
	[411009] = dataList[9],
	[411010] = dataList[10],
	[411011] = dataList[11],
	[411012] = dataList[12],
	[411013] = dataList[13],
	[411014] = dataList[14],
	[411015] = dataList[15],
	[411016] = dataList[16],
	[411017] = dataList[17],
	[411018] = dataList[18],
	[411019] = dataList[19],
	[411020] = dataList[20],
	[411021] = dataList[21],
	[411022] = dataList[22],
	[411023] = dataList[23]
}

t_borrow_pet_activity.dataList = dataList

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

return t_borrow_pet_activity
