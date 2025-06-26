-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/queue.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Queue = class("Queue")
Queue.Ctor = function(self)
  -- function num : 0_0
  self._list = {}
  self._first = 1
  self._last = 1
end

Queue.Push = function(self, value)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._list)[self._last] = value
  self._last = self._last + 1
end

Queue.Pop = function(self)
  -- function num : 0_2
  local retValue = nil
  if self._first < self._last then
    retValue = (self._list)[self._first]
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._list)[self._first] = nil
    self._first = self._first + 1
    if self._first == self._last then
      self._first = 1
    end
    return retValue
  end
end

Queue.Peek = function(self)
  -- function num : 0_3
  if self._first < self._last then
    return (self._list)[self._list]
  end
end

Queue.GetSize = function(self)
  -- function num : 0_4
  return self._last - self._first
end

Queue.Clear = function(self)
  -- function num : 0_5
  while 1 do
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

    if self._first < self._last then
      (self._list)[self._first] = nil
      self._first = self._first + 1
      if self._first == self._last then
        self._first = 1
      end
      -- DECOMPILER ERROR at PC17: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC17: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
end

return Queue

