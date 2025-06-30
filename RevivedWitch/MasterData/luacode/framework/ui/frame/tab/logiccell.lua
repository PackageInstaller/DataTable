-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/frame/tab/logiccell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LogicCell = class("LogicCell")
LogicCell.Ctor = function(self)
  -- function num : 0_0
  self._dialogName = ""
  self._data = {}
  self._cell = nil
end

return LogicCell

