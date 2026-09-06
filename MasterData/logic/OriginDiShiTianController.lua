-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindishitian/controller/OriginDiShiTianController.lua

module("logic.extensions.origindishitian.controller.OriginDiShiTianController", package.seeall)

local OriginDiShiTianController = class("OriginDiShiTianController", BaseController)

function OriginDiShiTianController:onInit()
	self:onReset()
end

function OriginDiShiTianController:onReset()
	self._resultView = nil
end

function OriginDiShiTianController:openMissionView(activityId, stageId, missionView, resultView)
	local fmtMo = OriginDiShiTianModel.instance:getFmtMo()

	fmtMo:initParams(activityId, stageId, missionView)

	self._resultView = resultView

	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginDiShiTianController:handlePM_OriginDiShiTianClgGetInfoRes(msg)
	OriginDiShiTianModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginDiShiTianInfoRes)
end

function OriginDiShiTianController:handlePM_NotifyOriginDiShiTianClgFightRes(msg)
	if msg.win == true then
		OriginDiShiTianModel.instance:saveTempBattleResult(msg)
		BattleFacade.instance:registerResultHandler(self._openResultView, self)
	else
		BattleFacade.instance:registerResultHandler(function()
			ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)

			return true
		end, self)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginDiShiTianInfoRes)
end

function OriginDiShiTianController:_openResultView()
	if OriginDiShiTianModel.instance:getTempBattleResult() ~= nil then
		if self._resultView then
			ViewMgr.instance:open(self._resultView)

			self._resultView = nil
		else
			ViewMgr.instance:open(ViewName.OriginDiShiTianResultView)
		end

		return true
	else
		return false
	end
end

function OriginDiShiTianController:handlePM_OriginDiShiTianClgResetRes(msg)
	OriginDiShiTianModel.instance:saveResetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginDiShiTianInfoRes)
end

function OriginDiShiTianController:handlePM_OriginDiShiTianClgConfirmRes(msg)
	if msg.save == true then
		OriginDiShiTianModel.instance:saveBattleInfo(msg)

		if msg.changeSetId then
			OriginDiShiTianModel.instance:saveTempPrizeChangeSet(msg.changeSetId)
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		end
	end

	OriginDiShiTianModel.instance:resestBattleResult()
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginDiShiTianInfoRes)
end

function OriginDiShiTianController:getAllLockPetMap(activityId)
	local lockPetMap = {}
	local lockPetList = OriginDiShiTianModel.instance:getLockPetList(activityId)

	for i, v in ipairs(lockPetList) do
		lockPetMap[v] = true
	end

	return lockPetMap
end

OriginDiShiTianController.instance = OriginDiShiTianController.New()

return OriginDiShiTianController
