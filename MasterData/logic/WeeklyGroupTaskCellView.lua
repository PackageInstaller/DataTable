-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklygroup/view/WeeklyGroupTaskCellView.lua

module("logic.extensions.weeklygroup.view.WeeklyGroupTaskCellView", package.seeall)

local WeeklyGroupTaskCellView = class("WeeklyGroupTaskCellView", EventTaskTabChildView)

function WeeklyGroupTaskCellView:ctor()
	WeeklyGroupTaskCellView.super.ctor(self)
end

function WeeklyGroupTaskCellView:unbindEvents()
	WeeklyGroupTaskCellView.super.unbindEvents(self)
end

function WeeklyGroupTaskCellView:bindEvents()
	WeeklyGroupTaskCellView.super.bindEvents(self)
end

function WeeklyGroupTaskCellView:buildUI()
	WeeklyGroupTaskCellView.super.buildUI(self)
end

function WeeklyGroupTaskCellView:onExit()
	WeeklyGroupTaskCellView.super.onExit(self)
end

function WeeklyGroupTaskCellView:onEnter()
	WeeklyGroupTaskCellView.super.onEnter(self)
end

function WeeklyGroupTaskCellView:_updateTaskCell(view, cell, info, tag)
	local taskId = info.taskId
	local state = info.state
	local data = EventTaskSummaryConfig.instance:getTaskData(self._activityId, taskId)
	local mainGo = cell.gameObject
	local btnReceive = goutil.findChild(mainGo, "recieve/btnReceive")
	local btnGoto = goutil.findChild(mainGo, "recieve/btnGoto")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local txtProgress = goutil.findChildTextComponent(mainGo, "recieve/txtProgress")
	local txtDesc = MaterialMgr.findGraphicText(mainGo, "txtDesc")

	if goutil.isNil(txtDesc) then
		txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	end

	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	if txtTitle then
		txtTitle.text = data.title
	end

	if txtDesc then
		txtDesc.text = data.desc
	end

	if txtProgress then
		local curProgress = self._eventTaskMgr:getCurProgressOfTask(taskId)
		local maxProgress = data.maxProgress

		txtProgress.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

		local isNeedShow = not data.isHideProgress and state == GameEnum.PrizeState.IsNotEnough

		GameUtil.SetActive(txtProgress.gameObject, isNeedShow)
	end

	if itemScrollerview and self._itemScrollercell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = itemScrollList

			itemScrollList:reloadData(prizeStrArr)
			itemScrollList:dragNotifyParent()
		end
	end

	GameUtil.SetActive(btnReceive, state == GameEnum.PrizeState.IsCanGet)
	GameUtil.SetActive(btnGoto, state == GameEnum.PrizeState.IsNotEnough and not string.nilorempty(data.jumpTo))
	GameUtil.SetActive(receivedGo, state == GameEnum.PrizeState.IsHasGain)
	GameUtil.addClickHandler(btnGoto, GameUtil.handler(self._onClickBtnGo, self, data))
	GameUtil.addClickHandler(btnReceive, GameUtil.handler(self._onClickBtnReceive, self, data.taskId))
end

return WeeklyGroupTaskCellView
