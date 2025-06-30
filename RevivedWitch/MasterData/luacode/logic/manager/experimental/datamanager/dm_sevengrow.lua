-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_sevengrow.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_SevenGrow = class("DM_SevenGrow")
DM_SevenGrow.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._sevengrow = (NekoData.Data).sevengrow
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._sevengrow).sevenDaysIsOpen = false
end

DM_SevenGrow.Clear = function(self)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._sevengrow).sevenDaysIsOpen = false
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._sevengrow).ramainTime = nil
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._sevengrow).initialRemainTime = nil
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._sevengrow).startTime = nil
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._sevengrow).gameTimerId = nil
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._sevengrow).version = -1
end

DM_SevenGrow.OnSSevenDaysOpen = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  self:RemoveTask()
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._sevengrow).initialRemainTime = protocol.remainTime
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._sevengrow).startTime = (ServerGameTimer.GetServerTimeForecast)()
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._sevengrow).gameTimerId = (ServerGameTimer.AddTask)(protocol.remainTime / 1000, -1, function()
    -- function num : 0_2_0 , upvalues : self
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (self._sevengrow).sevenDaysIsOpen = false
  end
)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._sevengrow).sevenDaysIsOpen = true
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._sevengrow).version = protocol.version
end

DM_SevenGrow.RemoveTask = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if (self._sevengrow).gameTimerId ~= nil then
    (ServerGameTimer.RemoveTask)((self._sevengrow).gameTimerId)
  end
end

return DM_SevenGrow

