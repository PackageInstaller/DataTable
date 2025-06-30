-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_sign.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Sign = class("DM_Sign")
DM_Sign.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).sign
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).signActivity = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).signActivityState = false
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).returnsignActivityState = false
end

DM_Sign.Clear = function(self)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).signActivity = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).signActivityState = false
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).returnsignActivityState = false
end

DM_Sign.OnSSignActivity = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  local activity = ((self._data).signActivity)[protocol.actId]
  if not activity then
    local awards = {}
    for index,award in ipairs(protocol.awards) do
      (table.insert)(awards, {itemId = award.itemId, itemNum = award.itemNum, receive = award.receive == 1, index = index})
    end
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self._data).signActivity)[protocol.actId] = {id = protocol.actId, awards = awards, totalSignNum = protocol.totalSignNum}
    local CWelfareTabCfg = (BeanManager.GetTableByName)("welfare.cwelfaretabconfig")
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

    if CWelfareTabCfg:GetRecorder(protocol.actId) then
      (((self._data).signActivity)[protocol.actId]).iswelfare = true
    else
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R5 in 'UnsetPending'

      (((self._data).signActivity)[protocol.actId]).iswelfare = false
    end
  else
    activity.awards = {}
    for index,award in ipairs(protocol.awards) do
      (table.insert)(activity.awards, {itemId = award.itemId, itemNum = award.itemNum, receive = award.receive == 1, index = index})
    end
    activity.totalSignNum = protocol.totalSignNum
  end
  self:RefreshSignActivityState()
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

DM_Sign.OnSReceiveAward = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  local act = ((self._data).signActivity)[protocol.actId]
  if act then
    for i,v in ipairs(protocol.index) do
      local award = (act.awards)[v]
      if award then
        award.receive = true
      else
        LogErrorFormat("DM_Sign", "awardIndex = %s does not exist!", v)
      end
    end
  else
    do
      LogErrorFormat("DM_Sign", "actId = %s does not exist!", protocol.actId)
      self:RefreshSignActivityState()
    end
  end
end

DM_Sign.RefreshSignActivityState = function(self)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).signActivityState = false
  for _,activity in pairs((self._data).signActivity) do
    if activity.iswelfare then
      for _,award in ipairs(activity.awards) do
        -- DECOMPILER ERROR at PC22: Confused about usage of register: R11 in 'UnsetPending'

        if award.index <= activity.totalSignNum and not award.receive then
          (self._data).signActivityState = true
          break
        end
      end
    end
  end
  do
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

    if not (self._data).signActivityState then
      (self._data).returnsignActivityState = false
      for _,activity in pairs((self._data).signActivity) do
        if not activity.iswelfare then
          for _,award in ipairs(activity.awards) do
            -- DECOMPILER ERROR at PC54: Confused about usage of register: R11 in 'UnsetPending'

            if award.index <= activity.totalSignNum and not award.receive then
              (self._data).returnsignActivityState = true
              break
            end
          end
        end
      end
      do
        if not (self._data).returnsignActivityState then
        end
      end
    end
  end
end

DM_Sign.OnSSignCrossDay = function(self, activityId)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self._data).signActivity)[activityId] = nil
  self:RefreshSignActivityState()
end

return DM_Sign

