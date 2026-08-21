-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/reddata.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RedData = strictclass("RedData")
RedData.FirstPage = 1
RedData.SecondPage = 2
RedData.ThirdPage = 3
RedData.FourPage = 4
RedData.SecondPage_Daily = 5
RedData.SecondPage_Weekly = 6
RedData.DelegateTask = 7
RedData.MainLineTask = 8
RedData.Ctor = function(self, eventName, len)
  -- function num : 0_0
  self._eventName = eventName
  self._redList = {}
  for i = 1, len do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R7 in 'UnsetPending'

    (self._redList)[i] = false
  end
end

RedData.Clear = function(self)
  -- function num : 0_1
  for i = 1, #self._redList do
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R5 in 'UnsetPending'

    (self._redList)[i] = false
  end
end

RedData.SetIndexRedValue = function(self, index, value)
  -- function num : 0_2 , upvalues : _ENV
  if (self._redList)[index] == value then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._redList)[index] = value
  ;
  (LuaNotificationCenter.PostNotification)(self._eventName, nil, self)
end

RedData.IsTrue = function(self)
  -- function num : 0_3
  for i = 1, #self._redList do
    if (self._redList)[i] then
      return true
    end
  end
  return false
end

RedData.IsIndexTrue = function(self, index)
  -- function num : 0_4
  if not (self._redList)[index] then
    return false
  end
  return (self._redList)[index]
end

return RedData

