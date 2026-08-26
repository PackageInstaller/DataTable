-- chunkname: @modules/logic/chessgame/config/ChessGameInteractField.lua

module("modules.logic.chessgame.config.ChessGameInteractField", package.seeall)

local ChessGameInteractField = _M

ChessGameInteractField.id = 1
ChessGameInteractField.groupId = 2
ChessGameInteractField.interactType = 3
ChessGameInteractField.x = 4
ChessGameInteractField.y = 5
ChessGameInteractField.dir = 6
ChessGameInteractField.path = 7
ChessGameInteractField.offset = nil
ChessGameInteractField.walkable = 9
ChessGameInteractField.show = 10
ChessGameInteractField.canMove = 11
ChessGameInteractField.touchTrigger = 12
ChessGameInteractField.specialData = 13
ChessGameInteractField.triggerDir = 14
ChessGameInteractField.effects = nil
ChessGameInteractField.iconType = 16

return ChessGameInteractField
