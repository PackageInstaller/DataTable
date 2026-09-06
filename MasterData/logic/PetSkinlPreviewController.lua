-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskinpreview/controller/PetSkinlPreviewController.lua

module("logic.extensions.petskinpreview.controller.PetSkinlPreviewController", package.seeall)

local PetSkinlPreviewController = class("PetSkinlPreviewController", BaseController)

function PetSkinlPreviewController:onInit()
	self:onReset()
end

function PetSkinlPreviewController:onReset()
	self._hadSkins = nil
	self._userId = 0
	self._isOtherUser = false
	self._isDragCell = false
end

function PetSkinlPreviewController:setUserId(userId)
	userId = checknumber(userId)

	if userId ~= self._userId then
		self._hadSkins = nil
		self._userId = userId
		self._isOtherUser = self._userId > 0 and self._userId ~= checknumber(RoleModel.instance:getUserId())
	end
end

function PetSkinlPreviewController:isHadSkin(skinId)
	self._hadSkins = self._hadSkins or self:_getHadSkins()

	local mainCfg = PetSkinConfig.instance:getMainSkinGroupCfgBySkinId(skinId)

	if mainCfg then
		return self._hadSkins[mainCfg.skinId]
	end

	return self._hadSkins[skinId]
end

function PetSkinlPreviewController:_getHadSkins()
	local skinIdKvList = {}

	if self._isOtherUser then
		local var_5_0 = PetskinModel.instance:getOtherUserOwnSkinListBySkinGroup()

		if not var_5_0 then
			var_5_0 = PetskinModel.instance:getUserOwnSkinListBySkinGroup()

			local skinList = var_5_0

			for quality, ids in pairs(skinList or {}) do
				for _, cfg in pairs(ids) do
					skinIdKvList[cfg.skinId] = true
				end
			end

			return skinIdKvList
		end
	end
end

function PetSkinlPreviewController:resetHadSkins()
	self._hadSkins = nil
end

function PetSkinlPreviewController:beginDrag()
	self._isDragCell = true
end

function PetSkinlPreviewController:endDrag()
	self._isDragCell = false
end

function PetSkinlPreviewController:isDrag()
	return self._isDragCell
end

PetSkinlPreviewController.instance = PetSkinlPreviewController.New()

return PetSkinlPreviewController
