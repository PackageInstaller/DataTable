-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/plot/HandbookPlotLstView.lua

module("logic.extensions.playerinfo.view.handbook.plot.HandbookPlotLstView", package.seeall)

local M = class("HandbookPlotLstView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnReturn = self:getBtn("title_view_-878360263")
	self._txtTitle = self:getText("title_view_-788888785")
	self._bigBgBG = UIComponentType.ImageBigBG(self:getGo("handbook_memory_view_-1106683588"))
	self._goImgForPlotBg = self:getGo("handbook_memory_view_276426009")

	local goScroll = self:getGo("handbook_memory_view_-819743721")

	self._loopList = LoopListHelper.New(goScroll)

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._btnReturn = nil
	self._txtTitle = nil
	self._bigBgBG = nil
	self._goImgForPlotBg = nil
	self._cellItem = nil

	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()

	for _, cell in pairs(self._cellItem or {}) do
		cell.btn:RemoveClickListener()
	end
end

function M:onEnter()
	self._cellItem = {}

	self:setEvent(true)
	self:_tryReloadMsg()
	self:refreshEntryTab()
end

function M:onExit()
	self:setEvent(false)
	self._loopList:ClearCells()

	for _, cell in pairs(self._cellItem or {}) do
		cell.btn:RemoveClickListener()
	end

	self._cfg = nil

	self._bigBgBG:ClearImage()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.PLOT_END, self._handlePlotEnd, self)
	else
		GlobalDispatcher:removeEventListener(EventType.PLOT_END, self._handlePlotEnd, self)
	end
end

function M:_handlePlotEnd()
	goutil.setActive(self._goImgForPlotBg, false)
end

function M:updatePlotBg(res)
	local path = string.format("ui/bigbg/%s.png", res)

	self._bigBgBG:ClearImage()
	self._bigBgBG:SetImage(path, self._onImageLoaded, self)
end

function M:_onImageLoaded()
	return
end

function M:_tryReloadMsg()
	local info = self:getFirstParam()
	local id = info.id
	local page = info.page

	if info and info.id and info.page then
		local viewInfo = GalleryModel.instance:getPlayerInfoViewMsg()

		viewInfo.plotLstView = {
			id = id,
			page = page
		}

		GalleryModel.instance:setPlayerInfoViewMsg(viewInfo)
	end

	if id == nil then
		local viewInfo = GalleryModel.instance:getPlayerInfoViewMsg()

		id = viewInfo.plotLstView.id
		page = viewInfo.plotLstView.page
	end

	self._cfg = HandbookConfig.instance:getPlotTab(id, page)
	self._txtTitle.text = self._cfg.name

	self:updatePlotBg(self._cfg.bgRes)
end

function M:_onClickReturn()
	self:close()
end

function M:_onPlotItemClick(plotItemCell)
	if plotItemCell.isLock then
		printWarn(string.format("[%s] is Lock", plotItemCell.id))

		return
	end

	if GalleryModel.instance:getIsIdUnRead(GameEnum.UnlockTypeEnum.PlotMemory, plotItemCell.id) then
		HandbookController.instance:setHandbookTypIdRead(GameEnum.UnlockTypeEnum.PlotMemory, plotItemCell.id)
		goutil.setActive(plotItemCell.goNewSign, false)
	end

	local data = self._plotLst[plotItemCell.index]
	local plotIds = data.plot

	if plotIds and #plotIds > 0 then
		StoryMgr.instance:start(plotIds)
	end
end

function M:refreshEntryTab()
	self._plotLst = {}

	if self._cfg and self._cfg.plots and #self._cfg.plots > 0 then
		for _, galleryPlotId in ipairs(self._cfg.plots) do
			local cfgGalleryPlot = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryPlotMemory, galleryPlotId)

			if cfgGalleryPlot then
				table.insert(self._plotLst, cfgGalleryPlot)
			end
		end
	end

	self._loopList:SetListItemCount(#self._plotLst, true)
	self._loopList:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._plotLst[curIndex]
	local item = self._loopList:NewListViewItem("handbook_memory_item")
	local cell = self._cellItem[item.gameObject:GetInstanceID()]

	if not cell then
		cell = self:_addCellData(item)
		self._cellItem[item.gameObject:GetInstanceID()] = cell
	end

	local isLock = not GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.PlotMemory, data.id)
	local isNew = GalleryModel.instance:getIsIdUnRead(GameEnum.UnlockTypeEnum.PlotMemory, data.id)
	local isSelected = false

	cell.id = data.id
	cell.index = curIndex
	cell.isLock = isLock
	cell.txtName.text = data.name
	cell.txtSubName.text = data.subName

	if isLock then
		cell.txtLockCondition.text = data.unlockTips
	end

	cell.btn:AddClickListener(function()
		self:_onPlotItemClick(cell)
	end, self)
	goutil.setActive(cell.goNormal, not isLock)
	goutil.setActive(cell.goLock, isLock)
	goutil.setActive(cell.goNewSign, isNew)

	return item
end

function M:_addCellData(loopLstItem)
	local go = loopLstItem.gameObject
	local t = {
		btn = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject),
		goNormal = goutil.findChild(go, "normal").gameObject,
		goLock = goutil.findChild(go, "lock").gameObject,
		goNewSign = goutil.findChild(go, "newSign").gameObject,
		txtName = goutil.findChildTextComponent(go, "normal/txtName1"),
		txtSubName = goutil.findChildTextComponent(go, "normal/txtName2"),
		txtLockCondition = goutil.findChildTextComponent(go, "lock/txtCondition")
	}

	return t
end

return M
