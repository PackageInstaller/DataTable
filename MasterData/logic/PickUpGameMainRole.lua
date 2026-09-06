-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/view/PickUpGameMainRole.lua

module("logic.extensions.pickupidea.view.PickUpGameMainRole", package.seeall)

local PickUpGameMainRole = class("PickUpGameMainRole")

function PickUpGameMainRole:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._goAnim = goutil.findChild(self._go, "animation")
	self._goEff = goutil.findChild(self._go, "effect")
	self._curX = 0
	self._curY = 0
	self._cacheV2 = Vector2.New(0, 0)

	local triggerGo = goutil.findChild(self._go, "trigger")
	local x, y = Framework.TransformUtil.GetLocalPos(triggerGo.transform, 0, 0, 0)

	self._offset = {
		x = x,
		y = y
	}
	self._playHitSpiderEffectTime = 0
	self._cacheColor = Color.New(1, 1, 1, 1)
end

function PickUpGameMainRole:setView(view)
	self._view = view
end

function PickUpGameMainRole:loadActor(actorPath)
	self._eff = UIEffectManager.instance:playEffect(view, actorPath, self._goAnim, 0, 0, true, nil, nil, self._onEffectLoaded, self)

	self._eff:setParent(self._goAnim.transform)
	self._eff:setScale(0.25)
	self._eff:setLocalPos()
end

function PickUpGameMainRole:_onEffectLoaded(uiEffect)
	self._sg = uiEffect.effGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
	self._effLoaded = true

	self:playAnimation(self._sg, "idle", 1, true)
end

function PickUpGameMainRole:setDirection(isLeft)
	GameUtil.setLocalScale(self._goAnim, isLeft and -1 or 1, 1, 1)
end

function PickUpGameMainRole:_playAnimationAndEffect(timeScale, isMoving)
	if not self._effLoaded then
		return
	end

	self:playAnimation(self._sg, (isMoving or nil) and "run", timeScale, true)

	if self._hitEffect then
		UIEffectManager.instance:stopEffect(self._hitEffect)

		self._hitEffect = nil
	end
end

function PickUpGameMainRole:playAnimation(sg, animName, timeScale, loop, callBack, reStart)
	if self._isSetZhuwangAni and self._isHitSpider then
		return
	end

	local graphic = sg

	if graphic then
		if graphic.startingAnimation == animName then
			return
		end

		if self._isHitSpider and animName == "zhuwang" then
			self._isSetZhuwangAni = true
		end

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

function PickUpGameMainRole:getTriggerPos()
	self._curX, self._curY = Framework.TransformUtil.GetLocalPos(self._go.transform, 0, 0, 0)
	self._cacheV2.x = self._curX + self._offset.x
	self._cacheV2.y = self._curY + self._offset.y

	return self._cacheV2
end

function PickUpGameMainRole:playHitSpiderEffect()
	self._playHitSpiderEffectTime = self._playHitSpiderEffectTime + 1

	if self._cacheColor == nil then
		self._cacheColor = self.main
	end

	if self._playHitSpiderEffectTime % 2 == 0 then
		self._cacheColor.g = 0
		self._cacheColor.b = 0
	else
		self._cacheColor.g = 1
		self._cacheColor.b = 1
	end

	if self._sg then
		self._sg.color = self._cacheColor
	end
end

function PickUpGameMainRole:resetRoleHitSpiderEffect()
	self._cacheColor.r = 1
	self._cacheColor.b = 1
	self._cacheColor.g = 1
	self._cacheColor.a = 1

	if self._sg then
		self._sg.color = self._cacheColor
	end

	self._playHitSpiderEffectTime = 0
end

function PickUpGameMainRole:hitSpider()
	self._isHitSpider = true
	self._isSetZhuwangAni = false

	self:playAnimation(self._sg, "zhuwang", 1, true)
end

function PickUpGameMainRole:overHitSpider()
	self._isHitSpider = false
	self._isSetZhuwangAni = false

	self:playAnimation(self._sg, "idle", 1, true)
end

function PickUpGameMainRole:onExit()
	self._isHitSpider = false
	self._isSetZhuwangAni = false

	self:resetRoleHitSpiderEffect()
	self:overHitSpider()
end

return PickUpGameMainRole
