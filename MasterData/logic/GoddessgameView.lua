-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/view/GoddessgameView.lua

module("logic.extensions.goddess.view.GoddessgameView", package.seeall)

local GoddessgameView = class("GoddessgameView", ViewComponent)
local Time = UnityEngine.Time

function GoddessgameView:unbindEvents()
	GoddessgameView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnClick:RemoveClickListener()
	self._btnAddTimes:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnResume:RemoveClickListener()
	self._btnRule:RemoveClickListener()
end

function GoddessgameView:bindEvents()
	GoddessgameView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnClick:AddClickListener(self._onBallClicked, self)
	self._btnAddTimes:AddClickListener(self._onClickAddTimes, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnResume:AddClickListener(self._onClickResume, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
end

function GoddessgameView:onExit()
	GoddessgameView.super.onExit(self)
	removetimer(self._onTicking, self)
	removetimer(self._onBallBoomed, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessReliveGame, self._onReliveRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessEndGame, self._onEndGameRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessStartGame, self._onStartGameRes, self)
	self:_clearAoqiLihui()
	self:_clearBaozaEffect()
	self:_clearHongquanEffect()

	if self._needPlayBubble then
		local info = GoddessModel.instance:getGoddessInfo(self._raecId)

		if info then
			GlobalDispatcher:dispatch(GlobalNotify.GoddessPlayBubble, info.raceCfg.bubbleBalloon)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.GoddessRefresMainView)
end

function GoddessgameView:buildUI()
	GoddessgameView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._ballRectTrans = self:getGo("ball"):GetComponent(typeof(UnityEngine.RectTransform))
	self._ballWarn = self:getGo("ballWarn")
	self._txtRule = self:getTxt("rule/txtRule")
	self._txtRemaingTime = self:getGo("countdown/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._countdown = self:getGo("countdown")
	self._btnClick = self:getBtn("btnClick")
	self._btnStart = self:getBtn("btnStart")
	self._txtClick = self:getTxt("btnClick/Text")
	self._btnAddTimes = self:getBtn("remaining/btnAdd")
	self._txtRemainingTimes = self:getTxt("remaining/txtCount")
	self._scales = self:getGo("scales")
	self._btnResume = self:getBtn("btnResume")
	self._btnRule = self:getBtn("btnRule")
	self._txtRule.text = GoddessConfig.instance:getCommonValue("GAME_RULE_TIP")
	self._model = self:getGo("model")
end

function GoddessgameView:onEnter()
	GoddessgameView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessReliveGame, self._onReliveRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessEndGame, self._onEndGameRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessStartGame, self._onStartGameRes, self)

	self._needPlayBubble = false
	self._raecId = self:getFirstParam()
	self._bloomedAniDone = false
	self._bloomed = false
	self._subInterval = 0.15
	self._maxGameTime = GoddessConfig.instance:getCommonValue("GAME_TIME", true)
	self._maxVolume = GoddessConfig.instance:getCommonValue("BALL_MAX_VOLUMN", true)
	self._addVolumePerClick = GoddessConfig.instance:getCommonValue("BALL_ADD_VOLUMN_PER_CLICK")
	self._subVolumePerSec = GoddessConfig.instance:getCommonValue("BALL_SUB_VOLUMN_PER_SEC")
	self._clickDuration = GoddessConfig.instance:getCommonValue("CLICK_DURATION", true)
	self._ballDottedLineVolumn = GoddessConfig.instance:getCommonValue("BALL_DOTTED_LINE_VOLUMN", true)
	self._onceGainMaxNum = 9999

	local planId = GoddessModel.instance:getGamePlanId()

	self._scalePrizeCfgs = GoddessConfig.instance:getScalePrizeCfgs(planId)
	self._cells = GameUtil.updateCellsWithCreate(self._scales, self._scalePrizeCfgs, self._updateOneScale, self)

	self:_initGame()
	self:_createAoqiLihui()
end

function GoddessgameView:_createAoqiLihui()
	local effect_path = "fx_ui_yilishabaitiaozhan/aoqicuiqiqiu_spine/aoqicuiqiqiu-ui_p.prefab"

	self._aoqiEffect = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, -363, 0)

		self._graphic = goutil.findChild(eff.effGo, "skeleton"):GetComponent("SkeletonGraphic")
		self._graphic.startingAnimation = "idle"

		self._graphic.AnimationState:SetAnimation(0, "idle", true)
		self._graphic:Update(0)
	end)

	self._aoqiEffect:setParent(self._model.transform)
	self._aoqiEffect:setScale(0.7)
end

function GoddessgameView:_clearAoqiLihui()
	if self._aoqiEffect then
		UIEffectManager.instance:stopEffect(self._aoqiEffect)

		self._aoqiEffect = nil
	end
end

function GoddessgameView:_updateAoqiLihuiState(_state, _loop)
	if not _state or not self._graphic then
		return
	end

	self._graphic.AnimationState:SetAnimation(0, _state, _loop)
	self._graphic:Update(0)
end

function GoddessgameView:_updateOneScale(go, data)
	local txtScale = goutil.findChildTextComponent(go, "item1/txtScale")

	txtScale.text = data.scale

	local x, y = Framework.TransformUtil.GetAnchoredPos(go.transform, 0, 0)

	Framework.TransformUtil.SetAnchoredPos(go.transform, x, data.scale / self._maxVolume * 203)
end

function GoddessgameView:_onClickResume()
	self:_startGame()
end

function GoddessgameView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "goddessgameview")
end

function GoddessgameView:_onClickClose()
	if self._isGaming then
		FloatWordMgr.instance:show("游戏过程中不能返回")

		return
	end

	ViewMgr.instance:close(ViewName.PopupTipsView)
	self:close()
end

function GoddessgameView:_onClickStart()
	self:_showHongquanEffect()
	self:_showBaozaEffect()

	local cur = GoddessModel.instance:getGameLeftTime()
	local total = GoddessConfig.instance:getGameTotalTime()

	if cur <= 0 then
		FloatWordMgr.instance:show("今日次数用完，次日5点重置！ ")
	else
		GoddessController.instance:sendPM_GoddessStartGameReq()
	end
end

function GoddessgameView:_onStartGameRes()
	FloatWordMgr.instance:show("游戏开始，请快速点击屏幕吹气球")
	self:_updateTimes()
	self:_startGame()
end

local ratio = 4.48

function GoddessgameView:_initGame()
	self._isGaming = false

	self:_updateBtnClick()
	self:_updateTimes()

	self._remainingTime = self._maxGameTime

	self._txtRemaingTime:SetText(math.ceil(self._remainingTime))

	self._curVolume = 0
	self._clicks = 0
	self._lastScale = 0

	self:_updateBallSize(true)
end

function GoddessgameView:_startGame()
	self._bloomedAniDone = false
	self._bloomed = false
	self._isGaming = true
	self._remainingTime = self._maxGameTime
	self._remainingSubTime = self._subInterval

	self:_updateBtnClick()

	self._curVolume = 0

	self:_updateBallSize()
	settimer(0, self._onTicking, self, true)
	UIStateManager.instance:open(ViewName.PopupTipsView)
	self:_updateAoqiLihuiState("cuiqi", true)
end

function GoddessgameView:_onReliveRes()
	FloatWordMgr.instance:show("复活成功")

	self._curVolume = 0
	self._clicks = 0
	self._lastScale = 0

	self:_updateBallSize()
	self._btnClick.gameObject:SetActive(false)
	self._btnResume.gameObject:SetActive(true)
end

function GoddessgameView:_onTicking()
	if not self._isGaming then
		return
	end

	local deltaTime = Time.deltaTime

	self._remainingTime = self._remainingTime - deltaTime

	if self._remainingTime < 0 then
		self._remainingTime = 0
	end

	self._remainingSubTime = self._remainingSubTime - deltaTime

	if self._remainingSubTime < 0 then
		self._remainingSubTime = self._remainingSubTime + self._subInterval
		self._curVolume = self._curVolume - self:_randomGetNum(self._subVolumePerSec)

		self:_updateBallSize()
	end

	self._txtRemaingTime:SetText(math.ceil(self._remainingTime))

	if self._remainingTime == 0 then
		self:_endGame()
	end
end

function GoddessgameView:_endGame()
	if self._bloomed then
		return
	end

	self:_updateBtnClick()
	removetimer(self._onTicking, self)
	self._btnClick.gameObject:SetActive(false)

	local volume = math.floor(self._curVolume)
	local cfgs = self._scalePrizeCfgs
	local feelingNums = 0
	local aixinNums = 0

	for _, v in ipairs(cfgs) do
		if volume >= v.scale then
			feelingNums = v.feeling
			aixinNums = v.scale
		end
	end

	local title = "游戏结束"

	if feelingNums > self._onceGainMaxNum then
		feelingNums = self._onceGainMaxNum
	end

	local text = string.format("本次吹气球，你一共获得了爱心x<color=#eb4642>%d</color>,\n可折算成好感度x<color=#eb4642>%d</color>", aixinNums, feelingNums)
	local btnText = "知道了"

	TipsFacade.instance:openTipWindowNoX(title, text, function()
		GoddessController.instance:sendPM_GoddessEndGameReq(self._raecId, volume, self._clicks)
	end, btnText, UnityEngine.TextAnchor.MiddleCenter)
	self:_updateAoqiLihuiState("idle", true)

	self._needPlayBubble = true
end

function GoddessgameView:_onEndGameRes()
	FloatWordMgr.instance:show("游戏结束~")

	self._isGaming = false

	self:_initGame()
end

function GoddessgameView:_randomGetNum(weights)
	local array = string.split(weights, "#")
	local maxWeight = 0

	for _, v in ipairs(array) do
		local num, weight = unpack(string.splitToNumber(v, ":"))

		maxWeight = maxWeight + weight
	end

	local random = math.random(1, maxWeight)
	local totalWeight = 0

	for _, v in ipairs(array) do
		local num, weight = unpack(string.splitToNumber(v, ":"))

		totalWeight = totalWeight + weight

		if random <= totalWeight then
			return num
		end
	end
end

function GoddessgameView:_onBallClicked()
	self._remainingSubTime = self._clickDuration + self._subInterval

	local addVolume = self:_randomGetNum(self._addVolumePerClick)

	self._curVolume = self._curVolume + addVolume
	self._clicks = self._clicks + 1

	self:_updateBallSize()
end

function GoddessgameView:_updateBtnClick()
	self._btnStart.gameObject:SetActive(not self._isGaming)
	self._btnClick.gameObject:SetActive(self._isGaming)
	self._countdown:SetActive(self._isGaming)
	self._btnResume.gameObject:SetActive(false)
end

function GoddessgameView:_updateTimes()
	local cur = GoddessModel.instance:getGameLeftTime()
	local total = GoddessConfig.instance:getGameTotalTime()

	self._txtRemainingTimes.text = string.format("今日剩余次数：%d/%d", cur, total)

	self._btnAddTimes.gameObject:SetActive(false)
end

function GoddessgameView:_updateBallSize(isForce)
	if self._curVolume < 0 then
		if self._elizBaozaEffect and self._elizBaozaEffect._visible then
			self._elizBaozaEffect:setVisible(false, true)
		end

		if self._elizHongquanEffect and self._elizHongquanEffect._visible then
			self._elizHongquanEffect:setVisible(false, true)
		end

		self._curVolume = 0
	elseif self._curVolume >= 0 and self._curVolume < self._ballDottedLineVolumn then
		if self._elizBaozaEffect and self._elizBaozaEffect._visible then
			self._elizBaozaEffect:setVisible(false, true)
		end

		if self._elizHongquanEffect and self._elizHongquanEffect._visible then
			self._elizHongquanEffect:setVisible(false, true)
		end
	elseif self._curVolume > self._ballDottedLineVolumn and self._curVolume <= self._maxVolume then
		if self._elizBaozaEffect and self._elizBaozaEffect._visible then
			self._elizBaozaEffect:setVisible(false, true)
		end

		if self._elizHongquanEffect and not self._elizHongquanEffect._visible then
			Framework.TransformUtil.SetLocalPos(self._elizHongquanEffect.effGo.transform, 0, 0, 0)
			self._elizHongquanEffect:setVisible(true, true)
		end
	elseif self._curVolume > self._maxVolume then
		if self._elizBaozaEffect and not self._elizBaozaEffect._visible then
			Framework.TransformUtil.SetLocalPos(self._elizBaozaEffect.effGo.transform, 0, 0, 0)
			self._elizBaozaEffect:setVisible(true, true)
		end

		if self._elizHongquanEffect and self._elizHongquanEffect._visible then
			self._elizHongquanEffect:setVisible(false, true)
		end

		self._curVolume = self._maxVolume

		if not self._bloomedAniDone then
			self:_updateAoqiLihuiState("baoza", false)

			self._bloomedAniDone = true
		end

		self._bloomed = true

		settimer(1, self._onBallBoomed, self, false)
	end

	local size = self._curVolume * ratio

	self._ballRectTrans.sizeDelta = Vector2.New(size, size)

	local list = self._scalePrizeCfgs
	local curScale = 0

	for i = #list, 1, -1 do
		if list[i].scale <= self._curVolume then
			curScale = list[i].scale

			break
		end
	end

	if not isForce and self._lastScale == curScale then
		return
	end

	self._lastScale = curScale

	for k, v in ipairs(self._cells) do
		local prizeCfg = self._scalePrizeCfgs[k]
		local gained = prizeCfg.scale <= self._curVolume
		local r, g, b, a = 1, 1, 1, 1

		if gained then
			a = 1
			b = 0.08627450980392157
			g = 0.27450980392156865
			r = 0.9215686274509803
		end

		Game.TextUtil.SetColorRGBA(goutil.findChildTextComponent(v, "item1/txtScale"), r, g, b, a)
	end
end

function GoddessgameView:_setTextColorInit()
	if self._cells then
		for k, v in ipairs(self._cells) do
			Game.TextUtil.SetColorRGBA(goutil.findChildTextComponent(v, "item1/txtScale"), 1, 1, 1, 1)
		end
	end
end

function GoddessgameView:_onBallBoomed()
	removetimer(self._onBallBoomed, self)
	removetimer(self._onTicking, self)
	self._elizBaozaEffect:setVisible(false, true)
	self:_setTextColorInit()

	self._clicks = 0
	self._curVolume = 0

	self:_updateAoqiLihuiState("idle", true)
	self._txtRemaingTime:SetText(math.ceil(self._maxGameTime))

	local leftTimes = GoddessModel.instance:getLeftReliveTimes()
	local consume = GoddessConfig.instance:getCommonValue("REVIVE_COST")
	local costNum = 0

	if leftTimes <= 0 or not MaterialMgr.getMatEnough(consume) then
		self._bloomed = false

		self:_endGame()
	else
		_, _, costNum = unpack(string.splitToNumber(consume, ":"))

		local text = string.format("好可惜，气球爆炸了！没有获得爱心！\n花费<color=#eb4642>%d</color>钻石可以重新吹气球哦！", costNum)

		TipsFacade.instance:openPopupWindow("提示", text, function()
			local activityId = GoddessModel.instance:getCurrActId()

			GoddessAgent.instance:sendPM_GoddessReliveReq(activityId)
		end, function()
			self._bloomed = false

			self:_endGame()
		end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	end
end

function GoddessgameView:_onClickAddTimes()
	printError("购买次数")
end

function GoddessgameView:_showBaozaEffect()
	if self._elizBaozaEffect then
		return
	end

	local effect_path = "fx_ui_yilishabaitiaozhan/fx_ui_yilishabai_baoza.prefab"

	self._elizBaozaEffect = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 2000, 0, 0)
	end)

	self._elizBaozaEffect:setParent(self._ballWarn.transform)
	self._elizBaozaEffect:setScale(1)
	self._elizBaozaEffect:setVisible(false, true)

	self._elizBaozaEffect.hideEffWhileNotOnTop = false
end

function GoddessgameView:_clearBaozaEffect()
	if self._elizBaozaEffect then
		UIEffectManager.instance:stopEffect(self._elizBaozaEffect)

		self._elizBaozaEffect = nil
	end
end

function GoddessgameView:_showHongquanEffect()
	if self._elizHongquanEffect then
		return
	end

	local effect_path = "fx_ui_yilishabaitiaozhan/fx_ui_yilishabai_hongquan.prefab"

	self._elizHongquanEffect = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 2000, 0, 0)
	end)

	self._elizHongquanEffect:setParent(self._ballWarn.transform)
	self._elizHongquanEffect:setScale(1)
	self._elizHongquanEffect:setVisible(false, true)

	self._elizHongquanEffect.hideEffWhileNotOnTop = false
end

function GoddessgameView:_clearHongquanEffect()
	if self._elizHongquanEffect then
		UIEffectManager.instance:stopEffect(self._elizHongquanEffect)

		self._elizHongquanEffect = nil
	end
end

return GoddessgameView
