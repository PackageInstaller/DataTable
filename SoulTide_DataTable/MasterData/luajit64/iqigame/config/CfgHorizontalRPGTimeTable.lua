-- chunkname: @IQIGame\\Config\\CfgHorizontalRPGTimeTable.lua

local CfgHorizontalRPGTimeTable = {
	{
		Id = 1,
		MazeInstanceId = 26070001,
		ResId = {
			1039,
			1040
		}
	},
	{
		Id = 2,
		MazeInstanceId = 26070002,
		ResId = {
			1041,
			1042
		}
	},
	{
		Id = 3,
		MazeInstanceId = 26070003,
		ResId = {
			1043,
			1044
		}
	},
	{
		Id = 4,
		MazeInstanceId = 26070004,
		ResId = {
			1043,
			1044
		}
	},
	{
		Id = 5,
		MazeInstanceId = 26070005,
		ResId = {
			1043,
			1044
		}
	},
	{
		Id = 6,
		MazeInstanceId = 26070006,
		ResId = {
			1043,
			1044
		}
	},
	{
		Id = 7,
		MazeInstanceId = 26070007,
		ResId = {
			1041,
			1042
		}
	},
	{
		Id = 8,
		MazeInstanceId = 26070008,
		ResId = {
			1041,
			1042
		}
	},
	{
		Id = 9,
		MazeInstanceId = 26070009,
		ResId = {
			1039,
			1040
		}
	},
	{
		Id = 10,
		MazeInstanceId = 26070010,
		ResId = {
			1043,
			1044
		}
	}
}

setmetatable(CfgHorizontalRPGTimeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHorizontalRPGTimeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		MazeInstanceId = 0,
		ResId = {}
	}
}

for i, data in pairs(CfgHorizontalRPGTimeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHorizontalRPGTimeTable
