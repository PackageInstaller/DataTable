local TableInstance = class("TableInstance")

function TableInstance:Ctor()
  self._data = {}
  self._ids = {}
end

function TableInstance:LoadFromLua(fileName)
  package.loaded[fileName] = nil
  local data = require(fileName)
  if not data then
    return false
  end
  self._data = data.Data
  self._ids = data.AllIds
  return true
end

function TableInstance:GetRecorder(id)
  return self._data[id]
end

function TableInstance:GetAllID()
  return self._ids
end

return TableInstance
