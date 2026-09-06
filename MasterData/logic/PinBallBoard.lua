-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallBoard.lua

module("logic.extensions.pinball.view.PinBallBoard", package.seeall)

local PinBallBoard = class("PinBallBoard")

function PinBallBoard:ctor()
	self._boardGo = nil
	self._boardDragGo = nil
	self._data = {}
	self._rightUpPoint = Vector2.New(0, 0)
	self._rightDownpPoint = Vector2.New(0, 0)
	self._leftUpPoint = Vector2.New(0, 0)
	self._leftDownPoint = Vector2.New(0, 0)
end

function PinBallBoard:init(boardGo, boardDragGo, x, y, width, height)
	self._boardGo = boardGo
	self._boardDragGo = boardDragGo
	self._posX = x
	self._posY = y
	self._width = width
	self._height = height
	self._boardTop = y + self._height / 2
	self._boardBottom = y - self._height / 2

	GameUtil.setWidth(self._boardGo, self._width)
	GameUtil.setWidth(self._boardDragGo, self._width + 50)
	GameUtil.setHeight(self._boardGo, self._height)
	GameUtil.setHeight(self._boardDragGo, self._height + 50)
	GameUtil.setLocalPos(self._boardGo, self._posX, self._posY)
	GameUtil.setLocalPos(self._boardDragGo, self._posX, self._posY)
end

function PinBallBoard:getBoardData()
	self._data.posX = self._posX
	self._data.posY = self._posY
	self._data.width = self._width
	self._data.height = self._height
	self._data.topY = self._boardTop
	self._data.bottomY = self._boardBottom

	return self._data
end

function PinBallBoard:getBoardRoundPos()
	local midWidth = self._width / 2
	local midHeight = self._height / 2

	self._rightUpPoint.x = self._posX + midWidth
	self._rightUpPoint.y = self._posY + midHeight
	self._leftUpPoint.x = self._posX - midWidth
	self._leftUpPoint.y = self._posY + midHeight
	self._rightDownpPoint.x = self._posX + midWidth
	self._rightDownpPoint.y = self._posY - midHeight
	self._leftDownPoint.x = self._posX - midWidth
	self._leftDownPoint.y = self._posY - midHeight

	return self._rightUpPoint, self._rightDownpPoint, self._leftUpPoint, self._leftDownPoint
end

function PinBallBoard:setBoardPos(x, y)
	self._posX = x
	self._posY = y
end

function PinBallBoard:addBoardLen(len)
	self._width = self._width + len

	GameUtil.setWidth(self._boardGo, self._width)
	GameUtil.setWidth(self._boardDragGo, self._width + 50)
end

return PinBallBoard
