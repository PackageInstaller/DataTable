-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulBattleView.lua

module("logic.extensions.fusionsoul.view.FusionSoulBattleView", package.seeall)

local FusionSoulBattleView = class("FusionSoulBattleView", ViewComponent)

function FusionSoulBattleView:ctor()
	FusionSoulBattleView.super.ctor(self)
end

function FusionSoulBattleView:unbindEvents()
	FusionSoulBattleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function FusionSoulBattleView:bindEvents()
	FusionSoulBattleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function FusionSoulBattleView:buildUI()
	FusionSoulBattleView.super.buildUI(self)

	self._txtDesc = self:getTxt("txtDesc")
	self._txtTitle = self:getTxt("txtTitle")
	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableList:setCenterMode(true)
end

function FusionSoulBattleView:onExit()
	FusionSoulBattleView.super.onExit(self)
	self._tableList:dispose()
end

function FusionSoulBattleView:onEnter()
	FusionSoulBattleView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._zoneId = checknumber(params[2])

	local zoneInfo = FusionSoulModel.instance:getZoneInfo(self._activityId, self._zoneId)
	local eventCfg = FusionSoulConfig.instance:getEventCfg(self._activityId, self._zoneId, zoneInfo.eventId)

	self._txtTitle.text = eventCfg.name
	self._txtDesc.text = eventCfg.desc

	self._tableList:reloadData(eventCfg.gainClues)
	FusionSoulController.instance:setNewEvent(self._activityId, self._zoneId, zoneInfo.eventId)
end

function FusionSoulBattleView:_onClickSure()
	local zoneInfo = FusionSoulModel.instance:getZoneInfo(self._activityId, self._zoneId)

	FusionSoulController.instance:openMission(self._activityId, self._zoneId, zoneInfo.eventId)
	self:close()
end

function FusionSoulBattleView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local clueCfg = FusionSoulConfig.instance:getClueCfg(self._activityId, data)

	txtName.text = clueCfg.name
end

function FusionSoulBattleView:_clearCell(cell)
	return
end

return FusionSoulBattleView
