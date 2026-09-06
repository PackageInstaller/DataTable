-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/controller/SeasonAutoFightController.lua

module("logic.extensions.season.controller.SeasonAutoFightController", package.seeall)

local SeasonAutoFightController = class("SeasonAutoFightController", BaseController)

function SeasonAutoFightController:ctor()
	SeasonAutoFightController.super.ctor(self)
end

function SeasonAutoFightController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.BattleSettlementAniPlayEnd, self._onBattleSettlementPlayEnd, self)
	self:onReset()
end

function SeasonAutoFightController:onReset()
	self._isAutoFight = false
	self._teamId = -1
	self._opType = -1
	self._targetGridX = -1
	self._targetGridY = -1
	self._nextClientGridX = -1
	self._nextClientGridY = -1

	removetimer(self._onTimer, self)
end

function SeasonAutoFightController:_onBattleSettlementPlayEnd()
	if self._isAutoFight then
		BattleController.instance:endBattle()
	end
end

function SeasonAutoFightController:onStartTimer()
	removetimer(self._onTimer, self)
	settimer(1, self._onTimer, self, false)
end

function SeasonAutoFightController:_onTimer()
	removetimer(self._onTimer, self)

	if self._isAutoFight and self._teamId > 0 then
		local teamMo = SeasonTeamsModel.instance:getTeam(self._teamId)
		local clientCurGridX, clientCurGridY = teamMo:getClientCurGridXY()

		self:tryGoContinueFight(clientCurGridX, clientCurGridY)
	end
end

function SeasonAutoFightController:startAutoFight(teamId, opType, gridX, gridY)
	self._isAutoFight = true
	self._teamId = teamId
	self._opType = opType
	self._targetGridX = gridX
	self._targetGridY = gridY
end

function SeasonAutoFightController:setNextTargetId(teamId, nextGridX, nextGridY)
	if self._teamId == teamId then
		self._nextClientGridX = nextGridX
		self._nextClientGridY = nextGridY
	end
end

function SeasonAutoFightController:stopAutoFight()
	if self._isAutoFight then
		TipsFacade.instance:openCommonTips(lang("当前地块事件无法自动行走，自动行走已停止"))
	end

	self._isAutoFight = false
	self._teamId = -1
	self._opType = -1
	self._targetGridX = -1
	self._targetGridY = -1
	self._nextClientGridX = -1
	self._nextClientGridY = -1
end

function SeasonAutoFightController:isAutoFight()
	return self._isAutoFight
end

function SeasonAutoFightController:tryGoContinueFight(nextPosX, nextPosY)
	if self._nextClientGridX == self._targetGridX and self._nextClientGridY == self._targetGridY then
		self:stopAutoFight()
	else
		SeasonOpHandler.instance:handle(self._opType, self._targetGridX, self._targetGridY)
	end
end

SeasonAutoFightController.instance = SeasonAutoFightController.New()

return SeasonAutoFightController
