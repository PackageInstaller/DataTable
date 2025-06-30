-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/tableinstance.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableInstance = class("TableInstance")
TableInstance.Ctor = function(self)
  -- function num : 0_0
  self._data = {}
  self._ids = {}
end

TableInstance.LoadFromLua = function(self, fileName)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (package.loaded)[fileName] = nil
  local data = require(fileName)
  if not data then
    return false
  end
  self._data = data.Data
  self._ids = data.AllIds
  return true
end

TableInstance.GetRecorder = function(self, id)
  -- function num : 0_2
  return (self._data)[id]
end

TableInstance.GetAllID = function(self)
  -- function num : 0_3
  return self._ids
end

return TableInstance

