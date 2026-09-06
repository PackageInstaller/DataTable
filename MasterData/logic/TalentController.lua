-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/talent/controller/TalentController.lua

module("logic.extensions.talent.controller.TalentController", package.seeall)

local TalentController = class("TalentController", BaseController)

function TalentController:onInit()
	return
end

function TalentController:openView(petId)
	UIStateManager.instance:open(ViewName.Talent, petId)
end

function TalentController:CultivatePetGenius(petId)
	return
end

TalentController.instance = TalentController.New()

return TalentController
