-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/view/DivineFarnasNorFightEndView.lua

module("logic.extensions.divinefarnas.view.DivineFarnasNorFightEndView", package.seeall)

local DivineFarnasNorFightEndView = class("DivineFarnasNorFightEndView", ViewComponent)

function DivineFarnasNorFightEndView:ctor()
	DivineFarnasNorFightEndView.super.ctor(self)
end

function DivineFarnasNorFightEndView:unbindEvents()
	DivineFarnasNorFightEndView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineFarnasNorFightEndView:bindEvents()
	DivineFarnasNorFightEndView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function DivineFarnasNorFightEndView:buildUI()
	DivineFarnasNorFightEndView.super.buildUI(self)

	self._txtNum = self:getTxt("txtNum")
	self._txtHighNum = self:getTxt("txtHighNum")
	self._btnSure = self:getGo("btnSure")
end

function DivineFarnasNorFightEndView:onExit()
	DivineFarnasNorFightEndView.super.onExit(self)
end

function DivineFarnasNorFightEndView:onEnter()
	DivineFarnasNorFightEndView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local msg = GameUtil.pbToTable(params[1])

	self._curDodgeTimes = msg.curDodgeTimes
	self._todayMaxDodgeTimes = msg.todayMaxDodgeTimes

	self:_onSetUI()
end

function DivineFarnasNorFightEndView:_onSetUI()
	self._txtNum.text = self._curDodgeTimes
	self._txtHighNum.text = self._todayMaxDodgeTimes
end

function DivineFarnasNorFightEndView:_onClickBtnSure()
	BattleController.instance:endBattle()
end

return DivineFarnasNorFightEndView
