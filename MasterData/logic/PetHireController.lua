-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pethire/controller/PetHireController.lua

module("logic.extensions.pethire.controller.PetHireController", package.seeall)

local PetHireController = class("PetHireController", BaseController)

function PetHireController:ctor()
	return
end

function PetHireController:onInit()
	self:onReset()
end

function PetHireController:onReset()
	return
end

function PetHireController:getAllHirePetInfo()
	PetHireAgent.instance:sendPM_HirePetInfoReq()
end

function PetHireController:onSetAllHirePetInfo(msg)
	PetHireModel.instance:onSetAllHirePetInfo(msg)
end

function PetHireController:sendSetHrieFormByFormId(formId)
	local fmo = PetHireModel.instance:getFormationMoByFormId(formId)
	local req = PetHireExtension_pb.PM_SetHirePetFormReq()

	req.form.formId = formId

	fmo:createFormPb(req.form.simpleForm)

	req.form.simpleForm.formId = 0

	PetHireAgent.instance:sendPM_SetHirePetFormReq(req)
end

function PetHireController:updateHrieForm(msg)
	PetHireModel.instance:updateHrieForm(msg)
end

PetHireController.instance = PetHireController.New()

return PetHireController
