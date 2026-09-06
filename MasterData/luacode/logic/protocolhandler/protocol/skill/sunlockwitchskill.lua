local function p1(protocol)
  LogInfo("sunlockwitchskill", "receive")
  
  NekoData.DataManager.DM_AllRoles:OnSUnlockWitchSkill(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
