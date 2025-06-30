-- chunkname: @IQIGame\\Config\\CfgChangeSoulMoodEventResTable.lua

local CfgChangeSoulMoodEventResTable = {
	{
		Id = 1,
		ChangeMoodType = 1,
		EventType = 1,
		ChangeMoodRange = {
			4,
			6
		}
	},
	{
		Id = 2,
		ChangeMoodType = 1,
		EventType = 2,
		ChangeMoodRange = {
			1,
			5
		}
	},
	{
		Id = 3,
		ChangeMoodType = 1,
		EventType = 3,
		ChangeMoodRange = {
			5,
			10
		}
	},
	{
		Id = 4,
		ChangeMoodType = 2,
		EventType = 4,
		ChangeMoodRange = {
			5,
			10
		}
	},
	{
		Id = 5,
		ChangeMoodType = 3,
		EventType = 5
	},
	{
		Id = 6,
		ChangeMoodType = 1,
		EventType = 6,
		ChangeMoodRange = {
			1,
			5
		}
	},
	{
		Id = 7,
		ChangeMoodType = 1,
		EventType = 7,
		ChangeMoodRange = {
			1,
			5
		}
	},
	{
		Id = 8,
		ChangeMoodType = 1,
		EventType = 8,
		ChangeMoodRange = {
			1,
			5
		}
	},
	{
		Id = 9,
		ChangeMoodType = 1,
		EventType = 9,
		ChangeMoodRange = {
			1,
			5
		}
	},
	{
		Id = 10,
		ChangeMoodType = 2,
		EventType = 10,
		ChangeMoodRange = {
			5,
			10
		}
	}
}

setmetatable(CfgChangeSoulMoodEventResTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgChangeSoulMoodEventResTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ChangeMoodType = 0,
		EventType = 0,
		ChangeMoodRange = {}
	}
}

for i, data in pairs(CfgChangeSoulMoodEventResTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgChangeSoulMoodEventResTable
