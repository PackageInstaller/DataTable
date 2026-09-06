-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kun_lun_challenge_monster.lua

module("logicconfig.config.t_kun_lun_challenge_monster", package.seeall)

local title = {
	perfectWinId = 5,
	name = 2,
	WinDesc = 7,
	skipTime = 9,
	battleDesc = 3,
	retreatMsgType = 13,
	formCondition = 14,
	btlMode = 11,
	btlBg = 10,
	missionDesc = 4,
	heroSkillId = 15,
	winId = 12,
	creepsMasterId = 1,
	showFaceId = 8,
	selfBuffProviderId = 16,
	isHideOp = 6
}
local dataList = {
	{
		100001,
		"昆仑试炼-1",
		"",
		"",
		0,
		1,
		"",
		16013,
		5,
		"",
		"",
		0,
		0,
		0,
		"416013",
		194
	},
	{
		100002,
		"昆仑试炼-2",
		"",
		"",
		0,
		1,
		"",
		14011,
		5,
		"",
		"",
		0,
		0,
		0,
		"414011",
		194
	},
	{
		100003,
		"昆仑试炼-3",
		"",
		"",
		0,
		1,
		"",
		12012,
		5,
		"",
		"",
		0,
		0,
		0,
		"412012",
		194
	},
	{
		100004,
		"昆仑试炼-4",
		"",
		"",
		0,
		1,
		"",
		11010,
		5,
		"",
		"",
		0,
		0,
		0,
		"411010",
		194
	},
	{
		100005,
		"昆仑试炼-5",
		"",
		"",
		0,
		1,
		"",
		11012,
		5,
		"",
		"",
		0,
		0,
		0,
		"411012",
		194
	},
	{
		100006,
		"昆仑试炼-6",
		"",
		"",
		0,
		1,
		"",
		13009,
		5,
		"",
		"",
		0,
		0,
		0,
		"413009",
		194
	},
	{
		200001,
		"BOSS挑战",
		"",
		"",
		0,
		1,
		"",
		97002,
		5,
		"",
		"",
		117,
		0,
		0,
		"",
		0
	}
}
local t_kun_lun_challenge_monster = {
	[100001] = dataList[1],
	[100002] = dataList[2],
	[100003] = dataList[3],
	[100004] = dataList[4],
	[100005] = dataList[5],
	[100006] = dataList[6],
	[200001] = dataList[7]
}

t_kun_lun_challenge_monster.dataList = dataList

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

return t_kun_lun_challenge_monster
