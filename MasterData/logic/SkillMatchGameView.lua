-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishihud/view/SkillMatchGameView.lua

module("logic.extensions.dragonkingaruishihud.view.SkillMatchGameView", package.seeall)

local SkillMatchGameView = class("SkillMatchGameView", ViewComponent)

function SkillMatchGameView:ctor()
	SkillMatchGameView.super.ctor(self)
end

function SkillMatchGameView:unbindEvents()
	SkillMatchGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i, cell in ipairs(self._bubbleCellList) do
		GameUtil.rmClickHandler(cell.btn)
	end
end

function SkillMatchGameView:bindEvents()
	SkillMatchGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)

	for i, cell in ipairs(self._bubbleCellList) do
		GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickBubble, self, i))
	end
end

function SkillMatchGameView:buildUI()
	SkillMatchGameView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._con = goutil.findChild(self.mainGO, "con")
	self._bubbleCon = self:getGo("bubbleCon")
	self._bubbleCellList = {}

	for id = 1, self._bubbleCon.transform.childCount do
		local cell = {}

		cell.id = id
		cell.go = self._bubbleCon.transform:GetChild(id - 1).gameObject
		cell.btn = goutil.findChild(cell.go, "btn")
		cell.txt = goutil.findChildTextComponent(cell.go, "txt")

		table.insert(self._bubbleCellList, cell)
	end

	self._txtTimer = self:getTxt("timer/txtTimer")
	self._sliderProgress = self:getSlider("progress/slider")
	self._txtProgress = self:getTxt("progress/txt")
	self._txtShowInfo = self:getTxt("showInfo/txt")
end

function SkillMatchGameView:onExit()
	SkillMatchGameView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	removetimer(self._onCountDown, self)
end

function SkillMatchGameView:onEnter()
	SkillMatchGameView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 506001
	end

	self:_updateUIByCfg()
	self:_initGame()
	self:_startGame()
end

function SkillMatchGameView:_updateUIByCfg()
	self._actCfg = DragonKingARuiShiHUDConfig.instance:getActviityCfg(self._activityId)
	self._curSkinId = self._actCfg.skinId

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSkinId)
	local curRaceId = petSkinCfg and petSkinCfg.raceId
	local petInfo = CharacterConfig.instance:getPetInfoCo(curRaceId)

	self._txtShowInfo.text = petInfo and string.gsub(petInfo.stragegy, "\n", " ") or ""

	local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("bag", self._curSkinId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, displayBagOffset[3], nil, false, displayBagOffset[1], displayBagOffset[2])
	self._questionBankCfgs = DragonKingARuiShiHUDConfig.instance:getQuestionBankCfg(self._actCfg.questionBank) or {}
end

function SkillMatchGameView:_initGame()
	for i, cell in ipairs(self._bubbleCellList) do
		goutil.setActive(cell.go, false)
	end

	self._showNum = self._actCfg.showNum or 0
	self._matchNum = 0
	self._totalTime = self._actCfg.totalTime or 0
	self._deductTime = self._actCfg.deductTime or 1
	self._timeStep = 1
	self._timer = self._totalTime + self._timeStep
	self._rightAnswers = {}
	self._wrongAnswers = {}
	self._rightNum = 0

	for i, cfg in ipairs(self._questionBankCfgs) do
		if cfg.isRight then
			self._rightNum = self._rightNum + 1

			table.insert(self._rightAnswers, cfg)
		else
			table.insert(self._wrongAnswers, cfg)
		end
	end

	self._initAnswers = {}
	self._answerMap = {}
	self._dealMap = {}

	self:_onCountDown()
	GameUtil.permuteArray(self._rightAnswers)
	GameUtil.permuteArray(self._wrongAnswers)

	self._showRightNum = 0

	for i = 1, Mathf.Ceil(self._showNum / 2) do
		if #self._rightAnswers > 0 then
			local cfg = table.remove(self._rightAnswers)

			if cfg then
				table.insert(self._initAnswers, cfg)
			end
		end
	end

	self._showRightNum = #self._initAnswers or 0

	for i = 1, self._showNum - self._showRightNum do
		if #self._wrongAnswers > 0 then
			local cfg = table.remove(self._wrongAnswers)

			if cfg then
				table.insert(self._initAnswers, cfg)
			end
		end
	end

	GameUtil.permuteArray(self._initAnswers)
end

function SkillMatchGameView:_startGame()
	for i = 1, self._showNum do
		goutil.setActive(self._bubbleCellList[i].go, true)
		self:_refreshBubble(i, true)
	end

	self._isPlaying = true

	settimer(self._timeStep, self._onCountDown, self, true)
end

function SkillMatchGameView:_onCountDown()
	if not self._isPlaying then
		return
	end

	self._timer = self._timer - self._timeStep

	Mathf.Max(self._timer, self._timer, 0)

	self._txtTimer.text = string.format("倒计时：<color=#fff5c3>%s</color>秒", self._timer)

	local curProgress = checknumber(checknumber(self._matchNum) / checknumber(self._rightNum))

	self._txtProgress.text = string.format("%.2f%%", checknumber(curProgress * 100))

	self._sliderProgress:SetValue(curProgress)

	if self._rightNum <= self._matchNum or self._timer <= 0 then
		self:_endGame()
	end
end

function SkillMatchGameView:_endGame()
	self._isPlaying = false

	if self._rightNum <= self._matchNum then
		local showTips = "挑战成功"

		TipsFacade:openTipWindowNoX("提示", showTips, function()
			self:close()
			DragonKingARuiShiHUDController.instance:gainPrize(self._activityId)
		end, "确定")
	else
		TipsFacade.instance:openPopupWindow("提示", "是否重新挑战？", function()
			self:_initGame()
			self:_startGame()
		end, function()
			self:close()
		end)
	end
end

function SkillMatchGameView:_onClickClose()
	self:close()
end

function SkillMatchGameView:_onClickBubble(id)
	if self._dealMap[id] then
		return
	end

	local cfg = self._answerMap[id]

	self:_dealAnwer(cfg)
	self:_refreshBubble(id, false)
end

function SkillMatchGameView:_refreshBubble(id, isInit)
	local cell = self._bubbleCellList[id]

	if not cell then
		return
	end

	UnityTweens.UITweenFadeIn.StopTween(cell.go)
	UnityTweens.UITweenFadeOut.StopTween(cell.go)
	UnityTweens.TweenSequence.StopTween(cell.go)

	self._dealMap[id] = true

	local newAnwer

	if isInit then
		if #self._initAnswers > 0 then
			newAnwer = table.remove(self._initAnswers, #self._initAnswers)
			self._answerMap[id] = newAnwer
		end
	elseif self._showRightNum <= 1 and #self._rightAnswers > 0 then
		newAnwer = table.remove(self._rightAnswers, #self._rightAnswers)
		self._answerMap[id] = newAnwer
		self._showRightNum = self._showRightNum + 1
	elseif #self._wrongAnswers <= 0 and #self._rightAnswers > 0 then
		newAnwer = table.remove(self._rightAnswers, #self._rightAnswers)
		self._answerMap[id] = newAnwer
		self._showRightNum = self._showRightNum + 1
	elseif #self._wrongAnswers > 0 and #self._rightAnswers <= 0 then
		newAnwer = table.remove(self._wrongAnswers, #self._wrongAnswers)
		self._answerMap[id] = newAnwer
	elseif #self._wrongAnswers > 0 and #self._rightAnswers > 0 then
		if math.random() < 0.5 then
			newAnwer = table.remove(self._wrongAnswers, #self._wrongAnswers)
		else
			newAnwer = table.remove(self._rightAnswers, #self._rightAnswers)
			self._showRightNum = self._showRightNum + 1
		end

		self._answerMap[id] = newAnwer
	end

	if newAnwer then
		if isInit then
			cell.txt.text = newAnwer.answer

			local fadeIn = UnityTweens.UITweenFadeIn.StartTween(cell.go, 0.5, UnityTweens.EaseType.linear, 0)

			fadeIn:AddListener(function()
				self._dealMap[id] = nil
			end)
		else
			local fadeOut = UnityTweens.UITweenFadeOut.Create(cell.go, 0.5, UnityTweens.EaseType.linear, 0)

			fadeOut:AddListener(function()
				cell.txt.text = newAnwer.answer
			end)

			local fadeIn = UnityTweens.UITweenFadeIn.Create(cell.go, 0.5, UnityTweens.EaseType.linear, 0)
			local tweenSeq = UnityTweens.TweenSequence.StartTween(cell.go, fadeOut, fadeIn)

			tweenSeq:AddListener(function()
				self._dealMap[id] = nil
			end)
		end
	else
		UnityTweens.UITweenFadeOut.StartTween(cell.go, 0.5, UnityTweens.EaseType.linear, 0)
	end
end

function SkillMatchGameView:_dealAnwer(cfg)
	if cfg then
		if cfg.isRight then
			self._matchNum = self._matchNum + 1
		else
			self._showRightNum = self._showRightNum - 1
			self._timer = self._timer - self._deductTime

			RoleObjectPool.instance:playAnimation(self._con, "hit", false, function()
				RoleObjectPool.instance:playAnimation(self._con, "idle", true)
			end, true)
		end
	end
end

return SkillMatchGameView
