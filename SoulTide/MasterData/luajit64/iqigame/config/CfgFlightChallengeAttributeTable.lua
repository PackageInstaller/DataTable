-- chunkname: @IQIGame\\Config\\CfgFlightChallengeAttributeTable.lua

local CfgFlightChallengeAttributeTable = {
	{
		Group = 1,
		ImageIcon = "/Activity/FlightGame/FlightGameCommon/FlightGameAtt_2.png",
		Id = 1,
		AttName = getI18NValue(180768324)
	},
	{
		Group = 1,
		ImageIcon = "/Activity/FlightGame/FlightGameCommon/FlightGameAtt_1.png",
		Id = 2,
		AttName = getI18NValue(180768325)
	},
	{
		Group = 1,
		ImageIcon = "/Activity/FlightGame/FlightGameCommon/FlightGameAtt_3.png",
		Id = 3,
		AttName = getI18NValue(180768326)
	},
	{
		Group = 1,
		ImageIcon = "/Activity/FlightGame/FlightGameCommon/FlightGameAtt_4.png",
		Id = 4,
		AttName = getI18NValue(180768327)
	},
	{
		Group = 1,
		ImageIcon = "/Activity/FlightGame/FlightGameCommon/FlightGameAtt_2.png",
		Id = 5,
		AttName = getI18NValue(180768328)
	},
	{
		Group = 1,
		ImageIcon = "/Activity/FlightGame/FlightGameCommon/FlightGameAtt_2.png",
		Id = 6,
		AttName = getI18NValue(180768329)
	}
}

setmetatable(CfgFlightChallengeAttributeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFlightChallengeAttributeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		ImageIcon = "",
		AttName = ""
	}
}

for i, data in pairs(CfgFlightChallengeAttributeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFlightChallengeAttributeTable
