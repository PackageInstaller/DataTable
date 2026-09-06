-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/MakeSnowmanTaskView.lua

module("logic.extensions.eventtasksummary.view.MakeSnowmanTaskView", package.seeall)

local MakeSnowmanTaskView = class("MakeSnowmanTaskView", EventTaskFather)

function MakeSnowmanTaskView:buildUI()
	MakeSnowmanTaskView.super.buildUI(self)

	self._guideFinger = self:getGo("guideFinger")
	self._scrollrect = goutil.findChildComponent(self.mainGO, "taskCol/taskScrollerview", "ScrollRect")
end

function MakeSnowmanTaskView:onEnter()
	MakeSnowmanTaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._getPrizeEnd, self)

	if MakeSnowmanModel.instance:getProgress() <= 0 then
		GameUtil.SetActive(self._guideFinger, true)

		self.hasGuide = true
		self._scrollrect.enabled = false
	else
		GameUtil.SetActive(self._guideFinger, false)

		self.hasGuide = false
		self._scrollrect.enabled = true
	end
end

function MakeSnowmanTaskView:_updateTaskCell(view, cell, cfg, tag)
	local data = cfg.data
	local state = cfg.state
	local mainGo = cell.gameObject
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local txtProg = goutil.findChildTextComponent(mainGo, "txtProg")
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

	if txtProg then
		local curProgress = EventTaskSummaryModel.instance:getTaskCurProgress(data.taskId)
		local maxProgress = data.maxProgress

		txtProg.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

		GameUtil.SetActive(txtProg.gameObject, state ~= GameEnum.PrizeState.IsHasGain)
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
	GameUtil.addClickHandler(btnReceive, GameUtil.handler(self._onClickBtnRecieve, self, data.taskId))
end

function MakeSnowmanTaskView:onExit()
	MakeSnowmanTaskView.super.onExit(self)
	MakeSnowmanAgent.instance:sendPM_MakeSnowmanGetInfoReq(self._activityId)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._getPrizeEnd, self)
end

function MakeSnowmanTaskView:_getPrizeEnd()
	if self.hasGuide == true then
		self:close()
	end

	if MakeSnowmanModel.instance:getProgress() <= 0 then
		GameUtil.SetActive(self._guideFinger, true)

		self.hasGuide = true
		self._scrollrect.enabled = false
	else
		GameUtil.SetActive(self._guideFinger, false)

		self.hasGuide = false
		self._scrollrect.enabled = true
	end
end

function MakeSnowmanTaskView:_onUpdatePlaneUI()
	if self.hasGuide == true then
		self._taskScrollList:MoveCellToCenter(0)
	end
end

return MakeSnowmanTaskView
