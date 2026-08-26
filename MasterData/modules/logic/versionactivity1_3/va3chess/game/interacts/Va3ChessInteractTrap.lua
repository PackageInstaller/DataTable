-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/interacts/Va3ChessInteractTrap.lua

module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractTrap", package.seeall)

local Va3ChessInteractTrap = class("Va3ChessInteractTrap", Va3ChessInteractBase)

function Va3ChessInteractTrap:showStateView(objState, params)
	if objState == Va3ChessEnum.ObjState.Idle then
		self:showIdleStateView()
	elseif objState == Va3ChessEnum.ObjState.Interoperable then
		self:showInteroperableStateView(params)
	end
end

function Va3ChessInteractTrap:showIdleStateView()
	local x, y = self._target.originData.posX, self._target.originData.posY

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmAreaOnXY, x, y, false)
end

function Va3ChessInteractTrap:showInteroperableStateView(params)
	if params.objType == Va3ChessEnum.InteractType.Player then
		local x, y = self._target.originData.posX, self._target.originData.posY

		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmAreaOnXY, x, y, true)
	end
end

function Va3ChessInteractTrap:playDeleteObjView()
	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.DeductHp)
end

function Va3ChessInteractTrap:dispose()
	self:showIdleStateView()
	Va3ChessInteractTrap.super.dispose(self)
end

return Va3ChessInteractTrap
