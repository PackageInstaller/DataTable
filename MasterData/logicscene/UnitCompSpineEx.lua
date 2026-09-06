-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompSpineEx.lua

module("logicscene.scene.unit.component.UnitCompSpineEx", package.seeall)

local UnitCompSpineEx = class("UnitCompSpineEx", UnitCompSpineAnims)

function UnitCompSpineEx:ctor(unit)
	UnitCompSpine.super.ctor(self, unit)

	self._skeletonLoader = nil
	self._skeletonAnimation = nil
	self._defaultAnimState = "idle"
	self._curAnimState = nil
	self._isLoop = true
	self._isFlipX = false
	self._playSpeed = 1
	self._colliderEnabled = true
	self._isVisible = true
	self._skeletonGO = nil
end

function UnitCompSpineEx:clear()
	self._skeletonAnimation = nil
	self._skeletonGO = nil
	self._allAnims = nil
end

function UnitCompSpineEx:setBody(skeletonGO)
	self:clear()

	self._skeletonGO = skeletonGO

	local parent = self._unit.mountRoot:getAvatarRoot()

	goutil.addChildToParent(skeletonGO, parent)
	Framework.GameObjectUtil.SetLayerRecursively(skeletonGO, parent.layer)

	self._skeletonAnimation = skeletonGO:GetComponent(UnitCompSpine.SkeletonAnimationType)

	if self._skeletonAnimation then
		self._skeletonAnimation:Initialize(false)

		self._skeletonAnimation.Skeleton.FlipX = self._isFlipX
	end

	if self._curAnimState then
		local animState = self._curAnimState

		self._curAnimState = nil

		self:play(animState, self._isLoop)
	elseif self._defaultAnimState then
		self:play(self._defaultAnimState, self._isLoop)
	end

	self:_updatePlaySpeed()
end

function UnitCompSpineEx:setVisible(isVisible)
	self._isVisible = isVisible

	if self._skeletonGO then
		self._skeletonGO:SetActive(self._isVisible)
	end
end

function UnitCompSpineEx:setUpdateEnable(enable)
	if self._skeletonAnimation then
		self._skeletonAnimation.enableUpdate = enable
	end
end

function UnitCompSpineEx:onUnitVisible(go)
	self:setBody(go)
	self:_recordAnims(go)

	self.isSpineLoaded = true
end

function UnitCompSpineEx:onUnitInVisible(go)
	self:clear()

	self.isSpineLoaded = nil
end

function UnitCompSpineEx:onDestroy()
	UnitCompSpineEx.super.onDestroy(self)

	self._skeletonGO = nil
end

return UnitCompSpineEx
