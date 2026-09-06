-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityBuildShopTabView.lua

module("logic.extensions.eternalcity.view.EternalCityBuildShopTabView", package.seeall)

local EternalCityBuildShopTabView = class("EternalCityBuildShopTabView", ViewComponent)
local _curTabKey = 0

EternalCityBuildShopTabView.TabKey_Buy = "BUY"
EternalCityBuildShopTabView.TabKey_Sales = "SALES"

function EternalCityBuildShopTabView:buildUI()
	EternalCityBuildShopTabView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._contentCol = goutil.findChild(self.mainGO, "content")

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/scrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/scrCell")

	self._tabScrollerList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function EternalCityBuildShopTabView:bindEvents()
	EternalCityBuildShopTabView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function EternalCityBuildShopTabView:unbindEvents()
	EternalCityBuildShopTabView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function EternalCityBuildShopTabView:onEnter()
	EternalCityBuildShopTabView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local tabKey = params[2]
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("不在活动时间内")
		self:close()

		return
	end

	if not string.nilorempty(tabKey) then
		_curTabKey = tabKey
	end

	self:_onUpdate()
end

function EternalCityBuildShopTabView:onExit()
	EternalCityBuildShopTabView.super.onExit(self)
	self._tabScrollerList:dispose()
	self:_onClearTabAt()
end

function EternalCityBuildShopTabView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function EternalCityBuildShopTabView:_onUpdateData()
	self._tabDataList = {}

	if self._tabDataList then
		local data = {}

		data.tabKey = EternalCityBuildShopTabView.TabKey_Buy
		data.viewName = ViewName.EternalCityBuildShopBuyView
		data.tabName = "购买建筑"
		data.viewParams = {
			self._activityId
		}

		table.insert(self._tabDataList, data)
	end

	if self._tabDataList then
		local data = {}

		data.tabKey = EternalCityBuildShopTabView.TabKey_Sales
		data.viewName = ViewName.EternalCityBuildShopSalesView
		data.tabName = "出售建筑"
		data.viewParams = {
			self._activityId
		}

		table.insert(self._tabDataList, data)
	end

	local isFind = false

	for _, data in ipairs(self._tabDataList) do
		if data.tabKey == _curTabKey then
			isFind = true

			break
		end
	end

	if not isFind then
		local data = self._tabDataList[1]

		_curTabKey = data and data.tabKey
	end
end

function EternalCityBuildShopTabView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_showTabAt()
end

function EternalCityBuildShopTabView:_onUpdateTabColUI()
	self._tabScrollerList:reloadData(self._tabDataList)

	local index = 0

	for i, data in ipairs(self._tabDataList) do
		if data.tabKey == _curTabKey then
			index = i - 1

			break
		end
	end

	self._tabScrollerList:MoveCellToCenter(index)
end

function EternalCityBuildShopTabView:_updateTabCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.tabName

	GameUtil.setUIGroupIdx(mainGo, _curTabKey == data.tabKey and 1 or 0)
	GameUtil.addClickHandler(mainGo, function()
		_curTabKey = data.tabKey

		self:_onUpdateUI()
	end)
end

function EternalCityBuildShopTabView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function EternalCityBuildShopTabView:_showTabAt()
	local data

	for _, v in ipairs(self._tabDataList) do
		if v.tabKey == _curTabKey then
			data = v

			break
		end
	end

	if data == nil then
		return
	end

	if self._oldTabKey and self._oldTabKey == _curTabKey then
		return
	end

	self:_onClearTabAt()

	self._oldTabKey = _curTabKey

	if data.viewParams then
		self:showTabAt(self._contentCol, data.viewName, unpack(data.viewParams))
	else
		self:showTabAt(self._contentCol, data.viewName)
	end
end

function EternalCityBuildShopTabView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabKey = nil
end

return EternalCityBuildShopTabView
