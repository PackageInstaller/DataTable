local Queue = class("Queue")

function Queue:Ctor()
  self._list = {}
  self._first = 1
  self._last = 1
end

function Queue:Push(value)
  self._list[self._last] = value
  self._last = self._last + 1
end

function Queue:Pop()
  local retValue
  if self._last > self._first then
    retValue = self._list[self._first]
    self._list[self._first] = nil
    self._first = self._first + 1
    if self._first == self._last then
      self._first, self._last = 1, 1
    end
    return retValue
  end
end

function Queue:Peek()
  if self._last > self._first then
    return self._list[self._list]
  end
end

function Queue:GetSize()
  return self._last - self._first
end

function Queue:Clear()
  while self._last > self._first do
    self._list[self._first] = nil
    self._first = self._first + 1
    if self._first == self._last then
      self._first, self._last = 1, 1
    end
  end
end

return Queue
