-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/srefreshmagictree.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.task")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local level = ((NekoData.BehaviorManager).BM_MagicTree):GetLevel()
  ;
  ((NekoData.DataManager).DM_MagicTree):OnSRefreshMagicTree(protocol)
  do
    if level < (protocol.magicTree).level then
      local dialog = (DialogManager.GetDialog)("magictree.magictreedialog")
      if dialog then
        dialog._magicTreeLvUpClick = false
      end
      ;
      ((DialogManager.CreateSingletonDialog)("magictree.magictreelvupsuccessdialog")):Init(level, (protocol.magicTree).level)
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_BuildingLevelUp, nil, {buildingId = DataCommon.MagicTree})
    end
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshMagicTree, nil, protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

