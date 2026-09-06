-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarcontroller/AvatarNakePartsCtrl.lua

module("logiccommon.common.avatar.avatarcontroller.AvatarNakePartsCtrl", package.seeall)

local AvatarNakePartsCtrl = class("AvatarNakePartsCtrl", AvatarController)

function AvatarNakePartsCtrl:ctor(avatarBase)
	AvatarNakePartsCtrl.super.ctor(self, avatarBase)
end

function AvatarNakePartsCtrl:_getControllerType()
	return AvatarControllerType.Nake
end

function AvatarNakePartsCtrl:onAvatarLoaded()
	AvatarNakePartsCtrl.super.onAvatarLoaded(self)
end

function AvatarNakePartsCtrl:onAvatarLoadedCallBack()
	AvatarNakePartsCtrl.super.onAvatarLoadedCallBack(self)
end

function AvatarNakePartsCtrl:onAvatarInvisible()
	AvatarNakePartsCtrl.super.onAvatarInvisible(self)
end

function AvatarNakePartsCtrl:onAvatarVisible()
	AvatarNakePartsCtrl.super.onAvatarVisible(self)
end

function AvatarNakePartsCtrl:onAvatarReset()
	AvatarNakePartsCtrl.super.onAvatarReset(self)

	self._nakeParts = {}
end

function AvatarNakePartsCtrl:onAvatarDestroy()
	AvatarNakePartsCtrl.super.onAvatarDestroy(self)
end

function AvatarNakePartsCtrl:updateNakeParts()
	local avatarMo = self._avatar.avatarmo
	local curPartId = avatarMo:getCurCoverDataValue()
	local hideParts = {}

	for _, v in ipairs(curPartId) do
		local cfg = AvatarConfig.instance:getPartCfgById(v)

		if cfg and cfg.nakeHides then
			for _1, v1 in ipairs(cfg.nakeHides) do
				table.insert(hideParts, v1)
			end
		end
	end

	for k, v in pairs(avatarMo:getOwnNakeParts()) do
		local nakeparts = self._avatar:getBoneByName(AvatarNakePartTypeName[v])

		if v == AvatarNakePartType.Face then
			nakeparts = self._avatar:getBoneByName((self._avatar.avatarmo.skeleton == 2 or nil) and AnimatorHash.maleBlendShapeName)
		end

		if nakeparts then
			goutil.setActive(nakeparts.gameObject, not table.indexof(hideParts, v))
		end
	end
end

function AvatarNakePartsCtrl:resetNakeParts()
	local avatarMo = self._avatar.avatarmo

	for k, v in pairs(avatarMo:getOwnNakeParts()) do
		local nakeparts = self._avatar:getBoneByName(AvatarNakePartTypeName[v])

		if v == AvatarNakePartType.Face then
			nakeparts = self._avatar:getBoneByName((self._avatar.avatarmo.skeleton == 2 or nil) and AnimatorHash.maleBlendShapeName)
		end

		if nakeparts then
			goutil.setActive(nakeparts.gameObject, true)
		end
	end
end

return AvatarNakePartsCtrl
