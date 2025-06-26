-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/srefreshfloor.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local tag = false
  local rolesMap = {}
  local rolesNum = 0
  local roomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetRoomInfoById((protocol.floor).id)
  if roomInfo then
    for i,v in ipairs(roomInfo.roles) do
      ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = v, buildingId = nil})
      rolesMap[v] = true
      rolesNum = rolesNum + 1
    end
  end
  do
    local curRolesNum = 0
    local randomNewRoleKey = nil
    for roleKey,leftRecoveryTime in pairs((protocol.floor).rolesLeftRecoveryTime) do
      ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = roleKey, buildingId = DataCommon.Cabin})
      curRolesNum = curRolesNum + 1
      if not rolesMap[roleKey] then
        tag = true
        if not randomNewRoleKey and roleKey ~= DataCommon.LeaderId then
          randomNewRoleKey = roleKey
        end
      end
    end
    local dialog = (DialogManager.GetDialog)("magictree.chooseroledialog")
    if dialog and dialog._buildingId == DataCommon.Cabin and dialog._slotId and dialog._slotId == (protocol.floor).id and (curRolesNum ~= rolesNum or tag) then
      dialog:Destroy()
      if randomNewRoleKey then
        ((NekoData.BehaviorManager).BM_Voice):Play(randomNewRoleKey, (((NekoData.BehaviorManager).BM_Voice).VoiceType).Dispatch, nil)
      end
    end
    ;
    ((NekoData.DataManager).DM_Cabin):OnSRefreshFloor(protocol)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshRoom, nil, protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

