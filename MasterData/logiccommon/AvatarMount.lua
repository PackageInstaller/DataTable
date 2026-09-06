-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/AvatarMount.lua

module("logiccommon.common.avatar.AvatarMount", package.seeall)

local TransformType = typeof(UnityEngine.Transform)
local AvatarMount = class("AvatarMount", AvatarEffects)

function AvatarMount:ctor(avatar)
	self.avatar = avatar
	self.instantMountEff = nil
	self.mountPoint = nil
	self._assetPathToLoaded = nil
	self._bonesRef = nil

	self.avatar:addListener(Avatar.OnSkeletonLoaded, self._onSkeletonLoaded, self)

	self._resLoader = AvatarResLoader.New(true, self._onAvatarMountLoaded, self)
end

function AvatarMount:load(assetPath)
	self._assetPathToLoaded = nil

	if not self.avatar:isSkelegonLoaded() then
		self._assetPathToLoaded = assetPath

		return
	end

	if self._resLoader:getResPath() == assetPath and self._resLoader:isLoaded() then
		self.avatar:dispatch(Avatar.OnMountLoaded, self)

		return
	end

	self:clearEffects()
	self._resLoader:load(assetPath)
end

function AvatarMount:detach()
	self:clearEffects()
	self._resLoader:clear()

	self.mountPoint = nil
	self._assetPathToLoaded = nil
	self._bonesRef = nil

	self:clearAnim()
end

function AvatarMount:destroy()
	self:clearEffects()
	self:detach()

	self.mountPoint = nil
	self._assetPathToLoaded = nil
	self._bonesRef = nil

	self:clearAnim()
	self.avatar:removeListener(Avatar.OnSkeletonLoaded, self._onSkeletonLoaded, self)
end

function AvatarMount:getResObject()
	return self._resLoader:getResObject()
end

function AvatarMount:isMountLoaded()
	return self._resLoader:isLoaded()
end

function AvatarMount:setLayer(layer)
	AvatarMount.super.setLayer(self, layer)
	self:_updateLayer()
end

function AvatarMount:setParent(parent)
	self._resLoader:setParent(parent)
end

function AvatarMount:playMountingEff()
	if self.instantMountEff then
		-- block empty
	end
end

function AvatarMount:_updateLayer()
	if self.layer then
		local resObject = self._resLoader:getResObject()

		if resObject then
			resObject:setLayer(self.layer)
		end
	end
end

function AvatarMount:isEmpty()
	return not self._resLoader:getResPath() and not self._assetPathToLoaded
end

function AvatarMount:setPreRecycleHandler(handler, handlerObj)
	self._resLoader:setPreRecycleHandler(handler, handlerObj)
end

function AvatarMount:_onSkeletonLoaded(avatar)
	if self._assetPathToLoaded and avatar:isSkelegonLoaded() then
		self:clearEffects()
		self._resLoader:load(self._assetPathToLoaded)

		self._assetPathToLoaded = nil
	end
end

function AvatarMount:_onAvatarMountLoaded(loader)
	if loader == self._resLoader then
		local go = loader:getGameObject()
		local animator = go:GetComponent(ComponentType.Animator)

		self:setAnimator(animator)

		self._bonesRef = go:GetComponent(ComponentType.BonesRef)
		self.mountPoint = self:getHagPoint(AvatarHangPointName[AvatarHangPointType.Mount])

		self:_updateLayer()
		self.avatar:dispatch(Avatar.OnMountLoaded, self)
	end
end

return AvatarMount
