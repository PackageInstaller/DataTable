-- chunkname: @modules/logic/chessgame/controller/ChessGameJumpHandler.lua

module("modules.logic.chessgame.controller.ChessGameJumpHandler", package.seeall)

local ChessGameJumpHandler = class("ChessGameJumpHandler")

function ChessGameJumpHandler.defaultJump()
	MainController.instance:enterMainScene()
end

return ChessGameJumpHandler
