-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkaya/controller/OriginKayaController.lua

module("logic.extensions.originkaya.controller.OriginKayaController", package.seeall)

local OriginKayaController = class("OriginKayaController", BaseController)

function OriginKayaController:ctor()
	return
end

function OriginKayaController:onInit()
	self:onReset()
end

function OriginKayaController:onReset()
	self._tempLockPet = {}
end

function OriginKayaController:openMissionView(activityId, floorId, stageId)
	local fmtMo = OriginKayaModel.instance:getFmtMo()

	fmtMo:initParams(activityId, floorId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginKayaController:handlePM_OriginKayaInfoRes(msg)
	OriginKayaModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginKayaInfoRes)
end

function OriginKayaController:handlePM_OriginKayaResetRes(msg)
	OriginKayaModel.instance:saveResetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginKayaInfoRes)
end

function OriginKayaController:handlePM_OriginKayaNotifyStageClgRes(msg)
	if msg.isWin then
		OriginKayaModel.instance:saveBattleEndInfo(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginKayaInfoRes)
end

function OriginKayaController:isPassAllFloor(activityId)
	local floorCfgs = OriginKayaConfig.instance:getFloorCfgs(activityId)
	local passFloorId = 0

	for i, v in ipairs(floorCfgs) do
		if OriginKayaModel.instance:isPassFloor(activityId, v.floorId) == true and passFloorId < v.floorId then
			passFloorId = v.floorId
		end
	end

	if passFloorId >= #floorCfgs then
		return true
	else
		return false
	end
end

OriginKayaController.instance = OriginKayaController.New()

return OriginKayaController
