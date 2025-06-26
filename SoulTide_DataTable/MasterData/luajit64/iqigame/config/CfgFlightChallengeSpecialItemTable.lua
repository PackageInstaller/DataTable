-- chunkname: @IQIGame\\Config\\CfgFlightChallengeSpecialItemTable.lua

local CfgFlightChallengeSpecialItemTable = {
	{
		Duration = 8,
		Group = 1,
		BuffIcon = "/Activity/FlightGame/FlightElementNode/FlightElementNode_0.png",
		ItemSpine = 815301,
		Type = 1,
		Id = 1,
		Weight = 100,
		AttType = {
			6
		},
		AttValue = {
			1.5
		}
	},
	{
		Group = 1,
		Parameter = 30,
		Type = 2,
		Id = 2,
		Weight = 100,
		ItemSpine = 815307,
		AttType = {
			6
		},
		AttValue = {
			1.5
		}
	},
	{
		Group = 1,
		Duration = 10,
		BuffIcon = "/Activity/FlightGame/FlightElementNode/FlightElementNode_1.png",
		Parameter = 100,
		ItemSpine = 815302,
		Type = 3,
		Id = 3,
		Weight = 100,
		AttType = {
			6
		},
		AttValue = {
			1.5
		}
	},
	{
		Group = 1,
		Duration = 10,
		BuffIcon = "/Activity/FlightGame/FlightElementNode/FlightElementNode_2.png",
		Parameter = 101,
		ItemSpine = 815303,
		Type = 4,
		Id = 4,
		Weight = 50,
		AttType = {
			6
		},
		AttValue = {
			1.5
		}
	},
	{
		Group = 1,
		Duration = 10,
		BuffIcon = "/Activity/FlightGame/FlightElementNode/FlightElementNode_3.png",
		Parameter = 102,
		ItemSpine = 815304,
		Type = 4,
		Id = 5,
		Weight = 50,
		AttType = {
			6
		},
		AttValue = {
			1.5
		}
	},
	{
		Group = 1,
		Duration = 10,
		BuffIcon = "/Activity/FlightGame/FlightElementNode/FlightElementNode_4.png",
		Parameter = 103,
		ItemSpine = 815305,
		Type = 4,
		Id = 6,
		Weight = 50,
		AttType = {
			6
		},
		AttValue = {
			1.5
		}
	},
	{
		Group = 1,
		Parameter = 999999,
		Type = 5,
		Id = 7,
		Weight = 100,
		ItemSpine = 815306,
		AttType = {
			6
		},
		AttValue = {
			1.5
		}
	}
}

setmetatable(CfgFlightChallengeSpecialItemTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFlightChallengeSpecialItemTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		BuffIcon = "",
		Parameter = 0,
		ItemSpine = 0,
		Type = 0,
		Duration = 0,
		Weight = 0,
		AttType = {
			0
		},
		AttValue = {
			0
		}
	}
}

for i, data in pairs(CfgFlightChallengeSpecialItemTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFlightChallengeSpecialItemTable
