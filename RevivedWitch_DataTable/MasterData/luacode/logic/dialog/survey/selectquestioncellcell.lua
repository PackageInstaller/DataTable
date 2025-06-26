-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/survey/selectquestioncellcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local SelectQuestionCellCell = class("SelectQuestionCellCell", Dialog)
SelectQuestionCellCell.AssetBundleName = "ui/layouts.survey"
SelectQuestionCellCell.AssetName = "SurveySelectCell"
SelectQuestionCellCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SelectQuestionCellCell
  ((SelectQuestionCellCell.super).Ctor)(self, ...)
  self._isOn = false
  self._canClick = true
end

SelectQuestionCellCell.OnCreate = function(self)
  -- function num : 0_1
  self._txt = self:GetChild("Label")
  self._toggle = self:GetRootWindow()
  self._toggleCheckMark = self:GetChild("Background/Checkmark")
  self._toggleBack = self:GetChild("Background")
  self._lable = self:GetChild("Label")
  ;
  (self._toggle):Subscribe_PointerClickEvent(self.OnClick, self)
end

SelectQuestionCellCell.OnDestroy = function(self)
  -- function num : 0_2
end

SelectQuestionCellCell.RefreshCell = function(self, data)
  -- function num : 0_3
  self._isOn = data.isChecked
  ;
  (self._toggle):SetIsOnType(data.isChecked)
  ;
  (self._txt):SetText(data.text)
end

SelectQuestionCellCell.OnClick = function(self)
  -- function num : 0_4
  if self._canClick then
    self._isOn = not self._isOn
    ;
    (self._delegate):OnOptionChange((self._cellData).index, self._isOn)
  end
end

SelectQuestionCellCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5 , upvalues : _ENV
  if eventName == "ChangeToggleState" then
    if arg == (self._cellData).index then
      (self._toggle):SetIsOnType(true)
      self._isOn = true
    else
      ;
      (self._toggle):SetIsOnType(false)
      self._isOn = false
    end
  else
    if eventName == "OffAllToggle" then
      (self._toggle):SetIsOnType(false)
      self._isOn = false
    else
      if eventName == "SelectCountMax" then
        for key,value in pairs(arg) do
          if (self._cellData).index == value then
            self._canClick = true
            ;
            (self._toggle):SetInteractable(true)
            return 
          end
        end
        self._canClick = false
        ;
        (self._toggle):SetInteractable(false)
      else
        if eventName == "SelectCountNotMax" then
          self._canClick = true
          ;
          (self._toggle):SetInteractable(true)
        end
      end
    end
  end
end

return SelectQuestionCellCell

