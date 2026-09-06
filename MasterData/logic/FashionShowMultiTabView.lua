-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/FashionShowMultiTabView.lua

module("logic.extensions.dressactivityshop.view.FashionShowMultiTabView", package.seeall)

local FashionShowMultiTabView = class("FashionShowMultiTabView", ViewComponent)

function FashionShowMultiTabView:ctor()
	FashionShowMultiTabView.super.ctor(self)
end

function FashionShowMultiTabView:buildUI()
	FashionShowMultiTabView.super.buildUI(self)

	self._bg = goutil.findChild(self.mainGO, "bg")
	self._btnClose = goutil.findChild(self.mainGO, "btnClose")

	local scrollerview = goutil.findChild(self.mainGO, "tabCol/scrollerview")
	local scrollercell = goutil.findChild(self.mainGO, "tabCol/scrollercell")
	local updateCellCallBack, clearCellCallBack = GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self)

	self._tabScrollList = ScrollerList.create(scrollerview, scrollercell, updateCellCallBack, clearCellCallBack)
	self._root = goutil.findChild(self.mainGO, "root")
end

function FashionShowMultiTabView:bindEvents()
	FashionShowMultiTabView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
end

function FashionShowMultiTabView:unbindEvents()
	FashionShowMultiTabView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FashionShowMultiTabView:destroyUI()
	FashionShowMultiTabView.super.destroyUI(self)
end

function FashionShowMultiTabView:onEnter()
	FashionShowMultiTabView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._curTabIdx = params[1] or 1

	self:_setRootContentCfg()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onUpdateUI, self)
	self:_onUpdateUI()
end

function FashionShowMultiTabView:onExit()
	FashionShowMultiTabView.super.onExit(self)
	self._tabScrollList:dispose()
	self:showTabAt(self._root, "")
end

function FashionShowMultiTabView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTabScroller()
	self:_onUpdateRootContent()
end

function FashionShowMultiTabView:_onUpdatePlaneUI()
	return
end

function FashionShowMultiTabView:_onUpdateTabScroller()
	local dataList = {}

	for _, cfg in ipairs(self._rootCtCfgs) do
		local isInTime = ActivityDefineController.instance:isInActivityTimeById(cfg.activityType, cfg.activityId)

		if isInTime then
			table.insert(dataList, cfg.data)
		end
	end

	self._tabScrollList:reloadData(dataList)
end

function FashionShowMultiTabView:_updateTabCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local index = cell.index + 1
	local select = goutil.findChild(mainGo, "select")

	GameUtil.SetActive(select, index == self._curTabIdx)

	local isNeedBg = not string.nilorempty(data.bgPath) and mainGo

	if isNeedBg then
		local bgUrl = GameUrl.getBigbgPngUrl(data.bgPath)

		uGuiUtil.setSpriteToImage(mainGo, uGuiUtil.SpriteType.BigBg, bgUrl)
	end

	local handler = GameUtil.handler(self._onClickBtnTab, self, data, index)

	GameUtil.addClickHandler(mainGo, handler)
end

function FashionShowMultiTabView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	uGuiUtil.clearImage(mainGo)
end

function FashionShowMultiTabView:_onClickBtnTab(data, index)
	self._curTabIdx = index

	self:_onUpdateUI()
end

function FashionShowMultiTabView:_onUpdateRootContent()
	local rootCtCfg = self._rootCtCfgs[self._curTabIdx]
	local viewName = rootCtCfg.viewName
	local params = rootCtCfg.params
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(rootCtCfg.activityType, rootCtCfg.activityId)

	if not isInTime then
		self:showTabAt(self._root, "")
		self:_onUpdateUI()
	end

	self:showTabAt(self._root, viewName, unpack(params))
end

function FashionShowMultiTabView:_onClickBtnClose()
	self:close()
end

function FashionShowMultiTabView:_setRootContentCfg()
	self._rootCtCfgs = {
		{
			activityId = 120001,
			viewName = ViewName.FashionShowSkinSaleGodGemTabView,
			params = {},
			data = {
				bgPath = "bgskin/btn_pfhd_24"
			},
			activityType = GameEnum.ActivityType.DressActivityShopGodGem
		},
		{
			activityId = 27009,
			viewName = ViewName.FashionShowSkinSaleTabView,
			params = {},
			data = {
				bgPath = "bgskin/btn_pfhd_25"
			},
			activityType = GameEnum.ActivityType.DressActivityShop
		}
	}
end

return FashionShowMultiTabView
