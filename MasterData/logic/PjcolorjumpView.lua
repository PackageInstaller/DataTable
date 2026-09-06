-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/baioogamescommunity/view/PjcolorjumpView.lua

module("logic.extensions.baioogamescommunity.view.PjcolorjumpView", package.seeall)

local PjcolorjumpView = class("PjcolorjumpView", ViewComponent)

function PjcolorjumpView:ctor()
	PjcolorjumpView.super.ctor(self)
end

function PjcolorjumpView:unbindEvents()
	PjcolorjumpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGo)
end

function PjcolorjumpView:bindEvents()
	PjcolorjumpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGo, self._onClickGo, self)
end

function PjcolorjumpView:buildUI()
	PjcolorjumpView.super.buildUI(self)

	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._btnGo = self:getGo("btnGo")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)

	self._img2 = self:getGo("btnGo/img2")
	self._img1 = self:getGo("btnGo/img1")
end

function PjcolorjumpView:onExit()
	PjcolorjumpView.super.onExit(self)
	self._scrollList:dispose()
end

function PjcolorjumpView:onEnter()
	PjcolorjumpView.super.onEnter(self)
	self:_refreshUI()
end

function PjcolorjumpView:_refreshUI()
	local str = "1004:1454:1#4:97057:1#4:41004:1#4:90121:1"
	local list = string.split(str, "#")

	self._scrollList:reloadData(list)
	GameUtil.SetActive(self._img1, false)
	GameUtil.SetActive(self._img2, false)

	if GameUtil.checkIsInTimePeriod("2026-04-28 11:00", "2037-12-30 00:00") then
		GameUtil.SetActive(self._img1, true)
	else
		GameUtil.SetActive(self._img2, true)
	end
end

function PjcolorjumpView:_updateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell)
end

function PjcolorjumpView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

function PjcolorjumpView:_onClickGo(cell)
	if GameUtil.checkIsInTimePeriod("2026-04-28 11:00", "2037-12-30 00:00") then
		local url = "http://act.baioogames.com/color/20260428-together/?fromAct=aqsy_banner"

		UnityEngine.Application.OpenURL(url)
	else
		TipsFacade.instance:openCommonTips(lang("活动将于4月28日11点开启哦~"))
	end
end

return PjcolorjumpView
