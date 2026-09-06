-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcompose/controller/PetComposeController.lua

module("logic.extensions.petcompose.controller.PetComposeController", package.seeall)

local PetComposeController = class("PetComposeController", BaseController)

function PetComposeController:ctor()
	self.isViewOpen = false
end

function PetComposeController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(PetAgent.PM_PetRareComposeRes, self._onPetComposeRes, self)
end

function PetComposeController:onReset()
	removetimer(self.playGetPet, self)
end

function PetComposeController:_onPetComposeRes(status, msg)
	if status == 0 then
		self._changeSetId = msg.changeSetId
		self._changeSetId2 = msg.strengthenItemCsi

		ItemGetController.instance:setTitleType(self._changeSetId2, ItemGetController.TITLE_RETURNMAT)
		MaterialController.instance:setChangeSetPopup(self._changeSetId)
		MaterialController.instance:setChangeSetPopup(self._changeSetId2)
		MaterialController.instance:saveChangeSetToTemp(self._changeSetId)
		MaterialController.instance:saveChangeSetToTemp(self._changeSetId2)
		settimer(2, self.playGetPet, self)
	end
end

function PetComposeController:playGetPet(force)
	if self._changeSetId and (not self.isViewOpen or force) then
		MaterialController.instance:showChangeSetInTemp(self._changeSetId2)
		MaterialController.instance:showChangeSetInTemp(self._changeSetId)

		self._changeSetId = nil
		self._changeSetId2 = nil
	end
end

PetComposeController.instance = PetComposeController.New()

return PetComposeController
