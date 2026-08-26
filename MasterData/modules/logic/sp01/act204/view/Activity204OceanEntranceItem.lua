-- chunkname: @modules/logic/sp01/act204/view/Activity204OceanEntranceItem.lua

module("modules.logic.sp01.act204.view.Activity204OceanEntranceItem", package.seeall)

local Activity204OceanEntranceItem = class("Activity204OceanEntranceItem", Activity204EntranceItemBase)

function Activity204OceanEntranceItem:init(go)
	Activity204OceanEntranceItem.super.init(self, go)

	self._gounlockeffect = gohelper.findChild(self.go, "root/#saoguang")
	self._gobg1 = gohelper.findChild(self.go, "root/#btn_Entrance/go_bg1")
	self._gobg2 = gohelper.findChild(self.go, "root/#btn_Entrance/go_bg2")

	gohelper.setActive(self._gounlockeffect, false)
end

function Activity204OceanEntranceItem:addEventListeners()
	Activity204OceanEntranceItem.super.addEventListeners(self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullViewFinish, self._onCloseViewFinish, self)
end

function Activity204OceanEntranceItem:initActInfo(actId)
	Activity204OceanEntranceItem.super.initActInfo(self, actId)
	self:_initStageList(actId)
end

function Activity204OceanEntranceItem:_getActivityStatus()
	local _, status, toastId = self:_getCurShowStage()

	if status == ActivityEnum.ActivityStatus.Expired then
		logNormal(self._actId .. "活动不满足开放时间: " .. TimeUtil.timestampToString(self._startTime) .. "," .. TimeUtil.timestampToString(self._endTime))
	end

	return status, toastId
end

function Activity204OceanEntranceItem:refreshTitle()
	local curStageMo, status = self:_getCurShowStage()
	local curStageCo = curStageMo and curStageMo.config

	if curStageCo then
		self._txtEntrance.text = curStageCo.name or ""
	end

	self._isCardGameOpen = curStageMo and curStageMo.stageId == Act205Enum.GameStageId.Card and status == ActivityEnum.ActivityStatus.Normal

	if self._isCardGameOpen and self._isCardGameNewOpen == nil then
		self._isCardGameNewOpen = Activity204Controller.instance:getPlayerPrefs(PlayerPrefsKey.Activity204CardNewUnlockEffect, 0) == 0

		self:tryPlayNewUnlockEffect()
	end

	gohelper.setActive(self._gobg1, curStageMo.stageId == Act205Enum.GameStageId.Card)
	gohelper.setActive(self._gobg2, curStageMo.stageId == Act205Enum.GameStageId.Ocean)
end

function Activity204OceanEntranceItem:_onOpenViewFinish(viewName)
	if viewName ~= ViewName.Activity204EntranceView then
		return
	end

	self:tryPlayNewUnlockEffect()
end

function Activity204OceanEntranceItem:_onCloseViewFinish(viewName)
	if viewName == ViewName.Activity204EntranceView then
		return
	end

	self:tryPlayNewUnlockEffect()
end

function Activity204OceanEntranceItem:tryPlayNewUnlockEffect()
	if not self._isCardGameNewOpen or ViewMgr.instance:isOpening(ViewName.Activity204EntranceView) or not ViewHelper.instance:checkViewOnTheTop(ViewName.Activity204EntranceView) then
		return
	end

	self._isCardGameNewOpen = false

	gohelper.setActive(self._gounlockeffect, true)
	Activity204Controller.instance:setPlayerPrefs(PlayerPrefsKey.Activity204CardNewUnlockEffect, 1)
end

function Activity204OceanEntranceItem:_getTimeStr()
	if not self._actMo then
		return
	end

	local stageMo, status = self:_getCurShowStage()
	local startTime = stageMo and stageMo.startTime
	local endTime = stageMo and stageMo.endTime

	return self:_decorateTimeStr(status, startTime, endTime)
end

function Activity204OceanEntranceItem:_initStageList(actId)
	local stageConfigList = lua_actvity205_stage.configDict[actId]

	self._stageMoList = {}

	for _, stageCo in ipairs(stageConfigList) do
		local stageMo = {}

		stageMo.config = stageCo
		stageMo.stageId = stageCo.stageId
		stageMo.activityId = stageCo.activityId
		stageMo.activityCofig = ActivityConfig.instance:getActivityCo(stageMo.activityId)
		stageMo.startTime = Act205Config.instance:getGameStageOpenTimeStamp(stageCo.activityId, stageCo.stageId)
		stageMo.endTime = Act205Config.instance:getGameStageEndTimeStamp(stageCo.activityId, stageCo.stageId)

		table.insert(self._stageMoList, stageMo)
	end

	if self._stageMoList then
		self._stageCount = #self._stageMoList or 0
	end

	table.sort(self._stageMoList, self._stageMoSortFunc)
end

function Activity204OceanEntranceItem._stageMoSortFunc(aStageMo, bStageMo)
	if aStageMo.startTime ~= bStageMo.startTime then
		return aStageMo.startTime < bStageMo.startTime
	end

	if aStageMo.endTime ~= bStageMo.endTime then
		return aStageMo.endTime < bStageMo.endTime
	end

	if aStageMo.activityId ~= bStageMo.activityId then
		return aStageMo.activityId < bStageMo.activityId
	end

	return aStageMo.stageId ~= bStageMo.stageId
end

function Activity204OceanEntranceItem:_getStageStatus(stageMo)
	if not stageMo then
		return
	end

	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(stageMo.activityId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return status, toastId, toastParam
	end

	local curServerTime = ServerTime.now()

	if curServerTime <= stageMo.startTime then
		return ActivityEnum.ActivityStatus.NotOpen, ToastEnum.ActivityNotOpen
	end

	if curServerTime >= stageMo.endTime then
		return ActivityEnum.ActivityStatus.Expired, ToastEnum.ActivityEnd
	end

	return ActivityEnum.ActivityStatus.Normal
end

function Activity204OceanEntranceItem:_getCurShowStage()
	local showStageMo, showStatus, showToastId

	for _, stageMo in ipairs(self._stageMoList) do
		local status, toastId = self:_getStageStatus(stageMo)

		showStageMo = stageMo
		showStatus = status
		showToastId = toastId

		if status == ActivityEnum.ActivityStatus.NotOpen or status == ActivityEnum.ActivityStatus.Normal then
			break
		end
	end

	return showStageMo, showStatus, showToastId
end

function Activity204OceanEntranceItem:updateReddot()
	if self._actCfg and self._actCfg.redDotId ~= 0 then
		local infoList = {}

		table.insert(infoList, {
			id = RedDotEnum.DotNode.V2a9_Act205OceanOpen
		})
		table.insert(infoList, {
			id = self._actCfg.redDotId
		})
		RedDotController.instance:addMultiRedDot(self._goRedPoint, infoList)
	end
end

return Activity204OceanEntranceItem
