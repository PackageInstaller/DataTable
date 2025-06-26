-- chunkname: @IQIGame\\Config\\CfgCupMatchVoteGlobalTable.lua

local CfgCupMatchVoteGlobalTable = {
	{
		FinalTime = 604800,
		KnockoutTime = 604800,
		Id = 1,
		Icon = "/Item/Item_IconWedding_Paper_01.png",
		GroupTime = 568800,
		BackGround = "/UI/_DailyActivityUI/VotingSystem_230223001.prefab",
		Name = getI18NValue(180505082),
		Desc = getI18NValue(180505081),
		GroupName = {
			getI18NValue(180506682),
			getI18NValue(180506683),
			getI18NValue(180506684),
			getI18NValue(180506685),
			getI18NValue(180506686),
			getI18NValue(180506687)
		},
		KnockoutGroupName = {
			getI18NValue(180506386),
			getI18NValue(180506387)
		},
		TicketName = getI18NValue(180506388),
		TicketDes = getI18NValue(180506385)
	}
}

setmetatable(CfgCupMatchVoteGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgCupMatchVoteGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		FinalTime = 0,
		KnockoutTime = 0,
		Name = "",
		Icon = "",
		TicketDes = "",
		GroupTime = 0,
		TicketName = "",
		BackGround = "",
		Desc = "",
		GroupName = {},
		KnockoutGroupName = {}
	}
}

for i, data in pairs(CfgCupMatchVoteGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgCupMatchVoteGlobalTable
