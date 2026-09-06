-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaQuizGameView.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaQuizGameView", package.seeall)

local MiyaQuizGameView = class("MiyaQuizGameView", MiyaGameBaseView)

function MiyaQuizGameView:onExit()
	MiyaQuizGameView.super.onExit(self)
	removetimer(self._tryNextQuestion, self)

	self._canClick = true
end

function MiyaQuizGameView:buildUI()
	MiyaQuizGameView.super.buildUI(self)

	self._txtNum = self:getTxt("question/title/txtNum")
	self._questionDesc = self:getTxt("question/title/txtDesc")
	self._questionGo = self:getGo("question")
	self._options = {}

	for i = 1, 4 do
		table.insert(self._options, self:getGo("question/answer/answer" .. i))
	end
end

function MiyaQuizGameView:onEnter()
	MiyaQuizGameView.super.onEnter(self)

	self._canClick = true
end

function MiyaQuizGameView:_initGame()
	local quizId = checknumber(self:getFirstParam())

	self._quizCfg = MiyaGameConfig.instance:getQuizCfg(quizId)
	self._curIdx = 0
	self._maxCount = self._quizCfg.totalNum
	self._totalTime = self._quizCfg.gameTime
	self._totalCount = self._quizCfg.passNeedNum
	self._tipCountdown = langPara("miya_quizgame_countdown_tip", self._totalTime, self._totalCount, self._maxCount)

	self._questionGo:SetActive(false)
	MiyaFindFaultView.super._initGame(self)
end

function MiyaQuizGameView:_startGame()
	MiyaQuizGameView.super._startGame(self)
	self._questionGo:SetActive(true)

	self._questionCfgs = MiyaGameConfig.instance:getRandomQuestionIds(self._quizCfg.quizIdNew, self._maxCount)
	self._questionIds = {}
	self._answerIds = {}
	self._curIdx = 1

	self:_updateCurQuestion()
end

function MiyaQuizGameView:_updateCurQuestion()
	local questionCfg

	if self._questionCfgs and self._curIdx > 0 then
		questionCfg = self._questionCfgs[self._curIdx]
	end

	self._txtNum.text = string.format("第%d/%d题", self._curIdx, self._maxCount)
	self._questionDesc.text = questionCfg == nil and "？？？" or questionCfg.question

	local randomList = GameUtil.permuteArray({
		2,
		3,
		4,
		1
	})

	for k, v in ipairs(self._options) do
		local txtDesc = goutil.findChildTextComponent(v, "txtDesc")
		local imgTrue = goutil.findChild(v, "true")
		local imgFalse = goutil.findChild(v, "false")
		local btn = Framework.ButtonAdapter.Get(v)

		imgTrue:SetActive(false)
		imgFalse:SetActive(false)

		if questionCfg == nil then
			txtDesc.text = "？？？"

			btn:RemoveClickListener()
		else
			local optionId = randomList[k]

			txtDesc.text = questionCfg["option" .. optionId]

			local isTrue = questionCfg.correctOptionId == optionId
			local img = isTrue and imgTrue or imgFalse

			btn:AddClickListener(function()
				self:_onClickOption(optionId, isTrue, img, questionCfg.questionId)
			end)
		end
	end
end

function MiyaQuizGameView:_onClickOption(optionId, isTrue, img, questionId)
	if not self._canClick then
		return
	end

	local text = isTrue and "回答正确" or "回答错误"

	FloatWordMgr.instance:show(text)
	img:SetActive(true)
	table.insert(self._questionIds, questionId)
	table.insert(self._answerIds, optionId)

	if isTrue then
		self._findedCount = self._findedCount + 1

		self:_updateLeftCount()
	elseif self._maxCount - self._curIdx < self._totalCount - self._findedCount then
		self:_endGame(false)
	end

	self._canClick = false

	settimer(0.4, self._tryNextQuestion, self, false)
end

function MiyaQuizGameView:_tryNextQuestion()
	self._canClick = true
	self._curIdx = self._curIdx + 1

	if self._curIdx > self._maxCount then
		self:_endGame()
	else
		self:_updateCurQuestion()
	end
end

return MiyaQuizGameView
