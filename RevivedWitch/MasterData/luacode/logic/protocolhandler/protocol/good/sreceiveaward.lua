-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/good/sreceiveaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CFavourPresent = (BeanManager.GetTableByName)("role.cfavourpresent")
local CFavourGiftType = (BeanManager.GetTableByName)("role.cfavourgifttype")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, CFavourPresent, CFavourGiftType
  ((NekoData.DataManager).DM_AllRoles):OnSReceiveAward(protocol)
  local relationPresentRecord = CFavourPresent:GetRecorder(protocol.roleId)
  do
    if relationPresentRecord then
      local rewardType = (relationPresentRecord.levelRewardType)[protocol.level]
      if rewardType == (DataCommon.Favour).Skill then
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100246)
      else
        if rewardType == (DataCommon.Favour).BackgroundStory then
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100247, {(TextManager.GetText)(((CFavourGiftType:GetRecorder(rewardType)).storyandlineid)[(relationPresentRecord.levelRewardID)[protocol.level]])})
        else
          if rewardType == (DataCommon.Favour).Voice then
            ((NekoData.BehaviorManager).BM_Message):SendMessageById(100248, {(TextManager.GetText)(((CFavourGiftType:GetRecorder(rewardType)).storyandlineid)[(relationPresentRecord.levelRewardID)[protocol.level]])})
          end
        end
      end
    end
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(protocol.roleId)
    do
      if role then
        local data = {}
        data.id = protocol.roleId
        data.canDrawAward = role:IsShowRelationRedDot()
        ;
        ((NekoData.DataManager).DM_HandBook):OnSRefreshRoleFavorAwardStatus(data)
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_RefreshRoleFavorAwardStatus, nil, data)
      end
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_RoleGoodReceiveAward, nil, protocol)
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

