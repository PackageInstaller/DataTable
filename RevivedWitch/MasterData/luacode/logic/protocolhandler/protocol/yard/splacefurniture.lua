-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/splacefurniture.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local roomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetRoomInfoById((protocol.floor).id)
  if roomInfo then
    for i,v in ipairs(roomInfo.roles) do
      ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = v, buildingId = nil})
    end
  end
  do
    for roleKey,leftRecoveryTime in pairs((protocol.floor).rolesLeftRecoveryTime) do
      ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = roleKey, buildingId = DataCommon.Cabin})
    end
    ;
    ((NekoData.DataManager).DM_Cabin):OnSPlaceFurniture(protocol)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshRoomFurnitures, nil, protocol)
    local dialog = (DialogManager.GetDialog)("courtcabin.dressupcabindialog")
    if dialog and dialog._willBack then
      (LuaNotificationCenter.PostNotification)(Common.n_ExitDressUpMode, dialog, nil)
      dialog:PlayExitAnimation()
    else
      ;
      (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

