-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/DDKMainActor.lua

module("logic.extensions.darkdragonknife.view.DDKMainActor", package.seeall)

local DDKMainActor = class("DDKMainActor")

function DDKMainActor:ctor(parent, view, propCfg, actorPath)
	self._go = parent
	self._view = view
	self._propCfg = propCfg
	self._goAnim = goutil.findChild(self._go, "animation")
	self._eff = UIEffectManager.instance:playEffect(view, actorPath, self._goAnim, 0, 0, true, nil, nil, self._onEffectLoaded, self)
	self._goEff = goutil.findChild(self._go, "effect")
end

function DDKMainActor:_onEffectLoaded(uiEffect)
	uiEffect:setParent(self._goAnim.transform)
	uiEffect:setScale(0.5)
	uiEffect:setLocalPos()

	self._sg = uiEffect.effGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
	self._effLoaded = true

	self:playAnimation(self._sg, self._propCfg.idleEffName, 1, true)
end

function DDKMainActor:_playAnimationAndEffect(timeScale, isMoving)
	if not self._effLoaded then
		return
	end

	self:playAnimation(self._sg, (isMoving or nil) and self._propCfg.moveEffName, timeScale, false)

	if self._hitEffect then
		UIEffectManager.instance:stopEffect(self._hitEffect)

		self._hitEffect = nil
	end

	local hitUrl = "xiaoyouxi/xiaoanlongyouxi/" .. self._propCfg.knifeEffect .. ".prefab"

	self._hitEffect = UIEffectManager.instance:playEffect(self._view, hitUrl, self._goEff, 0, 0, true, nil, nil, function(o, eff)
		eff:setParent(self._goEff.transform)
		eff:setScale(8)
	end)
end

function DDKMainActor:onDestroy()
	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end

	self._sg = nil

	if self._hitEffect then
		UIEffectManager.instance:stopEffect(self._hitEffect)

		self._hitEffect = nil
	end
end

function DDKMainActor:setDirection(isLeft, scaleRate)
	if not scaleRate or not scaleRate then
		scaleRate = 1
	end

	GameUtil.setLocalScale(self._goAnim, (isLeft or nil) and (-1 * scaleRate or scaleRate), scaleRate, scaleRate)
end

function DDKMainActor:playAnimation(sg, animName, timeScale, loop, callBack, reStart)
	local graphic = sg

	if graphic then
		local sk = graphic.skeletonDataAsset

		if sk ~= nil then
			local data = sk:GetAnimationStateData()
			local skd = data.SkeletonData
			local ani = skd:FindAnimation(animName)

			if reStart then
				graphic.AnimationState:ClearTracks()
			end

			if ani ~= nil then
				graphic.startingAnimation = animName
				graphic.AnimationState.TimeScale = timeScale

				graphic.AnimationState:SetAnimation(0, animName, loop)
				graphic:Update(0)

				local onComplete

				function onComplete()
					GameUtil.callBack(callBack)

					graphic.AnimationState.Complete = graphic.AnimationState.Complete - onComplete
				end

				graphic.AnimationState.Complete = graphic.AnimationState.Complete + onComplete
			end
		end
	end
end

return DDKMainActor
