local LogicCell = class("LogicCell")

function LogicCell:Ctor()
  self._dialogName = ""
  self._data = {}
  self._cell = nil
end

return LogicCell
