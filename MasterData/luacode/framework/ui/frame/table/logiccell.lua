local LogicCell = class("LogicCell")

function LogicCell:Ctor()
  self._pos = 0
  self._size = 0
  self._dialogName = ""
  self._data = {}
  self._visible = false
  self._cell = nil
end

return LogicCell
