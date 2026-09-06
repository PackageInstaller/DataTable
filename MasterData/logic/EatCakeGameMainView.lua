-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/view/eatcake/EatCakeGameMainView.lua

module("logic.extensions.anniversarycake.view.eatcake.EatCakeGameMainView", package.seeall)

local EatCakeGameMainView = class("EatCakeGameMainView", ViewComponent)
local GameState = {
	Ready = 1,
	End = 3,
	Playing = 2
}

function EatCakeGameMainView:ctor()
	EatCakeGameMainView.super.ctor(self)

	self._minTimeScale = 0.8
	self._maxTimeScale = 2
	self._clickAddTimeScale = 0.3
	self._reduceTimeScale = -1
	self._maxGameTime = checknumber(MakeCakeConfig.instance:getConstValue("EAT_TIME"))
	self._curClickCount = 0
	self._maxClickCount = 5
	self._intervalTime = 0.2
	self._animDuration = 0.5
	self._recycleImgGos = {}
	self._usingImgGos = {}
end

function EatCakeGameMainView:buildUI()
	EatCakeGameMainView.super.buildUI(self)

	self._btnClose = self:getBtn("topLeft/btnClose")
	self._btnEat1 = self:getBtn("game/btnEat1")
	self._btnEat2 = self:getBtn("game/btnEat2")
	self._btnReady = self:getBtn("game/ready")
	self._btnOver = self:getBtn("game/gameover/btnOver")
	self._slider = self:getSlider("game/countdown/slider")
	self._txtCountDown = self:getTxt("game/countdown/txtTime")
	self._txtScore = self:getTxt("game/score/txtScore")
	self._txtFinalScore = self:getTxt("game/gameover/txt")
	self._role = self:getGo("game/role")
	self._gameover = self:getGo("game/gameover")
	self._txtDesc = self:getTxt("game/tip/txtDesc")
	self._gameoverEffectGo = self:getGo("game/gameover/effect")
	self._numanimParent = self:getGo("game/numanim")
	self._startAnchoredPosition = self:getGo("game/numanim/startPos"):GetComponent(goutil.Type_RectTransform).anchoredPosition
	self._endAnchoredPosition = self:getGo("game/numanim/endPos"):GetComponent(goutil.Type_RectTransform).anchoredPosition
	self._animImg = self:getImg("game/numanim/img")

	goutil.setActive(self._animImg.gameObject, false)
end

function EatCakeGameMainView:bindEvents()
	EatCakeGameMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnEat1:AddClickListener(self._onClickEat, self)
	self._btnEat2:AddClickListener(self._onClickEat, self)
	self._btnOver:AddClickListener(self._onClickOver, self)
end

function EatCakeGameMainView:unbindEvents()
	EatCakeGameMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnEat1:RemoveClickListener()
	self._btnEat2:RemoveClickListener()
	self._btnOver:RemoveClickListener()
end

function EatCakeGameMainView:onEnter()
	EatCakeGameMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ACStartEatCakeRes, self._onStartEatCakeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ACEndEatCakeRes, self._onEndEatCakeRes, self)

	self._activityId = MakeCakeModel.instance:getActivityId()
	self._clientKey = self:_getRandomNum()
	self._serverKey = 0
	self._isStartEat = false
	self._maxCakeCount = MakeCakeModel.instance:getMaxEatCakeCount()

	self:_initState()
	self:_loadRole()
	self:_loadGameOverEffect()
	self:_initImgAnim()
	settimer(self._intervalTime, self._onPlayAnim, self)
end

function EatCakeGameMainView:onExit()
	EatCakeGameMainView.super.onExit(self)
	self:_clearRole()
	removetimer(self._onSecond, self)
	self:_clearTween()
	self:_removeStartEffect()
	self:_removeGameOverEffect()
	self:_clearImgAnim()
	removetimer(self._onPlayAnim, self)
end

function EatCakeGameMainView:onExitFinished()
	EatCakeGameMainView.super.onExitFinished()
end

function EatCakeGameMainView:_onClickClose()
	self:close()
end

function EatCakeGameMainView:_onClickEat()
	if self._curGameState == GameState.Playing then
		if not self._isStartEat then
			self._isStartEat = true

			self._skeletonGraphic.AnimationState:SetAnimation(0, "c_chidangao", true)
			self._skeletonGraphic:Update(0)

			self._skeletonGraphic.timeScale = 1
		end

		self:_updatePlaySpeed(self._clickAddTimeScale)
		self:_updateScore()
		self:_addNumAnimCount()
	end
end

function EatCakeGameMainView:_onClickReady()
	if self._isCanStart then
		AnniversaryCakeAgent.instance:sendPM_ACStartEatCakeReq(self._activityId, self._clientKey)
	end
end

function EatCakeGameMainView:_onClickOver()
	self:_onClickClose()
end

function EatCakeGameMainView:_onSecond()
	self:_updatePlaySpeed(self._reduceTimeScale)
	self:_updateGameTime()
end

function EatCakeGameMainView:_onStartEatCakeRes(serverKey)
	self._serverKey = serverKey

	self:_startEat()
end

function EatCakeGameMainView:_onEndEatCakeRes()
	self:_endEat()
end

function EatCakeGameMainView:_getRandomNum()
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))

	return math.random(1, 100000000)
end

function EatCakeGameMainView:_loadRole()
	local path = "fx_ui_yilishabaitiaozhan/aoqicuiqiqiu_spine/aoqicuiqiqiu-ui_p.prefab"

	self._aoqiRole = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, -300, 0)

		self._skeletonGraphic = goutil.findChild(eff.effGo, "skeleton"):GetComponent("SkeletonGraphic")
		self._skeletonGraphic.startingAnimation = "c_idle"

		self._skeletonGraphic.AnimationState:SetAnimation(0, "c_idle", true)
		self._skeletonGraphic:Update(0)

		self._isCanStart = true
	end)

	self._aoqiRole:setParent(self._role.transform)
	self._aoqiRole:setScale(0.6)
end

function EatCakeGameMainView:_clearRole()
	if self._aoqiRole then
		UIEffectManager.instance:stopEffect(self._aoqiRole)

		self._aoqiRole = nil
	end
end

function EatCakeGameMainView:_startEat()
	if not self._skeletonGraphic then
		return
	end

	if self._curGameState ~= GameState.NoStart then
		return
	end

	self._curGameState = GameState.Playing

	self._skeletonGraphic.AnimationState:SetAnimation(0, "c_idle", true)
	self._skeletonGraphic:Update(0)

	self._skeletonGraphic.timeScale = 1

	goutil.setActive(self._btnReady.gameObject, false)
	goutil.setActive(self._gameover, false)
	settimer(1, self._onSecond, self)
end

function EatCakeGameMainView:_endEat()
	if not self._skeletonGraphic then
		return
	end

	self._skeletonGraphic.AnimationState:SetAnimation(0, "c_idle", true)
	self._skeletonGraphic:Update(0)

	self._skeletonGraphic.timeScale = 1

	goutil.setActive(self._btnReady.gameObject, false)
	goutil.setActive(self._gameover, true)

	self._txtFinalScore.text = string.format("吃到蛋糕数量：%d个", self._eatCakeCount)

	removetimer(self._onSecond, self)
end

function EatCakeGameMainView:_updatePlaySpeed(timeScale)
	if self._skeletonGraphic then
		self._curTimeScale = self._curTimeScale + timeScale
		self._curTimeScale = Mathf.Clamp(self._curTimeScale, self._minTimeScale, self._maxTimeScale)
		self._skeletonGraphic.timeScale = self._curTimeScale
	end
end

function EatCakeGameMainView:_initState()
	self._isCanStart = false
	self._curGameState = GameState.NoStart
	self._curTimeScale = 1
	self._eatCakeCount = 0

	goutil.setActive(self._btnReady.gameObject, true)
	goutil.setActive(self._gameover, false)

	self._txtScore.text = 0
	self._txtDesc.text = string.format("单局最高可获得 %d/%d个蛋糕", 0, self._maxCakeCount)
	self._curGameTime = self._maxGameTime
	self._txtCountDown.text = self._curGameTime .. "s"

	self._slider:SetValue(1)
	self:_startTween()
	self:_loadStartEffect()
end

function EatCakeGameMainView:_updateGameTime()
	if self._curGameState == GameState.Playing then
		if self._curGameTime >= 0 then
			self._txtCountDown.text = self._curGameTime .. "s"

			self._slider:SetValue(self._curGameTime / self._maxGameTime)

			self._curGameTime = self._curGameTime - 1
		else
			self._curGameState = GameState.End

			local key = GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
				self._eatCakeCount
			})

			AnniversaryCakeAgent.instance:sendPM_ACEndEatCakeReq(self._activityId, self._eatCakeCount, key)
		end
	end
end

function EatCakeGameMainView:_updateScore()
	self._eatCakeCount = self._eatCakeCount + 1

	if self._eatCakeCount <= self._maxCakeCount then
		self._eatCakeCount = self._eatCakeCount or self._maxCakeCount
	end

	self._txtScore.text = self._eatCakeCount
	self._txtDesc.text = string.format("单局最高可获得 %d/%d个蛋糕", self._eatCakeCount, self._maxCakeCount)
end

function EatCakeGameMainView:_startTween()
	self:_clearTween()

	self._tweenStart = TweenUtil.DoDelay(1.5, function()
		self:_onClickReady()
	end)
end

function EatCakeGameMainView:_clearTween()
	if self._tweenStart then
		self._tweenStart:Kill(false)

		self._tweenStart = nil
	end
end

function EatCakeGameMainView:_loadStartEffect()
	self:_removeStartEffect()

	local path = EatCakeGameMainViewPresentor.EffectPath1
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._btnReady.gameObject.transform, 0, 0, true, false)

	uiEffect:setParent(self._btnReady.gameObject.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	uiEffect.hideEffWhileNotOnTop = false
	self._startEffect = uiEffect
end

function EatCakeGameMainView:_removeStartEffect()
	if self._startEffect then
		UIEffectManager.instance:stopEffect(self._startEffect)

		self._startEffect = nil
	end
end

function EatCakeGameMainView:_loadGameOverEffect()
	self:_removeGameOverEffect()

	local path = EatCakeGameMainViewPresentor.EffectPath2
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._gameoverEffectGo.transform, 0, 0, true, false)

	uiEffect:setParent(self._gameoverEffectGo.transform)
	uiEffect:setScale(0.7)
	uiEffect:setLocalPos(0, 0, 0)

	uiEffect.hideEffWhileNotOnTop = false
	self._gameoverEffect = uiEffect
end

function EatCakeGameMainView:_removeGameOverEffect()
	if self._gameoverEffect then
		UIEffectManager.instance:stopEffect(self._gameoverEffect)

		self._gameoverEffect = nil
	end
end

function EatCakeGameMainView:_initImgAnim()
	self._curClickCount = 0
	self._usingImgGos = {}
	self._tweenList = {}
end

function EatCakeGameMainView:_clearImgAnim()
	if self._tweenList then
		for i, v in ipairs(self._tweenList) do
			v:Kill()
		end

		table.clear(self._tweenList)
	end
end

function EatCakeGameMainView:_onPlayAnim()
	self:_playNumAnimTween()
end

function EatCakeGameMainView:_getImgGo()
	if #self._usingImgGos + #self._recycleImgGos >= self._maxClickCount then
		return nil
	end

	local count = #self._recycleImgGos

	if count > 0 then
		local go = table.remove(self._recycleImgGos, count)

		goutil.setActive(go, true)

		return go
	else
		local go = goutil.cloneAndSetParent(self._animImg.gameObject, self._numanimParent.transform, "img")

		goutil.setActive(go, true)

		return go
	end
end

function EatCakeGameMainView:_recycleImgGo(go)
	goutil.setActive(go, false)
	table.insert(self._recycleImgGos, go)
	table.removebyvalue(self._usingImgGos, go)
end

function EatCakeGameMainView:_addNumAnimCount()
	if self._curClickCount < self._maxClickCount then
		self._curClickCount = self._curClickCount + 1
	end
end

function EatCakeGameMainView:_playNumAnimTween()
	if self._curClickCount > 0 then
		local go = self:_getImgGo()

		if not goutil.isNil(go) then
			self._curClickCount = self._curClickCount - 1

			table.insert(self._usingImgGos, go)

			local rectTransform = go:GetComponent(goutil.Type_RectTransform)

			Framework.TransformUtil.SetAnchoredPos(rectTransform, self._startAnchoredPosition.x, self._startAnchoredPosition.y)

			local tweener = rectTransform:DOAnchorPos(self._endAnchoredPosition, self._animDuration)
			local image = go:GetComponent(goutil.Type_UIImage)

			Game.ImageUtil.SetImageAlpha(image, 1)

			local tweener2 = image:DOFade(0, self._animDuration):SetEase(DG.Tweening.Ease.InQuart)
			local sequence = DG.Tweening.DOTween.Sequence()

			sequence:Append(tweener)
			sequence:Join(tweener2)
			sequence:OnComplete(function()
				if not goutil.isNil(go) then
					self:_recycleImgGo(go)
				end

				if sequence ~= nil then
					table.removebyvalue(self._tweenList, sequence)
				end
			end)
			table.insert(self._tweenList, sequence)
		end
	end
end

return EatCakeGameMainView
