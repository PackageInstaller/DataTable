-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/entity/TeamChessPlayerSoldierUnit.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.entity.TeamChessPlayerSoldierUnit", package.seeall)

local TeamChessPlayerSoldierUnit = class("TeamChessPlayerSoldierUnit", TeamChessSoldierUnit)

function TeamChessPlayerSoldierUnit:_onResLoaded()
	TeamChessPlayerSoldierUnit.super._onResLoaded(self)

	if gohelper.isNil(self._backGo) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_put)
	self:playAnimator("in")
	self:refreshMeshOrder()
	self:setActive(true)
	self:refreshShowModeState()
end

function TeamChessPlayerSoldierUnit:setOutlineActive(active)
	if gohelper.isNil(self._backOutLineGo) then
		return
	end

	gohelper.setActive(self._backOutLineGo.gameObject, active)
	TeamChessPlayerSoldierUnit.super.setOutlineActive(self, active)
end

function TeamChessPlayerSoldierUnit:setNormalActive(active)
	if gohelper.isNil(self._backGo) then
		return
	end

	gohelper.setActive(self._backGo.gameObject, active)
	TeamChessPlayerSoldierUnit.super.setNormalActive(self, active)
end

function TeamChessPlayerSoldierUnit:setGrayActive(active)
	if gohelper.isNil(self._backGrayGo) then
		return
	end

	gohelper.setActive(self._backGrayGo.gameObject, active)
	TeamChessPlayerSoldierUnit.super.setGrayActive(self, active)
end

function TeamChessPlayerSoldierUnit:onDrag(screenX, screenY)
	if not self._unitMo:canActiveMove() then
		return
	end

	self:cacheModel()
	self:setShowModeType()

	local unit = self._unitMo

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDrag, unit.soldierId, unit.uid, unit.stronghold, screenX, screenY)
end

function TeamChessPlayerSoldierUnit:onDragEnd(screenX, screenY)
	if not self._unitMo:canActiveMove() then
		return
	end

	self:restoreModel()

	local unit = self._unitMo

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDragEnd, unit.soldierId, unit.uid, unit.stronghold, screenX, screenY)
end

return TeamChessPlayerSoldierUnit
