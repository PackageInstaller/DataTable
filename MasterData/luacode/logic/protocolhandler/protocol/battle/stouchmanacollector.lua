local function p1(protocol)
  LogInfo("stouchmanacollector", "receive")
  
  NekoData.DataManager.DM_Dungeon:OnSTouchManaCollector(protocol)
  local randomKey = NekoData.BehaviorManager.BM_Team:GetRandomRoleKeyInCurrentTeam()
  local roleID = randomKey
end

local function p2(protocol, client)
end

return {p1, p2}
