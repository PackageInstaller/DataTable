-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/questionnaire/view/QuestionScoring.lua

module("logic.extensions.questionnaire.view.QuestionScoring", package.seeall)

local QuestionScoring = class("QuestionScoring", QuestionBase)

function QuestionScoring:buildUI()
	return
end

function QuestionScoring:onSetMo(cfg)
	QuestionScoring.super.onSetMo(self, cfg)

	self._choiceTexts = {}

	GameUtil.updateCellsWithCreate(self.mainGO, self._planCfgs, self._updateOneScoring, self)
end

function QuestionScoring:_updateOneScoring(cell, data)
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")

	txtTitle.text = data.secondQue

	local choiceText = QuestionChoiceText.New(goutil.findChild(cell, "choices"))

	choiceText:onSetScoreMo(1)
	table.insert(self._choiceTexts, choiceText)
end

function QuestionScoring:getResultStr()
	local resultStr, isSuccess = "", true

	for k, v in ipairs(self._choiceTexts) do
		local str, isSubSuccess = v:getResultStr()

		if not isSubSuccess then
			isSuccess = false

			break
		end

		resultStr = string.nilorempty(resultStr) and str or resultStr .. "#" .. str
	end

	if isSuccess then
		return resultStr, true
	else
		return "有问题没答，请继续填写", false
	end
end

function QuestionScoring:clear()
	if self._choiceTexts then
		for _, v in ipairs(self._choiceTexts) do
			v:clear()
		end
	end
end

return QuestionScoring
