-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/spine/HLSpineCtrl.lua

module("logic.extensions.holylight.view.spine.HLSpineCtrl", package.seeall)

local HLSpineCtrl = class("HLSpineCtrl")

function HLSpineCtrl:ctor()
	return
end

function HLSpineCtrl:onInit(spineRoot, view)
	self._spineRoot = spineRoot
	self._view = view

	self:_loadSpine()
end

function HLSpineCtrl:onClear()
	self:_clearSpine()

	self._spineRoot = nil
	self._view = nil
end

function HLSpineCtrl:onDestory()
	self:unregCallBackOfSpineLoaded()
end

function HLSpineCtrl:_loadSpine()
	self:_clearSpine()

	local effParent = self._spineRoot
	local urlPath = self:_getUrl()

	if effParent then
		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(self:_getDefaultScale())
			self:playDefaultAnim()

			if not goutil.isNil(eff.effGo) then
				self._skeletonGraphic = eff.effGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
				self._skeleton = self._skeletonGraphic and self._skeletonGraphic.Skeleton
			end

			GameUtil.callBack(self._callBackOfSpineLoaded)
		end

		local handlerTarget

		self._playerSpine = UIEffectManager.instance:playEffect(self._view, urlPath, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function HLSpineCtrl:_clearSpine()
	if self._playerSpine then
		UIEffectManager.instance:stopEffect(self._playerSpine)
	end

	self._skeleton = nil
	self._skeletonGraphic = nil
	self._playerSpine = nil
end

function HLSpineCtrl:_getUrl()
	error(">>>> 必须重写 <<<<")

	return ""
end

function HLSpineCtrl:_getDefaultScale()
	return 0.2
end

function HLSpineCtrl:_playAnim(animName, isLoop, callBack, isReStart, trackIndex, isNeedFadeOut)
	if self._playerSpine then
		local effGo = self._playerSpine.effGo

		if goutil.isNil(effGo) then
			return
		end

		isLoop = isLoop or false
		isReStart = isReStart or false
		trackIndex = trackIndex or 0
		isNeedFadeOut = isNeedFadeOut or true

		local list = effGo:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic), true)
		local validSkeletonCount = 0
		local completedCount = 0

		for i = 0, list.Length - 1 do
			local graphic = list[i]
			local sk = graphic.skeletonDataAsset

			if sk ~= nil then
				local skd = sk:GetAnimationStateData().SkeletonData
				local animation = skd:FindAnimation(animName)

				if animation ~= nil then
					validSkeletonCount = validSkeletonCount + 1
				end
			end
		end

		for i = 0, list.Length - 1 do
			local graphic = list[i]
			local sk = graphic.skeletonDataAsset

			if sk ~= nil then
				local data = sk:GetAnimationStateData()
				local skd = data.SkeletonData
				local ani = skd:FindAnimation(animName)

				if isReStart then
					graphic.AnimationState:ClearTracks()
				end

				if ani ~= nil then
					local animationState = graphic.AnimationState

					animationState:SetAnimation(trackIndex, animName, isLoop)

					local onComplete

					function onComplete()
						animationState.Complete = animationState.Complete - onComplete
						completedCount = completedCount + 1

						if not isLoop and isNeedFadeOut then
							animationState:AddEmptyAnimation(trackIndex, data.DefaultMix, 0)
						end

						if completedCount >= validSkeletonCount then
							GameUtil.callBack(callBack)
						end
					end

					animationState.Complete = animationState.Complete + onComplete
				end
			end
		end

		self:resumeAnim()
	end
end

function HLSpineCtrl:pauseAnim()
	if self._playerSpine then
		local effGo = self._playerSpine.effGo

		if not goutil.isNil(effGo) then
			local list = effGo:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic), true)

			for i = 0, list.Length - 1 do
				local graphic = list[i]

				graphic.timeScale = 0
			end
		end
	end
end

function HLSpineCtrl:resumeAnim()
	if self._playerSpine then
		local effGo = self._playerSpine.effGo

		if not goutil.isNil(effGo) then
			local list = effGo:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic), true)

			for i = 0, list.Length - 1 do
				local graphic = list[i]

				graphic.timeScale = 1
			end
		end
	end
end

function HLSpineCtrl:getSkeletonGraphic()
	return self._skeletonGraphic
end

function HLSpineCtrl:getSkeleton()
	return self._skeleton
end

function HLSpineCtrl:regCallBackOfSpineLoaded(callBack)
	self._callBackOfSpineLoaded = callBack
end

function HLSpineCtrl:unregCallBackOfSpineLoaded()
	self._callBackOfSpineLoaded = nil
end

return HLSpineCtrl
