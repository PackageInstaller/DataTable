-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storysummary/view/StorySummaryPartView.lua

module("logic.extensions.storysummary.view.StorySummaryPartView", package.seeall)

local StorySummaryPartView = class("StorySummaryPartView", ViewComponent)

function StorySummaryPartView:ctor()
	StorySummaryPartView.super.ctor(self)
end

function StorySummaryPartView:buildUI()
	StorySummaryPartView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._partScrollerview = goutil.findChild(self.mainGO, "partCol/partScrollerview")
	self._partScrollercell = goutil.findChild(self.mainGO, "partCol/partScrollercell")
	self._partScrollList = ScrollerList.create(self._partScrollerview, self._partScrollercell, GameUtil.handler(self._updatePartCell, self), GameUtil.handler(self._clearPartCell, self))
end

function StorySummaryPartView:bindEvents()
	StorySummaryPartView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function StorySummaryPartView:unbindEvents()
	StorySummaryPartView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function StorySummaryPartView:destroyUI()
	StorySummaryPartView.super.destroyUI(self)
end

function StorySummaryPartView:onEnter()
	StorySummaryPartView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._storyPlanId = checknumber(params[1])

	if self._storyPlanId == 0 then
		FloatWordMgr.instance:show("故事方案id错误")
		self:close()

		return
	end

	self._ssPartCfg = StorySummaryConfig.instance:getSsPartCfg(self._storyPlanId)

	self:_onUpdateUI()
end

function StorySummaryPartView:onExit()
	StorySummaryPartView.super.onExit(self)
end

function StorySummaryPartView:_onUpdateUI()
	self:_onUpdatePartScrollerList()
end

function StorySummaryPartView:_onUpdatePartScrollerList()
	local dataList = {}

	for _, data in ipairs(self._ssPartCfg) do
		local periodType = StorySummaryController.instance:getPartPeriodType(data.storyPlanId, data.partIdx)

		if periodType == GameUtil.inTimePeriod or periodType == GameUtil.beforeTimePeriod then
			table.insert(dataList, data)
		end
	end

	self._partScrollList:reloadData(dataList)
end

function StorySummaryPartView:_updatePartCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtPartName = goutil.findChildTextComponent(mainGo, "txtPartName/txt")
	local txtLock = goutil.findChildTextComponent(mainGo, "txtLock/txt")
	local txtPartDesc = goutil.findChildTextComponent(mainGo, "txtPartDesc")
	local txtLockGo = goutil.findChild(mainGo, "txtLock")
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local newTag = goutil.findChild(mainGo, "newTag")
	local con = goutil.findChild(mainGo, "mask/con")

	txtPartName.text = data.partrName
	txtPartDesc.text = data.partrDesc

	local isPartNewTagInTime = StorySummaryController.instance:isPartNewTagInTime(data.storyPlanId, data.partIdx)

	GameUtil.SetActive(newTag, isPartNewTagInTime)

	local isNeedCon = not string.nilorempty(data.partrIconPath)

	GameUtil.SetActive(con, isNeedCon)

	if isNeedCon then
		local path = string.format("ui/bigbg/%s.png", data.partrIconPath)

		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, path)
	else
		uGuiUtil.clearImage(con)
	end

	local perType = StorySummaryController.instance:getPartPeriodType(data.storyPlanId, data.partIdx)
	local isInTime = perType == GameUtil.inTimePeriod
	local isPassThreadCond = StorySummaryController.instance:isPartPassThreadCond(data.storyPlanId, data.partIdx)
	local isPartPassPrePart = StorySummaryController.instance:isPartPassPrePartCond(data.storyPlanId, data.partIdx)
	local isPartPass = StorySummaryController.instance:isStorySummaryPartPass(data.partId)
	local isPartUnlock = isInTime and isPassThreadCond and isPartPassPrePart
	local floatStr = ""
	local lockStr = ""

	if not isInTime then
		local startDate, endDate = GameUtil.string2date(data.startTime), GameUtil.string2date(data.endTime)

		if perType == GameUtil.beforeTimePeriod then
			lockStr = string.format("%d.%d日 %d:%02d将开启", startDate.month, startDate.day, startDate.hour, startDate.min)
			floatStr = "未开启"
		elseif perType == GameUtil.afterTimePeriod then
			lockStr = string.format("%d.%d日 %d:%02d已结束", endDate.month, endDate.day, endDate.hour, endDate.min)
			floatStr = "已结束"
		end
	elseif not isPassThreadCond then
		local threadChapterId, threadStageId = data.unlockCondition[1], data.unlockCondition[2]
		local threadStageData = CopyConfig.instance:getStageById(threadChapterId, threadStageId)

		lockStr = string.format("通关【主线%s】解锁", threadStageData.stageName)
		floatStr = string.format("通关【主线%s】解锁", threadStageData.stageName)
	elseif not isPartPassPrePart then
		local prePartData = StorySummaryConfig.instance:getSsPartDataByPId(data.prePartId)

		lockStr = string.format("通关【%s】解锁", prePartData.partrName)
		floatStr = string.format("通关【%s】解锁", prePartData.partrName)
	end

	txtLock.text = lockStr

	GameUtil.SetActive(txtLockGo, not isPartUnlock)

	local isNeedRed = StorySummaryController.instance:isPartNeedRed(data.storyPlanId, data.partIdx)

	GameUtil.SetActive(redPoint, isNeedRed)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickPartCell, self, data.partId, floatStr, isPartUnlock))
end

function StorySummaryPartView:_clearPartCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")

	GameUtil.rmClickHandler(mainGo)
	uGuiUtil.clearImage(con)
end

function StorySummaryPartView:_onClickPartCell(partId, floatStr, isPartUnlock)
	if not string.nilorempty(floatStr) then
		FloatWordMgr.instance:show(floatStr)
	end

	if isPartUnlock then
		UIStateManager.instance:push(ViewName.StorySummaryChapterView, partId)
	end
end

return StorySummaryPartView
