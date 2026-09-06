-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesslantern/view/NewGuessLanternAnswerView.lua

module("logic.extensions.guesslantern.view.NewGuessLanternAnswerView", package.seeall)

local NewGuessLanternAnswerView = class("NewGuessLanternAnswerView", ViewComponent)
local OptionEnum = {
	"A",
	"B",
	"C"
}

function NewGuessLanternAnswerView:ctor()
	NewGuessLanternAnswerView.super.ctor(self)
end

function NewGuessLanternAnswerView:buildUI()
	NewGuessLanternAnswerView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnNext = self:getBtn("btnNext")
	self._txtQuestion = self:getTxt("question/txt")
	self._answerList = {}

	local answerGo = self:getGo("answer")

	for i = 1, 3 do
		local go = goutil.findChild(answerGo, "option" .. i)
		local element = {}

		element.btn = Framework.ButtonAdapter.Get(go)
		element.imgSelect = goutil.findChild(go, "select")
		element.yes = goutil.findChild(go, "yes")
		element.no = goutil.findChild(go, "no")
		element.txt = goutil.findChildTextComponent(go, "txt")
		element.effect = goutil.findChild(go, "effect")

		table.insert(self._answerList, element)
	end

	self._mask = self:getGo("mask")
	self._btnMask = self:getBtn("mask")
	self._imgCh = self:getGo("pet")
end

function NewGuessLanternAnswerView:bindEvents()
	NewGuessLanternAnswerView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._btnMask:AddClickListener(self._onClickMask, self)

	for i, v in ipairs(self._answerList) do
		v.btn:AddClickListener(function()
			self:_onClickAnswer(i)
		end)
	end
end

function NewGuessLanternAnswerView:unbindEvents()
	NewGuessLanternAnswerView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnMask:RemoveClickListener()

	for i, v in ipairs(self._answerList) do
		v.btn:RemoveClickListener()
	end
end

function NewGuessLanternAnswerView:onEnter()
	NewGuessLanternAnswerView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GuessLanternIncProgressRes, self._onIncProgressRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._problemId = params[2]
	self._nextProblemId = 0
	self._passProblem = {}
	self._cfgActivity = GuessLanternConfig.instance:getActivityCfg(self._activityId)
	self._problemPlanId = self._cfgActivity.problemPlanId
	self._curRealAnswter = ""
	self._reqProblemId = 0
	self._isStartQuestioning = true

	self:_refreshViewUI(params[3])
	self:_closeMask()
	self:_initBtnNext()
	self:_refreshProblem(self._problemId)
	self:_loadEffects()
end

function NewGuessLanternAnswerView:onExit()
	NewGuessLanternAnswerView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GuessLanternIncProgressRes, self._onIncProgressRes, self)
	self:_clearTween()
	self:_closeMask()
	self:_clearEffects()
	uGuiUtil.clearImage(self._imgCh)
end

function NewGuessLanternAnswerView:_onClickNext()
	if self._nextProblemId > 0 then
		self:_refreshProblem(self._nextProblemId)
		self:_closeMask()
		self:_initBtnNext()
	else
		FloatWordMgr.instance:show("今日题目已答完")
	end
end

function NewGuessLanternAnswerView:_onClickMask()
	FloatWordMgr.instance:show("作答错误，冷静3秒再想想~")
end

function NewGuessLanternAnswerView:_onClickAnswer(index)
	if not self._isStartQuestioning then
		printInfo("test 不在答题中")

		return
	end

	local selectAnswer = OptionEnum[index]

	printInfo("test NewGuessLanternAnswerView:_onClickAnswer", index, selectAnswer, self._curRealAnswter, selectAnswer == self._curRealAnswter)

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

function NewGuessLanternAnswerView:_onIncProgressRes()
	self:_updateBtnNext()
end

function NewGuessLanternAnswerView:_initBtnNext()
	goutil.setActive(self._btnNext.gameObject, false)
end

function NewGuessLanternAnswerView:_updateBtnNext()
	if TableUtil.isTableEmpty(self._passProblem) then
		local nextProblemIds = GuessLanternModel.instance:getNoGuessProblemIds()

		self._passProblem = {}

		for _, v in ipairs(nextProblemIds) do
			self._passProblem[v] = false
		end
	end

	local count = #self._passProblem
	local isExistNext = count > 1

	if self._reqProblemId > 0 then
		self._passProblem[self._reqProblemId] = true
	end

	self._nextProblemId = 0

	for i, isPass in pairs(self._passProblem) do
		if not isPass then
			self._nextProblemId = i

			break
		end
	end

	isExistNext = self._nextProblemId > 0

	goutil.setActive(self._btnNext.gameObject, isExistNext)

	if not isExistNext then
		self._nextProblemId = 0

		TipsFacade.instance:openPopupWindow(lang("tip"), "本次题目已答完", function()
			self:close()
		end)
	end
end

function NewGuessLanternAnswerView:_refreshProblem(problemId)
	local cfg = GuessLanternConfig.instance:getProblemCfg(self._problemPlanId, problemId)

	if not cfg then
		return
	end

	self._txtQuestion.text = cfg.title

	for i, v in ipairs(self._answerList) do
		goutil.setActive(v.yes, false)
		goutil.setActive(v.no, false)
		goutil.setActive(v.effect, false)

		v.txt.text = OptionEnum[i] .. "." .. cfg["option" .. OptionEnum[i]]

		goutil.setActive(v.imgSelect, false)
	end

	self._curRealAnswter = cfg.answer
	self._reqProblemId = problemId
	self._isStartQuestioning = true
end

function NewGuessLanternAnswerView:_refreshProblemOnAnswered(isRight, index)
	for i, v in ipairs(self._answerList) do
		if i == index then
			goutil.setActive(v.no, not isRight)
			goutil.setActive(v.yes, isRight)
			goutil.setActive(v.effect, isRight)
		end

		goutil.setActive(v.imgSelect, i == index)
	end
end

function NewGuessLanternAnswerView:_isLeftUniqueAnswer()
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

function NewGuessLanternAnswerView:_closeMask()
	goutil.setActive(self._mask, false)
end

function NewGuessLanternAnswerView:_openMask()
	goutil.setActive(self._mask, true)
end

function NewGuessLanternAnswerView:_delayCloseMask()
	self._delayTween = TweenUtil.DoDelay(3, function()
		self:_closeMask()
	end)
end

function NewGuessLanternAnswerView:_clearTween()
	if self._delayTween then
		self._delayTween:Kill()

		self._delayTween = nil
	end
end

function NewGuessLanternAnswerView:_loadEffects()
	self:_clearEffects()

	self._effectList = {}

	for i, v in ipairs(self._answerList) do
		local effect = UIEffectManager.instance:playEffect(self, NewGuessLanternAnswerViewPresentor.Effect1, v.effect.transform, 0, 0, true, false)

		effect:setParent(v.effect.transform)
		effect:setScale(1)
		effect:setLocalPos(0, 0, 0)
		table.insert(self._effectList, effect)
	end
end

function NewGuessLanternAnswerView:_clearEffects()
	if self._effectList then
		for i, v in ipairs(self._effectList) do
			UIEffectManager.instance:stopEffect(v)
		end

		table.clear(self._effectList)

		self._effectList = nil
	end
end

function NewGuessLanternAnswerView:_refreshViewUI(imgName)
	if string.nilorempty(imgName) then
		goutil.setActive(self._imgCh, false)

		return
	end

	if self._imgCh then
		local isNeedSetBg = not string.nilorempty(imgName)

		local function localFunc()
			local image = self._imgCh:GetComponent(goutil.Type_UIImage)

			if image then
				image:SetNativeSize()
			end
		end

		if isNeedSetBg then
			local bgUrl = string.format("ui/bigbg/petcollegetip/%s" .. ".png", imgName)

			uGuiUtil.setSpriteToImage(self._imgCh, uGuiUtil.SpriteType.BigBg, bgUrl, localFunc)
		end
	end
end

return NewGuessLanternAnswerView
