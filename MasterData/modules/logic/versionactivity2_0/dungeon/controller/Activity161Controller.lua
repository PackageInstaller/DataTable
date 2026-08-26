-- chunkname: @modules/logic/versionactivity2_0/dungeon/controller/Activity161Controller.lua

module("modules.logic.versionactivity2_0.dungeon.controller.Activity161Controller", package.seeall)

local Activity161Controller = class("Activity161Controller", BaseController)

function Activity161Controller:onInit()
	self.actId = Activity161Model.instance:getActId()
end

function Activity161Controller:onInitFinish()
	return
end

function Activity161Controller:addConstEvents()
	return
end

function Activity161Controller:reInit()
	TaskDispatcher.cancelTask(self.refreshGraffitiCdInfo, self)

	self.isRunCdTask = false
end

function Activity161Controller:initAct161Info(isNeedShowToast, failedDoCb, cb, cbObj)
	local actId = Activity161Model.instance:getActId()
	local isOline = ActivityModel.instance:isActOnLine(actId)

	if isOline then
		Activity161Rpc.instance:sendAct161RefreshElementsRequest(self.actId)
		Activity161Rpc.instance:sendAct161GetInfoRequest(actId, cb, cbObj)
	else
		if isNeedShowToast then
			GameFacade.showToast(ToastEnum.ActivityNotOpen)
		end

		if failedDoCb and cb then
			cb(cbObj)
		end
	end
end

function Activity161Controller:openGraffitiEnterView()
	Activity161Config.instance:initGraffitiPicMap(self.actId)
	ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapGraffitiEnterView)
end

function Activity161Controller:openGraffitiView(param)
	local viewParam = param or {
		actId = Activity161Model.instance:getActId()
	}

	Activity161Config.instance:initGraffitiPicMap(self.actId)
	ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonGraffitiView, viewParam)
end

function Activity161Controller:openGraffitiDrawView(param)
	ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonGraffitiDrawView, param)
end

function Activity161Controller:checkGraffitiCdInfo()
	self.inCdMoList = Activity161Model.instance:getInCdGraffiti()
	self.isRunCdTask = self.isRunCdTask or false

	if #self.inCdMoList > 0 and not self.isRunCdTask then
		TaskDispatcher.cancelTask(self.refreshGraffitiCdInfo, self)
		TaskDispatcher.runRepeat(self.refreshGraffitiCdInfo, self, 1)

		self.isRunCdTask = true
	elseif #self.inCdMoList == 0 and self.isRunCdTask then
		TaskDispatcher.cancelTask(self.refreshGraffitiCdInfo, self)

		self.isRunCdTask = false
	end
end

function Activity161Controller:refreshGraffitiCdInfo()
	local curInCdMoList = Activity161Model.instance:getInCdGraffiti()
	local arriveCdMoList = Activity161Model.instance:getArriveCdGraffitiList(self.inCdMoList, curInCdMoList)

	self.inCdMoList = curInCdMoList

	if #arriveCdMoList > 0 then
		for _, arriveCdMo in pairs(arriveCdMoList) do
			Activity161Model.instance:setGraffitiState(arriveCdMo.id, Activity161Enum.graffitiState.ToUnlock)
			Activity161Controller.instance:dispatchEvent(Activity161Event.ToUnlockGraffiti, arriveCdMo)
		end

		Activity161Model.instance:setNeedRefreshNewElementsState(true)
		Activity161Rpc.instance:sendAct161RefreshElementsRequest(self.actId)
	elseif #curInCdMoList == 0 then
		TaskDispatcher.cancelTask(self.refreshGraffitiCdInfo, self)

		self.isRunCdTask = false
		self.inCdMoList = {}

		Activity161Model.instance:setNeedRefreshNewElementsState(false)
	elseif #curInCdMoList > 0 then
		Activity161Controller.instance:dispatchEvent(Activity161Event.GraffitiCdRefresh, curInCdMoList)
	end
end

function Activity161Controller:jumpToElement(graffitiMO)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_0DungeonGraffitiView) then
		ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonGraffitiView)
		ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonMapGraffitiEnterView)
		self:dispatchEvent(Activity161Event.CloseGraffitiEnterView)

		local elementId = graffitiMO.config.mainElementId

		VersionActivity2_0DungeonController.instance:dispatchEvent(VersionActivity2_0DungeonEvent.FocusElement, elementId)
	end
end

function Activity161Controller:getRecentFinishGraffiti()
	local graffitiInfMap = Activity161Model.instance.graffitiInfoMap
	local graffitiList = {}

	for index, mo in pairs(graffitiInfMap) do
		if mo.config.dialogGroupId > 0 and mo.state == Activity161Enum.graffitiState.IsFinished then
			table.insert(graffitiList, mo)
		end
	end

	if #graffitiList > 0 then
		return graffitiList[#graffitiList]
	end
end

function Activity161Controller:getLocalKey()
	return "GraffitiFinishDialog" .. "#" .. tostring(self.actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function Activity161Controller:checkRencentGraffitiHasDialog()
	local saveGraffitiId = PlayerPrefsHelper.getNumber(self:getLocalKey(), 0)
	local recentFinishDialogMO = self:getRecentFinishGraffiti()

	if recentFinishDialogMO and saveGraffitiId ~= 0 and saveGraffitiId == recentFinishDialogMO.config.id then
		return true
	end

	return false, recentFinishDialogMO
end

function Activity161Controller:saveRecentGraffitiDialog()
	local hasSaveDialog, recentFinishDialogMO = self:checkRencentGraffitiHasDialog()

	if not hasSaveDialog and recentFinishDialogMO then
		PlayerPrefsHelper.setNumber(self:getLocalKey(), recentFinishDialogMO.config.id)
	end
end

function Activity161Controller:checkHasUnDoElement()
	local needDoElementId = VersionActivity2_0DungeonModel.instance:getCurNeedUnlockGraffitiElement()
	local needShowRedDot = needDoElementId and needDoElementId > 0 and 1 or 0
	local redDotInfoList = {
		{
			uid = 0,
			id = RedDotEnum.DotNode.V2a0DungeonHasUnDoElement,
			value = needShowRedDot
		}
	}

	RedDotRpc.instance:clientAddRedDotGroupList(redDotInfoList, true)
end

Activity161Controller.instance = Activity161Controller.New()

return Activity161Controller
