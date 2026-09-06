-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindishitian/view/OriginDiShiTianResultView.lua

module("logic.extensions.origindishitian.view.OriginDiShiTianResultView", package.seeall)

local OriginDiShiTianResultView = class("OriginDiShiTianResultView", ViewComponent)

function OriginDiShiTianResultView:ctor()
	OriginDiShiTianResultView.super.ctor(self)
end

function OriginDiShiTianResultView:unbindEvents()
	OriginDiShiTianResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function OriginDiShiTianResultView:bindEvents()
	OriginDiShiTianResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function OriginDiShiTianResultView:buildUI()
	OriginDiShiTianResultView.super.buildUI(self)

	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._tableList:setCenterMode(true)

	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")
	self._empty = self:getGo("empty")
end

function OriginDiShiTianResultView:onExit()
	OriginDiShiTianResultView.super.onExit(self)
end

function OriginDiShiTianResultView:onEnter()
	OriginDiShiTianResultView.super.onEnter(self)

	self._resultInfo = OriginDiShiTianModel.instance:getTempBattleResult()

	if not self._resultInfo.lockPetRaceIds then
		local list = {}

		self._tableList:reloadData(list)
		GameUtil.SetActive(self._empty, #list <= 0)
	end
end

function OriginDiShiTianResultView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCell(MatType.Pet, data, go)
end

function OriginDiShiTianResultView:_clearPetCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function OriginDiShiTianResultView:_onClickSure()
	OriginDiShiTianClgAgent.instance:sendPM_OriginDiShiTianClgConfirmReq(self._resultInfo.activityId, self._resultInfo.stageId, true)
	BattleController.instance:endBattle()
end

function OriginDiShiTianResultView:_onClickCancel()
	OriginDiShiTianClgAgent.instance:sendPM_OriginDiShiTianClgConfirmReq(self._resultInfo.activityId, self._resultInfo.stageId, false)
	BattleController.instance:endBattle()
end

return OriginDiShiTianResultView
