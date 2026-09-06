local CFavourPresent = BeanManager.GetTableByName("role.cfavourpresent")
local CFavourGiftType = BeanManager.GetTableByName("role.cfavourgifttype")

local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSReceiveAward(protocol)
  local relationPresentRecord = CFavourPresent:GetRecorder(protocol.roleId)
  if relationPresentRecord then
    local rewardType = relationPresentRecord.levelRewardType[protocol.level]
    if rewardType == DataCommon.Favour.Skill then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100246)
    elseif rewardType == DataCommon.Favour.BackgroundStory then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100247, {
        TextManager.GetText(CFavourGiftType:GetRecorder(rewardType).storyandlineid[relationPresentRecord.levelRewardID[protocol.level]])
      })
    elseif rewardType == DataCommon.Favour.Voice then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100248, {
        TextManager.GetText(CFavourGiftType:GetRecorder(rewardType).storyandlineid[relationPresentRecord.levelRewardID[protocol.level]])
      })
    end
  end
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(protocol.roleId)
  if role then
    local data = {}
    data.id = protocol.roleId
    data.canDrawAward = role:IsShowRelationRedDot()
    NekoData.DataManager.DM_HandBook:OnSRefreshRoleFavorAwardStatus(data)
    LuaNotificationCenter.PostNotification(Common.n_RefreshRoleFavorAwardStatus, nil, data)
  end
  LuaNotificationCenter.PostNotification(Common.n_RoleGoodReceiveAward, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
