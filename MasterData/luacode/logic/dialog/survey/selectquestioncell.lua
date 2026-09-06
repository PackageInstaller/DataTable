local GridFrame = require("framework.ui.frame.grid.gridframe")
local SelectQuestionCell = class("SelectQuestionCell", Dialog)
SelectQuestionCell.AssetBundleName = "ui/layouts.survey"
SelectQuestionCell.AssetName = "QuestionCell1"

function SelectQuestionCell:Ctor(...)
  SelectQuestionCell.super.Ctor(self, ...)
  self._options = {}
  self._answers = {}
  self.questionRow = 2
end

function SelectQuestionCell:OnCreate()
  self._title = self:GetChild("Title")
  self._selectionPanel = self:GetChild("SelectionFrame")
  self._selectionFrame = GridFrame.Create(self._selectionPanel, self, true, self.questionRow, false, false)
  self._x, self._ox, self._y, self._oy = self._selectionPanel:GetSize()
  self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y = self._selectionPanel:GetPosition()
  self._rootX, self._rootOX, self._rooty, self._rootOY = self:GetRootWindow():GetSize()
end

function SelectQuestionCell:OnDestroy()
  self._selectionFrame:Destroy()
end

function SelectQuestionCell:RefreshCell(data)
  self._options = {}
  self._answers = self._delegate._answerData[data.id] or {}
  self._title:SetText(data.questionTitle)
  for i, value in ipairs(data.selection) do
    local temp = {}
    temp.index = i
    temp.text = value
    temp.isChecked = self._delegate:IsOptionChecked(data.id, temp.index)
    table.insert(self._options, temp)
  end
  self._selectionFrame:ReloadAllCell()
  local totallength = self._selectionFrame:GetTotalLength()
  local delta = totallength - self._oy
  self._selectionPanel:SetSize(self._x, self._ox, self._y, self._oy + delta)
  self._selectionPanel:SetPosition(self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y - delta)
  self:GetRootWindow():SetSize(self._rootX, self._rootOX, self._rooty, self._rootOY + delta)
  self._selectionFrame:ReloadAllCell()
  if self._cellData.questionType == 2 then
    if #self._answers == self._cellData.multiCountMax then
      self._selectionFrame:FireEvent("SelectCountMax", self._answers)
    else
      self._selectionFrame:FireEvent("SelectCountNotMax")
    end
    self._delegate:OnMultipleOptionChecked(self._cellData.id, self._answers)
  else
    self._selectionFrame:FireEvent("SelectCountNotMax")
  end
end

function SelectQuestionCell:OnOptionChange(index, isChecked)
  if self._cellData.questionType == 2 then
    if isChecked then
      local canInsert = true
      for i, value in ipairs(self._answers) do
        if value == index then
          canInsert = false
        end
      end
      if canInsert then
        table.insert(self._answers, index)
      end
    else
      local removepos
      for i, value in ipairs(self._answers) do
        if value == index then
          removepos = i
        end
      end
      if removepos then
        table.remove(self._answers, removepos)
      end
    end
    if #self._answers == self._cellData.multiCountMax then
      self._selectionFrame:FireEvent("SelectCountMax", self._answers)
    else
      self._selectionFrame:FireEvent("SelectCountNotMax")
    end
    self._delegate:OnMultipleOptionChecked(self._cellData.id, self._answers)
  else
    self._delegate:OnSingleOptionChecked(self._cellData.id, index, isChecked)
    if isChecked then
      self._selectionFrame:FireEvent("ChangeToggleState", index)
    else
      self._selectionFrame:FireEvent("OffAllToggle", index)
    end
  end
  self._delegate:RefreshProgress()
  self._delegate:SetNextBtnState()
end

function SelectQuestionCell:NumberOfCell(frame)
  return #self._options
end

function SelectQuestionCell:CellAtIndex(frame, index)
  return "survey.selectquestioncellcell"
end

function SelectQuestionCell:DataAtIndex(frame, index)
  return self._options[index]
end

return SelectQuestionCell
