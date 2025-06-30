-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/login/schangeroles.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local IsInOldTeam = function(roleKey, oldRoles)
  -- function num : 0_0 , upvalues : _ENV
  for k,v in pairs(oldRoles) do
    if roleKey == v then
      return true
    end
  end
  return false
end

local p1 = function(protocol)
  -- function num : 0_1 , upvalues : _ENV, IsInOldTeam
  local oldRoles = ((NekoData.BehaviorManager).BM_Team):GetTeamRoles(protocol.lineupId)
  local newRoles = protocol.roles
  for k,v in pairs(newRoles) do
    if v > 0 and IsInOldTeam(v, oldRoles) == false then
      local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(v)
      ;
      ((NekoData.BehaviorManager).BM_Voice):Play(role:GetId(), (((NekoData.BehaviorManager).BM_Voice).VoiceType).Formation, nil)
    end
  end
  ;
  ((NekoData.DataManager).DM_Team):OnSChangeRoles(protocol)
  local userInfo = {}
  userInfo.name = "schangeroles"
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TeamInfoChange, DM_Team, userInfo)
  local dialog = (DialogManager.GetDialog)("teamedit.changeteamroledialog")
  if dialog then
    dialog:Destroy()
  end
  dialog = (DialogManager.GetDialog)("activity.christmas.christmaspart2commonbattlechangeteamdialog")
  if dialog then
    dialog:Destroy()
  end
end

local p2 = function(protocol, client)
  -- function num : 0_2
end

return {p1, p2}

