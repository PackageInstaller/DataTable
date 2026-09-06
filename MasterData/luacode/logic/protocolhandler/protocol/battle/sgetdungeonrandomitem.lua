local function p1(protocol)
  local item = RandomItemManager.GetRandomItem(protocol.key)
  
  if item and item:GetType() == RandomItemManager.Type.RecoverShrine then
    local randomKey = NekoData.BehaviorManager.BM_Team:GetRandomRoleKeyInCurrentTeam()
    local roleID = randomKey
    NekoData.BehaviorManager.BM_Voice:Play(roleID, NekoData.BehaviorManager.BM_Voice.VoiceType.LifeHealing, nil)
  end
  NekoData.BehaviorManager.BM_Dungeon:OnSGetDungeonRandomItem(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
