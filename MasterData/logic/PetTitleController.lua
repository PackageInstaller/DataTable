-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettitle/controller/PetTitleController.lua

module("logic.extensions.pettitle.controller.PetTitleController", package.seeall)

local PetTitleController = class("PetTitleController", BaseController)

function PetTitleController:ctor()
	return
end

function PetTitleController:onInit()
	self:onReset()
end

function PetTitleController:onReset()
	self._isOtherInfo = false

	PetTitleModel.instance:initRedPoint()
end

function PetTitleController:reqServerData(userId)
	if userId then
		self._isOtherInfo = true

		PetTitleAgent.instance:sendPM_PetTitleGetPetTitlesReq(userId)
	else
		self._isOtherInfo = false

		PetTitleModel.instance:initRedPoint()
		PetTitleAgent.instance:sendPM_PetTitleGetPetTitlesReq()
	end
end

function PetTitleController:handleGetPetTitlesRes(status, msg)
	if status == 0 then
		PetTitleModel.instance:handleGetPetTitlesRes(msg, self._isOtherInfo)
		GlobalDispatcher:dispatch(GlobalNotify.PetTitleModelInit)
	end

	self._isOtherInfo = false
end

function PetTitleController:handleChangeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function PetTitleController:handleNotifyPetTitleChangeRes(msg)
	PetTitleModel.instance:handleNotifyPetTitleChangeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PetTitleModelChange)
end

function PetTitleController:showChangeCurPetTitle(petMo, callback, thisArg)
	UIStateManager.instance:push(ViewName.PetTitleShowSelectView, petMo, function(titleId)
		if callback then
			GameUtil.callBack(callback, thisArg, titleId)
		elseif titleId ~= petMo.petTitleId then
			PetTitleAgent.instance:sendPM_PetTitleChangeReq(petMo.petId, titleId)
		end
	end)
end

PetTitleController.instance = PetTitleController.New()

return PetTitleController
