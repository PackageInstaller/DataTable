-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/view/WisdomCourageClgMainView.lua

module("logic.extensions.wisdomcourageclg.view.WisdomCourageClgMainView", package.seeall)

local WisdomCourageClgMainView = class("WisdomCourageClgMainView", ViewComponent)
local _curTabIdx = 0

function WisdomCourageClgMainView:buildUI()
	WisdomCourageClgMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")

	local tabScrView = self:getGo("tabCol/scrView")
	local tabScrCell = self:getGo("tabCol/scrCell")

	self._contentCol = self:getGo("contentCol")
	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function WisdomCourageClgMainView:bindEvents()
	WisdomCourageClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function WisdomCourageClgMainView:unbindEvents()
	WisdomCourageClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function WisdomCourageClgMainView:onEnter()
	WisdomCourageClgMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = WisdomCourageClgController.instance:getActivityId()
	end

	local isInTime = WisdomCourageClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = WisdomCourageClgConfig.instance:getActData(self._activityId)

	self:_onUpdate()
end

function WisdomCourageClgMainView:onExit()
	WisdomCourageClgMainView.super.onExit(self)
	self._tabScrollList:dispose()
	self:_onClearTabAt()
end

function WisdomCourageClgMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function WisdomCourageClgMainView:_onUpdateData()
	self:_updateTabData()
end

function WisdomCourageClgMainView:_onUpdateUI()
	self:_updateTabScrollerList()
	self:_showTabAt()
end

function WisdomCourageClgMainView:_updateTabData()
	self._tabDataList = {}

	if self._activityId > 0 then
		local data = {}

		data.viewName = ViewName.WisdomCourageClgBossView
		data.tabName = "勇气历练"
		data.viewParams = {
			self._activityId
		}

		table.insert(self._tabDataList, data)
	end

	if self._activityId > 0 then
		local data = {}

		data.viewName = ViewName.WisdomCourageClgSupportView
		data.tabName = "智慧历练"
		data.viewParams = {
			self._activityId
		}

		table.insert(self._tabDataList, data)
	end

	_curTabIdx = Mathf.Max(_curTabIdx, 1)
	_curTabIdx = Mathf.Min(_curTabIdx, #self._tabDataList)
end

function WisdomCourageClgMainView:_updateTabScrollerList()
	self._tabScrollList:reloadData(self._tabDataList)
end

function WisdomCourageClgMainView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")

	txtName.text = data.tabName

	GameUtil.SetActive(imgSelect, _curTabIdx == tabIdx)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, tabIdx))
end

function WisdomCourageClgMainView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function WisdomCourageClgMainView:_onClickTab(data, idx)
	_curTabIdx = idx

	self:_onUpdateUI()
end

function WisdomCourageClgMainView:_showTabAt()
	local data = self._tabDataList[_curTabIdx]

	if data == nil then
		return
	end

	if self._oldTabIdx and self._oldTabIdx == _curTabIdx then
		return
	end

	self:_onClearTabAt()

	self._oldTabIdx = _curTabIdx

	if data.viewParams then
		self:showTabAt(self._contentCol, data.viewName, unpack(data.viewParams))
	else
		self:showTabAt(self._contentCol, data.viewName)
	end
end

function WisdomCourageClgMainView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabIdx = nil
end

function WisdomCourageClgMainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(self._actData.ruleKeyMain)
end

return WisdomCourageClgMainView
