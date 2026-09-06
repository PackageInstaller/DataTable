-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarobject/AvatarPartNew.lua

module("logiccommon.common.avatar.avatarobj.AvatarPartNew", package.seeall)

local TransformType = typeof(UnityEngine.Transform)
local AvatarPartNew = class("AvatarPartNew", AvatarObject)

function AvatarPartNew:ctor(ctrl)
	AvatarPartNew.super.ctor(self)

	self._type = nil
	self._id = nil
	self._isShareBone = false
	self._isUseTransMat = false
	self._ctrl = ctrl
	self._skinedMeshRenderer = nil

	self._resLoader:setPreRecycleHandler(self._onPreRecycleHandler, self)
end

function AvatarPartNew:load(assetPath)
	AvatarPartNew.super.load(self, assetPath)

	if not self._id then
		printInfo("Part'Id is NIL VALUE")
	end
end

function AvatarPartNew:destroy()
	AvatarPartNew.super.destroy(self)

	self._type = nil
	self._id = nil
	self._ctrl = nil
	self._skinedMeshRenderer = nil
end

function AvatarPartNew:loadedHandle(loader)
	if loader == self._resLoader then
		local resObject = self:getGameObject()

		resObject.name = AvatarPartTypeName[self._type]
		self._skinedMeshRenderer = resObject:GetComponentInChildren(ComponentType.SkinnedMeshRenderer)

		local skMap = self._ctrl._avatar:getSkeletonMap()

		if skMap then
			self:sharedSkeletonMap(skMap)

			self._isShareBone = true
		end
	end

	AvatarPartNew.super.loadedHandle(self, loader)
end

function AvatarPartNew:callBackHandle(loader)
	if loader == self._resLoader then
		if not self._isShareBone then
			local skMap = self._ctrl._avatar:getSkeletonMap()

			if skMap then
				self:sharedSkeletonMap(skMap)

				self._isShareBone = true
			end
		end

		if self._isShareBone then
			self._ctrl:dispatch(AvatarNotify.OnPartLoaded, self)
		else
			printInfo("not ShareBoneInfo")
		end
	end

	AvatarPartNew.super.callBackHandle(self, loader)
end

function AvatarPartNew:sharedSkeletonMap(skMap)
	local skinedMeshRenderer = self._skinedMeshRenderer

	if skinedMeshRenderer then
		self._originBones = self._originBones or skinedMeshRenderer.bones
		self._originRootBone = self._originRootBone or skinedMeshRenderer.rootBone

		local bones = skinedMeshRenderer.bones
		local bonesNew = System.Array.CreateInstance(TransformType, bones.Length)
		local rootBone = skMap[skinedMeshRenderer.rootBone.name]
		local idx = 0

		for i = 0, bones.Length - 1 do
			local bone = skMap[bones[i].name]

			if not bone then
				printError("蒙皮路径=" .. self._resLoader:getResPath() .. "  中的骨骼缺失，骨骼名字=" .. bones[i].name)
			end

			if bone then
				bonesNew[idx] = bone
				idx = idx + 1
			end
		end

		skinedMeshRenderer.bones = bonesNew
		skinedMeshRenderer.rootBone = rootBone
	end
end

function AvatarPartNew:setPartType(PartType)
	if not table.keyof(AvatarPartType, PartType) then
		printError("Part set Error Type")
	end

	self._type = PartType
end

function AvatarPartNew:getPartType()
	return self._type
end

function AvatarPartNew:setPartId(id)
	self._id = id
end

function AvatarPartNew:setIsUseTransMat(IsUse)
	self._isUseTransMat = checkbool(IsUse)
end

function AvatarPartNew:getIsUseTransMat()
	return self._isUseTransMat
end

function AvatarPartNew:getPartId()
	return self._id
end

function AvatarPartNew:getSkinedMeshRenderer()
	return self._skinedMeshRenderer
end

function AvatarPartNew:detach()
	self:reset()
end

function AvatarPartNew:reset()
	self:_clearSkinedMesh()
	self._resLoader:clear()

	self._isUseTransMat = false
	self._assetPath = nil
	self._id = nil
end

function AvatarPartNew:_clearSkinedMesh()
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
	self._isShareBone = false
end

function AvatarPartNew:_onPreRecycleHandler()
	self:_clearSkinedMesh()
end

return AvatarPartNew
