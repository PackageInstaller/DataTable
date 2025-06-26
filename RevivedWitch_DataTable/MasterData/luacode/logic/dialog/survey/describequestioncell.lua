-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/survey/describequestioncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local DescribeQuestionCell = class("DescribeQuestionCell", Dialog)
DescribeQuestionCell.AssetBundleName = "ui/layouts.survey"
DescribeQuestionCell.AssetName = "QuestionCell2"
DescribeQuestionCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DescribeQuestionCell
  ((DescribeQuestionCell.super).Ctor)(self, ...)
end

DescribeQuestionCell.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("Title")
  self._inputField = self:GetChild("InputField")
  self._inputFieldTxt = self:GetChild("InputField/Text")
  ;
  (self._inputField):Subscribe_ValueChangedEvent(self.OnInputFieldValueChanged, self)
end

DescribeQuestionCell.OnDestroy = function(self)
  -- function num : 0_2
end

DescribeQuestionCell.RefreshCell = function(self, data)
  -- function num : 0_3
  if ((self._delegate)._answerData)[data.id] and (((self._delegate)._answerData)[data.id])[1] ~= "nil" then
    (self._inputField):SetText((((self._delegate)._answerData)[data.id])[1])
  else
    ;
    (self._inputField):SetText("")
    ;
    (self._delegate):OnTxtInput((self._cellData).id, "nil")
  end
  ;
  (self._title):SetText(data.questionTitle)
end

DescribeQuestionCell.OnInputFieldValueChanged = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local str = (self._inputField):GetText()
  str = (string.gsub)(str, " ", "")
  if (string.len)(str) > 0 then
    (self._delegate):OnTxtInput((self._cellData).id, (self._inputField):GetText())
  else
    ;
    (self._delegate):OnTxtInput((self._cellData).id, "nil")
  end
  ;
  (self._delegate):RefreshProgress()
  ;
  (self._delegate):SetNextBtnState()
end

return DescribeQuestionCell

