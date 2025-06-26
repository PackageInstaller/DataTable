-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/survey/selectquestioncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local SelectQuestionCell = class("SelectQuestionCell", Dialog)
SelectQuestionCell.AssetBundleName = "ui/layouts.survey"
SelectQuestionCell.AssetName = "QuestionCell1"
SelectQuestionCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SelectQuestionCell
  ((SelectQuestionCell.super).Ctor)(self, ...)
  self._options = {}
  self._answers = {}
  self.questionRow = 2
end

SelectQuestionCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._title = self:GetChild("Title")
  self._selectionPanel = self:GetChild("SelectionFrame")
  self._selectionFrame = (GridFrame.Create)(self._selectionPanel, self, true, self.questionRow, false, false)
  self._x = (self._selectionPanel):GetSize()
  self._pos_x = (self._selectionPanel):GetPosition()
  self._rootX = (self:GetRootWindow()):GetSize()
end

SelectQuestionCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._selectionFrame):Destroy()
end

SelectQuestionCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._options = {}
  if not ((self._delegate)._answerData)[data.id] then
    self._answers = {}
    ;
    (self._title):SetText(data.questionTitle)
    for i,value in ipairs(data.selection) do
      local temp = {}
      temp.index = i
      temp.text = value
      temp.isChecked = (self._delegate):IsOptionChecked(data.id, temp.index)
      ;
      (table.insert)(self._options, temp)
    end
    ;
    (self._selectionFrame):ReloadAllCell()
    local totallength = (self._selectionFrame):GetTotalLength()
    local delta = totallength - self._oy
    ;
    (self._selectionPanel):SetSize(self._x, self._ox, self._y, self._oy + delta)
    ;
    (self._selectionPanel):SetPosition(self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y - delta)
    ;
    (self:GetRootWindow()):SetSize(self._rootX, self._rootOX, self._rooty, self._rootOY + delta)
    ;
    (self._selectionFrame):ReloadAllCell()
    if (self._cellData).questionType == 2 then
      if #self._answers == (self._cellData).multiCountMax then
        (self._selectionFrame):FireEvent("SelectCountMax", self._answers)
      else
        ;
        (self._selectionFrame):FireEvent("SelectCountNotMax")
      end
      ;
      (self._delegate):OnMultipleOptionChecked((self._cellData).id, self._answers)
    else
      ;
      (self._selectionFrame):FireEvent("SelectCountNotMax")
    end
  end
end

SelectQuestionCell.OnOptionChange = function(self, index, isChecked)
  -- function num : 0_4 , upvalues : _ENV
  if (self._cellData).questionType == 2 then
    if isChecked then
      local canInsert = true
      for i,value in ipairs(self._answers) do
        if value == index then
          canInsert = false
        end
      end
      if canInsert then
        (table.insert)(self._answers, index)
      end
    else
      do
        do
          local removepos = nil
          for i,value in ipairs(self._answers) do
            if value == index then
              removepos = i
            end
          end
          if removepos then
            (table.remove)(self._answers, removepos)
          end
          if #self._answers == (self._cellData).multiCountMax then
            (self._selectionFrame):FireEvent("SelectCountMax", self._answers)
          else
            ;
            (self._selectionFrame):FireEvent("SelectCountNotMax")
          end
          ;
          (self._delegate):OnMultipleOptionChecked((self._cellData).id, self._answers)
          ;
          (self._delegate):OnSingleOptionChecked((self._cellData).id, index, isChecked)
          if isChecked then
            (self._selectionFrame):FireEvent("ChangeToggleState", index)
          else
            ;
            (self._selectionFrame):FireEvent("OffAllToggle", index)
          end
          ;
          (self._delegate):RefreshProgress()
          ;
          (self._delegate):SetNextBtnState()
        end
      end
    end
  end
end

SelectQuestionCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._options
end

SelectQuestionCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "survey.selectquestioncellcell"
end

SelectQuestionCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._options)[index]
end

return SelectQuestionCell

