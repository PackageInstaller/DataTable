-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindragonnoah/view/OriginDragonNoahRulePopView.lua

module("logic.extensions.origindragonnoah.view.OriginDragonNoahRulePopView", package.seeall)

local OriginDragonNoahRulePopView = class("OriginDragonNoahRulePopView", ViewComponent)

function OriginDragonNoahRulePopView:ctor()
	OriginDragonNoahRulePopView.super.ctor(self)
end

function OriginDragonNoahRulePopView:unbindEvents()
	OriginDragonNoahRulePopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginDragonNoahRulePopView:bindEvents()
	OriginDragonNoahRulePopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function OriginDragonNoahRulePopView:buildUI()
	OriginDragonNoahRulePopView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._tableviewNoah = self:getGo("tableviewNoah")
	self._tablecellNoah = self:getGo("tableviewNoah/tablecellNoah")
	self._scrollListNoah = ScrollerList.create(self._tableviewNoah, self._tablecellNoah, GameUtil.handler(self._updateCellNoah, self), GameUtil.handler(self._clearCellNoah, self))
	self._tableviewAojiu = self:getGo("tableviewAojiu")
	self._tablecellAojiu = self:getGo("tableviewAojiu/tablecellAojiu")
	self._scrollListAojiu = ScrollerList.create(self._tableviewAojiu, self._tablecellAojiu, GameUtil.handler(self._updateCellAojiu, self), GameUtil.handler(self._clearCellAojiu, self))
end

function OriginDragonNoahRulePopView:onExit()
	OriginDragonNoahRulePopView.super.onExit(self)
	self._scrollListNoah:dispose()
	self._scrollListAojiu:dispose()
end

function OriginDragonNoahRulePopView:onEnter()
	OriginDragonNoahRulePopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 539001
	end

	self._actCfg = OriginDragonNoahConfig.instance:getActCfg(self._activityId)
	self._noahScorePlanList = OriginDragonNoahConfig.instance:getbuffRuleList(self._activityId, OriginDragonNoahController.BuffIdx.noah)
	self._aoJiuScorePlanList = OriginDragonNoahConfig.instance:getbuffRuleList(self._activityId, OriginDragonNoahController.BuffIdx.aoJiu)

	self._scrollListNoah:reloadData(self._noahScorePlanList)
	self._scrollListAojiu:reloadData(self._aoJiuScorePlanList)
end

function OriginDragonNoahRulePopView:_updateCellNoah(view, cell, data)
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local txtDistance = goutil.findChildTextComponent(cell, "txtDistance")

	txtArea.text = data.areaDesc
	txtDistance.text = string.format("前进<color=#3EB679>%d</color>米", data.score)
end

function OriginDragonNoahRulePopView:_clearCellNoah(cell)
	return
end

function OriginDragonNoahRulePopView:_updateCellAojiu(view, cell, data)
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local txtDistance = goutil.findChildTextComponent(cell, "txtDistance")

	txtArea.text = data.areaDesc
	txtDistance.text = string.format("前进<color=#3EB679>%d</color>米", data.score)
end

function OriginDragonNoahRulePopView:_clearCellAojiu(cell)
	return
end

return OriginDragonNoahRulePopView
