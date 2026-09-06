-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmoyanclg/view/OrigindarkmoyanclgresultView.lua

module("logic.extensions.origindarkmoyanclg.view.OrigindarkmoyanclgresultView", package.seeall)

local OrigindarkmoyanclgresultView = class("OrigindarkmoyanclgresultView", ViewComponent)

function OrigindarkmoyanclgresultView:ctor()
	OrigindarkmoyanclgresultView.super.ctor(self)
end

function OrigindarkmoyanclgresultView:unbindEvents()
	OrigindarkmoyanclgresultView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function OrigindarkmoyanclgresultView:bindEvents()
	OrigindarkmoyanclgresultView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function OrigindarkmoyanclgresultView:buildUI()
	OrigindarkmoyanclgresultView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._btnCancel = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:setCenterMode(true)
end

function OrigindarkmoyanclgresultView:onExit()
	OrigindarkmoyanclgresultView.super.onExit(self)
	self._scrollerList:dispose()
end

function OrigindarkmoyanclgresultView:onEnter()
	OrigindarkmoyanclgresultView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._x = params[3]
	self._y = params[4]
	self._raceIds = params[5]
	self._raceId = 0

	self:_updateUI()
end

function OrigindarkmoyanclgresultView:_onClickbtnSure()
	if self._raceId <= 0 then
		FloatWordMgr.instance:show("请选择镇守的精灵")

		return
	end

	OriginDarkMoYanClgAgent.instance:sendPM_OriginDarkMoYanClgConfirmLockPetReq(self._activityId, self._stageId, self._x, self._y, true, self._raceId)
	BattleFacade.instance:endBattle()
end

function OrigindarkmoyanclgresultView:_onClickbtnCancel()
	OriginDarkMoYanClgAgent.instance:sendPM_OriginDarkMoYanClgConfirmLockPetReq(self._activityId, self._stageId, self._x, self._y, false, 0)
	BattleFacade.instance:endBattle()
end

function OrigindarkmoyanclgresultView:_updateUI()
	self._scrollerList:reloadData(self._raceIds)
end

function OrigindarkmoyanclgresultView:_updateCell(view, cell, raceId, tag)
	local goItem = goutil.findChild(cell.gameObject, "item")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local goBtn = goutil.findChild(cell.gameObject, "btn")

	GameUtil.SetActive(goSelect, self._raceId == raceId)
	GameUtil.addClickHandler(goBtn, function()
		self._raceId = raceId

		self._scrollerList:refresh()
	end)
	MaterialMgr.setCell(MatType.Pet, raceId, goItem)
end

function OrigindarkmoyanclgresultView:_clearCell(cell)
	local goItem = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(goItem)
end

return OrigindarkmoyanclgresultView
