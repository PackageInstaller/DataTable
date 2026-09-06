-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/view/CatchPropsAnimCtrl.lua

module("logic.extensions.catchprops.view.CatchPropsAnimCtrl", package.seeall)

local CatchPropsAnimCtrl = class("CatchPropsAnimCtrl")

function CatchPropsAnimCtrl:ctor(node)
	self._nodeParent = node
	self._currAnimState = nil
	self._isFlipX = false
	self._spineGo = nil
	self._skeletonGraphic = nil
end

function CatchPropsAnimCtrl:onEnter()
	return
end

function CatchPropsAnimCtrl:onExit()
	if self._spineGo then
		goutil.destroy(self._spineGo)

		self._spineGo = nil
	end

	self:resetAnimState()
end

function CatchPropsAnimCtrl:playAnim(state, loop, force)
	if not force and self._currAnimState == state then
		return
	end

	self._currAnimState = state

	if self._skeletonGraphic then
		self._skeletonGraphic.startingAnimation = state

		self._skeletonGraphic.AnimationState:SetAnimation(0, state, loop)
		self._skeletonGraphic:Update(0)
	end
end

function CatchPropsAnimCtrl:setDirection(isFlipX)
	self._isFlipX = isFlipX

	if self._skeletonGraphic and self._skeletonGraphic.Skeleton then
		self._skeletonGraphic.Skeleton.FlipX = isFlipX
	end
end

function CatchPropsAnimCtrl:resetAnimState()
	self._currAnimState = nil
	self._isFlipX = false
	self._spineGo = nil
	self._skeletonGraphic = nil
end

function CatchPropsAnimCtrl:loadSpine(path, animName)
	local res = rescache:GetResourceNoLoadIfNotExists(path)

	if not res then
		return
	end

	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	self._spineGo = goutil.clone(mainAsset)

	if not self._spineGo then
		return
	end

	self._spineGo.transform:SetParent(self._nodeParent.transform)
	Framework.TransformUtil.SetLocalScale(self._spineGo.transform, 1, 1, 1)
	Framework.TransformUtil.SetLocalPos(self._spineGo.transform, 0, 0, 0)

	self._skeletonGraphic = self._spineGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	if animName then
		self:playAnim(animName, true, true)
	else
		self:playAnim("idle", true, true)
	end
end

return CatchPropsAnimCtrl
