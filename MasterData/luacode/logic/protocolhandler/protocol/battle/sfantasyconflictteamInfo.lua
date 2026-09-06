local function p1(protocol)
  NekoData.BehaviorManager.BM_Team:SetSeasonPvpTeam(3000, protocol.attackteam)
  
  NekoData.BehaviorManager.BM_Team:SetSeasonPvpTeam(3100, protocol.defendteam)
end

local function p2(protocol, client)
end

return {p1, p2}
