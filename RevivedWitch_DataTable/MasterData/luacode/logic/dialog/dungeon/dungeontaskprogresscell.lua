-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeontaskprogresscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonTaskProgressCell = class("DungeonTaskProgressCell", Dialog)
DungeonTaskProgressCell.AssetBundleName = "ui/layouts.dungeon"
DungeonTaskProgressCell.AssetName = "DungeonMenuTask1Cell2"
local TableFrame = require("framework.ui.frame.table.tableframe")
DungeonTaskProgressCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonTaskProgressCell
  ((DungeonTaskProgressCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

DungeonTaskProgressCell.OnCreate = function(self)
  -- function num : 0_1
  self._dots = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

    (self._dots)[i] = self:GetChild("Dot" .. i)
  end
  self._name = self:GetChild("Task")
  self._progress = self:GetChild("Num")
end

DungeonTaskProgressCell.OnDestroy = function(self)
  -- function num : 0_2
end

DungeonTaskProgressCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._name):SetText((self._cellData).desc)
  local text = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1058)).msgTextID
  text = (TextManager.GetText)(text)
  text = text:gsub("%$parameter(%d)", {["1"] = (self._cellData).current, ["2"] = (self._cellData).total})
  ;
  (self._progress):SetText(text)
  for i,v in ipairs(self._dots) do
    v:SetActive(((self._cellData).index - 1) % #self._dots == i - 1)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return DungeonTaskProgressCell

