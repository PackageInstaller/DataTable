-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_commonactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_CommonActivity = class("DM_CommonActivity")
local CActiveMissionModReward = (BeanManager.GetTableByName)("mission.cactivemissionmodreward")
DM_CommonActivity.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).taskshopactivity
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).actInfo = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).timer = {}
end

DM_CommonActivity.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs((self._data).actInfo) do
    self:RemoveTimer(k)
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).actInfo = {}
end

DM_CommonActivity.RemoveTimer = function(self, actId)
  -- function num : 0_2 , upvalues : _ENV
  local timerId = ((self._data).timer)[actId]
  if timerId then
    (GameTimer.RemoveTask)(timerId)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._data).timer)[actId] = nil
  end
end

DM_CommonActivity.OnSTaskShopAct = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, CActiveMissionModReward
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).actInfo = {}
  local actId = protocol.activityId
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self._data).actInfo)[actId] = {}
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self._data).actInfo)[actId]).awardIdList = {}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self._data).actInfo)[actId]).receivedList = {}
  for k,v in pairs(protocol.award) do
    (table.insert)((((self._data).actInfo)[actId]).awardIdList, k)
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R8 in 'UnsetPending'

    if v == 1 then
      ((((self._data).actInfo)[actId]).receivedList)[k] = true
    end
  end
  ;
  (table.sort)((((self._data).actInfo)[actId]).awardIdList, function(a, b)
    -- function num : 0_3_0 , upvalues : CActiveMissionModReward
    local _a = CActiveMissionModReward:GetRecorder(a)
    local _b = CActiveMissionModReward:GetRecorder(b)
    do return _a.needNum < _b.needNum end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self._data).actInfo)[actId]).leftTime = protocol.leftTime
  self:RemoveTimer(actId)
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R3 in 'UnsetPending'

  if protocol.leftTime > 0 then
    ((self._data).timer)[actId] = (GameTimer.AddTask)((math.ceil)(protocol.leftTime / 1000), 0, function()
    -- function num : 0_3_1 , upvalues : self, actId, _ENV
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    ((self._data).actInfo)[actId] = nil
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_OnSTaskShopActRefresh, nil, "close")
  end
)
  else
    -- DECOMPILER ERROR at PC74: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._data).actInfo)[actId] = nil
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_OnSTaskShopActRefresh, nil, "close")
  end
end

DM_CommonActivity.OnSReceiveTaskShop = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  if (table.contain)((((self._data).actInfo)[protocol.activityId]).awardIdList, protocol.rewardID) then
    if not ((((self._data).actInfo)[protocol.activityId]).receivedList)[protocol.rewardID] then
      ((((self._data).actInfo)[protocol.activityId]).receivedList)[protocol.rewardID] = true
    else
      LogErrorFormat("DM_CommonActivity", "Repeat pick up: ActivityID:%s,RewardID:%s", protocol.activityId, protocol.rewardID)
    end
  else
    LogErrorFormat("DM_CommonActivity", "non-existent activity data:%s", protocol.activityId)
  end
end

return DM_CommonActivity

