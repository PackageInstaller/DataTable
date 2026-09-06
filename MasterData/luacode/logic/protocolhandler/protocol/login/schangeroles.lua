local function IsInOldTeam(roleKey, oldRoles)
  for k, v in pairs(oldRoles) do
    if roleKey == v then
      return true
    end
  end
  return false
end

local function p1(protocol)
  local oldRoles = NekoData.BehaviorManager.BM_Team:GetTeamRoles(protocol.lineupId)
  local newRoles = protocol.roles
  for k, v in pairs(newRoles) do
    if 0 < v and IsInOldTeam(v, oldRoles) == false then
      local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v)
      NekoData.BehaviorManager.BM_Voice:Play(role:GetId(), NekoData.BehaviorManager.BM_Voice.VoiceType.Formation, nil)
    end
  end
  NekoData.DataManager.DM_Team:OnSChangeRoles(protocol)
  local userInfo = {}
  userInfo.name = "schangeroles"
  LuaNotificationCenter.PostNotification(Common.n_TeamInfoChange, DM_Team, userInfo)
  local dialog = DialogManager.GetDialog("teamedit.changeteamroledialog")
  if dialog then
    dialog:Destroy()
  end
  dialog = DialogManager.GetDialog("activity.christmas.christmaspart2commonbattlechangeteamdialog")
  if dialog then
    dialog:Destroy()
  end
end

local function p2(protocol, client)
end

return {p1, p2}
