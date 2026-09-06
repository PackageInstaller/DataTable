local PQueue = class("PQueue")

local function genID()
  local id = 0
  return function()
    id = id + 1
    return id
  end
end

function PQueue:Ctor()
  self._heapTable = {}
  self._idIndexTable = {}
  self._func = nil
  self._genid = genID()
end

function PQueue:Init(compareFunc)
  self._func = compareFunc
  return self
end

function PQueue:Destroy()
  self._heapTable = nil
  self._idIndexTable = nil
  self._func = nil
end

local function exchange(tab, i, j)
  local tmp = tab[i]
  tab[i] = tab[j]
  tab[j] = tmp
end

local function adjust_heap(heap, length, adj_index)
  local l, r, largest, t_num, t_value
  while adj_index <= length do
    l = 2 * adj_index
    r = 2 * adj_index + 1
    if length >= l and heap._func(heap._heapTable[l].data, heap._heapTable[adj_index].data) then
      largest = l
    else
      largest = adj_index
    end
    if length >= r and heap._func(heap._heapTable[r].data, heap._heapTable[largest].data) then
      largest = r
    end
    if largest ~= adj_index then
      exchange(heap._heapTable, largest, adj_index)
      exchange(heap._idIndexTable, heap._heapTable[largest].id, heap._heapTable[adj_index].id)
      adj_index = largest
    else
      break
    end
  end
end

function PQueue:Size()
  return table.slen(self._heapTable)
end

function PQueue:Push(data, id)
  local item = {}
  item.data = data
  if not id then
    item.id = self._genid()
  else
    item.id = id
  end
  self._heapTable[table.slen(self._heapTable) + 1] = item
  self._idIndexTable[item.id] = table.slen(self._heapTable)
  local index = table.slen(self._heapTable)
  local parent = math.floor(index / 2)
  if not self._heapTable[index].data then
    LogWarning("pqueue", "index: " .. index .. ", " .. "parent: " .. parent .. "heaptable: " .. table.nums(self._heapTable) .. "&&" .. table.slen(self._heapTable) .. ", " .. "idindextable: " .. table.nums(self._idIndexTable) .. "&&" .. table.slen(self._idIndexTable))
  end
  while 1 <= parent and self._func(self._heapTable[index].data, self._heapTable[math.floor(parent)].data) do
    exchange(self._heapTable, index, parent)
    exchange(self._idIndexTable, self._heapTable[index].id, self._heapTable[parent].id)
    index = parent
    parent = math.floor(index / 2)
  end
  return item.id
end

function PQueue:Pop()
  local ret, id = self:Top()
  if ret then
    exchange(self._heapTable, 1, table.slen(self._heapTable))
    exchange(self._idIndexTable, self._heapTable[1].id, self._heapTable[table.slen(self._heapTable)].id)
    self._idIndexTable[self._heapTable[table.slen(self._heapTable)].id] = nil
    self._heapTable[table.slen(self._heapTable)] = nil
    adjust_heap(self, table.slen(self._heapTable), 1)
    return ret, id
  end
end

function PQueue:Top()
  if self:Size() > 0 then
    return self._heapTable[1].data, self._heapTable[1].id
  end
end

function PQueue:Find(key)
  local index = self._idIndexTable[key]
  if index and 0 < index then
    return self._heapTable[index].data
  end
end

function PQueue:Find_If(predict)
  for key, index in pairs(self._idIndexTable) do
    if predict(self._heapTable[index].data) then
      return self._heapTable[index].data, key
    end
  end
end

function PQueue:Remove(key)
  local index = self._idIndexTable[key]
  if index and 0 < index then
    exchange(self._heapTable, index, table.slen(self._heapTable))
    exchange(self._idIndexTable, self._heapTable[index].id, self._heapTable[table.slen(self._heapTable)].id)
    self._idIndexTable[self._heapTable[table.slen(self._heapTable)].id] = nil
    self._heapTable[table.slen(self._heapTable)] = nil
    adjust_heap(self, table.slen(self._heapTable), index)
  end
end

return PQueue
