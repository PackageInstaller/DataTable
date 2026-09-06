-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_throw_shells_monster.lua

module("logicconfig.config.t_throw_shells_monster", package.seeall)

local title = {
	interval = 8,
	monsterPlanId = 1,
	srcScale = 5,
	blood = 9,
	damageScale = 10,
	xMove = 6,
	monsterSrc = 4,
	raceId = 3,
	monsterId = 2,
	yMove = 7
}
local dataList = {
	{
		1,
		1,
		10020,
		"10020_yuandulingbao/10020_yuandulingbao-ui_p",
		0.15,
		nil,
		nil,
		0,
		1000,
		2
	},
	{
		2,
		1,
		10159,
		"10159_gongfuxiongmao/10159_gongfuxiongmao-ui_p",
		0.15,
		{
			-110,
			145
		},
		nil,
		50,
		1000,
		2
	},
	{
		3,
		1,
		10362,
		"10362_daitouya/10362_daitouya-ui_p",
		0.2,
		nil,
		nil,
		0,
		1000,
		2
	},
	{
		3,
		2,
		10020,
		"10020_yuandulingbao/10020_yuandulingbao-ui_p",
		0.15,
		nil,
		nil,
		0,
		1000,
		2
	},
	{
		4,
		1,
		10365,
		"10365_panglulu/10365_panglulu-ui_p",
		0.15,
		nil,
		nil,
		0,
		900,
		2
	},
	{
		4,
		2,
		10362,
		"10362_daitouya/10362_daitouya-ui_p",
		0.2,
		nil,
		nil,
		0,
		900,
		2
	},
	{
		5,
		1,
		10374,
		"10374_yuling/10374_yuling-ui_p",
		0.17,
		nil,
		nil,
		0,
		600,
		2
	},
	{
		5,
		2,
		10374,
		"10374_yuling/10374_yuling-ui_p",
		0.17,
		nil,
		nil,
		0,
		600,
		2
	},
	{
		5,
		3,
		10374,
		"10374_yuling/10374_yuling-ui_p",
		0.17,
		nil,
		nil,
		0,
		600,
		2
	},
	{
		6,
		1,
		10350,
		"10350_shuguangshujing/10350_shuguangshujing-ui_p",
		0.2,
		nil,
		nil,
		0,
		1000,
		2
	},
	{
		7,
		1,
		10374,
		"10374_yuling/10374_yuling-ui_p",
		0.2,
		nil,
		nil,
		0,
		1000,
		2
	},
	{
		7,
		2,
		10016,
		"10016_sagute/10016_sagute-ui_p",
		0.2,
		nil,
		nil,
		0,
		1000,
		2
	},
	{
		8,
		1,
		10055,
		"10055_tuzhutailang/10055_tuzhutailang-ui_p",
		0.15,
		nil,
		nil,
		0,
		1000,
		2
	},
	{
		9,
		1,
		10047,
		"10047_haibulan/10047_haibulan-ui_p",
		0.2,
		nil,
		nil,
		0,
		1000,
		2
	},
	{
		9,
		2,
		10048,
		"10048_gulumaoniu/10048_gulumaoniu-ui_p",
		0.2,
		nil,
		nil,
		0,
		1000,
		2
	},
	{
		9,
		3,
		10049,
		"10049_nuhuozhizhu/10049_nuhuozhizhu-ui_p",
		0.2,
		nil,
		nil,
		0,
		1000,
		2
	}
}
local t_throw_shells_monster = {
	{
		dataList[1]
	},
	{
		dataList[2]
	},
	{
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10]
	},
	{
		dataList[11],
		dataList[12]
	},
	{
		dataList[13]
	},
	{
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_throw_shells_monster.dataList = dataList

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

return t_throw_shells_monster
