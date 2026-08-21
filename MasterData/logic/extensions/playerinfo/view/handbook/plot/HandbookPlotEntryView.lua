-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/plot/HandbookPlotEntryView.lua

module("logic.extensions.playerinfo.view.handbook.plot.HandbookPlotEntryView", package.seeall)

local M = class("HandbookPlotEntryView", ViewComponent)

M.SubToggleType = {
	Activity = 3,
	Plot = 1,
	OutOfChapter = 2
}

function M:ctor()
	M.super.ctor(self)
end

function M:getSubPageTyp()
	return CommEnum.HandBookSubView.Plot
end

function M:buildUI()
	self._btnReturn = self:getBtn("title_view_-878360263")
	self._btnPlot = self:getBtn("handbook_memory_entry_view_-1402625432")
	self._btnOutOfChapter = self:getBtn("handbook_memory_entry_view_-781136379")
	self._btnActivity = self:getBtn("handbook_memory_entry_view_-919727500")
	self._entryComp = {}
	self._entryComp[self.SubToggleType.Plot] = {
		rectTr = self:getUIComponent("handbook_memory_entry_view_-1402625432", UIComponentType.RectTransform),
		objNew = self:getGo("handbook_memory_entry_view_-1675849105"),
		objLock = self:getGo("handbook_memory_entry_view_2025904833"),
		txtLockCondition = self:getText("handbook_memory_entry_view_536761689")
	}
	self._entryComp[self.SubToggleType.OutOfChapter] = {
		rectTr = self:getUIComponent("handbook_memory_entry_view_-781136379", UIComponentType.RectTransform),
		objNew = self:getGo("handbook_memory_entry_view_-723775927"),
		objLock = self:getGo("handbook_memory_entry_view_-1075050885"),
		txtLockCondition = self:getText("handbook_memory_entry_view_-889301327")
	}
	self._entryComp[self.SubToggleType.Activity] = {
		rectTr = self:getUIComponent("handbook_memory_entry_view_-919727500", UIComponentType.RectTransform),
		objNew = self:getGo("handbook_memory_entry_view_-987675901"),
		objLock = self:getGo("handbook_memory_entry_view_-1822751983"),
		txtLockCondition = self:getText("handbook_memory_entry_view_-1686039399", UIComponentType.Text)
	}
	self._goScroll = self:getGo("handbook_memory_entry_view_-1015132403")
	self._loopList = LoopListHelper.New(self._goScroll)

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._btnReturn = nil
	self._btnPlot = nil
	self._btnOutOfChapter = nil
	self._btnActivity = nil
	self._entryComp = nil
	self._cellItem = nil
	self._goScroll = nil

	self._loopList:Dispose()

	self._loopList = nil
	self._passThroughInfo = nil
	self.TabPos = nil
	self._cellPosCache = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnPlot:AddClickListener(self._onClickPlot, self)
	self._btnOutOfChapter:AddClickListener(self._onClickOutOfChapter, self)
	self._btnActivity:AddClickListener(self._onClickActivity, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnPlot:RemoveClickListener()
	self._btnOutOfChapter:RemoveClickListener()
	self._btnActivity:RemoveClickListener()

	for _, cell in pairs(self._cellItem or {}) do
		cell.btn:RemoveClickListener()
	end
end

function M:onEnter()
	self:_setEvent(true)

	self._canTween = true
	self._cellItem = {}
	self._lockState = {}

	self:_setCurShowPlotTyp(nil)
	self:refreshLock()
	self:refreshNewTag()
	self:prepareData()
	settimer(0, self.getTabPos, self, false)
end

function M:onExit()
	self:_setEvent(false)

	self._lockState = nil

	self._loopList:ClearCells()

	for _, cell in pairs(self._cellItem or {}) do
		cell.btn:RemoveClickListener()
	end
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleUnReadInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleUnReadInfoChange, self)
	end
end

function M:_handleUnReadInfoChange(e)
	self:refreshNewTag()
	self:_refreshCurLoopLst(self:_getCurShowPlotTyp())
end

function M:_onClickReturn()
	if self:_getCurShowPlotTyp() then
		self:_hidePlotTabLst()

		return
	end

	self:close()
end

function M:_onClickChapter(id, page, isLock)
	if isLock then
		return
	end

	if not self._passThroughInfo then
		self._passThroughInfo = {}
	end

	self._passThroughInfo.id = id
	self._passThroughInfo.page = page

	ViewMgr.instance:open(ViewName.HandbookPlotLstView, self._passThroughInfo)
end

function M:_onClickPlot()
	local typ = self.SubToggleType.Plot

	if self:_getIsLock(typ) then
		return
	end

	self:_showPlotTabsLst(typ)
end

function M:_onClickOutOfChapter()
	local typ = self.SubToggleType.OutOfChapter

	if self:_getIsLock(typ) then
		return
	end

	self:_showPlotTabsLst(typ)
end

function M:_onClickActivity()
	local typ = self.SubToggleType.Activity

	if self:_getIsLock(typ) then
		return
	end

	self:_showPlotTabsLst(typ)
end

function M:getTabPos(typ)
	if not self.TabPos then
		self.TabPos = {}

		local x, y = Astral.TransformUtil.GetAnchoredPos(self._entryComp[self.SubToggleType.Plot].rectTr, 0, 0)

		self.TabPos[M.SubToggleType.Plot] = x
		x, y = Astral.TransformUtil.GetAnchoredPos(self._entryComp[self.SubToggleType.OutOfChapter].rectTr, 0, 0)
		self.TabPos[M.SubToggleType.OutOfChapter] = x
		x, y = Astral.TransformUtil.GetAnchoredPos(self._entryComp[self.SubToggleType.Activity].rectTr, 0, 0)
		self.TabPos[M.SubToggleType.Activity] = x
		self.TabPosY = y
	end

	return self.TabPos[typ]
end

function M:_showPlotTabsLst(typ)
	if not self._canTween then
		return
	end

	local curTabTyp = self:_getCurShowPlotTyp()

	if curTabTyp and curTabTyp == typ then
		self:_hidePlotTabLst()

		return
	end

	self._canTween = false

	self:_setCurShowPlotTyp(typ)

	local rectTr = self._entryComp[typ].rectTr

	rectTr:DOKill()

	if typ == self.SubToggleType.Plot then
		self:_onTweenShowFinish(rectTr, typ)
	else
		rectTr:DOAnchorPosX(self:getTabPos(1), 0.3):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
			self:_onTweenShowFinish(rectTr, typ)
		end, self)
	end

	for tabTyp, comp in pairs(self._entryComp) do
		local show = tabTyp == typ

		goutil.setActive(comp.rectTr.gameObject, show)
	end
end

function M:_onTweenShowFinish(rectTr, typ)
	RectTransformUtils.SetAnchoredPosition(rectTr, self:getTabPos(1), self.TabPosY)

	self._canTween = true

	self:_refreshCurLoopLst(typ)
end

function M:_refreshCurLoopLst(typ)
	local itemCount = self:getItemDataCount(typ)

	goutil.setActive(self._goScroll, true)
	self._loopList:SetListItemCount(itemCount, true)
	self._loopList:RefreshAllShownItem()
end

function M:_hidePlotTabLst()
	if not self._canTween then
		return
	end

	self._canTween = false

	local curTabTyp = self:_getCurShowPlotTyp()

	if curTabTyp then
		local rectTr = self._entryComp[curTabTyp].rectTr

		rectTr:DOKill()
		rectTr:DOAnchorPosX(self:getTabPos(curTabTyp), 0.3):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
			RectTransformUtils.SetAnchoredPosition(rectTr, self:getTabPos(curTabTyp), self.TabPosY)

			self._canTween = true
		end, self)
	else
		self._canTween = true
	end

	for tabTyp, comp in pairs(self._entryComp) do
		local tr = comp.rectTr

		goutil.setActive(tr.gameObject, true)
	end

	goutil.setActive(self._goScroll, false)
	self:_setCurShowPlotTyp(nil)
end

function M:_getCurShowPlotTyp()
	return self._curSelectTyp
end

function M:_setCurShowPlotTyp(typ)
	self._curSelectTyp = typ
end

function M:prepareData()
	self._dataGroup = {}

	for keyStr, valTyp in pairs(self.SubToggleType) do
		self._dataGroup[valTyp] = {}

		local cfgTabs = HandbookConfig.instance:getPlotTabs(valTyp)

		for page, cfg in ipairs(cfgTabs) do
			table.insert(self._dataGroup[valTyp], cfg)
		end
	end
end

function M:getItemDataCount(typ)
	local dataLst = self._dataGroup[typ]

	return dataLst and #dataLst or 0
end

function M:getItemData(index)
	local curTyp = self:_getCurShowPlotTyp()

	if self:getItemDataCount(curTyp) > 0 then
		return self._dataGroup[curTyp][index]
	end

	return nil
end

function M:refreshLock()
	for typVal, compGroup in pairs(self._entryComp) do
		local lock = self:_getIsLock(typVal)

		goutil.setActive(compGroup.objLock, lock)
	end
end

function M:refreshNewTag()
	for typVal, compGroup in pairs(self._entryComp) do
		local hasNew = self:_getIsNew(typVal)

		goutil.setActive(compGroup.objNew, hasNew)
	end
end

function M:_getIsLock(subToggleTyp)
	if not self._lockState[subToggleTyp] then
		self._lockState[subToggleTyp] = false

		if subToggleTyp == self.SubToggleType.Plot then
			-- block empty
		elseif subToggleTyp == self.SubToggleType.OutOfChapter then
			-- block empty
		elseif subToggleTyp == self.SubToggleType.Activity then
			-- block empty
		end
	end

	return self._lockState[subToggleTyp]
end

function M:_getIsNew(subToggleTyp)
	local count = 0
	local ids
	local unReadIdMap = GalleryModel.instance:getTypUnReadNewIds(GameEnum.UnlockTypeEnum.PlotMemory)

	if subToggleTyp == self.SubToggleType.Plot then
		ids = HandbookConfig.instance:getPlotIdsMemory()
	elseif subToggleTyp == self.SubToggleType.OutOfChapter then
		ids = HandbookConfig.instance:getPlotIdsOutOfChapter()
	elseif subToggleTyp == self.SubToggleType.Activity then
		ids = HandbookConfig.instance:getPlotIdsActivity()
	end

	for _, id in ipairs(ids or {}) do
		count = unReadIdMap[id] and count + 1 or count
	end

	return count > 0
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self:getItemData(curIndex)
	local prefabName = "handbook_memory_chapter_item"
	local item = self._loopList:NewListViewItem(prefabName)
	local cell = self._cellItem[item.gameObject:GetInstanceID()]

	if not cell then
		cell = self:_addCellData(item)
		self._cellItem[item.gameObject:GetInstanceID()] = cell
	end

	self:_fixCellItemPos(cell, curIndex)

	local isLock = true

	for _, id in ipairs(data.plots) do
		if GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.PlotMemory, id) then
			isLock = false

			break
		end
	end

	local isNew = false

	for _, id in ipairs(data.plots) do
		if GalleryModel.instance:getIsIdUnRead(GameEnum.UnlockTypeEnum.PlotMemory, id) then
			isNew = true

			break
		end
	end

	cell.txtName.text = data.name

	if isLock then
		cell.txtLockCondition.text = data.unlockTips
	end

	goutil.setActive(cell.goNormal, not isLock)
	goutil.setActive(cell.goLock, isLock)
	goutil.setActive(cell.goNewSign, isNew)
	cell.btn:AddClickListener(function()
		self:_onClickChapter(data.id, data.page, isLock)
	end, self)

	return item
end

function M:_addCellData(loopLstItem)
	local go = loopLstItem.gameObject
	local t = {
		btn = UIComponentType.ButtonAdapter(go),
		rectTr = goutil.findChildComponent(go, "content", UIComponentType.RectTransform),
		goNormal = goutil.findChild(go, "content/normal").gameObject,
		goLock = goutil.findChild(go, "content/lock").gameObject,
		goNewSign = goutil.findChild(go, "content/newSign").gameObject,
		goLine1 = goutil.findChild(go, "lineType1").gameObject,
		goLine2 = goutil.findChild(go, "lineType2").gameObject,
		txtName = goutil.findChildTextComponent(go, "content/normal/txtName"),
		txtLockCondition = goutil.findChildTextComponent(go, "content/lock/txtCondition")
	}

	return t
end

function M:_fixCellItemPos(comps, index)
	if not self._cellPosCache then
		self._cellPosCache = {}

		local rectTr1 = goutil.findChildComponent(comps.btn.gameObject, "content_pos_type1", UIComponentType.RectTransform)
		local x, y = Astral.TransformUtil.GetAnchoredPos(rectTr1, 0, 0)

		table.insert(self._cellPosCache, {
			x = x,
			y = y
		})

		local rectTr2 = goutil.findChildComponent(comps.btn.gameObject, "content_pos_type2", UIComponentType.RectTransform)

		x, y = Astral.TransformUtil.GetAnchoredPos(rectTr2, 0, 0)

		table.insert(self._cellPosCache, {
			x = x,
			y = y
		})
	end

	local up = index % 2 == 0

	goutil.setActive(comps.goLine1, not up)
	goutil.setActive(comps.goLine2, up)

	local pos = up and self._cellPosCache[2] or self._cellPosCache[1]

	if pos then
		Astral.TransformUtil.SetAnchoredPos(comps.rectTr, pos.x, pos.y)
	end
end

return M
