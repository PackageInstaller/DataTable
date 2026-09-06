local RedData = strictclass("RedData")
RedData.FirstPage = 1
RedData.SecondPage = 2
RedData.ThirdPage = 3
RedData.FourPage = 4
RedData.SecondPage_Daily = 5
RedData.SecondPage_Weekly = 6
RedData.DelegateTask = 7
RedData.MainLineTask = 8

function RedData:Ctor(eventName, len)
  self._eventName = eventName
  self._redList = {}
  for i = 1, len do
    self._redList[i] = false
  end
end

function RedData:Clear()
  for i = 1, #self._redList do
    self._redList[i] = false
  end
end

function RedData:SetIndexRedValue(index, value)
  if self._redList[index] == value then
    return
  end
  self._redList[index] = value
  LuaNotificationCenter.PostNotification(self._eventName, nil, self)
end

function RedData:IsTrue()
  for i = 1, #self._redList do
    if self._redList[i] then
      return true
    end
  end
  return false
end

function RedData:IsIndexTrue(index)
  if not self._redList[index] then
    return false
  end
  return self._redList[index]
end

return RedData
