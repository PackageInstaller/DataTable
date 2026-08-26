-- chunkname: @modules/logic/sp01/act204/view/Activity204EntranceView.lua

module("modules.logic.sp01.act204.view.Activity204EntranceView", package.seeall)

local Activity204EntranceView = class("Activity204EntranceView", BaseView)

function Activity204EntranceView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Page1/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Page1/#txt_LimitTime")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity204EntranceView:addEvents()
	return
end

function Activity204EntranceView:removeEvents()
	return
end

function Activity204EntranceView:_editableInitView()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._updateActivity, self)
end

function Activity204EntranceView:onUpdateParam()
	return
end

function Activity204EntranceView:onOpen()
	self._actId = self.viewParam and self.viewParam.actId
	self._entranceIds = self.viewParam and self.viewParam.entranceIds
	self.actEntranceItemMap = self:getUserDataTb_()

	self:refresh()
	self:checkActivityState()
	AudioMgr.instance:trigger(AudioEnum2_9.Activity204.EnterEntrance)
end

function Activity204EntranceView:refresh()
	self:refreshAllEntrances()
	self:refreshBubbleItem()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
end

function Activity204EntranceView:refreshAllEntrances()
	for index, actId in ipairs(self._entranceIds or {}) do
		local goentrance = gohelper.findChild(self.viewGO, "Page1/Entrance" .. index)
		local cls = Activity204Enum.ActId2EntranceCls[actId]

		if gohelper.isNil(goentrance) then
			logError(string.format("缺少活动入口 index = %s actId = %s", index, actId))
		elseif not cls then
			logError(string.format("缺少活动入口类(Activity204Enum.ActId2EntranceCls) index = %s actId = %s", index, actId))
		else
			local entranceItem = MonoHelper.addNoUpdateLuaComOnceToGo(goentrance, cls)

			entranceItem:onUpdateMO(actId)

			self.actEntranceItemMap[actId] = entranceItem
		end
	end
end

function Activity204EntranceView:refreshBubbleItem()
	local bubbleActIds = Activity204Controller.instance:getBubbleActIdList()
	local gobubbleItem = gohelper.findChild(self.viewGO, "Page1/Entrance5")
	local bubbleItem = MonoHelper.addNoUpdateLuaComOnceToGo(gobubbleItem, Activity204BubbleItem)

	bubbleItem:onUpdateMO(bubbleActIds)
end

function Activity204EntranceView:refreshRemainTime()
	if not self._actId then
		return
	end

	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function Activity204EntranceView:_updateActivity()
	self:checkActivityState()
	Activity204Controller.instance:getAllEntranceActInfo(self.refresh, self)
end

function Activity204EntranceView:checkActivityState()
	for actId, entranceItem in pairs(self.actEntranceItemMap) do
		local status = entranceItem and entranceItem:_getActivityStatus(actId)
		local isActFinish = status == ActivityEnum.ActivityStatus.Expired

		if isActFinish then
			local actViewList = Activity204Enum.ActId2ViewList[actId]

			self:checkFinishViewList(actViewList)
		end
	end

	for stageId = Act205Enum.GameStageId.Card, Act205Enum.GameStageId.Ocean do
		local isOpen = Act205Model.instance:isGameStageOpen(stageId, false)

		if not isOpen then
			local viewList = Activity204Enum.Act205StageView[stageId]

			self:checkFinishViewList(viewList)
		end
	end
end

function Activity204EntranceView:checkFinishViewList(actViewList)
	if actViewList and #actViewList > 0 then
		for _, viewName in ipairs(actViewList) do
			if ViewMgr.instance:isOpen(viewName) then
				MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, Activity204EntranceView.yesCallback)

				return
			end
		end
	end
end

function Activity204EntranceView.yesCallback()
	ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)
	NavigateButtonsView.homeClick()
end

function Activity204EntranceView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function Activity204EntranceView:onDestroyView()
	return
end

return Activity204EntranceView
