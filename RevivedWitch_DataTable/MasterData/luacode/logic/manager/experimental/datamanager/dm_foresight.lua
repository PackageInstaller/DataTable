-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_foresight.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Foresight = class("DM_Foresight")
DM_Foresight.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).foresight
  self:Clear()
end

DM_Foresight.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).activityId = -1
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).initialTime = 0
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).curLeftTime = 0
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).actLeftTime = 0
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).unlockedDay = 0
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  if (self._data).receiveAward == nil then
    (self._data).receiveAward = {}
  else
    for key,_ in pairs((self._data).receiveAward) do
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

      ((self._data).receiveAward)[key] = nil
    end
  end
  do
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._data).foresightGoodInfo = {}
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._data).haveRedDot = false
  end
end

DM_Foresight.OnSGeneralForesightAct = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).activityId = protocol.activityId
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).initialTime = (ServerGameTimer.GetServerTimeForecast)()
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).curLeftTime = protocol.curLeftTime
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).actLeftTime = protocol.actLeftTime
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).unlockedDay = protocol.unlockedTimes
  for _,value in pairs(protocol.receiveAward) do
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).receiveAward)[value] = true
  end
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).foresightGoodInfo = protocol.foresightGoodInfo
end

return DM_Foresight

