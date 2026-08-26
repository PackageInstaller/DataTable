-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/interacts/Va3ChessInteractDestroyableTrap.lua

module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractDestroyableTrap", package.seeall)

local Va3ChessInteractDestroyableTrap = class("Va3ChessInteractDestroyableTrap", Va3ChessInteractBase)

function Va3ChessInteractDestroyableTrap:showStateView(objState, params)
	if objState == Va3ChessEnum.ObjState.Idle then
		self:showIdleStateView()
	elseif objState == Va3ChessEnum.ObjState.Interoperable then
		self:showInteroperableStateView(params)
	end
end

function Va3ChessInteractDestroyableTrap:showIdleStateView()
	local x, y = self._target.originData.posX, self._target.originData.posY

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmAreaOnXY, x, y, false)
end

function Va3ChessInteractDestroyableTrap:showInteroperableStateView(params)
	if params.objType == Va3ChessEnum.InteractType.Player then
		local x, y = self._target.originData.posX, self._target.originData.posY

		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmAreaOnXY, x, y, true)
	end
end

function Va3ChessInteractDestroyableTrap:playDeleteObjView()
	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.FireHurt)
end

function Va3ChessInteractDestroyableTrap:dispose()
	self:showIdleStateView()
	Va3ChessInteractDestroyableTrap.super.dispose(self)
end

return Va3ChessInteractDestroyableTrap
