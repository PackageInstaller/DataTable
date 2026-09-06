-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/controller/ThroneController.lua

module("logic.extensions.throne.controller.ThroneController", package.seeall)

local ThroneController = class("ThroneController", BaseController)

ThroneController.PM_LoadAllThronesRes = "ThroneController_PM_LoadAllThronesRes"
ThroneController.PM_GetThronePanelOtherInfoRes = "ThroneController_PM_GetThronePanelOtherInfoRes"
ThroneController.PM_UpgradeThroneRes = "ThroneController_PM_UpgradeThroneRes"
ThroneController.PM_GainThroneDailyPrizeRes = "ThroneController_PM_GainThroneDailyPrizeRes"
ThroneController.PM_GainThroneAchievementPrizeRes = "ThroneController_PM_GainThroneAchievementPrizeRes"
ThroneController.PM_NotifyThronesChangeRes = "ThroneController_PM_NotifyThronesChangeRes"
ThroneController.UpdateRedDot = "ThroneController.UpdateRedDot"
ThroneController.ON_RESET_THE_CELL = "on_reset_the_cell"

function ThroneController:ctor()
	return
end

function ThroneController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(ThroneAgent.PM_LoadAllThronesRes, self._PM_LoadAllThronesRes, self)
	GlobalDispatcher:addListener(ThroneAgent.PM_GetThronePanelOtherInfoRes, self._PM_GetThronePanelOtherInfoRes, self)
	GlobalDispatcher:addListener(ThroneAgent.PM_UpgradeThroneRes, self._PM_UpgradeThroneRes, self)
	GlobalDispatcher:addListener(ThroneAgent.PM_GainThroneDailyPrizeRes, self._PM_GainThroneDailyPrizeRes, self)
	GlobalDispatcher:addListener(ThroneAgent.PM_GainThroneAchievementPrizeRes, self._PM_GainThroneAchievementPrizeRes, self)
	GlobalDispatcher:addListener(ThroneAgent.PM_NotifyThronesChangeRes, self._PM_NotifyThronesChangeRes, self)
	GlobalDispatcher:addListener(ThroneAgent.PM_OneClickUpgradeThroneReq, self._PM_OneClickUpgradeThroneReq, self)
end

function ThroneController:onReset()
	self._isSendLoadAll = false
end

function ThroneController:sendPM_LoadAllThronesReq()
	if self._isSendLoadAll then
		return
	end

	self._isSendLoadAll = true

	ThroneAgent.instance:sendPM_LoadAllThronesReq()
end

function ThroneController:_PM_LoadAllThronesRes(status, msg)
	if status == 0 then
		ThroneModel.instance:setAllThrones(msg.throneInfos)
		BagPetsController.instance:calcAllPetThroneAttr()
		GlobalDispatcher:dispatch(ThroneController.UpdateRedDot)
		GlobalDispatcher:dispatch(ThroneController.PM_LoadAllThronesRes)
	end
end

function ThroneController:_PM_GetThronePanelOtherInfoRes(status, msg)
	if status == 0 then
		ThroneModel.instance:setPanelInfo(msg)
		GlobalDispatcher:dispatch(ThroneController.UpdateRedDot)
		GlobalDispatcher:dispatch(ThroneController.PM_GetThronePanelOtherInfoRes)
	end
end

function ThroneController:_PM_UpgradeThroneRes(status, msg)
	if status == 0 then
		UIStateManager.instance:push(ViewName.ThronelvupView, msg.throneId)
		GlobalDispatcher:dispatch(ThroneController.UpdateRedDot)
		GlobalDispatcher:dispatch(ThroneController.PM_UpgradeThroneRes)
	end
end

function ThroneController:_PM_GainThroneDailyPrizeRes(status, msg)
	if status == 0 then
		ThroneModel.instance:setGetDailyPrize()
		GlobalDispatcher:dispatch(ThroneController.UpdateRedDot)
		GlobalDispatcher:dispatch(ThroneController.PM_GainThroneDailyPrizeRes)
	end
end

function ThroneController:_PM_GainThroneAchievementPrizeRes(status, msg)
	if status == 0 then
		ThroneModel.instance:setAchievementPrizeRes(msg.id)
		GlobalDispatcher:dispatch(ThroneController.UpdateRedDot)
		GlobalDispatcher:dispatch(ThroneController.PM_GainThroneAchievementPrizeRes)
	end
end

function ThroneController:_PM_NotifyThronesChangeRes(status, msg)
	if status == 0 then
		ThroneModel.instance:setThronesChange(msg.changeList)
		BagPetsController.instance:calcAllPetThroneAttr()
		GlobalDispatcher:dispatch(ThroneController.PM_NotifyThronesChangeRes)
	end
end

function ThroneController:_PM_OneClickUpgradeThroneReq(status, msg)
	if status == 0 then
		UIStateManager.instance:push(ViewName.ThroneOneKeyLvUpView)
		GlobalDispatcher:dispatch(ThroneController.UpdateRedDot)
		GlobalDispatcher:dispatch(ThroneController.PM_UpgradeThroneRes)
	end
end

ThroneController.instance = ThroneController.New()

return ThroneController
