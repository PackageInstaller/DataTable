-- chunkname: @IQIGame\\Config\\CfgSpaceTreasureGlobalTable.lua

local CfgSpaceTreasureGlobalTable = {
	{
		Id = 1,
		NeedPower = 1,
		BackGround = "/UI/_DailyActivityUI/MazeHidden_211202.prefab",
		Name = getI18NValue(180150113),
		Reward = {
			1201086,
			1201087,
			1201088,
			1201089
		}
	}
}

setmetatable(CfgSpaceTreasureGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSpaceTreasureGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		NeedPower = 0,
		BackGround = "",
		Desc = "",
		Reward = {}
	}
}

for i, data in pairs(CfgSpaceTreasureGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSpaceTreasureGlobalTable
