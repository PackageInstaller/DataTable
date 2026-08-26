-- chunkname: @modules/logic/chessgame/rpc/ChessGameRpc.lua

module("modules.logic.chessgame.rpc.ChessGameRpc", package.seeall)

local ChessGameRpc = class("ChessGameRpc", BaseRpc)

ChessGameRpc.instance = ChessGameRpc.New()

return ChessGameRpc
