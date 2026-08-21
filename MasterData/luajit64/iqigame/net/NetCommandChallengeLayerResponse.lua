-- chunkname: @IQIGame\\Net\\NetCommandChallengeLayerResponse.lua

function net_commandChallengeLayer.startDrillResult(code)
	CommandChallengeModule.StartDrillResult()
end

function net_commandChallengeLayer.notifyFightComplete(win, levelID, dmgRecords, getItems)
	CommandChallengeModule.NotifyFightComplete(win, levelID, dmgRecords, getItems)
end
