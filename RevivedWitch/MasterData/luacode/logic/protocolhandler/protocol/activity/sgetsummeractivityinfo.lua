-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sgetsummeractivityinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.SummerActivityManagerID)
  dm:OnSGetSummerActivityInfo(protocol)
  if protocol.firstEnter == 1 then
    local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
    if sceneController then
      (sceneController._baseMainFSM):SetNumber("storyId", 2013)
    end
  else
    do
      local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
      if controller then
        (DialogManager.CreateSingletonDialog)("activity.swimsuit.entrymaindialog")
      else
        GlobalGameFSM:SetNumber("sceneLoadingId", 30015)
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

