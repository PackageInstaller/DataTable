-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/interacts/Va3ChessInteractBoltLauncher.lua

module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractBoltLauncher", package.seeall)

local Va3ChessInteractBoltLauncher = class("Va3ChessInteractBoltLauncher", Va3ChessInteractBase)

function Va3ChessInteractBoltLauncher:init(targetObj)
	Va3ChessInteractBoltLauncher.super.init(self, targetObj)

	self._enableAlarm = true
end

function Va3ChessInteractBoltLauncher:onDrawAlert(map)
	if not self._enableAlarm then
		return
	end

	local dir = self._target.originData:getDirection()

	if not dir then
		return
	end

	local beginPos, endPos
	local w, h = Va3ChessGameModel.instance:getGameSize()
	local curX, curY = self._target.originData.posX, self._target.originData.posY
	local isUp = dir == Va3ChessEnum.Direction.Up
	local isDown = dir == Va3ChessEnum.Direction.Down
	local isRight = dir == Va3ChessEnum.Direction.Right

	if isUp or isDown then
		beginPos = isUp and curY + 1 or 0
		endPos = isUp and h - 1 or curY - 1
	else
		beginPos = isRight and curX + 1 or 0
		endPos = isRight and w - 1 or curX - 1
	end

	if beginPos < 0 or endPos < 0 then
		return
	end

	if endPos < beginPos then
		logError(string.format("Va3ChessInteractBoltLauncher:onDrawAlert target error,interactId:%s beginPos:%s endPos:%s", self._target.id, beginPos, endPos))

		return
	end

	if isUp or isDown then
		for y = beginPos, endPos do
			local showDirLine = {
				Va3ChessEnum.Direction.Left,
				Va3ChessEnum.Direction.Right
			}

			if y == beginPos then
				table.insert(showDirLine, Va3ChessEnum.Direction.Down)
			elseif y == endPos then
				table.insert(showDirLine, Va3ChessEnum.Direction.Up)
			end

			self:_insertToAlertMap(map, curX, y, showDirLine)
		end
	else
		for x = beginPos, endPos do
			local showDirLine = {
				Va3ChessEnum.Direction.Up,
				Va3ChessEnum.Direction.Down
			}

			if x == beginPos then
				table.insert(showDirLine, Va3ChessEnum.Direction.Left)
			elseif x == endPos then
				table.insert(showDirLine, Va3ChessEnum.Direction.Right)
			end

			self:_insertToAlertMap(map, x, curY, showDirLine)
		end
	end
end

function Va3ChessInteractBoltLauncher:_insertToAlertMap(map, x, y, showDirLine)
	if Va3ChessGameModel.instance:isPosInChessBoard(x, y) and Va3ChessGameModel.instance:getBaseTile(x, y) ~= Va3ChessEnum.TileBaseType.None then
		map[x] = map[x] or {}
		map[x][y] = map[x][y] or {}

		table.insert(map[x][y], {
			isStatic = true,
			resPath = Va3ChessEnum.SceneResPath.AlarmItem2,
			showDirLine = showDirLine
		})
	end
end

function Va3ChessInteractBoltLauncher:onAvatarLoaded()
	Va3ChessInteractBoltLauncher.super.onAvatarLoaded(self)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function Va3ChessInteractBoltLauncher:dispose()
	self._enableAlarm = false

	Va3ChessInteractBoltLauncher.super.dispose(self)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

return Va3ChessInteractBoltLauncher
