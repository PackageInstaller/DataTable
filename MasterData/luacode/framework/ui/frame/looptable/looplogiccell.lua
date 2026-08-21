-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/frame/looptable/looplogiccell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LoopLogicCell = class("LoopLogicCell")
LoopLogicCell.Ctor = function(self)
  -- function num : 0_0
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

