-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipstrengthen/filterframecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local FilterFrameCell = class("FilterFrameCell", Dialog)
FilterFrameCell.AssetBundleName = "ui/layouts.basecharacterinfo"
FilterFrameCell.AssetName = "BaseCharacterListFliterNewFrame"
FilterFrameCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FilterFrameCell
  ((FilterFrameCell.super).Ctor)(self, ...)
end

FilterFrameCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._panel = self:GetRootWindow()
  self._field = self:GetChild("Frame")
  self._title = self:GetChild("Txt")
  self._frame = (GridFrame.Create)(self._field, self, true, 3, false)
  self._size_x = (self._panel):GetSize()
  self.pos_x = (self._panel):GetPosition()
end

FilterFrameCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

FilterFrameCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._frame):ReloadAllCell()
  if data.target == "Role" then
    (self._title):SetActive(true)
    ;
    (self._title):SetText((TextManager.GetText)(data.TypeNameId))
  else
    if not data.target or data.target == "Equip" or data.target == "EquipBook" then
      (self._title):SetActive(true)
      ;
      (self._title):SetText((TextManager.GetText)(data.TypeNameId))
    else
      if data.target == "Monster" then
        (self._title):SetActive(true)
        ;
        (self._title):SetText((TextManager.GetText)(data.TypeNameId))
      else
        ;
        (self._title):SetActive(false)
      end
    end
  end
end

FilterFrameCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #(self._cellData).list
end

FilterFrameCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "equipstrengthen.filtersortcell"
end

FilterFrameCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return ((self._cellData).list)[index]
end

FilterFrameCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_7
  if eventName == "ChangeSelectNameId" then
    (self._frame):FireEvent("ChangeSelectNameId")
  end
end

return FilterFrameCell

