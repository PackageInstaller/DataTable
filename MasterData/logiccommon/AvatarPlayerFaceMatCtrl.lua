-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarcontroller/AvatarPlayerFaceMatCtrl.lua

module("logiccommon.common.avatar.avatarcontroller.AvatarPlayerFaceMatCtrl", package.seeall)

local AvatarPlayerFaceMatCtrl = class("AvatarPlayerFaceMatCtrl", AvatarController)

function AvatarPlayerFaceMatCtrl:ctor(avatarBase)
	AvatarPlayerFaceMatCtrl.super.ctor(self, avatarBase)

	if self._avatar:getAvatarCreateType() ~= AvatarCreateType.Player then
		printError("AvatarPlayerFaceMatCtrl Must Used By AvatarPlayerFaceMatCtrl")
	end

	self.changeMat = AvatarPlayerFaceMat.New(self)
end

function AvatarPlayerFaceMatCtrl:_getControllerType()
	return AvatarControllerType.PlayerFaceMat
end

function AvatarPlayerFaceMatCtrl:onAvatarLoaded()
	AvatarPlayerFaceMatCtrl.super.onAvatarLoaded(self)
end

function AvatarPlayerFaceMatCtrl:onAvatarLoadedCallBack()
	AvatarPlayerFaceMatCtrl.super.onAvatarLoadedCallBack(self)
	self:updatePlayerFaceMat()
end

function AvatarPlayerFaceMatCtrl:onAvatarInvisible()
	AvatarPlayerFaceMatCtrl.super.onAvatarInvisible(self)
end

function AvatarPlayerFaceMatCtrl:onAvatarVisible()
	AvatarPlayerFaceMatCtrl.super.onAvatarVisible(self)
	self:updatePlayerFaceMat()
end

function AvatarPlayerFaceMatCtrl:onAvatarReset()
	AvatarPlayerFaceMatCtrl.super.onAvatarReset(self)
	self.changeMat:reset()
end

function AvatarPlayerFaceMatCtrl:onAvatarDestroy()
	AvatarPlayerFaceMatCtrl.super.onAvatarDestroy(self)
	self.changeMat:destroy()

	self.changeMat = nil
end

function AvatarPlayerFaceMatCtrl:updatePlayerFaceMat()
	if self._avatar.useType == AvatarUseType.UI then
		local hairId = self._avatar.avatarmo.hair.cover

		if hairId == 100602 then
			hairId = 100601
		end

		local partCfg = AvatarConfig.instance:getPartCfgById(hairId)

		if partCfg then
			if not AvatarPartTypeName[partCfg.partType] then
				local name = AvatarPendantTypeName[partCfg.partType]

				if partCfg then
					local path = GameUrl.getAvatarPlayerFaceMat(partCfg.asset, name)

					self.changeMat:load(path)
				else
					printError(">>>>>>>>>>>>>>>>>>>>>>> AvatarPlayerFaceMatCtrl error")
				end
			end
		end
	end
end

function AvatarPlayerFaceMatCtrl:changePlayerFaceMat(mat)
	local faceObje = self._avatar:getBoneByName(self._avatar.avatarmo.skeleton == 2 and AnimatorHash.maleBlendShapeName or AnimatorHash.femaleBlendShapeName)

	if faceObje then
		local skinedMeshRenderer = faceObje:GetComponent(ComponentType.SkinnedMeshRenderer)

		skinedMeshRenderer.material = mat
	end
end

return AvatarPlayerFaceMatCtrl
