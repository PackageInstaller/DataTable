-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventTimelineView.lua

module("logic.extensions.jieshenevent.view.JieShenEventTimelineView", package.seeall)

local JieShenEventTimelineView = class("JieShenEventTimelineView", ViewComponent)
local contentPosList = {
	[0] = {
		x = 0,
		y = -127
	},
	{
		x = -2.5,
		y = 144
	}
}

function JieShenEventTimelineView:ctor()
	JieShenEventTimelineView.super.ctor(self)
end

function JieShenEventTimelineView:unbindEvents()
	JieShenEventTimelineView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
end

function JieShenEventTimelineView:bindEvents()
	JieShenEventTimelineView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function JieShenEventTimelineView:buildUI()
	JieShenEventTimelineView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._lineTableView = self:getGo("lineTableView")
	self._lineTableCell = self:getGo("lineTableCell")
	self._lineTableList = ScrollerList.create(self._lineTableView, self._lineTableCell, GameUtil.handler(self._updateLineCell, self), GameUtil.handler(self._clearLineCell, self))
	self._chipTableView = self:getGo("chipTableView")
	self._chipTableCell = self:getGo("chipTableCell")
	self._chipTableList = ScrollerList.create(self._chipTableView, self._chipTableCell, GameUtil.handler(self._updateChipCell, self), GameUtil.handler(self._clearChipCell, self))

	self._chipTableList:getView():RegisterDraggingCallback(nil, GameUtil.handler(self._onDragCellStart, self), nil, nil, nil, nil)
	self._chipTableList:getView():RegisterDragEndedCallback(self._onDragCellEnd, self)

	self._itemCell = self:getGo("itemCell")
	self._itemTableMap = {}
	self._btnRule = self:getGo("btnRule")
	self._txtEmpty = self:getTxt("clipInfo/txtEmpty")
end

function JieShenEventTimelineView:onExit()
	JieShenEventTimelineView.super.onExit(self)
	self._chipTableList:dispose()
	self._lineTableList:dispose()
end

function JieShenEventTimelineView:onEnter()
	JieShenEventTimelineView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_JieShenEvnetGainTimelinePrizeRes, self._refreshView, self)

	self._activityId = self:getFirstParam()

	self:_refreshView()
end

function JieShenEventTimelineView:_refreshView()
	local list = JieShenEventModel.instance:getTimelineSaveList(self._activityId)
	local timelineCfgs = JieShenEventConfig.instance:getTimelineCfgs(self._activityId)

	self._drag = false

	self._lineTableList:reloadData(timelineCfgs)
	self._chipTableList:reloadData(list)
	GameUtil.SetActive(self._txtEmpty, #list <= 0)

	local isGainAll = true

	for i, v in ipairs(timelineCfgs) do
		if not JieShenEventModel.instance:isTimelineGain(self._activityId, v.timelineId) then
			isGainAll = false

			break
		end
	end

	self._txtEmpty.text = isGainAll and lang("恭喜，已成功复原时间轴！") or lang("去寻访重要知情者，获取信息吧~")
end

function JieShenEventTimelineView:_updateLineCell(view, cell, data, tag)
	local go = cell.gameObject

	go.name = "lineCell_" .. data.timelineId

	local uiChangeGroup = go:GetComponent(ComponentType.UIChangeGroup)
	local content = goutil.findChild(go, "content")
	local txtTitle = goutil.findChildTextComponent(content, "txtTitle")
	local txtDesc = goutil.findChildTextComponent(content, "descTableview/viewport/content/txtDesc")
	local itemTableView = goutil.findChild(content, "itemTableView")
	local isUnlock = JieShenEventModel.instance:isTimelineGain(self._activityId, data.timelineId)

	txtTitle.text = not isUnlock and lang("？？？") or data.title
	txtDesc.text = not isUnlock and "" or data.desc

	local pos = contentPosList[data.timelineId % 2]

	GameUtil.setAnchoredPos(content, pos.x, pos.y)

	if itemTableView and self._itemCell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemTableMap[go] then
			local itemScrollList = ScrollerList.create(itemTableView, self._itemCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemTableMap[go] = self._itemTableMap[go]

			self._itemTableMap[go]:setCenterMode(true)
			self._itemTableMap[go]:reloadData(prizeStrArr)
			self._itemTableMap[go]:dragNotifyParent()
		end
	end

	GameUtil.SetActive(itemTableView, not isUnlock)

	if isUnlock then
		uiChangeGroup:SetState(0)
	else
		uiChangeGroup:SetState(1)
	end
end

function JieShenEventTimelineView:_clearLineCell(cell)
	local go = cell.gameObject
	local itemScrollList = self._itemTableMap[go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemTableMap[go] = nil
	end
end

function JieShenEventTimelineView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function JieShenEventTimelineView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function JieShenEventTimelineView:_updateChipCell(view, cell, data, tag)
	local go = cell.gameObject

	go.name = "chipCell_" .. data

	local txtTitle = goutil.findChildTextComponent(go, "txtTitle")
	local cfg = JieShenEventConfig.instance:getTimelineCfg(self._activityId, data)

	txtTitle.text = cfg.title

	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		if not self._drag then
			self:_onClickChip(data)
		end
	end, self)
end

function JieShenEventTimelineView:_clearChipCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function JieShenEventTimelineView:_onDragCellStart(startContainer, cell)
	cell.gameObject.transform:SetParent(self.mainGO.transform)

	self._drag = true
end

function JieShenEventTimelineView:_onDragCellEnd(startContainer, cell, endContainer)
	if endContainer then
		local cellNameStrArr = string.split(cell.name, "_")
		local lineGoStrArr = string.split(endContainer.name, "_")
		local clipId = checknumber(cellNameStrArr[2])
		local timelineId = checknumber(lineGoStrArr[2])

		if clipId == timelineId then
			JieShenEventAgent.instance:sendPM_JieShenEvnetGainTimelinePrizeReq(self._activityId, timelineId)
		else
			local list = JieShenEventModel.instance:getTimelineSaveList(self._activityId)

			self._chipTableList:reloadData(list)
			FloatWordMgr.instance:show(lang("不是正确的位置"))
			self:showShakeEffect(timelineId)
		end
	else
		local list = JieShenEventModel.instance:getTimelineSaveList(self._activityId)

		self._chipTableList:reloadData(list)
	end

	self._drag = false

	return true
end

function JieShenEventTimelineView:_onClickChip(chipId)
	UIStateManager.instance:push(ViewName.JieShenEventTimelineTipsView, self._activityId, chipId)
end

function JieShenEventTimelineView:_onClickRule()
	TipsFacade.instance:openRulesView("jie_shen_event_rule")
end

function JieShenEventTimelineView:showShakeEffect(timelineId)
	local timelineGo = self._lineTableList:getView():GetCellAtIndex(timelineId - 1)

	if timelineGo then
		local content = goutil.findChild(timelineGo, "content")

		content.transform:DOShakePosition(0.3, Vector3.New(20, 0, 0), 3, 90)
	end
end

return JieShenEventTimelineView
