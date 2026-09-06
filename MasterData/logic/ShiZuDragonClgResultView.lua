-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shizudragonclg/view/ShiZuDragonClgResultView.lua

module("logic.extensions.shizudragonclg.view.ShiZuDragonClgResultView", package.seeall)

local ShiZuDragonClgResultView = class("ShiZuDragonClgResultView", ViewComponent)

function ShiZuDragonClgResultView:ctor()
	ShiZuDragonClgResultView.super.ctor(self)
end

function ShiZuDragonClgResultView:unbindEvents()
	ShiZuDragonClgResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function ShiZuDragonClgResultView:bindEvents()
	ShiZuDragonClgResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function ShiZuDragonClgResultView:buildUI()
	ShiZuDragonClgResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtType = self:getTxt("txtType")
	self._txtTypeNum = self:getTxt("txtTypeNum")
	self._txtScore = self:getTxt("txtScore")
end

function ShiZuDragonClgResultView:onExit()
	ShiZuDragonClgResultView.super.onExit(self)
end

function ShiZuDragonClgResultView:onEnter()
	ShiZuDragonClgResultView.super.onEnter(self)

	self._info = ShiZuDragonClgModel.instance:getClgTempInfo()

	local phaseCfg = ShiZuDragonClgConfig.instance:getPhaseCfg(self._info.activityId, self._info.phaseId)

	self._txtType.text = phaseCfg.typeName
	self._txtTypeNum.text = self._info.buffNum or 0
	self._txtScore.text = self._info.num or 0
end

function ShiZuDragonClgResultView:_onClickSure()
	self:close()
	BattleController.instance:endBattle()
end

return ShiZuDragonClgResultView
