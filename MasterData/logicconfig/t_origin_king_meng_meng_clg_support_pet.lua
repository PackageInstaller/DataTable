-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_king_meng_meng_clg_support_pet.lua

module("logicconfig.config.t_origin_king_meng_meng_clg_support_pet", package.seeall)

local title = {
	raceId = 4,
	summonMasterId = 9,
	creepsId = 2,
	carriedPetId = 13,
	faceId = 11,
	summonedPetId = 10,
	onlyUseExtProperties = 8,
	heavenAwakenSummonPetId = 17,
	supportPetPlanId = 3,
	activityId = 1,
	heavenAwakenMasterId = 16,
	oraclePetId = 15,
	creepsName = 5,
	extproperties = 7,
	oracleMasterId = 14,
	lv = 6,
	carriedMasterId = 12
}
local dataList = {
	{
		594001,
		100000001,
		1,
		11009,
		"神曜极睿·哆啦梦梦",
		100,
		"生命+3181538#攻击+347076#物防+188000#魔防+188000#速度+57846#起始气势+50#暴击率+0.2#格挡率+0.4#防暴率+0.4",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		594001,
		100000002,
		1,
		11010,
		"祈唤璨星·王者梦梦",
		100,
		"生命+2458461#攻击+462769#物防+151846#魔防+151846#速度+65076#起始气势+50#暴击率+0.4#格挡率+0.2#防暴率+0.2",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		594001,
		100000003,
		1,
		12017,
		"神曜炽火·热血梦梦",
		100,
		"生命+1446153#攻击+592923#物防+94000#魔防+86769#速度+86769#起始气势+50#暴击率+0.6",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		594001,
		100000004,
		1,
		13007,
		"神曜启蒙·炼金梦梦",
		100,
		"生命+2458461#攻击+462769#物防+151846#魔防+151846#速度+65076#起始气势+50#暴击率+0.4#格挡率+0.2#防暴率+0.2",
		true,
		"",
		"100000007",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		594001,
		100000005,
		1,
		14015,
		"神曜天使·爱心梦梦",
		100,
		"生命+2096923#攻击+433846#物防+144615#魔防+144615#速度+86769#起始气势+50#暴击率+0.5",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		594001,
		100000006,
		1,
		15016,
		"神曜佑魂·暗黑梦梦",
		100,
		"生命+1446153#攻击+592923#物防+86769#魔防+94000#速度+86769#起始气势+50#暴击率+0.6",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		594001,
		100000007,
		1,
		11041,
		"祈唤璨梦·王者梦梦",
		100,
		"生命+2458461#攻击+462769#物防+151846#魔防+151846#速度+65076#起始气势+80#暴击率+0.4#格挡率+0.2#防暴率+0.2",
		true,
		"100000004",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		594001,
		100000008,
		1,
		11042,
		"真理之智·哆啦梦梦",
		100,
		"生命+3181538#攻击+347076#物防+188000#魔防+188000#速度+57846#起始气势+80#暴击率+0.2#格挡率+0.4#防暴率+0.4",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		594001,
		100000009,
		1,
		18031,
		"至高天理·创世圣龙",
		100,
		"生命+1735384#攻击+491692#物防+94000#魔防+94000#速度+101230#起始气势+80#暴击率+0.6",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		594001,
		100000010,
		2,
		11010,
		"祈唤璨星·王者梦梦",
		100,
		"生命+1569230#攻击+210989#物防+96923#魔防+96923#速度+41538",
		true,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	}
}
local t_origin_king_meng_meng_clg_support_pet = {
	[594001] = {
		[100000001] = dataList[1],
		[100000002] = dataList[2],
		[100000003] = dataList[3],
		[100000004] = dataList[4],
		[100000005] = dataList[5],
		[100000006] = dataList[6],
		[100000007] = dataList[7],
		[100000008] = dataList[8],
		[100000009] = dataList[9],
		[100000010] = dataList[10]
	}
}

t_origin_king_meng_meng_clg_support_pet.dataList = dataList

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

return t_origin_king_meng_meng_clg_support_pet
