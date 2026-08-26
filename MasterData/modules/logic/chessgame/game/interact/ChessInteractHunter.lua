-- chunkname: @modules/logic/chessgame/game/interact/ChessInteractHunter.lua

module("modules.logic.chessgame.game.interact.ChessInteractHunter", package.seeall)

local ChessInteractHunter = class("ChessInteractHunter", ChessInteractBase)

function ChessInteractHunter:onSelectCall()
	return
end

function ChessInteractHunter:onCancelSelect()
	return
end

function ChessInteractHunter:onSelectPos(x, y)
	return
end

function ChessInteractHunter:onAvatarLoaded()
	ChessInteractHunter.super.onAvatarLoaded(self)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetAlarmAreaVisible, {
		visible = true
	})
end

function ChessInteractHunter:onMoveBegin()
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetAlarmAreaVisible, {
		visible = false
	})
end

function ChessInteractHunter:onDrawAlert(map)
	local curX, curY = self._target.mo.posX, self._target.mo.posY

	map[curX] = map[curX] or {}
	map[curX][curY] = map[curX][curY] or {}

	table.insert(map[curX][curY], false)
end

function ChessInteractHunter:refreshAlarmArea()
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetAlarmAreaVisible, {
		visible = true
	})
end

function ChessInteractHunter:breakObstacle(obstacle, callback, callbackObj)
	local x, y = obstacle.mo:getXY()
	local posx = (self._target.mo.posX + x) / 2
	local posy = (self._target.mo.posY + y) / 2

	self:onMoveBegin()

	local function selfcallback()
		self:refreshAlarmArea()
		obstacle:getHandler():playBreakAnim(callback, callbackObj)
	end

	local function func()
		self.moveTo(self, self._target.mo.posX, self._target.mo.posY, selfcallback, self)
	end

	self.moveTo(self, posx, posy, func, self)
end

function ChessInteractHunter:moveTo(x, y, callback, callbackObj)
	ChessInteractHunter.super.moveTo(self, x, y, callback, callbackObj)
end

function ChessInteractHunter:setAlertActive(isActive)
	return
end

function ChessInteractHunter:dispose()
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetAlarmAreaVisible, {
		visible = false
	})
	ChessInteractHunter.super.dispose(self)
end

return ChessInteractHunter
