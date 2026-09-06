-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/questionnaire/view/QuestionFillInBlanks.lua

module("logic.extensions.questionnaire.view.QuestionFillInBlanks", package.seeall)

local QuestionFillInBlanks = class("QuestionFillInBlanks", QuestionBase)

function QuestionFillInBlanks:buildUI()
	self._inputField = Framework.InputFieldAdapter.Get(self.mainGO)
end

function QuestionFillInBlanks:onSetMo(cfg)
	QuestionFillInBlanks.super.onSetMo(self, cfg)
	self._inputField:SetText("")

	self._minCharNum = checknumber(QuestionnaireConfig.instance:getConstantValue("FillBlank_Min_Input_Characters"))
	self._Placeholder = goutil.findChildTextComponent(self._inputField.gameObject, "Placeholder")
	self._Placeholder.text = string.format("请输入你的建议（不得少于%s字）", self._minCharNum)
end

function QuestionFillInBlanks:getResultStr()
	local text = self._inputField:GetText()

	if string.nilorempty(text) then
		return "输入内容不能为空", false
	elseif Framework.StringUtil.GetLength(text) < self._minCharNum then
		return string.format("输入内容不能少于%d个字", self._minCharNum), false
	else
		return text, true
	end
end

function QuestionFillInBlanks:clear()
	self._inputField:SetText("")
end

return QuestionFillInBlanks
