-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elizabethgame/view/ElizabethactgameBall.lua

module("logic.extensions.elizabethgame.view.ElizabethactgameBall", package.seeall)

local ElizabethactgameBall = class("ElizabethactgameBall", BaseLuaOnce)

ElizabethactgameBall.Ratio = 3.18

local Time = UnityEngine.Time

function ElizabethactgameBall:buildUI()
	self._ballRectTrans = self:getGo("ball"):GetComponent(typeof(UnityEngine.RectTransform))
	self._btnClick = self:getBtn("btnClick")
	self._scales = self:getGo("scales")
	self._ballWarn = self:getGo("ballWarn")
end

function ElizabethactgameBall:bindEvents()
	self._btnClick:AddClickListener(self._onClickbtnClick, self)
end

function ElizabethactgameBall:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function ElizabethactgameBall:onExit()
	removetimer(self._onTicking, self)
	removetimer(self._onBallBoomed, self)
	self:_clearBaozaEffect()
	self:_clearHongquanEffect()

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function ElizabethactgameBall:setView(view)
	self._view = view
end

function ElizabethactgameBall:onEnter(view, actCfg)
	self._view = view
	self._bloomedAniDone = false
	self._bloomed = false
	self._subInterval = 0.02

	self:_setActCfg(actCfg)
	self:_initGame()
end

function ElizabethactgameBall:_initGame()
	self._isGaming = false

	self:_updateBtnClick()

	self._curVolume = 0
	self._clicks = 0
	self._lastScale = 0

	self:_updateBallSize(true)
end

function ElizabethactgameBall:_setActCfg(actCfg)
	self._actCfg = actCfg
	self._maxGameTime = self._actCfg.gameTime
	self._maxVolume = self._actCfg.ballMaxVolumn
	self._addVolumePerClick = self._actCfg.ballAddVolumnPerClick
	self._subVolumePerSec = self._actCfg.ballSubVolumnPerSec
	self._clickDuration = self._actCfg.clickDuration
	self._ballDottedLineVolumn = self._actCfg.ballDottedLineVlumn
	self._onceGainMaxNum = self._actCfg.onceGainMaxNum

	local scalePrizePlanId = self._actCfg.scalePrizePlanId

	self._scalePrizeCfgs = ElizabethgameConfig.instance:getScalePrizeCfgs(scalePrizePlanId)
	ElizabethactgameBall.Ratio = 412 / self._maxVolume
	self._cfgLastScale = self._scalePrizeCfgs[#self._scalePrizeCfgs].scale
	self._cells = GameUtil.updateCellsWithCreate(self._scales, self._scalePrizeCfgs, self._updateOneScale, self)
end

function ElizabethactgameBall:_onClickbtnClick()
	self._remainingSubTime = self._clickDuration + self._subInterval

	local addVolume = self:_randomGetNum(self._addVolumePerClick)

	self._curVolume = self._curVolume + addVolume
	self._clicks = self._clicks + 1

	self:_updateBallSize()
	GlobalDispatcher:dispatch(GlobalNotify.ElizabethBallClicked)

	if self._curVolume >= self._cfgLastScale then
		self:_restartHitEffect()
	end
end

function ElizabethactgameBall:_updateBtnClick()
	self._btnClick.gameObject:SetActive(self._isGaming)
end

function ElizabethactgameBall:_updateBallSize(isForce)
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
			Framework.TransformUtil.SetLocalPos(self._elizHongquanEffect.effGo.transform, 5, -1, 0)
			self._elizHongquanEffect:setVisible(true, true)
		end
	elseif self._curVolume > self._maxVolume + 10 then
		if self._elizBaozaEffect and not self._elizBaozaEffect._visible then
			Framework.TransformUtil.SetLocalPos(self._elizBaozaEffect.effGo.transform, 0, 0, 0)
			self._elizBaozaEffect:setVisible(true, true)
		end

		if self._elizHongquanEffect and self._elizHongquanEffect._visible then
			self._elizHongquanEffect:setVisible(false, true)
		end

		self._curVolume = self._maxVolume

		if not self._bloomedAniDone then
			GlobalDispatcher:dispatch(GlobalNotify.ElizabethGameBallBoomAniDone)

			self._bloomedAniDone = true
		end

		self._bloomed = true

		settimer(1, self._onBallBoomed, self, false)
	end

	local size = self._curVolume * ElizabethactgameBall.Ratio

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
			b = 0.35294117647058826
			g = 0.3686274509803922
			r = 0.8823529411764706
		end

		Game.TextUtil.SetColorRGBA(goutil.findChildTextComponent(v, "item1/txtScale"), r, g, b, a)
	end
end

function ElizabethactgameBall:startGame()
	self._bloomedAniDone = false
	self._bloomed = false
	self._isGaming = true
	self._remainingTime = self._maxGameTime
	self._remainingSubTime = self._subInterval

	self:_updateBtnClick()

	self._curVolume = 0

	self:_updateBallSize()
	settimer(0, self._onTicking, self, true)
	self:_showBaozaEffect()
	self:_showHongquanEffect()
end

function ElizabethactgameBall:_onTicking()
	if not self._isGaming then
		return
	end

	local deltaTime = Time.deltaTime

	self._remainingSubTime = self._remainingSubTime - deltaTime

	if self._remainingSubTime < 0 then
		self._remainingSubTime = self._remainingSubTime + self._subInterval
		self._curVolume = self._curVolume - self:_randomGetNum(self._subVolumePerSec)

		self:_updateBallSize()
	end
end

function ElizabethactgameBall:_randomGetNum(weights)
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

function ElizabethactgameBall:_showBaozaEffect()
	if self._elizBaozaEffect then
		return
	end

	local effect_path = "fx_ui_yilishabaitiaozhan/fx_ui_yilishabai_baoza.prefab"

	self._elizBaozaEffect = UIEffectManager.instance:playEffect(self._view, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 2000, 0, 0)
	end)

	self._elizBaozaEffect:setParent(self._ballWarn.transform)
	self._elizBaozaEffect:setScale(1)
	self._elizBaozaEffect:setVisible(false, true)

	self._elizBaozaEffect.hideEffWhileNotOnTop = false
end

function ElizabethactgameBall:_showHongquanEffect()
	if self._elizHongquanEffect then
		return
	end

	local effect_path = "fx_ui_yilishabaitiaozhan/fx_ui_yilishabai_hongquan.prefab"

	self._elizHongquanEffect = UIEffectManager.instance:playEffect(self._view, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 2000, 0, 0)
	end)

	self._elizHongquanEffect:setParent(self._ballWarn.transform)
	self._elizHongquanEffect:setScale(1)
	self._elizHongquanEffect:setVisible(false, true)

	self._elizHongquanEffect.hideEffWhileNotOnTop = false
end

function ElizabethactgameBall:_clearBaozaEffect()
	if self._elizBaozaEffect then
		UIEffectManager.instance:stopEffect(self._elizBaozaEffect)

		self._elizBaozaEffect = nil
	end
end

function ElizabethactgameBall:_clearHongquanEffect()
	if self._elizHongquanEffect then
		UIEffectManager.instance:stopEffect(self._elizHongquanEffect)

		self._elizHongquanEffect = nil
	end
end

function ElizabethactgameBall:_onBallBoomed()
	removetimer(self._onBallBoomed, self)
	removetimer(self._onTicking, self)
	self._elizBaozaEffect:setVisible(false, true)
	self:_setTextColorInit()

	self._clicks = 0
	self._curVolume = 0

	GlobalDispatcher:dispatch(GlobalNotify.ElizabethGameBallBoom)
end

function ElizabethactgameBall:_setTextColorInit()
	if self._cells then
		for k, v in ipairs(self._cells) do
			Game.TextUtil.SetColorRGBA(goutil.findChildTextComponent(v, "item1/txtScale"), 1, 1, 1, 1)
		end
	end
end

function ElizabethactgameBall:_updateOneScale(go, data)
	local txtScale = goutil.findChildTextComponent(go, "item1/txtScale")

	txtScale.text = data.flowerNum

	local x, y = Framework.TransformUtil.GetAnchoredPos(go.transform, 0, 0)

	Framework.TransformUtil.SetAnchoredPos(go.transform, x, data.scale / self._maxVolume * 203)
end

function ElizabethactgameBall:isBloom()
	return self._bloomed
end

function ElizabethactgameBall:setIsBloom(isBloom)
	self._bloomed = isBloom
end

function ElizabethactgameBall:getCurVolume()
	return self._curVolume
end

function ElizabethactgameBall:getClicks()
	return self._clicks
end

function ElizabethactgameBall:relive()
	self._curVolume = 0
	self._clicks = 0

	self:_updateBallSize()
	goutil.setActive(self._btnClick.gameObject, false)
end

function ElizabethactgameBall:endGame()
	self._isGaming = false

	goutil.setActive(self._btnClick.gameObject, false)
end

function ElizabethactgameBall:_restartHitEffect()
	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)
	end

	local effName = "20240209/changanguwu/fx_ui_changanguwu_jigu.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self._view, effName, nil, 0, 0, false)

	self._effectHandler:setParent(self.mainGO.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(-6.6, -154, 0)

	self._effectHandler.hideEffWhileNotOnTop = false
end

return ElizabethactgameBall
