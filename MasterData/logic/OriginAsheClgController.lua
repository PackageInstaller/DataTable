-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originasheclg/controller/OriginAsheClgController.lua

module("logic.extensions.originasheclg.controller.OriginAsheClgController", package.seeall)

local OriginAsheClgController = class("OriginAsheClgController", BaseController)

function OriginAsheClgController:ctor()
	return
end

function OriginAsheClgController:onInit()
	self:onReset()
end

function OriginAsheClgController:onReset()
	self._tempLockPet = {}
end

function OriginAsheClgController:openMissionView(activityId, stageId, index)
	local fmtMo = OriginAsheClgModel.instance:getFmtMo()

	fmtMo:initParams(activityId, stageId, index)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginAsheClgController:handlePM_OriginAsheClgGetInfoRes(msg)
	OriginAsheClgModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_OriginAsheClgGetInfoRes)
end

function OriginAsheClgController:handlePM_OriginAsheClgResetStageRes(msg)
	OriginAsheClgModel.instance:saveResetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_OriginAsheClgGetInfoRes)
end

function OriginAsheClgController:sendPM_OriginAsheClgChallengeReq(activityId, stageId, battleSeq, form)
	self._tempLockPet = {}

	for i, v in ipairs(form.pos) do
		if checknumber(v) > 0 then
			local bagPetMo = BagPetsController.instance:getPet(v)

			self._tempLockPet[i] = bagPetMo.raceId
		end
	end

	OriginAsheClgAgent.instance:sendPM_OriginAsheClgChallengeReq(activityId, stageId, battleSeq, form)
end

function OriginAsheClgController:handlePM_Notify_OriginAsheClgChallengeResultRes(msg)
	OriginAsheClgModel.instance:saveChallengeResult(msg, self._tempLockPet)
	BattleFacade.instance:registerResultHandler(function()
		UIStateManager.instance:push(ViewName.OriginAsheClgResultView, msg.activityId, msg.stageId, msg.battleSeq, msg.pass)

		return true
	end)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_OriginAsheClgGetInfoRes)
end

OriginAsheClgController.instance = OriginAsheClgController.New()

return OriginAsheClgController
