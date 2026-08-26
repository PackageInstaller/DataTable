-- chunkname: @modules/logic/sp01/assassinChase/view/AssassinChaseSpineItem.lua

module("modules.logic.sp01.assassinChase.view.AssassinChaseSpineItem", package.seeall)

local AssassinChaseSpineItem = class("AssassinChaseSpineItem", LuaCompBase)

function AssassinChaseSpineItem:init(go)
	self.go = go
	self._spineGO = gohelper.findChild(self.go, "spine")
	self._skeletonComponent = self._spineGO:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

	gohelper.onceAddComponent(self._spineGO, UnitSpine.TypeSpineAnimationEvent)

	if self._skeletonComponent then
		self._skeletonComponent:SetScaleX(SpineLookDir.Right)
	end

	transformhelper.setLocalPos(self._spineGO.transform, 0, AssassinChaseEnum.SpineDefaultHeight, 0)

	self._goBubble = gohelper.findChild(self.go, "image_Bubble")
end

function AssassinChaseSpineItem:replaceMaterial(material)
	self._material = UnityEngine.GameObject.Instantiate(material)
	self._skeletonComponent.material = self._material
end

function AssassinChaseSpineItem:setBubbleActive(active)
	gohelper.setActive(self._goBubble, active)
end

function AssassinChaseSpineItem:play(animState, isLoop, reStart)
	if not animState then
		return
	end

	if not self._skeletonComponent then
		return
	end

	isLoop = isLoop or false
	reStart = reStart or false

	local needPlay = reStart or animState ~= self._curAnimState or isLoop ~= self._isLoop

	if not needPlay then
		return
	end

	self._curAnimState = animState
	self._isLoop = isLoop

	if self._skeletonComponent:HasAnimation(animState) then
		self._skeletonComponent:SetAnimation(0, animState, self._isLoop, 0.2)
	else
		local spineName = gohelper.isNil(self._spineGO) and "nil" or self._spineGO.name

		logError(string.format("animName:%s  goName:%s  Animation Name not exist ", animState, spineName))
	end
end

function AssassinChaseSpineItem:setRolePosition(offset, isTween, time)
	self:_releaseTween()

	if not isTween then
		transformhelper.setLocalPos(self._spineGO.transform, offset, AssassinChaseEnum.SpineDefaultHeight, 0)
	else
		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._spineGO.transform, offset, time, nil, nil, EaseType.InCubic)
	end
end

function AssassinChaseSpineItem:_releaseTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function AssassinChaseSpineItem:onDestroy()
	if self._spineGO then
		gohelper.destroy(self._spineGO)

		self._spineGO = nil
		self._spineGOTrs = nil
	end

	if self._material then
		gohelper.destroy(self._material)

		self._material = nil
	end

	self._skeletonComponent = nil
	self._skeletonAnim = nil
	self._curAnimState = nil

	self:_releaseTween()
end

return AssassinChaseSpineItem
