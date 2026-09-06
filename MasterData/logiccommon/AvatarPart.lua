-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/AvatarPart.lua

module("logiccommon.common.avatar.AvatarPart", package.seeall)

local TransformType = typeof(UnityEngine.Transform)
local AvatarPart = class("AvatarPart")

function AvatarPart:ctor(partType, avatar)
	self.partType = partType
	self._resLoader = AvatarResLoader.New(true, self._onAvatarResLoaded, self)
	self.avatar = avatar
	self._assetPathToLoaded = nil

	self.avatar:addListener(Avatar.OnSkeletonLoaded, self._onSkeletonLoaded, self)
	self._resLoader:setPreRecycleHandler(self._onPreRecycleHandler, self)
end

function AvatarPart:load(assetPath)
	self._assetPathToLoaded = nil

	if not self.avatar:isSkelegonLoaded() then
		self._assetPathToLoaded = assetPath

		return
	end

	if self._resLoader:getResPath() == assetPath and self._resLoader:isLoaded() then
		self.avatar:dispatch(Avatar.OnPartLoaded, self)

		return
	end

	self:_clearSkinedMesh()
	self._resLoader:load(assetPath)
	self:_updateParent()
	self:_updateLayer()
end

function AvatarPart:setLayer(layer)
	self.layer = layer

	self:_updateLayer()
end

function AvatarPart:detach()
	self:_clearSkinedMesh()
	self._resLoader:clear()
end

function AvatarPart:destroy()
	self:detach()
	self.avatar:removeListener(Avatar.OnSkeletonLoaded, self._onSkeletonLoaded, self)
end

function AvatarPart:getResObject()
	return self._resLoader:getResObject()
end

function AvatarPart:getSkinedMeshRenderer()
	return self._skinedMeshRenderer
end

function AvatarPart:sharedSkeletons(skeletonsT)
	local skinedMeshRenderer = self._skinedMeshRenderer

	if skinedMeshRenderer then
		self._originBones = self._originBones or skinedMeshRenderer.bones
		self._originRootBone = self._originRootBone or skinedMeshRenderer.rootBone

		local bones = skinedMeshRenderer.bones
		local bonesNew = System.Array.CreateInstance(TransformType, bones.Length)
		local rootBone = skeletonsT[skinedMeshRenderer.rootBone.name]

		for i = 0, bones.Length - 1 do
			local bone = skeletonsT[bones[i].name]

			if not bone then
				error("蒙皮路径=" .. self._resLoader:getResPath() .. "  中的骨骼缺失，骨骼名字=" .. bones[i].name)
			end

			bonesNew[i] = bone
		end

		skinedMeshRenderer.bones = bonesNew
		skinedMeshRenderer.rootBone = rootBone

		if self.partType == AvatarPartType.Face then
			self.avatar:rebindAnimator()
		end
	end
end

function AvatarPart:isPartLoaded()
	return self._resLoader:isLoaded()
end

function AvatarPart:_updateParent()
	if self.avatar.avatarType == AvatarType.UI and self.avatar:isSkelegonLoaded() then
		local skeletonGo = self.avatar:getGameObject()

		self._resLoader:setParent(skeletonGo.transform)
	end
end

function AvatarPart:_updateLayer()
	if self.avatar.avatarType == AvatarType.Scene then
		local resObject = self._resLoader:getResObject()

		if resObject then
			resObject:setLayer(SceneLayer.Invisible_Value)
		end

		return
	end

	if self.layer and self.avatar.avatarType == AvatarType.UI then
		local resObject = self._resLoader:getResObject()

		if resObject then
			resObject:setLayer(self.layer)
		end
	end
end

function AvatarPart:_clearSkinedMesh()
	if self._skinedMeshRenderer then
		if self._originBones then
			self._skinedMeshRenderer.bones = self._originBones
		end

		if self._originRootBone then
			self._skinedMeshRenderer.rootBone = self._originRootBone
		end
	end

	self._skinedMeshRenderer = nil
	self._originRootBone = nil
	self._originBones = nil
end

function AvatarPart:_onSkeletonLoaded(avatar)
	if self._assetPathToLoaded and avatar:isSkelegonLoaded() then
		self._resLoader:load(self._assetPathToLoaded)

		self._assetPathToLoaded = nil

		self:_updateParent()
		self:_updateLayer()
	end
end

function AvatarPart:_onAvatarResLoaded(loader)
	if loader == self._resLoader then
		local resObject = self:getResObject()

		if self.partType == AvatarPartType.Face then
			if self.avatar.gender == GameEnum.Gender.Female then
				resObject.go.name = AnimatorHash.femaleBlendShapeName or AnimatorHash.maleBlendShapeName
			end
		else
			resObject.go.name = AvatarPartTypeName[self.partType]
		end

		self._skinedMeshRenderer = resObject.go:GetComponentInChildren(ComponentType.SkinnedMeshRenderer)

		self.avatar:dispatch(Avatar.OnPartLoaded, self)
	end
end

function AvatarPart:_onPreRecycleHandler()
	self:_clearSkinedMesh()
end

return AvatarPart
