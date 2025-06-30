-- chunkname: @IQIGame\\Config\\CfgCheckInSoulMoodReduceEffectTable.lua

local CfgCheckInSoulMoodReduceEffectTable = {
	{
		Id = 1,
		level = 1,
		ComfortNum = {
			0,
			500
		},
		ChangeMoodSpeedWord = getI18NValue(180004024)
	},
	{
		Id = 2,
		ChangeMoodSpeed = 10,
		level = 2,
		ComfortNum = {
			500,
			1000
		},
		ChangeMoodSpeedWord = getI18NValue(180004025)
	},
	{
		Id = 3,
		ChangeMoodSpeed = 20,
		level = 3,
		ComfortNum = {
			1000,
			1500
		},
		ChangeMoodSpeedWord = getI18NValue(180004026)
	},
	{
		Id = 4,
		ChangeMoodSpeed = 30,
		level = 4,
		ComfortNum = {
			1500,
			2000
		},
		ChangeMoodSpeedWord = getI18NValue(180004027)
	},
	{
		Id = 5,
		ChangeMoodSpeed = 40,
		level = 5,
		ComfortNum = {
			2000,
			2500
		},
		ChangeMoodSpeedWord = getI18NValue(180004028)
	},
	{
		Id = 6,
		ChangeMoodSpeed = 50,
		level = 6,
		ComfortNum = {
			2500,
			3000
		},
		ChangeMoodSpeedWord = getI18NValue(180004029)
	},
	{
		Id = 7,
		ChangeMoodSpeed = 60,
		level = 7,
		ComfortNum = {
			3000,
			3500
		},
		ChangeMoodSpeedWord = getI18NValue(180004030)
	},
	{
		Id = 8,
		ChangeMoodSpeed = 70,
		level = 8,
		ComfortNum = {
			3500,
			4000
		},
		ChangeMoodSpeedWord = getI18NValue(180004031)
	},
	{
		Id = 9,
		ChangeMoodSpeed = 80,
		level = 9,
		ComfortNum = {
			4000,
			4500
		},
		ChangeMoodSpeedWord = getI18NValue(180004032)
	},
	{
		Id = 10,
		ChangeMoodSpeed = 90,
		level = 10,
		ComfortNum = {
			4500,
			5000
		},
		ChangeMoodSpeedWord = getI18NValue(180004033)
	},
	{
		Id = 11,
		ChangeMoodSpeed = 100,
		level = 11,
		ComfortNum = {
			5000,
			9999999
		},
		ChangeMoodSpeedWord = getI18NValue(180004034)
	}
}

setmetatable(CfgCheckInSoulMoodReduceEffectTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgCheckInSoulMoodReduceEffectTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ChangeMoodSpeedWord = "",
		ChangeMoodSpeed = 0,
		level = 0,
		ComfortNum = {}
	}
}

for i, data in pairs(CfgCheckInSoulMoodReduceEffectTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgCheckInSoulMoodReduceEffectTable
