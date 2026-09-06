local LogicCell = class("LogicCell")

function LogicCell:Ctor()
  self._posX = 0
  self._posY = 0
  self._sizeX = 0
  self._sizeY = 0
  self._row = 0
  self._col = 0
  self._dialogName = ""
  self._data = {}
  self._visible = false
  self._cell = nil
end

return LogicCell
