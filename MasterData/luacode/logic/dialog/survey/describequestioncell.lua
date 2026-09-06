local GridFrame = require("framework.ui.frame.grid.gridframe")
local DescribeQuestionCell = class("DescribeQuestionCell", Dialog)
DescribeQuestionCell.AssetBundleName = "ui/layouts.survey"
DescribeQuestionCell.AssetName = "QuestionCell2"

function DescribeQuestionCell:Ctor(...)
  DescribeQuestionCell.super.Ctor(self, ...)
end

function DescribeQuestionCell:OnCreate()
  self._title = self:GetChild("Title")
  self._inputField = self:GetChild("InputField")
  self._inputFieldTxt = self:GetChild("InputField/Text")
  self._inputField:Subscribe_ValueChangedEvent(self.OnInputFieldValueChanged, self)
end

function DescribeQuestionCell:OnDestroy()
end

function DescribeQuestionCell:RefreshCell(data)
  if self._delegate._answerData[data.id] and self._delegate._answerData[data.id][1] ~= "nil" then
    self._inputField:SetText(self._delegate._answerData[data.id][1])
  else
    self._inputField:SetText("")
    self._delegate:OnTxtInput(self._cellData.id, "nil")
  end
  self._title:SetText(data.questionTitle)
end

function DescribeQuestionCell:OnInputFieldValueChanged()
  local str = self._inputField:GetText()
  str = string.gsub(str, " ", "")
  if string.len(str) > 0 then
    self._delegate:OnTxtInput(self._cellData.id, self._inputField:GetText())
  else
    self._delegate:OnTxtInput(self._cellData.id, "nil")
  end
  self._delegate:RefreshProgress()
  self._delegate:SetNextBtnState()
end

return DescribeQuestionCell
