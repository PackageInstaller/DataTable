-- chunkname: @modules/logic/partygame/rpc/PartyGameProto.lua

module("modules.logic.partygame.rpc.PartyGameProto", package.seeall)

local PartyGameProto = class("PartyGameProto")

PartyGameProto.KcpLoginCmd = 6
PartyGameProto.EnterPartyRequest = GamePartyModule.EnterPartyRequest
PartyGameProto.TransToGamePush = GamePartyModule.TransToGamePush
PartyGameProto.GamePlayer = GamePartyModule.GamePlayer
PartyGameProto.LoadGameFinishRequest = GamePartyModule.LoadGameFinishRequest
PartyGameProto.NewGameRequest = GamePartyModule.NewGameRequest
PartyGameProto.GameEndRequest = GamePartyModule.GameEndRequest
PartyGameProto.SelectCardRewardRequest = GamePartyModule.SelectCardRewardRequest

return PartyGameProto
