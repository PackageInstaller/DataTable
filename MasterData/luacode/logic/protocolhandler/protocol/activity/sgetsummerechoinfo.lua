-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sgetsummerechoinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
  local dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
  dm:OnSGetSummerEchoInfo(protocol)
  if protocol.firstEnter == 1 then
    local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
    if sceneController then
      (sceneController._baseMainFSM):SetNumber("storyId", DataCommon.SummerEchoesTimeLineId)
    end
  else
    do
      do
        local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
        if controller then
          (DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.entrymaindialog")
        else
          GlobalGameFSM:SetNumber("sceneLoadingId", 30017)
        end
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_OnSSGetSummerEchoInfo, nil, nil)
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

