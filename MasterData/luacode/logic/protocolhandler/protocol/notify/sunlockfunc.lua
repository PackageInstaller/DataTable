local function p1(protocol)
  NekoData.DataManager.DM_Game:OnSUnlockFunc(protocol)
  
  local list = {}
  for i, v in ipairs(protocol.funcLisk) do
    table.insert(list, v)
    if v.funId == DataCommon.Functions.FirstReCharge then
      CS.UnityEngine.PlayerPrefs.SetInt("FirstReChargeRedPoint", 1)
    elseif v.funId == DataCommon.Functions.Signboard then
      CS.UnityEngine.PlayerPrefs.SetInt("FirstUnlockSignBoard", 1)
      local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
      if controller then
        controller:RefrashCharBubble()
      end
    elseif v.funId == DataCommon.Functions.Notice then
      NoticeManager.SetAutoPopup(false)
    elseif v.funId == DataCommon.Functions.Shop then
      NekoData.DataManager.DM_RedDot.CreateShopTree(true)
    elseif v.funId == DataCommon.Functions.Friend then
      NekoData.DataManager.DM_RedDot.CreateFriendTree(true)
    elseif v.funId == DataCommon.Functions.CourtYard then
      NekoData.DataManager.DM_RedDot.CreateCourtYardTree(true)
    elseif v.funId == DataCommon.Functions.Task_Every then
      NekoData.DataManager.DM_Task:RefreshDailyTaskRedData()
      NekoData.DataManager.DM_Task:RefreshAchievementTaskRedData()
    end
  end
  table.sort(list, function(a, b)
    return a.sortId < b.sortId
  end)
  for i, v in ipairs(list) do
    NekoData.BehaviorManager.BM_Message:PopFunctionUnlockDialog(v.funId)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
