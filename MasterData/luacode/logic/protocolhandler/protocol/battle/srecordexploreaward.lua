local function p1(protocol)
  LogInfo("srecordexploreaward", "recevie")
  
  NekoData.DataManager.DM_Dungeon:OnSRecordExploreAward(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
