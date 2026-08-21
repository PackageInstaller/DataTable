-- chunkname: @IQIGame\\Net\\NetGuildChallengeResponse.lua

function net_guildChallenge.attackResult(code, layerCid)
	GuildChallengeModule.AttackResult(layerCid)
end

function net_guildChallenge.getRewardsResult(code, id, getItems)
	GuildChallengeModule.GetRewardsResult(id, getItems)
end

function net_guildChallenge.mopupResult(code, layerCid, getItems, count)
	GuildChallengeModule.MoPupResult(layerCid, getItems, count)
end

function net_guildChallenge.getScoreResult(code, score)
	GuildChallengeModule.GetScoreResult(score)
end

function net_guildChallenge.notifyAttackComplete(win, layerCid, dmgRecords, getItems)
	GuildChallengeModule.NotifyAttackComplete(win, layerCid, dmgRecords, getItems)
end
