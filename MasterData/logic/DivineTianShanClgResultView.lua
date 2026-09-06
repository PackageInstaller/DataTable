-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/view/DivineTianShanClgResultView.lua

module("logic.extensions.divinetianshanclg.view.DivineTianShanClgResultView", package.seeall)

local DivineTianShanClgResultView = class("DivineTianShanClgResultView", ViewComponent)

function DivineTianShanClgResultView:ctor()
	DivineTianShanClgResultView.super.ctor(self)
end

function DivineTianShanClgResultView:unbindEvents()
	DivineTianShanClgResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineTianShanClgResultView:bindEvents()
	DivineTianShanClgResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickClose, self)
end

function DivineTianShanClgResultView:buildUI()
	DivineTianShanClgResultView.super.buildUI(self)

	self._txtNum = self:getTxt("txtNum")
	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")

	local tableviewGo = self:getGo("Scrollerview")
	local cellGo = self:getGo("petItem")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableview:setCenterMode(true)
end

function DivineTianShanClgResultView:onExit()
	DivineTianShanClgResultView.super.onExit(self)
	self._tableview:dispose()
end

function DivineTianShanClgResultView:onEnter()
	DivineTianShanClgResultView.super.onEnter(self)

	local info = self:getFirstParam()

	if info then
		if not info.effectTimes then
			local num = 0

			self._txtNum.text = langPara("领域技能:%s", num)

			if info then
				if not info.lockRaceIds then
					local lockRaceIds = {}

					self._tableview:reloadData(lockRaceIds)
				end
			end
		end
	end
end

function DivineTianShanClgResultView:_onClickClose()
	self:close()
	BattleController.instance:endBattle()
end

function DivineTianShanClgResultView:_updateCell(view, cell, data)
	MaterialMgr.setCell(MatType.Pet, data, cell.gameObject)
end

function DivineTianShanClgResultView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return DivineTianShanClgResultView
