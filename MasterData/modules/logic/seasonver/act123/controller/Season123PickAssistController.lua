-- chunkname: @modules/logic/seasonver/act123/controller/Season123PickAssistController.lua

module("modules.logic.seasonver.act123.controller.Season123PickAssistController", package.seeall)

local Season123PickAssistController = class("Season123PickAssistController", BaseController)

function Season123PickAssistController:onOpenView(actId, finishCall, finishCallObj, selectedHeroUid)
	Season123PickAssistListModel.instance:init(actId, selectedHeroUid)

	self._finishCall = finishCall
	self._finishCallObj = finishCallObj
end

function Season123PickAssistController:manualRefreshList()
	if self:checkCanRefresh() then
		self:sendRefreshList()
	else
		GameFacade.showToast(ToastEnum.Season123RefreshAssistInCD)
	end
end

function Season123PickAssistController:sendRefreshList()
	self:setHeroSelect()
	self:pickOver()
	DungeonRpc.instance:sendRefreshAssistRequest(DungeonEnum.AssistType.Season123, self.onRefreshAssist, self)
end

function Season123PickAssistController:onRefreshAssist(cmd, resultCode, msg)
	Season123Controller.instance:dispatchEvent(Season123Event.BeforeRefreshAssistList)
	self:recordAssistRefreshTime()
	Season123PickAssistListModel.instance:updateDatas()
end

function Season123PickAssistController:recordAssistRefreshTime()
	self._refreshUnityTime = Time.realtimeSinceStartup
end

function Season123PickAssistController:getRefreshCDRate()
	if self._refreshUnityTime then
		local updateInterval = CommonConfig.instance:getConstNum(ConstEnum.AssistCharacterUpdateInterval)
		local value = (Time.realtimeSinceStartup - self._refreshUnityTime) / updateInterval

		return 1 - math.max(0, math.min(1, value))
	else
		return 0
	end
end

function Season123PickAssistController:checkCanRefresh()
	local updateInterval = CommonConfig.instance:getConstNum(ConstEnum.AssistCharacterUpdateInterval)

	return not self._refreshUnityTime or updateInterval <= Time.realtimeSinceStartup - self._refreshUnityTime
end

function Season123PickAssistController:setCareer(career)
	local isDirty = false
	local curSelectedCareer = Season123PickAssistListModel.instance:getCareer()

	if career ~= curSelectedCareer then
		Season123PickAssistListModel.instance:setCareer(career)

		isDirty = true
	end

	return isDirty
end

function Season123PickAssistController:setHeroSelect(assistMO, value)
	Season123PickAssistListModel.instance:setHeroSelect(assistMO, value)
	self:notifyView()
end

function Season123PickAssistController:pickOver()
	local selectedMO = Season123PickAssistListModel.instance:getSelectedMO()

	if self._finishCall then
		self._finishCall(self._finishCallObj, selectedMO)
	end
end

function Season123PickAssistController:notifyView()
	Season123PickAssistListModel.instance:onModelUpdate()
end

function Season123PickAssistController:onCloseView()
	Season123PickAssistListModel.instance:release()
end

Season123PickAssistController.instance = Season123PickAssistController.New()

return Season123PickAssistController
