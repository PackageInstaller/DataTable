-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/entity/TeamChessEnemySoldierUnit.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.entity.TeamChessEnemySoldierUnit", package.seeall)

local TeamChessEnemySoldierUnit = class("TeamChessEnemySoldierUnit", TeamChessSoldierUnit)

function TeamChessEnemySoldierUnit:_onResLoaded()
	TeamChessEnemySoldierUnit.super._onResLoaded(self)

	if gohelper.isNil(self._frontGo) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_put)
	self:refreshMeshOrder()
	self:playAnimator("in")
	self:setActive(true)
end

function TeamChessEnemySoldierUnit:setOutlineActive(active)
	if gohelper.isNil(self._frontOutLineGo) then
		return
	end

	gohelper.setActive(self._frontOutLineGo.gameObject, active)
	TeamChessEnemySoldierUnit.super.setOutlineActive(self, active)
end

function TeamChessEnemySoldierUnit:setNormalActive(active)
	if gohelper.isNil(self._frontGo) then
		return
	end

	gohelper.setActive(self._frontGo.gameObject, active)
	TeamChessEnemySoldierUnit.super.setNormalActive(self, active)
end

function TeamChessEnemySoldierUnit:setGrayActive(active)
	if gohelper.isNil(self._frontGrayGo) then
		return
	end

	gohelper.setActive(self._frontGrayGo.gameObject, active)
	TeamChessEnemySoldierUnit.super.setGrayActive(self, active)
end

return TeamChessEnemySoldierUnit
