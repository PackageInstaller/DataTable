-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpgame/view/JumpPlayer.lua

module("logic.extensions.jumpgame.view.JumpPlayer", package.seeall)

local JumpPlayer = class("JumpPlayer", ViewComponent)

function JumpPlayer:ctor()
	JumpPlayer.super.ctor(self)

	self._gravity = -1500
	self._speedxFactor = 20
	self._jump = false
	self._touchTime = 0
	self._factor = 1
	self._touchMaxTime = 0
	self._maxWidth = 1000
	self._maxJumpHeight = 350
	self._wantedTime = 1.1
	self._targetTime = 0.2
	self._minTime = 0.3
	self._targetX = 0
	self._targetY = 0
	self._sliderSpeed = 3
	self._isDown = false
end

JumpPlayer._animName = {
	idle = "idle",
	luoxia = "luoxia",
	tiaoqi = "tiaoqi",
	xiadun = "xiadun"
}

function JumpPlayer:bindEvents()
	self._downHandler = PointerDownHandler.Get(self._Img_Bg):AddLuaHandler(function()
		if self._jump then
			return
		end

		if self._uiTweenMoveBy.enabled then
			return
		end

		self._isDown = true
		self._touchTime = 0

		settimer(0, self._updateSlider, self)
	end)
	self._upHandler = PointerUpHandler.Get(self._Img_Bg):AddLuaHandler(function()
		if JumpGameModel.instance:isOver() then
			return nil
		end

		if self._jump then
			return
		end

		if self._uiTweenMoveBy.enabled then
			return
		end

		if not self._isDown then
			return
		end

		self._isDown = false

		removetimer(self._updateSlider, self)

		self._startJumpTime = 0
		self._start_y = self.player.transform.localPosition.y
		self._time0 = 0.5
		self._speedy = -self._gravity * 1 * self._time0
		self._initspeedy = self._speedy
		self._start_x = self.player.transform.localPosition.x
		self._delta_x = 0
		self._speedx = self._speedxFactor * self._Slider_value.value

		if not self._jump then
			settimer(0, self._onTickJump, self)

			self._jump = true
		end

		self._Slider_value.value = 0
	end)
end

function JumpPlayer:unbindEvents()
	PointerDownHandler.Get(self._Img_Bg):RemoveLuaHandler(self._downHandler)
	PointerUpHandler.Get(self._Img_Bg):RemoveLuaHandler(self._upHandler)
end

function JumpPlayer:buildUI()
	self._Pnl_Road = self:getGo("Container/Pnl_Road")
	self._Img_Bg = self:getGo("Img_Bg")
	self._Slider_value = self:getGo("Slider"):GetComponent("Slider")
	self._uiTweenMoveBy = self._Pnl_Road:GetComponent(UnityTweensType.TweenPositionBy)
end

function JumpPlayer:destroyUI()
	return
end

function JumpPlayer:onEnter()
	self._gravity = JumpGameConfig.instance:getGameInfoCfgByKey("gravity")
	self._speedxFactor = JumpGameConfig.instance:getGameInfoCfgByKey("speedxFactor")
	self._touchMaxTime = JumpGameConfig.instance:getGameInfoCfgByKey("touchTime")
	self._getScoreGo = self:getResInstance("ui/views/jumpgame/getscore.prefab")

	goutil.addChildToParent(self._getScoreGo, self._Pnl_Road)

	self.player = self:getResInstance("character/10159_gongfuxiongmao/10159_gongfuxiongmao-ui_p.prefab")
	self.skeletonGraphic = self.player:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	self:_playAnimation(self._animName.idle, true)

	self.player.gameObject.transform.localScale = Vector3.New(0.14, 0.14, 1)
	self.player.gameObject.transform.localPosition = Vector3.New(-526, -190, 0)

	goutil.addChildToParent(self.player, self._Pnl_Road)
	JumpGameModel.instance:setInitPlayerPos(self.player.gameObject.transform.localPosition)
	GlobalDispatcher:addListener(GlobalNotify.JumpPlayerStop, self._onStopPlayer, self)
	GlobalDispatcher:addListener(GlobalNotify.JumpItemVisible, self._onUpdateCollect, self)
end

function JumpPlayer:onEnterFinished()
	return
end

function JumpPlayer:onExit()
	goutil.destroy(self.player.gameObject)

	self.player = nil

	removetimer(self._onTickJump, self)
	removetimer(self._updateSlider, self)

	self._jump = false
	self._Slider_value.value = 0

	GlobalDispatcher:removeListener(GlobalNotify.JumpPlayerStop, self._onStopPlayer, self)
	GlobalDispatcher:removeListener(GlobalNotify.JumpItemVisible, self._onUpdateCollect, self)
end

function JumpPlayer:onExitFinished()
	return
end

function JumpPlayer:_updateSlider()
	self:_playAnimation(self._animName.xiadun)

	if self._touchTime > self._touchMaxTime then
		self._factor = -1
	elseif self._touchTime < 0 then
		self._factor = 1
	end

	self._touchTime = self._touchTime + Time.deltaTime * self._factor * self._sliderSpeed
	self._Slider_value.value = self._touchTime / 3

	local percent = self._Slider_value.value
	local widthPercent = percent >= 0.14 and percent or 0.14

	self._targetX = self._maxWidth * widthPercent
	self._targetY = self._maxJumpHeight * percent
	self._targetTime = self._wantedTime * percent

	if self._targetTime < self._minTime then
		self._targetTime = self._minTime
	end
end

function JumpPlayer:_onTickJump()
	if self._jump == false then
		return nil
	end

	if JumpGameModel.instance:isOver() then
		return nil
	end

	if self._startJumpTime == 0 then
		self:_playAnimation(self._animName.tiaoqi)
	end

	if Mathf.Abs(self._startJumpTime - self._targetTime) <= 0.01 then
		self:_playAnimation(self._animName.luoxia)
	end

	self._startJumpTime = self._startJumpTime + Time.deltaTime

	local s_x = self._startJumpTime / self._targetTime * self._targetX
	local s_y = self:_jumpFormula(self._targetX, self._targetY, s_x)

	if s_y >= 0 then
		self._delta_x = s_x
	end

	if self._start_y + s_y < -350 then
		self._jump = false

		JumpGameModel.instance:gameOver()
		UIStateManager.instance:open("jumpResultView", true, JumpGameModel.instance:getInitCollectParams(), function()
			UIStateManager.instance:popByName(ViewName.JumpGameView)
		end)

		return
	end

	Framework.TransformUtil.SetLocalPos(self.player.transform, self._start_x + self._delta_x, self._start_y + s_y, self.player.transform.localPosition.z)
	self.player.transform:SetAsLastSibling()
	GlobalDispatcher:dispatch(GlobalNotify.JumpPlayerPos, self.player)
end

function JumpPlayer:_onStopPlayer(param)
	self:_playAnimation(self._animName.idle, true)

	pos = param[1]
	self.player.gameObject.transform.position = Vector3.New(self.player.gameObject.transform.position.x, pos.y, self.player.gameObject.transform.position.z)

	if param[2] == false then
		self._speedx = 0

		self:doFallAction(param[3])
	else
		self._jump = false

		removetimer(self._onTickJump, self)
		JumpGameModel.instance:setPlayerPos(self.player.gameObject.transform.localPosition)
		GlobalDispatcher:dispatch(GlobalNotify.JumpViewOffset)
		JumpGameModel.instance:setInitPlayerPos(self.player.gameObject.transform.localPosition)
	end
end

function JumpPlayer:_jumpFormula(width, height, x)
	if width == 0 then
		return 0
	end

	if height < 6 then
		height = 6
	end

	return -(x - width) * x * (height / Mathf.Pow(width / 2, 2))
end

function JumpPlayer:doFallAction(param)
	Framework.TransformUtil.SetLocalRotation(self.player.gameObject.transform, 0, 0, param)
end

function JumpPlayer:_onSpineEvent(actionName, eventName, eventParam)
	return
end

function JumpPlayer:_playAnimation(animName, isRepeat)
	isRepeat = isRepeat or false
	self.skeletonGraphic.startingAnimation = animName

	self.skeletonGraphic.AnimationState:SetAnimation(0, animName, isRepeat)
	self.skeletonGraphic:Update(0)
end

function JumpPlayer:_onUpdateCollect()
	local score = JumpGameModel.instance:returnRecentCollect()
	local pos = self.player:GetComponent(goutil.Type_RectTransform).anchoredPosition

	Framework.TransformUtil.SetAnchoredPos(self._getScoreGo:GetComponent(goutil.Type_RectTransform), pos.x + 32, -30)

	self._getScoreGo:GetComponentInChildren(goutil.Type_UIText, true).text = "x" .. score

	self._getScoreGo:GetComponentInChildren(typeof(UIImageSpriteChange), true):ChangeStateNow(JumpGameModel.instance:getGameType() - 1)

	local animator = self._getScoreGo:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("start")
end

return JumpPlayer
