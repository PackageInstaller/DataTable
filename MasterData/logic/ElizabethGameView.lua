-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/elizabeth/ElizabethGameView.lua

module("logic.extensions.timelimitedchallenge.view.elizabeth.ElizabethGameView", package.seeall)

local ElizabethGameView = class("ElizabethGameView", ViewComponent)
local Time = UnityEngine.Time

function ElizabethGameView:unbindEvents()
	ElizabethGameView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnClick:RemoveClickListener()
	self._btnAddTimes:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnResume:RemoveClickListener()
	self._btnRule:RemoveClickListener()
end

function ElizabethGameView:bindEvents()
	ElizabethGameView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnClick:AddClickListener(self._onBallClicked, self)
	self._btnAddTimes:AddClickListener(self._onClickAddTimes, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnResume:AddClickListener(self._onClickResume, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
end

function ElizabethGameView:onExit()
	ElizabethGameView.super.onExit(self)
	removetimer(self._onTicking, self)
	removetimer(self._onBallBoomed, self)
	GlobalDispatcher:removeListener(GlobalNotify.EliBuyTimesRes, self._onBuyTimesRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.EliReliveRes, self._onReliveRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.EliEndGameRes, self._onEndGameRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.EliStartGameRes, self._onStartGameRes, self)
	self:_clearAoqiLihui()
	self:_clearBaozaEffect()
	self:_clearHongquanEffect()
end

function ElizabethGameView:buildUI()
	ElizabethGameView.super.buildUI(self)

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
	self._txtRule.text = lang("elizabeth_game_tip")
	self._model = self:getGo("model")
end

function ElizabethGameView:onEnter()
	ElizabethGameView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.EliBuyTimesRes, self._onBuyTimesRes, self)
	GlobalDispatcher:addListener(GlobalNotify.EliReliveRes, self._onReliveRes, self)
	GlobalDispatcher:addListener(GlobalNotify.EliEndGameRes, self._onEndGameRes, self)
	GlobalDispatcher:addListener(GlobalNotify.EliStartGameRes, self._onStartGameRes, self)

	self._bloomedAniDone = false
	self._bloomed = false
	self._subInterval = 0.02

	local configIns = ElizabethConfig.instance

	self._maxGameTime = configIns:getConstantValue("GAME_TIME", true)
	self._maxVolume = configIns:getConstantValue("BALL_MAX_VOLUMN", true)
	self._addVolumePerClick = configIns:getConstantValue("BALL_ADD_VOLUMN_PER_CLICK")
	self._subVolumePerSec = configIns:getConstantValue("BALL_SUB_VOLUMN_PER_SEC")
	self._clickDuration = configIns:getConstantValue("CLICK_DURATION", true)
	self._ballDottedLineVolumn = configIns:getConstantValue("BALL_DOTTED_LINE_VOLUMN", true)
	self._onceGainMaxNum = configIns:getConstantValue("ONCE_GAIN_MAX_NUM", true)

	local scalePrizePlanId = ElizabethModel.instance:getScalePrizePlanId()

	self._scalePrizeCfgs = ElizabethConfig.instance:getScalePrizeCfgs(scalePrizePlanId)
	self._cells = GameUtil.updateCellsWithCreate(self._scales, self._scalePrizeCfgs, self._updateOneScale, self)

	self:_initGame()
	self:_createAoqiLihui()
end

function ElizabethGameView:_createAoqiLihui()
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

function ElizabethGameView:_clearAoqiLihui()
	if self._aoqiEffect then
		UIEffectManager.instance:stopEffect(self._aoqiEffect)

		self._aoqiEffect = nil
	end
end

function ElizabethGameView:_updateAoqiLihuiState(_state, _loop)
	if not _state or not self._graphic then
		return
	end

	self._graphic.AnimationState:SetAnimation(0, _state, _loop)
	self._graphic:Update(0)
end

function ElizabethGameView:_updateOneScale(go, data)
	local txtScale = goutil.findChildTextComponent(go, "item1/txtScale")

	txtScale.text = data.flowerNum

	local x, y = Framework.TransformUtil.GetAnchoredPos(go.transform, 0, 0)

	Framework.TransformUtil.SetAnchoredPos(go.transform, x, data.scale / self._maxVolume * 203)
end

function ElizabethGameView:_onBuyTimesRes()
	self:_updateTimes()
end

function ElizabethGameView:_onClickResume()
	self:_startGame()
end

function ElizabethGameView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "elizabethchallenge1")
end

function ElizabethGameView:_onClickClose()
	if self._isGaming then
		FloatWordMgr.instance:show("游戏过程中不能返回")

		return
	end

	ViewMgr.instance:close(ViewName.PopupTipsView)
	self:close()
end

function ElizabethGameView:_onClickStart()
	self:_showHongquanEffect()
	self:_showBaozaEffect()

	local cur, total = ElizabethController.instance:getCurAndTotalTimes()
	local remainingBuyTimes = ElizabethController.instance:getRemaingBuyTimes()

	if cur <= 0 then
		if remainingBuyTimes <= 0 then
			FloatWordMgr.instance:show("今日次数用完，次日5点重置！ ")
		else
			ElizabethController.instance:addTimes(function()
				ElizabethController.instance:sendStartGameReq()
			end)
		end
	else
		ElizabethController.instance:sendStartGameReq()
	end
end

function ElizabethGameView:_onStartGameRes()
	FloatWordMgr.instance:show("游戏开始，请快速点击屏幕吹气球")
	self:_updateTimes()
	self:_startGame()
end

local ratio = 4.48

function ElizabethGameView:_initGame()
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

function ElizabethGameView:_startGame()
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

function ElizabethGameView:_onReliveRes()
	FloatWordMgr.instance:show("复活成功")

	self._curVolume = 0
	self._clicks = 0
	self._lastScale = 0

	self:_updateBallSize()
	self._btnClick.gameObject:SetActive(false)
	self._btnResume.gameObject:SetActive(true)
end

function ElizabethGameView:_onTicking()
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

function ElizabethGameView:_endGame()
	if self._bloomed then
		return
	end

	self:_updateBtnClick()
	removetimer(self._onTicking, self)

	local volume = math.floor(self._curVolume)
	local scalePrizePlanId = ElizabethModel.instance:getScalePrizePlanId()
	local addFlowerPerClick = ElizabethConfig.instance:getConstantValue("CLICK_NUMS", true)
	local cfgs = ElizabethConfig.instance:getScalePrizeCfgs(scalePrizePlanId, volume)
	local flowerNums = addFlowerPerClick * self._clicks

	for _, v in ipairs(cfgs) do
		if volume >= v.scale then
			flowerNums = flowerNums + v.flowerNum
		end
	end

	local title = "游戏结束"

	if flowerNums > self._onceGainMaxNum then
		flowerNums = self._onceGainMaxNum
	end

	local text = string.format("本次吹气球，你一共获得了\n鲜花x<color=#eb4642>%d</color>", flowerNums)
	local btnText = "知道了"

	TipsFacade.instance:openTipWindowNoX(title, text, function()
		ElizabethController.instance:sendEndGameReq(self._clicks, volume, true)
	end, btnText)
	self:_updateAoqiLihuiState("idle", true)
end

function ElizabethGameView:_onEndGameRes()
	FloatWordMgr.instance:show("游戏结束~")

	self._isGaming = false

	self:_initGame()
end

function ElizabethGameView:_randomGetNum(weights)
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

function ElizabethGameView:_onBallClicked()
	self._remainingSubTime = self._clickDuration + self._subInterval

	local addVolume = self:_randomGetNum(self._addVolumePerClick)

	self._curVolume = self._curVolume + addVolume
	self._clicks = self._clicks + 1

	self:_updateBallSize()
	GlobalDispatcher:dispatch(GlobalNotify.EliBallClicked)
end

function ElizabethGameView:_updateBtnClick()
	self._btnStart.gameObject:SetActive(not self._isGaming)
	self._btnClick.gameObject:SetActive(self._isGaming)
	self._countdown:SetActive(self._isGaming)
	self._btnResume.gameObject:SetActive(false)
end

function ElizabethGameView:_updateTimes()
	local cur, total = ElizabethController.instance:getCurAndTotalTimes()

	self._txtRemainingTimes.text = string.format("今日剩余次数：%d/%d", cur, total)

	self._btnAddTimes.gameObject:SetActive(cur <= 0)

	local remainingBuyTimes = ElizabethController.instance:getRemaingBuyTimes()

	uGuiUtil.setGoGrayState(self._btnClick.gameObject, cur <= 0 and remainingBuyTimes <= 0)
end

function ElizabethGameView:_updateBallSize(isForce)
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

function ElizabethGameView:_setTextColorInit()
	if self._cells then
		for k, v in ipairs(self._cells) do
			Game.TextUtil.SetColorRGBA(goutil.findChildTextComponent(v, "item1/txtScale"), 1, 1, 1, 1)
		end
	end
end

function ElizabethGameView:_onBallBoomed()
	removetimer(self._onBallBoomed, self)
	removetimer(self._onTicking, self)
	self._elizBaozaEffect:setVisible(false, true)
	self:_setTextColorInit()

	self._clicks = 0
	self._curVolume = 0

	self:_updateAoqiLihuiState("idle", true)
	self._txtRemaingTime:SetText(math.ceil(self._maxGameTime))

	local planId = ElizabethModel.instance:getCurPlanId()
	local consume = ElizabethConfig.instance:getReliveConsume(planId, 1)
	local costNum = 0

	if not MaterialMgr.getMatEnough(consume) then
		self._bloomed = false

		self:_endGame()
	else
		_, _, costNum = unpack(string.splitToNumber(consume, ":"))

		local text = string.format("好可惜，气球爆炸了！没有获得鲜花！\n花费<color=#eb4642>%d</color>钻石可以重新吹气球哦！", costNum)

		TipsFacade.instance:openPopupWindow("提示", text, function()
			ElizabethChallengeAgent.instance:sendPM_ElizabethClgReliveReq()
		end, function()
			self._bloomed = false

			self:_endGame()
		end)
	end
end

function ElizabethGameView:_onClickAddTimes()
	ElizabethController.instance:addTimes()
end

function ElizabethGameView:_showBaozaEffect()
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

function ElizabethGameView:_clearBaozaEffect()
	if self._elizBaozaEffect then
		UIEffectManager.instance:stopEffect(self._elizBaozaEffect)

		self._elizBaozaEffect = nil
	end
end

function ElizabethGameView:_showHongquanEffect()
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

function ElizabethGameView:_clearHongquanEffect()
	if self._elizHongquanEffect then
		UIEffectManager.instance:stopEffect(self._elizHongquanEffect)

		self._elizHongquanEffect = nil
	end
end

return ElizabethGameView
