-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/chat/srefreshsupportrolelist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local resourceFloorDialog = (DialogManager.GetDialog)("mainline.resource.resourcefloordialog")
  if resourceFloorDialog and not ((NekoData.BehaviorManager).BM_Team):GetTeamEditCopyInfo() then
    LogError("srefreshsupportrolelist 数据不匹配")
    return 
  end
  ;
  ((NekoData.DataManager).DM_Friends):OnSRefreshSupportRoleList(protocol)
  local selectLevelMainDialog = (DialogManager.GetDialog)("activity.starmirage.selectlevelmaindialog")
  do
    if selectLevelMainDialog then
      local tabCell = (selectLevelMainDialog._tabFrame):GetCellAtIndex(selectLevelMainDialog._tabType)
      if tabCell and not tabCell._selectLevelId then
        return 
      end
    end
    local dialog = (DialogManager.GetDialog)("assistbattle.choosesupportroledialog")
    if not dialog then
      dialog = (DialogManager.CreateSingletonDialog)("assistbattle.choosesupportroledialog")
    end
    dialog:OnSRefreshSupportRoleList(protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

