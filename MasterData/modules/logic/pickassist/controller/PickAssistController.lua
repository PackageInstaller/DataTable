-- chunkname: @modules/logic/pickassist/controller/PickAssistController.lua

module("modules.logic.pickassist.controller.PickAssistController", package.seeall)

local PickAssistController = class("PickAssistController", BaseController)

function PickAssistController:openPickAssistView(assistType, actId, selectedHeroUid, finishCall, finishCallObj, isAutoRefresh, extraStr, notNeedCareer)
	if not assistType or not actId then
		return
	end

	self._actId = actId
	self._assistType = assistType
	self._selectedHeroUid = selectedHeroUid
	self._finishCall = finishCall
	self._finishCallObj = finishCallObj
	self._notNeedCareer = notNeedCareer
	self._extraStr = extraStr

	local canRefresh = self:checkCanRefresh()

	if isAutoRefresh and canRefresh then
		self.tmpIsRecordRefreshTime = true

		DungeonRpc.instance:sendRefreshAssistRequest(assistType, self._openPickAssistViewAfterRpc, self, self._extraStr)
	else
		self:_openPickAssistViewAfterRpc()
	end
end

function PickAssistController:_openPickAssistViewAfterRpc(cmd, resultCode, msg)
	PickAssistListModel.instance:init(self._actId, self._assistType, self._selectedHeroUid, self._notNeedCareer)

	if self.tmpIsRecordRefreshTime then
		self:recordAssistRefreshTime()
	end

	self.tmpIsRecordRefreshTime = nil

	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 1)

	local viewName = PickAssistListModel.instance:getPickAssistViewName()

	if viewName then
		ViewMgr.instance:openView(viewName)
	end
end

function PickAssistController:manualRefreshList()
	if self:checkCanRefresh() then
		self:sendRefreshList()
	else
		GameFacade.showToast(ToastEnum.Season123RefreshAssistInCD)
	end
end

function PickAssistController:sendRefreshList()
	self:setHeroSelect()
	self:pickOver()

	local assistType = PickAssistListModel.instance:getAssistType()

	if assistType then
		DungeonRpc.instance:sendRefreshAssistRequest(assistType, self.onRefreshAssist, self, self._extraStr)
	end
end

function PickAssistController:onRefreshAssist(cmd, resultCode, msg)
	self:dispatchEvent(PickAssistEvent.BeforeRefreshAssistList)
	self:recordAssistRefreshTime()
	PickAssistListModel.instance:updateDatas()
end

function PickAssistController:recordAssistRefreshTime()
	self._refreshUnityTime = Time.realtimeSinceStartup
end

function PickAssistController:getRefreshCDRate()
	if self._refreshUnityTime then
		local updateInterval = CommonConfig.instance:getConstNum(ConstEnum.AssistCharacterUpdateInterval)
		local value = (Time.realtimeSinceStartup - self._refreshUnityTime) / updateInterval

		return 1 - math.max(0, math.min(1, value))
	else
		return 0
	end
end

function PickAssistController:checkCanRefresh()
	local updateInterval = CommonConfig.instance:getConstNum(ConstEnum.AssistCharacterUpdateInterval)

	return not self._refreshUnityTime or updateInterval <= Time.realtimeSinceStartup - self._refreshUnityTime
end

function PickAssistController:setCareer(career)
	local isDirty = false
	local curSelectedCareer = PickAssistListModel.instance:getCareer()

	if career ~= curSelectedCareer then
		PickAssistListModel.instance:setCareer(career)

		isDirty = true
	end

	return isDirty
end

function PickAssistController:setHeroSelect(assistMO, value)
	PickAssistListModel.instance:setHeroSelect(assistMO, value)
	self:notifyView()
end

function PickAssistController:pickOver()
	local selectedMO = PickAssistListModel.instance:getSelectedMO()

	if self._finishCall then
		self._finishCall(self._finishCallObj, selectedMO)
	end
end

function PickAssistController:notifyView()
	PickAssistListModel.instance:onModelUpdate()
end

function PickAssistController:onCloseView()
	PickAssistListModel.instance:onCloseView()
end

PickAssistController.instance = PickAssistController.New()

return PickAssistController
