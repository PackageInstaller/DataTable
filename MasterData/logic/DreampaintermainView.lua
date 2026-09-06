-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/view/DreampaintermainView.lua

module("logic.extensions.dreampainter.view.DreampaintermainView", package.seeall)

local DreampaintermainView = class("DreampaintermainView", ViewComponent)
local TAB_VIEW = {
	ViewName.DreampainteradView,
	ViewName.DreampaintertuweiView,
	ViewName.DreampainterRankView,
	ViewName.DreampainterDispalyView,
	ViewName.DreampainterprizeView
}

function DreampaintermainView:ctor()
	DreampaintermainView.super.ctor(self)
end

function DreampaintermainView:unbindEvents()
	DreampaintermainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnHelp)
	GameUtil.rmClickHandler(self._btnBox)
end

function DreampaintermainView:bindEvents()
	DreampaintermainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnHelp, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnBox, self._onClickBox, self)
end

function DreampaintermainView:buildUI()
	DreampaintermainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnHelp = self:getGo("txtTitle/btnTip")
	self._btnBox = self:getGo("btnBox")
	self._container = self:getGo("container")
	self._txtTime = self:getTxt("time/txt")
	self._cell = self:getGo("cell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function DreampaintermainView:onExit()
	DreampaintermainView.super.onExit(self)
	self._scrollList:dispose()
end

function DreampaintermainView:onEnter()
	DreampaintermainView.super.onEnter(self)

	local activityId = DreamPainterConfig.instance:getCommonValue("CURR_ACTIVITY_ID", true)

	self._activityId = activityId

	local cfg = DreamPainterConfig.instance:getCfgById(self._activityId) or {}
	local list = DreamPainterConfig.instance:getPahseCfgById(self._activityId) or {}

	self._openIndex = #TAB_VIEW

	for i, v in ipairs(list) do
		if GameUtil.checkIsInTimePeriod(v.openDateTime, v.endDateTime) then
			self._openIndex = i

			break
		end
	end

	self._scrollList:reloadData(TAB_VIEW)
	self:_showView(self._openIndex)

	local activityType = math.floor(activityId / 1000)
	local start, over = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)
	local startTime, endTime = GameUtil.time2date(start), GameUtil.time2date(over)

	self._txtTime.text = string.format("活动时间: %s.%s %s:00 - %s.%s %s:00", startTime.month, startTime.day, startTime.hour, endTime.month, endTime.day, endTime.hour)

	self:_refreshUI()
	self.addGEvent(self, GlobalNotify.DreamPainterInfoUpdate, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.DreamPainterPageUpdate, self._refreshUI, self)
end

function DreampaintermainView:_refreshUI()
	self._scrollList:refresh()
end

function DreampaintermainView:_showView(idx)
	self._selectIdx = idx

	local viewName = TAB_VIEW[idx]

	self:showTabAt(self._container, viewName, self._activityId)
end

function DreampaintermainView:_updateCell(view, cell, data, tag)
	local select = goutil.findChild(cell, "select")
	local redPoint = goutil.findChild(cell, "redPoint")
	local txt = goutil.findChildTextComponent(cell, "txt")
	local idx = cell.data
	local cfg = DreamPainterConfig.instance:getPahseCfgByIdAndPid(self._activityId, idx)

	txt.text = (cfg == nil or string.nilorempty(cfg.tabName)) and lang("奖励预览") or cfg.tabName

	GameUtil.setUIImageSpriteIdx(select, self._selectIdx == idx and 1 or 0)

	if cell.data == self._openIndex then
		local id = DreamPainterConfig.instance:getCommonValue("RED_POINT_ID", true)

		GameUtil.SetActive(redPoint, RedPointModel.instance:isActive(id))
	else
		GameUtil.SetActive(redPoint, false)
	end

	GameUtil.addClickHandler(cell, function()
		if cfg then
			if GameUtil.checkIsInTimePeriod(cfg.openDateTime, cfg.endDateTime) then
				self:_showView(idx)
				self._scrollList:refresh()
			else
				TipsFacade.instance:openCommonTips(lang("不在开放时间内，暂时无法查看~"))
			end
		else
			self:_showView(idx)
			self._scrollList:refresh()
		end
	end)
end

function DreampaintermainView:clearCell(cell)
	return
end

function DreampaintermainView:_onClickHelp()
	TipsFacade.instance:openRulesView("dreampaintermainview_rule")
end

function DreampaintermainView:_onClickBox()
	local itemStr = DreamPainterConfig.instance:getCommonValue("MAIN_VIEW_ITEM")

	CommonTipsMgr.instance:openTipsByConfStr(self._btnBox, itemStr)
end

return DreampaintermainView
