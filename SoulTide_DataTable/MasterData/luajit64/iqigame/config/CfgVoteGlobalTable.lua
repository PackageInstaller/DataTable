-- chunkname: @IQIGame\\Config\\CfgVoteGlobalTable.lua

local CfgVoteGlobalTable = {
	{
		Id = 1,
		BackGround = "/UI/_DailyActivityUI/VotingSystem_220113001.prefab",
		Name = getI18NValue(180247373),
		VoteNeeds = {
			405,
			1
		}
	}
}

setmetatable(CfgVoteGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgVoteGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		BackGround = "",
		Name = "",
		Desc = "",
		VoteNeeds = {}
	}
}

for i, data in pairs(CfgVoteGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgVoteGlobalTable
