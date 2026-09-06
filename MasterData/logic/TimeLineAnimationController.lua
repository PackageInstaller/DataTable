-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/TimeLineAnimationController.lua

module("logic.extensions.dressactivityshop.view.TimeLineAnimationController", package.seeall)

local TimeLineAnimationController = class("TimeLineAnimationController", AnimationPlayer)

function TimeLineAnimationController:ctor(amPlayer, animName)
	self._amPlayerGo = amPlayer
	self._animName = animName
	self._interval = 2
end

function TimeLineAnimationController:startPlay(onAnimPlayFinish, onAnimPlayStart, handleObject)
	self:setFinishCallback(onAnimPlayFinish, handleObject)
	self:setStartCallback(onAnimPlayStart, handleObject)
	settimer(self._interval, self._autoPlayAnimation, self)
end

function TimeLineAnimationController:stopPlay()
	self:Stop()
	removetimer(self._autoPlayAnimation, self)

	if self._targets then
		for i = 1, #self._targets do
			if not goutil.isNil(self._targets[i]) then
				local compont = self._targets[i]:GetComponent("AMCameraFovFade")

				while compont ~= nil do
					UnityEngine.GameObject.DestroyImmediate(compont)

					compont = self._targets[i]:GetComponent("AMCameraFovFade")
				end
			end
		end
	end

	self._targets = nil
	self._animName = nil
	self._amPlayerGo = nil
end

function TimeLineAnimationController:setTargets(tgts)
	self._targets = tgts
end

function TimeLineAnimationController:setInterval(interval)
	self._interval = interval or 2
end

function TimeLineAnimationController:_autoPlayAnimation()
	if self._amPlayer or not self._amPlayerGo then
		return
	end

	removetimer(self._autoPlayAnimation, self)
	self:PlayAnimWithObject(self._amPlayerGo, self._animName, 1, true, self._targets)
end

function TimeLineAnimationController:_onStart(player)
	if self._amPlayer then
		if self._onStartHandler then
			self._onStartHandler(self._onStartHandlerObj)

			self._onStartHandler = nil
			self._onStartHandler = nil
		end
	else
		self._unHandlerStarted = true
	end
end

function TimeLineAnimationController:_onStop(player)
	self._amPlayer = nil
	self._onEvtHandler = nil
	self._onEvtHandlerObj = nil

	if self._stopHandler then
		local stopHandler = self._stopHandler
		local handlerTarget = self._stopHandlerObj

		self._stopHandler = nil
		self._stopHandlerObj = nil

		if stopHandler then
			self._stopHandler(handlerTarget)
		end
	end

	removetimer(self._autoPlayAnimation, self)

	if self._amPlayerGo then
		settimer(self._interval, self._autoPlayAnimation, self)
	end
end

function TimeLineAnimationController:_onActiveEffect(go, loop)
	Framework.GameObjectUtil.SetLayerRecursively(go, SceneLayer.UI3D_Value)

	go.transform.eulerAngles = self._amPlayerGo.transform.eulerAngles

	go:SetActive(true)
end

function TimeLineAnimationController:_onDeActiveEffect(go)
	go:SetActive(false)
end

return TimeLineAnimationController
