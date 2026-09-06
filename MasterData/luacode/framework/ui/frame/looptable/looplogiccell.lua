local LoopLogicCell = class("LoopLogicCell")

function LoopLogicCell:Ctor()
  self._pos = 0
  self._size = 0
  self._dialogName = ""
  self._data = {}
  self._visible = false
  self._cell = nil
  self._index = 0
  self._isLogicCell = true
end

return LoopLogicCell
