-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godrace/controller/GodRaceController.lua

module("logic.extensions.godrace.controller.GodRaceController", package.seeall)

local GodRaceController = class("GodRaceController", BaseController)

function GodRaceController:awake(petIdBefore, leftSlotPutPetId, rightSlotPutPetId)
	GodRaceAgent.instance:sendPM_GodRaceTypeWakeReq(petIdBefore, leftSlotPutPetId, rightSlotPutPetId)
end

GodRaceController.instance = GodRaceController.New()

return GodRaceController
