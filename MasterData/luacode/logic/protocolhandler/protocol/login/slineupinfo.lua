local function p1(protocol)
  NekoData.DataManager.DM_Team:OnSLineInfo(protocol)
  
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.OffLinePvp) then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.crequestfantasyconflictteam")
    if csend then
      csend:Send()
    end
  end
end

local function p2(protocol, client)
end

return {p1, p2}
