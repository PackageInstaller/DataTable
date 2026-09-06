-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmoyanclg/controller/OriginKingMoYanClgController.lua

module("logic.extensions.originkingmoyanclg.controller.OriginKingMoYanClgController", package.seeall)

local OriginKingMoYanClgController = class("OriginKingMoYanClgController", BaseController)

function OriginKingMoYanClgController:ctor()
	return
end

function OriginKingMoYanClgController:onInit()
	self:onReset()
end

function OriginKingMoYanClgController:onReset()
	self._tempLockPet = {}
end

function OriginKingMoYanClgController:openMissionView(activityId, floorId, stageId, neighbor)
	local flowerCount, fireCount, unitCount = 0, 0, 0

	for i, id in ipairs(neighbor) do
		if OriginKingMoYanClgModel.instance:isSetFlower(activityId, floorId, id) and OriginKingMoYanClgModel.instance:isSetFire(activityId, floorId, id) then
			unitCount = unitCount + 1
		end

		if OriginKingMoYanClgModel.instance:isSetFlower(activityId, floorId, id) then
			flowerCount = flowerCount + 1
		end

		if OriginKingMoYanClgModel.instance:isSetFire(activityId, floorId, id) then
			fireCount = fireCount + 1
		end
	end

	local fmtMo = OriginKingMoYanClgModel.instance:getFmtMo()

	fmtMo:initParams(activityId, floorId, stageId, flowerCount, fireCount, unitCount)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginKingMoYanClgController:handlePM_OriginKingMoYanClgGetInfoRes(msg)
	OriginKingMoYanClgModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginKingMoYanClgGetInfoRes)
end

function OriginKingMoYanClgController:handlePM_OriginKingMoYanClgSetItemRes(msg)
	OriginKingMoYanClgModel.instance:saveSetItem(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginKingMoYanClgSetItemRes)
end

function OriginKingMoYanClgController:handlePM_OriginKingMoYanClgResetPointRes(msg)
	OriginKingMoYanClgModel.instance:saveResetItem(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginKingMoYanClgSetItemRes)
end

function OriginKingMoYanClgController:handlePM_OriginKingMoYanClgFightNotifyRes(msg)
	if msg.isWin then
		OriginKingMoYanClgModel.instance:saveBattleInfo(msg)
	else
		BattleFacade.instance:registerResultHandler(self._openResult, self)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginKingMoYanClgFightNotifyRes)
end

function OriginKingMoYanClgController:_openResult()
	ViewMgr.instance:open(ViewName.OriginKingMoYanClgFailView)

	return true
end

function OriginKingMoYanClgController:handlePM_OriginKingMoYanClgResetRes(msg)
	OriginKingMoYanClgModel.instance:saveResetFloor(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginKingMoYanClgResetRes)
end

OriginKingMoYanClgController.instance = OriginKingMoYanClgController.New()

return OriginKingMoYanClgController
