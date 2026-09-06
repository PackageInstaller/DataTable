-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesslantern/view/copyindjs/GuessLanternAnswerCopyInDjsView.lua

module("logic.extensions.guesslantern.view.GuessLanternAnswerCopyInDjsView", package.seeall)

local GuessLanternAnswerCopyInDjsView = class("GuessLanternAnswerCopyInDjsView", ViewComponent)
local OptionEnum = {
	"A",
	"B",
	"C"
}

function GuessLanternAnswerCopyInDjsView:ctor()
	GuessLanternAnswerCopyInDjsView.super.ctor(self)
end

function GuessLanternAnswerCopyInDjsView:buildUI()
	GuessLanternAnswerCopyInDjsView.super.buildUI(self)

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

function GuessLanternAnswerCopyInDjsView:bindEvents()
	GuessLanternAnswerCopyInDjsView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._btnMask:AddClickListener(self._onClickMask, self)

	for i, v in ipairs(self._answerList) do
		v.btn:AddClickListener(function()
			self:_onClickAnswer(i)
		end)
	end
end

function GuessLanternAnswerCopyInDjsView:unbindEvents()
	GuessLanternAnswerCopyInDjsView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnMask:RemoveClickListener()

	for i, v in ipairs(self._answerList) do
		v.btn:RemoveClickListener()
	end
end

function GuessLanternAnswerCopyInDjsView:onEnter()
	GuessLanternAnswerCopyInDjsView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineJieShenClgNormalFinishGameRes, self._handlePM_DivineJieShenClgNormalFinishGameRes, self)

	local params = self:getOpenParam()

	self._problemPlanId = params[1]
	self._problemCount = params[2]
	self._djsParams = params[3]

	local cfg = GuessLanternConfig.instance:getProblemCfgList(self._problemPlanId)
	local totalProblemCount = #cfg

	if self._problemCount <= 0 then
		self._problemCount = #cfg or self._problemCount
	end

	self._problemIdList = MathUtil.randomEx(1, totalProblemCount, self._problemCount)

	if enableDebug then
		local str = string.format("抽中%s道题目：", #self._problemIdList)

		for _, v in ipairs(self._problemIdList) do
			str = str .. v .. ", "
		end

		print(str)
	end

	local problemId = self._problemIdList[1]

	self._curProblemIndex = 1
	self._curRealAnswter = ""
	self._reqProblemId = 0
	self._isStartQuestioning = true

	self:_closeMask()
	self:_initBtnNext()
	self:_refreshProblem(problemId)
	self:_loadEffects()
end

function GuessLanternAnswerCopyInDjsView:onExit()
	GuessLanternAnswerCopyInDjsView.super.onExit(self)
	self:_clearTween()
	self:_closeMask()
	self:_clearEffects()
end

function GuessLanternAnswerCopyInDjsView:_handlePM_DivineJieShenClgNormalFinishGameRes(status, msg)
	local function okFunc()
		self:close()
	end

	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openTipWindowNoX("提示", (not ((status ~= 0 and msg or nil) and checkbool(msg.pass)) or nil) and "很遗憾，试炼失败，请继续努力！", okFunc, "确定", alignment)
end

function GuessLanternAnswerCopyInDjsView:_onClickNext()
	local nextIndex = self._curProblemIndex + 1
	local problemId = checknumber(self._problemIdList[nextIndex])

	if problemId > 0 then
		printInfo("test GuessLanternAnswerCopyInDjsView:_onClickNext", problemId)

		self._curProblemIndex = nextIndex

		self:_refreshProblem(problemId)
		self:_closeMask()
		self:_initBtnNext()
	else
		FloatWordMgr.instance:show("今日题目已答完")
	end
end

function GuessLanternAnswerCopyInDjsView:_onClickMask()
	FloatWordMgr.instance:show("作答错误，冷静3秒再想想~")
end

function GuessLanternAnswerCopyInDjsView:_onClickAnswer(index)
	if not self._isStartQuestioning then
		printInfo("test 不在答题中")

		return
	end

	local selectAnswer = OptionEnum[index]

	printInfo("test GuessLanternAnswerCopyInDjsView:_onClickAnswer", index, selectAnswer, self._curRealAnswter, selectAnswer == self._curRealAnswter)

	if not string.nilorempty(selectAnswer) and selectAnswer == self._curRealAnswter then
		FloatWordMgr.instance:show("回答正确")

		self._isStartQuestioning = false

		self:_refreshProblemOnAnswered(true, index)
		self:_closeMask()
		self:_onIncProgressRes()
	else
		self:_refreshProblemOnAnswered(false, index)

		if not self:_isLeftUniqueAnswer() then
			self:_openMask()
			self:_delayCloseMask()
			FloatWordMgr.instance:show("作答错误，冷静3秒再想想~")
		end
	end
end

function GuessLanternAnswerCopyInDjsView:_onIncProgressRes()
	self:_updateBtnNext()
end

function GuessLanternAnswerCopyInDjsView:_initBtnNext()
	goutil.setActive(self._btnNext.gameObject, false)
end

function GuessLanternAnswerCopyInDjsView:_updateBtnNext()
	local cfg = GuessLanternConfig.instance:getProblemCfgList(self._problemPlanId)

	if cfg then
		if not #cfg then
			local nextIndex = self._curProblemIndex + 1
			local problemId = checknumber(self._problemIdList[nextIndex])
			local isExistNext = problemId > 0

			goutil.setActive(self._btnNext.gameObject, isExistNext)

			if isExistNext then
				self:_onClickNext()
			else
				local activityId = self._djsParams.activityId
				local stageId = self._djsParams.stageId

				DivineJieShenController.instance:sendPM_DivineJieShenClgNormalFinishGameReq(activityId, stageId, true, 0)
			end
		end
	end
end

function GuessLanternAnswerCopyInDjsView:_refreshProblem(problemId)
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

function GuessLanternAnswerCopyInDjsView:_refreshProblemOnAnswered(isRight, index)
	for i, v in ipairs(self._answerList) do
		if i == index then
			v.bgColorChange:SetState(isRight and 0 or 1)
			goutil.setActive(v.no, not isRight)
			goutil.setActive(v.yes, isRight)
			goutil.setActive(v.effect, isRight)
		end
	end
end

function GuessLanternAnswerCopyInDjsView:_isLeftUniqueAnswer()
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

function GuessLanternAnswerCopyInDjsView:_closeMask()
	goutil.setActive(self._mask, false)
end

function GuessLanternAnswerCopyInDjsView:_openMask()
	goutil.setActive(self._mask, true)
end

function GuessLanternAnswerCopyInDjsView:_delayCloseMask()
	self._delayTween = TweenUtil.DoDelay(3, function()
		self:_closeMask()
	end)
end

function GuessLanternAnswerCopyInDjsView:_clearTween()
	if self._delayTween then
		self._delayTween:Kill()

		self._delayTween = nil
	end
end

function GuessLanternAnswerCopyInDjsView:_loadEffects()
	self:_clearEffects()

	self._effectList = {}

	for i, v in ipairs(self._answerList) do
		local effect = UIEffectManager.instance:playEffect(self, GuessLanternAnswerCopyInDjsViewPresentor.Effect1, v.effect.transform, 0, 0, true, false)

		effect:setParent(v.effect.transform)
		effect:setScale(1)
		effect:setLocalPos(0, 0, 0)
		table.insert(self._effectList, effect)
	end
end

function GuessLanternAnswerCopyInDjsView:_clearEffects()
	if self._effectList then
		for i, v in ipairs(self._effectList) do
			UIEffectManager.instance:stopEffect(v)
		end

		table.clear(self._effectList)

		self._effectList = nil
	end
end

return GuessLanternAnswerCopyInDjsView
