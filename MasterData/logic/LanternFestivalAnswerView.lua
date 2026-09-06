-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternfestival/view/LanternFestivalAnswerView.lua

module("logic.extensions.lanternfestival.view.LanternFestivalAnswerView", package.seeall)

local LanternFestivalAnswerView = class("LanternFestivalAnswerView", ViewComponent)
local OptionEnum = {
	"A",
	"B",
	"C"
}

function LanternFestivalAnswerView:ctor()
	LanternFestivalAnswerView.super.ctor(self)
end

function LanternFestivalAnswerView:unbindEvents()
	LanternFestivalAnswerView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnMask:RemoveClickListener()

	for i, v in ipairs(self._answerList) do
		v.btn:RemoveClickListener()
	end

	GameUtil.rmClickHandler(self._btnTip)
end

function LanternFestivalAnswerView:bindEvents()
	LanternFestivalAnswerView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._btnMask:AddClickListener(self._onClickMask, self)

	for i, v in ipairs(self._answerList) do
		v.btn:AddClickListener(function()
			self:_onClickAnswer(i)
		end)
	end

	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function LanternFestivalAnswerView:buildUI()
	LanternFestivalAnswerView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnNext = self:getBtn("btnNext")
	self._txtQuestion = self:getTxt("question/txt")
	self._answerList = {}

	local answerGo = self:getGo("answer")

	for i = 1, 3 do
		local go = goutil.findChild(answerGo, "option" .. i)
		local element = {}

		element.btn = Framework.ButtonAdapter.Get(go)
		element.bgColorChange = goutil.findChild(go, "img1"):GetComponent(ComponentType.UIImageColorChange)
		element.yes = goutil.findChild(go, "yes")
		element.no = goutil.findChild(go, "no")
		element.txt = goutil.findChildTextComponent(go, "txt")
		element.effect = goutil.findChild(go, "effect")

		table.insert(self._answerList, element)
	end

	self._mask = self:getGo("mask")
	self._btnMask = self:getBtn("mask")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
end

function LanternFestivalAnswerView:onExit()
	LanternFestivalAnswerView.super.onExit(self)
	self:_clearTween()
	self:_closeMask()
	self:_clearEffects()
	removetimer(self._handleAnswerCorrect, self)
end

function LanternFestivalAnswerView:onEnter()
	LanternFestivalAnswerView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._problemId = 1
	self._nextProblemId = 0
	self._actCfg = LanternFestivalConfig.instance:getActivityCfg(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._problemPlanId = self._actCfg.personQuastionPlan
	self._curDay = ActivityDefineController.instance:getActivityCurrentDay(self._activityId)

	if self._curDay <= 0 then
		self._curDay = 1
	end

	self._qusestionPlanCfgs = LanternFestivalConfig.instance:getPersonQuestionPlanCfgs(self._problemPlanId, self._curDay)
	self._questionIdList = {}

	for k, v in pairs(self._qusestionPlanCfgs) do
		table.insert(self._questionIdList, k)
	end

	self._questionIdList = GameUtil.permuteArray(self._questionIdList)
	self._curRealAnswer = ""
	self._isStartQuestioning = true

	self:_closeMask()
	self:_initBtnNext()
	self:_refreshProblem(self._problemId)
	self:_loadEffects()
end

function LanternFestivalAnswerView:_onClickNext()
	if self._nextProblemId > 0 then
		self:_refreshProblem(self._nextProblemId)
		self:_closeMask()
		self:_initBtnNext()
	else
		FloatWordMgr.instance:show("今日题目已答完")
	end
end

function LanternFestivalAnswerView:_onClickMask()
	FloatWordMgr.instance:show("点击太频繁，冷静3秒再想想~")
end

function LanternFestivalAnswerView:_onClickAnswer(index)
	removetimer(self._handleAnswerCorrect, self)

	if not self._isStartQuestioning then
		return
	end

	local selectAnswer = OptionEnum[index]

	if not string.nilorempty(selectAnswer) and selectAnswer == self._curRealAnswer then
		FloatWordMgr.instance:show("回答正确")
		self:_refreshProblemOnAnswered(true, index)
		self:_openMask()
		settimer(1, self._handleAnswerCorrect, self, false)
	else
		self:_refreshProblemOnAnswered(false, index)

		if not self:_isLeftUniqueAnswer() then
			self:_openMask()
			self:_delayCloseMask()
			FloatWordMgr.instance:show("作答错误，冷静3秒再想想~")
		end
	end
end

function LanternFestivalAnswerView:_handleAnswerCorrect()
	self:_closeMask()
	self:_updateBtnNext()
end

function LanternFestivalAnswerView:_initBtnNext()
	goutil.setActive(self._btnNext.gameObject, false)
end

function LanternFestivalAnswerView:_updateBtnNext()
	if self._problemId >= #self._qusestionPlanCfgs then
		self._nextProblemId = 0

		TipsFacade.instance:openTipWindowNoX(lang("tip"), "今日题目已答完，明日再来吧", function()
			self:close()
			LanternFestivalController.instance:finishPersionQuestion(self._activityId)
		end)
	else
		self._nextProblemId = self._problemId + 1
	end

	goutil.setActive(self._btnNext.gameObject, self._problemId <= #self._qusestionPlanCfgs)
end

function LanternFestivalAnswerView:_refreshProblem(problemId)
	local cfg = self._qusestionPlanCfgs[self._questionIdList[problemId]]

	if not cfg then
		return
	end

	self._txtQuestion.text = cfg.title

	for i, v in ipairs(self._answerList) do
		goutil.setActive(v.yes, false)
		goutil.setActive(v.no, false)
		goutil.setActive(v.effect, false)

		v.txt.text = cfg["option" .. OptionEnum[i]]

		v.bgColorChange:SetState(0)
	end

	self._curRealAnswer = cfg.answer
	self._isStartQuestioning = true
	self._problemId = problemId
end

function LanternFestivalAnswerView:_refreshProblemOnAnswered(isRight, index)
	for i, v in ipairs(self._answerList) do
		if i == index then
			v.bgColorChange:SetState(isRight and 0 or 1)
			goutil.setActive(v.no, not isRight)
			goutil.setActive(v.yes, isRight)
			goutil.setActive(v.effect, isRight)
		end
	end
end

function LanternFestivalAnswerView:_isLeftUniqueAnswer()
	if not self._isStartQuestioning then
		return false
	end

	local wrongNum = 0

	for i, v in ipairs(self._answerList) do
		if v.no.activeSelf and not v.yes.activeSelf then
			wrongNum = wrongNum + 1
		end
	end

	return wrongNum == 2
end

function LanternFestivalAnswerView:_closeMask()
	goutil.setActive(self._mask, false)
end

function LanternFestivalAnswerView:_openMask()
	goutil.setActive(self._mask, true)
end

function LanternFestivalAnswerView:_delayCloseMask()
	self._delayTween = TweenUtil.DoDelay(3, function()
		self:_closeMask()
	end)
end

function LanternFestivalAnswerView:_clearTween()
	if self._delayTween then
		self._delayTween:Kill()

		self._delayTween = nil
	end
end

function LanternFestivalAnswerView:_loadEffects()
	self:_clearEffects()

	self._effectList = {}

	local effPath = "20230929/zhongqiucaidengmi/fx_ui_caidengmi_datiguang.prefab"

	for i, v in ipairs(self._answerList) do
		local effect = UIEffectManager.instance:playEffect(self, effPath, v.effect.transform, 0, 0, true, false)

		effect:setParent(v.effect.transform)
		effect:setScale(1)
		effect:setLocalPos(0, 0, 0)
		table.insert(self._effectList, effect)
	end
end

function LanternFestivalAnswerView:_clearEffects()
	if self._effectList then
		for i, v in ipairs(self._effectList) do
			UIEffectManager.instance:stopEffect(v)
		end

		table.clear(self._effectList)

		self._effectList = nil
	end
end

function LanternFestivalAnswerView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

return LanternFestivalAnswerView
