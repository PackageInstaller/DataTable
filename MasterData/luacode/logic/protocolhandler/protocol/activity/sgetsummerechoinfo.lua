local function p1(protocol)
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
  
  local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
  dm:OnSGetSummerEchoInfo(protocol)
  if protocol.firstEnter == 1 then
    local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if sceneController then
      sceneController._baseMainFSM:SetNumber("storyId", DataCommon.SummerEchoesTimeLineId)
    end
  else
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if controller then
      DialogManager.CreateSingletonDialog("activity.swimsuitechoes.entrymaindialog")
    else
      GlobalGameFSM:SetNumber("sceneLoadingId", 30017)
    end
  end
  LuaNotificationCenter.PostNotification(Common.n_OnSSGetSummerEchoInfo, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
