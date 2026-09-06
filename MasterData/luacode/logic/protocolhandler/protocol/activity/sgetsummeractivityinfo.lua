local function p1(protocol)
  local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.SummerActivityManagerID)
  
  dm:OnSGetSummerActivityInfo(protocol)
  if protocol.firstEnter == 1 then
    local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if sceneController then
      sceneController._baseMainFSM:SetNumber("storyId", 2013)
    end
  else
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if controller then
      DialogManager.CreateSingletonDialog("activity.swimsuit.entrymaindialog")
    else
      GlobalGameFSM:SetNumber("sceneLoadingId", 30015)
    end
  end
end

local function p2(protocol, client)
end

return {p1, p2}
