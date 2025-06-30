-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/srefreshalchemy.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.task")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local roleKeyPre = (((NekoData.BehaviorManager).BM_Alchemy):GetDispatchRoles())[1]
  local roleKey = (protocol.alchemy).roleId
  if (roleKeyPre and roleKeyPre ~= roleKey) or not roleKeyPre and roleKey ~= 0 then
    ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = roleKeyPre, buildingId = nil})
    local dialog = (DialogManager.GetDialog)("magictree.chooseroledialog")
    if dialog and dialog._buildingId == DataCommon.Alchemy then
      dialog:Destroy()
      if roleKey and roleKey ~= DataCommon.LeaderId then
        ((NekoData.BehaviorManager).BM_Voice):Play(roleKey, (((NekoData.BehaviorManager).BM_Voice).VoiceType).Dispatch, nil)
      end
    end
    ;
    ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = roleKey, buildingId = DataCommon.Alchemy})
    ;
    ((NekoData.DataManager).DM_Alchemy):OnSRefreshAlchemy(protocol)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_AlchemyRoleChanged, nil, protocol)
  else
    do
      local level = ((NekoData.BehaviorManager).BM_Alchemy):GetLevel()
      if level == 0 and (protocol.alchemy).alchemyLevel == 1 then
        (LuaNotificationCenter.PostNotification)(Common.n_BuildingUnlock, nil, {buildingId = DataCommon.Alchemy})
      end
      if #protocol.mainResult > 0 then
        ((DialogManager.CreateSingletonDialog)("alchemy.productaccountdialog")):SetData(protocol)
      end
      ;
      ((NekoData.DataManager).DM_Alchemy):OnSRefreshAlchemy(protocol)
      if level < (protocol.alchemy).alchemyLevel then
        (LuaNotificationCenter.PostNotification)(Common.n_BuildingLevelUp, nil, {buildingId = DataCommon.Alchemy})
      end
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_RefreshAlchemy, nil, protocol)
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

