-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/srefreshcaverntask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SlotStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.caverntask")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local slot = ((NekoData.BehaviorManager).BM_Explore):GetSlotInfoBySlotId((protocol.task).Id)
  if slot then
    local tag = false
    local rolesMap = {}
    local rolesNum = 0
    for i,v in ipairs(slot.roles) do
      ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = v, buildingId = nil})
      rolesMap[v] = true
      rolesNum = rolesNum + 1
    end
    local dialog = (DialogManager.GetDialog)("magictree.chooseroledialog")
    if dialog and dialog._buildingId == DataCommon.Explore and dialog._slotId and dialog._slotId == slot.slotId then
      local num = #(protocol.task).roles
      local randomNewRoleKey = nil
      if rolesNum ~= num then
        tag = true
        for i,v in ipairs((protocol.task).roles) do
          if v.roleId ~= DataCommon.LeaderId then
            randomNewRoleKey = v.roleId
            break
          end
        end
      end
      do
        do
          if tag then
            (DialogManager.DestroySingletonDialog)("magictree.chooseroledialog")
            if randomNewRoleKey then
              ((NekoData.BehaviorManager).BM_Voice):Play(randomNewRoleKey, (((NekoData.BehaviorManager).BM_Voice).VoiceType).Dispatch, nil)
            end
          end
          for i,v in ipairs((protocol.task).roles) do
            ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = v.roleId, buildingId = DataCommon.Explore})
          end
          ;
          ((NekoData.DataManager).DM_Explore):OnSRefreshCavernTask(protocol)
          ;
          (LuaNotificationCenter.PostNotification)(Common.n_RefreshExploreSlot, nil, protocol)
        end
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

