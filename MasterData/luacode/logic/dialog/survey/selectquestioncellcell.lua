local GridFrame = require("framework.ui.frame.grid.gridframe")
local SelectQuestionCellCell = class("SelectQuestionCellCell", Dialog)
SelectQuestionCellCell.AssetBundleName = "ui/layouts.survey"
SelectQuestionCellCell.AssetName = "SurveySelectCell"

function SelectQuestionCellCell:Ctor(...)
  SelectQuestionCellCell.super.Ctor(self, ...)
  self._isOn = false
  self._canClick = true
end

function SelectQuestionCellCell:OnCreate()
  self._txt = self:GetChild("Label")
  self._toggle = self:GetRootWindow()
  self._toggleCheckMark = self:GetChild("Background/Checkmark")
  self._toggleBack = self:GetChild("Background")
  self._lable = self:GetChild("Label")
  self._toggle:Subscribe_PointerClickEvent(self.OnClick, self)
end

function SelectQuestionCellCell:OnDestroy()
end

function SelectQuestionCellCell:RefreshCell(data)
  self._isOn = data.isChecked
  self._toggle:SetIsOnType(data.isChecked)
  self._txt:SetText(data.text)
end

function SelectQuestionCellCell:OnClick()
  if self._canClick then
    self._isOn = not self._isOn
    self._delegate:OnOptionChange(self._cellData.index, self._isOn)
  end
end

function SelectQuestionCellCell:OnEvent(eventName, arg)
  if eventName == "ChangeToggleState" then
    if arg == self._cellData.index then
      self._toggle:SetIsOnType(true)
      self._isOn = true
    else
      self._toggle:SetIsOnType(false)
      self._isOn = false
    end
  elseif eventName == "OffAllToggle" then
    self._toggle:SetIsOnType(false)
    self._isOn = false
  elseif eventName == "SelectCountMax" then
    for key, value in pairs(arg) do
      if self._cellData.index == value then
        self._canClick = true
        self._toggle:SetInteractable(true)
        return
      end
    end
    self._canClick = false
    self._toggle:SetInteractable(false)
  elseif eventName == "SelectCountNotMax" then
    self._canClick = true
    self._toggle:SetInteractable(true)
  end
end

return SelectQuestionCellCell
