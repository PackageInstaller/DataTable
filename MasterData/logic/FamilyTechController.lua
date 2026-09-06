-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familytech/controller/FamilyTechController.lua

module("logic.extensions.familytech.controller.FamilyTechController", package.seeall)

local FamilyTechController = class("FamilyTechController", BaseController)

function FamilyTechController:ctor()
	return
end

function FamilyTechController:onInit()
	FamilyTechAgent.instance:addHandler(FamilyTechAgent.PM_NotifyFamilyTechChangeRes, self._onTechChangeRes, self)
end

function FamilyTechController:onReset()
	return
end

function FamilyTechController:reqTechInfo()
	FamilyTechAgent.instance:sendPM_GetFamilyTechInfoReq(self._onFamilyTechInfoRes, self)
end

function FamilyTechController:_onFamilyTechInfoRes(msg)
	FamilyTechModel.instance:setTechInfos(msg.techInfos)
	GlobalDispatcher:dispatch(GlobalNotify.UpdateFamilyTechUI)
end

function FamilyTechController:reqUpgradeTech(techId)
	FamilyTechAgent.instance:sendPM_UpgradeFamilyTechReq(techId, self._onUpgradeFamilyTechRes, self)
end

function FamilyTechController:_onTechChangeRes(msg)
	local techInfo = msg.techInfo

	FamilyTechModel.instance:setTechLevel(techInfo.techId, techInfo.level)
	GlobalDispatcher:dispatch(GlobalNotify.FamilyTechUpgradeSuccess)
end

function FamilyTechController:_onUpgradeFamilyTechRes(msg)
	print("_onUpgradeFamilyTechRes")
end

FamilyTechController.instance = FamilyTechController.New()

return FamilyTechController
