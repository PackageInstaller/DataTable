-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesslantern/view/GuessLanternAnswerView.lua

module("logic.extensions.guesslantern.view.GuessLanternAnswerView", package.seeall)

local GuessLanternAnswerView = class("GuessLanternAnswerView", ViewComponent)
local OptionEnum = {
	"A",
	"B",
	"C"
}

function GuessLanternAnswerView:ctor()
	GuessLanternAnswerView.super.ctor(self)
end

function GuessLanternAnswerView:buildUI()
	GuessLanternAnswerView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
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
end

function GuessLanternAnswerView:bindEvents()
	GuessLanternAnswerView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._btnMask:AddClickListener(self._onClickMask, self)

	for i, v in ipairs(self._answerList) do
		v.btn:AddClickListener(function()
			self:_onClickAnswer(i)
		end)
	end
end

function GuessLanternAnswerView:unbindEvents()
	GuessLanternAnswerView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnMask:RemoveClickListener()

	for i, v in ipairs(self._answerList) do
		v.btn:RemoveClickListener()
	end
end

function GuessLanternAnswerView:onEnter()
	GuessLanternAnswerView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GuessLanternIncProgressRes, self._onIncProgressRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._problemId = params[2]
	self._nextProblemId = 0
	self._cfgActivity = GuessLanternConfig.instance:getActivityCfg(self._activityId)
	self._problemPlanId = self._cfgActivity.problemPlanId
	self._curRealAnswter = ""
	self._reqProblemId = 0
	self._isStartQuestioning = true

	self:_closeMask()
	self:_initBtnNext()
	self:_refreshProblem(self._problemId)
	self:_loadEffects()
end

function GuessLanternAnswerView:onExit()
	GuessLanternAnswerView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GuessLanternIncProgressRes, self._onIncProgressRes, self)
	self:_clearTween()
	self:_closeMask()
	self:_clearEffects()
end

function GuessLanternAnswerView:_onClickNext()
	if self._nextProblemId > 0 then
		printInfo("test GuessLanternAnswerView:_onClickNext", self._nextProblemId)
		self:_refreshProblem(self._nextProblemId)
		self:_closeMask()
		self:_initBtnNext()
	else
		FloatWordMgr.instance:show("今日题目已答完")
	end
end

function GuessLanternAnswerView:_onClickMask()
	FloatWordMgr.instance:show("作答错误，冷静3秒再想想~")
end

function GuessLanternAnswerView:_onClickAnswer(index)
	if not self._isStartQuestioning then
		printInfo("test 不在答题中")

		return
	end

	local selectAnswer = OptionEnum[index]

	printInfo("test GuessLanternAnswerView:_onClickAnswer", index, selectAnswer, self._curRealAnswter, selectAnswer == self._curRealAnswter)

	if not string.nilorempty(selectAnswer) and selectAnswer == self._curRealAnswter then
		FloatWordMgr.instance:show("回答正确")

		self._isStartQuestioning = false

		self:_refreshProblemOnAnswered(true, index)
		self:_closeMask()
		GuessLanternAgent.instance:sendPM_GuessLanternIncProgressReq(self._activityId, self._reqProblemId)
	else
		self:_refreshProblemOnAnswered(false, index)

		if not self:_isLeftUniqueAnswer() then
			self:_openMask()
			self:_delayCloseMask()
			FloatWordMgr.instance:show("作答错误，冷静3秒再想想~")
		end
	end
end

function GuessLanternAnswerView:_onIncProgressRes()
	self:_updateBtnNext()
end

function GuessLanternAnswerView:_initBtnNext()
	goutil.setActive(self._btnNext.gameObject, false)
end

function GuessLanternAnswerView:_updateBtnNext()
	local nextProblemIds = GuessLanternModel.instance:getNoGuessProblemIds()
	local count = #nextProblemIds
	local isExistNext = count > 0

	goutil.setActive(self._btnNext.gameObject, isExistNext)

	if isExistNext then
		self._nextProblemId = nextProblemIds[1]
	else
		self._nextProblemId = 0

		TipsFacade.instance:openPopupWindow(lang("tip"), "本次题目已答完", function()
			self:close()
		end)
	end
end

function GuessLanternAnswerView:_refreshProblem(problemId)
	local cfg = GuessLanternConfig.instance:getProblemCfg(self._problemPlanId, problemId)

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

	self._curRealAnswter = cfg.answer
	self._reqProblemId = problemId
	self._isStartQuestioning = true
end

function GuessLanternAnswerView:_refreshProblemOnAnswered(isRight, index)
	for i, v in ipairs(self._answerList) do
		if i == index then
			v.bgColorChange:SetState(isRight and 0 or 1)
			goutil.setActive(v.no, not isRight)
			goutil.setActive(v.yes, isRight)
			goutil.setActive(v.effect, isRight)
		end
	end
end

function GuessLanternAnswerView:_isLeftUniqueAnswer()
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

function GuessLanternAnswerView:_closeMask()
	goutil.setActive(self._mask, false)
end

function GuessLanternAnswerView:_openMask()
	goutil.setActive(self._mask, true)
end

function GuessLanternAnswerView:_delayCloseMask()
	self._delayTween = TweenUtil.DoDelay(3, function()
		self:_closeMask()
	end)
end

function GuessLanternAnswerView:_clearTween()
	if self._delayTween then
		self._delayTween:Kill()

		self._delayTween = nil
	end
end

function GuessLanternAnswerView:_loadEffects()
	self:_clearEffects()

	self._effectList = {}

	for i, v in ipairs(self._answerList) do
		local effect = UIEffectManager.instance:playEffect(self, GuessLanternAnswerViewPresentor.Effect1, v.effect.transform, 0, 0, true, false)

		effect:setParent(v.effect.transform)
		effect:setScale(1)
		effect:setLocalPos(0, 0, 0)
		table.insert(self._effectList, effect)
	end
end

function GuessLanternAnswerView:_clearEffects()
	if self._effectList then
		for i, v in ipairs(self._effectList) do
			UIEffectManager.instance:stopEffect(v)
		end

		table.clear(self._effectList)

		self._effectList = nil
	end
end

return GuessLanternAnswerView
