-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_giftoftimemaze.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_GiftOfTimeMaze = class("DM_GiftOfTimeMaze")
DM_GiftOfTimeMaze.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).giftoftimemaze
  self:Clear()
end

DM_GiftOfTimeMaze.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).leftTime = 0
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).initialTime = 0
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).currentPos = 0
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  if (self._data).cards == nil then
    (self._data).cards = {}
  else
    for key,_ in pairs((self._data).cards) do
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

      ((self._data).cards)[key] = nil
    end
  end
  do
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

    if (self._data).blocks == nil then
      (self._data).blocks = {}
    else
      for key,_ in pairs((self._data).blocks) do
        -- DECOMPILER ERROR at PC39: Confused about usage of register: R6 in 'UnsetPending'

        ((self._data).blocks)[key] = nil
      end
    end
    do
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._data).oldCTime = 0
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._data).nowCTime = 0
    end
  end
end

DM_GiftOfTimeMaze.OnSOpenLabyrinth = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  if PrintTable then
    PrintTable(protocol, 3, "OnSOpenLabyrinth")
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).leftTime = protocol.leftTime
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).initialTime = (ServerGameTimer.GetServerTimeForecast)()
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).currentPos = protocol.currentPos
  for key,_ in pairs((self._data).cards) do
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).cards)[key] = nil
  end
  for _,value in ipairs(protocol.cards) do
    (table.insert)((self._data).cards, value)
  end
  for key,_ in pairs((self._data).blocks) do
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).blocks)[key] = nil
  end
  for key,value in pairs(protocol.blocks) do
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).blocks)[key] = value
  end
end

DM_GiftOfTimeMaze.OnSRefreshMazeBlock = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  if PrintTable then
    PrintTable(protocol, 3, "OnSRefreshMazeBlock")
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).currentPos = protocol.pos
  for key,value in pairs(protocol.blocks) do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).blocks)[key] = value
  end
end

DM_GiftOfTimeMaze.OnSRefreshMazeCards = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  if PrintTable then
    PrintTable(protocol, 3, "OnSRefreshMazeCards")
  end
  for key,_ in pairs((self._data).cards) do
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).cards)[key] = nil
  end
  for _,value in ipairs(protocol.cards) do
    (table.insert)((self._data).cards, value)
  end
end

return DM_GiftOfTimeMaze

