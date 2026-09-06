local function p1(protocol)
  if protocol.sendType == 2 and NekoData.BehaviorManager.BM_Task:GetAchievement() then
    local list = NekoData.BehaviorManager.BM_Task:GetAchievement().badges
    
    if list then
      for k, v in pairs(protocol.achievement.badges) do
        local ishas = false
        for id, _ in pairs(list) do
          if id == k then
            ishas = true
            break
          end
        end
        if not ishas then
          NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
            tag = DataCommon.ShowDialogType.RoleAchievementGetShow,
            data = k
          })
          break
        end
      end
    else
      for k, v in pairs(protocol.achievement.badges) do
        NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
          tag = DataCommon.ShowDialogType.RoleAchievementGetShow,
          data = k
        })
      end
    end
  end
  NekoData.DataManager.DM_Task:OnSRefreshAchievementInfo(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshAchievementLevelAward, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
