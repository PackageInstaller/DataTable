-- chunkname: @modules/logic/fight/rpc/FightToolRpc.lua

module("modules.logic.fight.rpc.FightToolRpc", package.seeall)

local FightToolRpc = class("FightToolRpc", BaseRpc)

function FightToolRpc:sendEnterCustomFightRequest()
	local req = FightToolModule_pb.EnterCustomFightRequest()

	self:sendMsg(req)
end

function FightToolRpc:onReceiveEnterCustomFightReply(resultCode, msg)
	if resultCode == 0 then
		if not msg:HasField("startDungeonReply") then
			GameFacade.showToastString("success")

			return
		end

		FightPlayBackController.instance:startRecordFightData(msg.startDungeonReply)

		local fightData = FightData.New(msg.startDungeonReply.fight)

		DungeonModel.instance.curSendEpisodeId = fightData.episodeId

		local episodeConfig = DungeonConfig.instance:getEpisodeCO(fightData.episodeId)

		DungeonModel.instance.curSendChapterId = episodeConfig.chapterId

		local fightParam = FightController.instance:setFightParamByEpisodeBattleId(fightData.episodeId, fightData.battleId)

		FightMgr.instance:startFight(fightData)
		FightModel.instance:updateFight(fightData)
		FightModel.instance:updateFightRound(msg.startDungeonReply.round)
		FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
	end
end

FightToolRpc.instance = FightToolRpc.New()

return FightToolRpc
