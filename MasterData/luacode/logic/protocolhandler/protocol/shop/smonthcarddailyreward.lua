local function p1(protocol)
  local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  
  if not (sceneController and sceneController._baseMainFSM) or sceneController._baseMainFSM:GetCurrentState() ~= "Normal" then
    NekoData.DataManager.DM_ItemAccountShow:CacheShowDialogData({
      tag = DataCommon.ShowDialogType.MonthCardDailyAward,
      data = protocol.dailyReward
    })
  else
    NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
      tag = DataCommon.ShowDialogType.MonthCardDailyAward,
      data = protocol.dailyReward
    })
  end
end

local function p2(protocol, client)
end

return {p1, p2}
