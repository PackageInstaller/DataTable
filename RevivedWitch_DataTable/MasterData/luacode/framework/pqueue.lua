-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/pqueue.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PQueue = class("PQueue")
local genID = function()
  -- function num : 0_0
  local id = 0
  return function()
    -- function num : 0_0_0 , upvalues : id
    id = id + 1
    return id
  end

end

PQueue.Ctor = function(self)
  -- function num : 0_1 , upvalues : genID
  self._heapTable = {}
  self._idIndexTable = {}
  self._func = nil
  self._genid = genID()
end

PQueue.Init = function(self, compareFunc)
  -- function num : 0_2
  self._func = compareFunc
  return self
end

PQueue.Destroy = function(self)
  -- function num : 0_3
  self._heapTable = nil
  self._idIndexTable = nil
  self._func = nil
end

local exchange = function(tab, i, j)
  -- function num : 0_4
  local tmp = tab[i]
  tab[i] = tab[j]
  tab[j] = tmp
end

local adjust_heap = function(heap, length, adj_index)
  -- function num : 0_5 , upvalues : exchange
  local l, r, largest, t_num, t_value = nil, nil, nil, nil, nil
  while 1 do
    while 1 do
      if adj_index <= length then
        l = 2 * adj_index
        r = 2 * adj_index + 1
        if l <= length and (heap._func)(((heap._heapTable)[l]).data, ((heap._heapTable)[adj_index]).data) then
          largest = l
        else
          largest = adj_index
        end
        if r <= length and (heap._func)(((heap._heapTable)[r]).data, ((heap._heapTable)[largest]).data) then
          largest = r
        end
        if largest ~= adj_index then
          exchange(heap._heapTable, largest, adj_index)
          exchange(heap._idIndexTable, ((heap._heapTable)[largest]).id, ((heap._heapTable)[adj_index]).id)
          adj_index = largest
          -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    break
  end
end

PQueue.Size = function(self)
  -- function num : 0_6 , upvalues : _ENV
  return (table.slen)(self._heapTable)
end

PQueue.Push = function(self, data, id)
  -- function num : 0_7 , upvalues : _ENV, exchange
  local item = {}
  item.data = data
  if not id then
    item.id = (self._genid)()
  else
    item.id = id
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._heapTable)[(table.slen)(self._heapTable) + 1] = item
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._idIndexTable)[item.id] = (table.slen)(self._heapTable)
  local index = (table.slen)(self._heapTable)
  local parent = (math.floor)(index / 2)
  if not ((self._heapTable)[index]).data then
    LogWarning("pqueue", "index: " .. index .. ", " .. "parent: " .. parent .. "heaptable: " .. (table.nums)(self._heapTable) .. "&&" .. (table.slen)(self._heapTable) .. ", " .. "idindextable: " .. (table.nums)(self._idIndexTable) .. "&&" .. (table.slen)(self._idIndexTable))
  end
  while parent >= 1 and (self._func)(((self._heapTable)[index]).data, ((self._heapTable)[(math.floor)(parent)]).data) do
    exchange(self._heapTable, index, parent)
    exchange(self._idIndexTable, ((self._heapTable)[index]).id, ((self._heapTable)[parent]).id)
    index = parent
    parent = (math.floor)(index / 2)
  end
  return item.id
end

PQueue.Pop = function(self)
  -- function num : 0_8 , upvalues : exchange, _ENV, adjust_heap
  local ret, id = self:Top()
  if ret then
    exchange(self._heapTable, 1, (table.slen)(self._heapTable))
    exchange(self._idIndexTable, ((self._heapTable)[1]).id, ((self._heapTable)[(table.slen)(self._heapTable)]).id)
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._idIndexTable)[((self._heapTable)[(table.slen)(self._heapTable)]).id] = nil
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._heapTable)[(table.slen)(self._heapTable)] = nil
    adjust_heap(self, (table.slen)(self._heapTable), 1)
    return ret, id
  end
end

PQueue.Top = function(self)
  -- function num : 0_9
  if self:Size() > 0 then
    return ((self._heapTable)[1]).data, ((self._heapTable)[1]).id
  end
end

PQueue.Find = function(self, key)
  -- function num : 0_10
  local index = (self._idIndexTable)[key]
  if index and index > 0 then
    return ((self._heapTable)[index]).data
  end
end

PQueue.Find_If = function(self, predict)
  -- function num : 0_11 , upvalues : _ENV
  for key,index in pairs(self._idIndexTable) do
    if predict(((self._heapTable)[index]).data) then
      return ((self._heapTable)[index]).data, key
    end
  end
end

PQueue.Remove = function(self, key)
  -- function num : 0_12 , upvalues : exchange, _ENV, adjust_heap
  local index = (self._idIndexTable)[key]
  if index and index > 0 then
    exchange(self._heapTable, index, (table.slen)(self._heapTable))
    exchange(self._idIndexTable, ((self._heapTable)[index]).id, ((self._heapTable)[(table.slen)(self._heapTable)]).id)
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._idIndexTable)[((self._heapTable)[(table.slen)(self._heapTable)]).id] = nil
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._heapTable)[(table.slen)(self._heapTable)] = nil
    adjust_heap(self, (table.slen)(self._heapTable), index)
  end
end

return PQueue

