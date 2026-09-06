-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_awaken_verification_pet.lua

module("logicconfig.config.t_pet_awaken_verification_pet", package.seeall)

local title = {
	skinId = 5,
	id = 2,
	petPlanId = 1,
	prizePlanId = 4,
	petName = 10,
	headPos = 8,
	endTime = 7,
	raceId = 3,
	rolePos = 9,
	startTime = 6
}
local dataList = {
	{
		1,
		1,
		16004,
		1,
		16004,
		"2022-01-28T05:00:00",
		"2022-02-18T05:00:00",
		{
			149,
			-196
		},
		{
			154.5,
			-16,
			-0.7
		},
		"星宙·超神圣龙"
	},
	{
		1,
		2,
		16003,
		2,
		16003,
		"2022-01-28T05:00:00",
		"2022-02-18T05:00:00",
		{
			212,
			-77
		},
		{
			61,
			-7.8,
			0.7
		},
		"神临王者·秩序"
	},
	{
		2,
		1,
		16005,
		3,
		16005,
		"2022-02-18T05:00:00",
		"2022-03-04T05:00:00",
		{
			149,
			-196
		},
		{
			26.4,
			1.11,
			-0.7
		},
		"无限未来·∞"
	},
	{
		3,
		1,
		16006,
		4,
		16006,
		"2022-03-04T05:00:00",
		"2022-04-01T05:00:00",
		{
			149,
			-196
		},
		{
			26.4,
			1.11,
			-0.7
		},
		"璨境女神·星绛"
	},
	{
		4,
		1,
		10314,
		5,
		10314,
		"2022-04-01T05:00:00",
		"2022-04-29T05:00:00",
		{
			220,
			10
		},
		{
			61,
			-7.8,
			0.7
		},
		"烈焰·无烬圣龙"
	},
	{
		4,
		2,
		16009,
		6,
		16009,
		"2022-04-15T05:00:00",
		"2022-05-06T05:00:00",
		{
			195,
			-100
		},
		{
			61,
			-7.8,
			0.7
		},
		"伙伴意志·极"
	},
	{
		4,
		3,
		12002,
		7,
		12002,
		"2022-04-29T05:00:00",
		"2022-06-02T05:00:00",
		{
			140,
			-200
		},
		{
			61,
			-7.8,
			0.7
		},
		"力量神祇·龙炎"
	},
	{
		4,
		4,
		12004,
		8,
		12004,
		"2022-05-13T05:00:00",
		"2022-06-02T05:00:00",
		{
			50,
			-265
		},
		{
			61,
			-7.8,
			0.7
		},
		"赤龙银甲·火次元"
	},
	{
		5,
		1,
		12005,
		9,
		12005,
		"2022-06-02T05:00:00",
		"2022-07-02T05:00:00",
		{
			149,
			-196
		},
		{
			26.4,
			1.11,
			-0.7
		},
		"维蕾塔"
	}
}
local t_pet_awaken_verification_pet = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3]
	},
	{
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9]
	}
}

t_pet_awaken_verification_pet.dataList = dataList

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

return t_pet_awaken_verification_pet
