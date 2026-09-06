-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/questionnaire/view/QuestionnaireView.lua

module("logic.extensions.questionnaire.view.QuestionnaireView", package.seeall)

local QuestionnaireView = class("QuestionnaireView", ViewComponent)

function QuestionnaireView:unbindEvents()
	QuestionnaireView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnOk:RemoveClickListener()
end

function QuestionnaireView:bindEvents()
	QuestionnaireView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._btnOk:AddClickListener(self._onClickOk, self)
end

function QuestionnaireView:buildUI()
	QuestionnaireView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")

	local scrollContent = self:getGo("ScrollView/Viewport/Content")

	self._reward = self:getGo("reward")
	self._choiceText = QuestionChoiceText.New(goutil.findChild(scrollContent, "choice_text"))
	self._choiceImage = QuestionChoiceImage.New(goutil.findChild(scrollContent, "choice_image"))
	self._fillInBlanks = QuestionFillInBlanks.New(goutil.findChild(scrollContent, "fill_in_blanks"))
	self._scoring = QuestionScoring.New(goutil.findChild(scrollContent, "scoring"))
	self._remark = QuestionRemark.New(goutil.findChild(scrollContent, "remark"))
	self._scrollView = self:getGo("ScrollView"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._questions = {}
	self._questions[GameEnum.QuestionType.ChoiceText] = self._choiceText
	self._questions[GameEnum.QuestionType.FillInBlanks] = self._fillInBlanks
	self._questions[GameEnum.QuestionType.Scoring] = self._scoring
	self._questions[GameEnum.QuestionType.Remark] = self._remark
	self._questions[GameEnum.QuestionType.ChoiceImage] = self._choiceImage
	self._btnOk = self:getBtn("btnOk")
	self._txtOk = goutil.findChildTextComponent(self._btnOk.gameObject, "Text")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
end

function QuestionnaireView:onExit()
	QuestionnaireView.super.onExit(self)

	for _, v in pairs(self._questions) do
		v:clear()
	end

	self._curQuestion = nil
end

function QuestionnaireView:onEnter()
	QuestionnaireView.super.onEnter(self)

	self._curIdx = 0
	self._surveyId = QuestionnaireModel.instance:getSurveyId()
	self._cfgs = QuestionnaireConfig.instance:getQuestionCfgsById(self._surveyId)
	self._prizeCfg = QuestionnaireConfig.instance:getPrizeCfgById(self._surveyId)
	self._answers = {}

	for i = 1, #self._cfgs do
		self._answers[i] = ""
	end

	if QuestionnaireModel.instance:getSurveyDone(self._surveyId) then
		self._curIdx = -1
	end

	self:_updateUI()
end

function QuestionnaireView:_updateUI()
	goutil.setActive(self._reward, false)

	for _, v in ipairs(self._questions) do
		v:setActive(false)
	end

	self:_updateBtnText()

	if self._curIdx <= 0 then
		self._txtTitle.text = lang("questionnaire_prize_tip")

		self:_updateReward()
	else
		self._questioncfg = self._cfgs[self._curIdx]
		self._planCfgs = QuestionnaireConfig.instance:getPlanCfgsById(self._questioncfg.planId)
		self._planCfg = self._planCfgs[1]
		self._questionType = self._planCfg.typeId

		self:_updateTitleText()

		self._curQuestion = self._questions[self._questionType]

		self._curQuestion:setActive(true)
		self._curQuestion:onSetMo(self._questioncfg)
	end

	self._scrollView.verticalNormalizedPosition = 1
end

function QuestionnaireView:_updateBtnText()
	self._txtOk.text = self._curIdx == 0 and "开始填写" or self._curIdx == #self._cfgs and "提交问卷" or self._curIdx == -1 and "领取奖励" or "下一题"
end

function QuestionnaireView:_updateTitleText()
	local suffix = ""

	if self._questionType == GameEnum.QuestionType.ChoiceText or self._questionType == GameEnum.QuestionType.ChoiceImage then
		suffix = self._questioncfg.chooseMax > 1 and string.format("（多选题，请选择1-%s项）", self._questioncfg.chooseMax) or "（单选题）"
	elseif self._questionType == GameEnum.QuestionType.FillInBlanks then
		suffix = "（填空题）"
	elseif self._questionType == GameEnum.QuestionType.Scoring then
		suffix = "（评分题）"
	elseif self._questionType == GameEnum.QuestionType.Remark then
		suffix = "（评分题）"
	end

	self._txtTitle.text = self._questioncfg.title .. suffix
end

function QuestionnaireView:_updateReward()
	goutil.setActive(self._reward, true)
	print("self._prizeCfg.reward = " .. self._prizeCfg.reward)
	GameUtil.updateCells(self._reward, (self._prizeCfg or nil) and string.split(self._prizeCfg.reward, "#"), self._updateOneReward, self, true)
end

function QuestionnaireView:_updateOneReward(cell, data)
	local pointItem = goutil.findChild(cell, "pointItem")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local arr = string.split(data, ":")
	local matType = checknumber(arr[1])
	local matId = checknumber(arr[2])
	local matNum = checknumber(arr[3])

	MaterialMgr.setCell(matType, matId, pointItem)

	local matCfg = MaterialMgr.getMatCfg(matType, matId)

	if matCfg then
		txtName.text = matCfg.name or ""
	end

	txtNum.text = "x" .. matNum
end

function QuestionnaireView:_onClickOk()
	if not self:_recordCurQuestion() then
		return
	end

	if self._curIdx == #self._cfgs then
		self:_reqSaveSurvey()
	elseif self._curIdx == -1 then
		self:_reqGainPrize()
	else
		self:_checkNextQuestion()
	end
end

function QuestionnaireView:_recordCurQuestion()
	if self._curQuestion ~= nil then
		local resultStr, isSuccess = self._curQuestion:getResultStr(true)

		if not isSuccess then
			FloatWordMgr.instance:show(resultStr)

			return false
		end

		self._answers[self._curIdx] = tostring(resultStr)
	end

	return true
end

function QuestionnaireView:_checkNextQuestion()
	local isJump = false
	local answerIdx, questionIdx

	if self._questioncfg and self._questionType == GameEnum.QuestionType.ChoiceText and not string.nilorempty(self._questioncfg.gotoId) then
		answerIdx, questionIdx = unpack(string.splitToNumber(self._questioncfg.gotoId, ":"))

		if not self._answers[self._curIdx] then
			do
				local resultStr = ""
				local arr = string.splitToNumber(resultStr, ":")

				for _, v in ipairs(arr) do
					if v == answerIdx then
						isJump = true

						break
					end
				end
			end

			if isJump then
				for i = self._curIdx + 1, questionIdx - 1 do
					self._answers[i] = ""
				end

				self._curIdx = questionIdx

				goto label_13_0
			end
		end
	end

	self._curIdx = self._curIdx + 1

	::label_13_0::

	self:_updateUI()
end

function QuestionnaireView:_reqSaveSurvey()
	SurveyAgent.instance:sendPM_SaveSurveyReq(self._surveyId, self._answers, self._onSaveSuccess, self)
end

function QuestionnaireView:_onSaveSuccess()
	FloatWordMgr.instance:show("问卷提交成功")

	self._curIdx = -1

	QuestionnaireModel.instance:setSurveyDone(self._surveyId)
	self:_updateUI()
end

function QuestionnaireView:_reqGainPrize()
	SurveyAgent.instance:sendPM_GainSurveyGiftReq(self._surveyId, self._onGainPrizeSuccess, self)
end

function QuestionnaireView:_onGainPrizeSuccess()
	QuestionnaireModel.instance:setSurveyGainGift(self._surveyId)
	FloatWordMgr.instance:show("领奖成功")
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.UpdateMainUIFuncs)
end

return QuestionnaireView
