-- chunkname: @IQIGame\\Net\\NetChallengeResponse.lua

function net_challenge.challengeDupResult(code)
	return
end

function net_challenge.sweepingResult(code, getItems, oldMaxHurt)
	ChallengeModule.SweepingResult(getItems, oldMaxHurt)
end

function net_challenge.notifyChallengeComplete(win, dupCid, levelCid, dmgRecords, getItems, oldMaxHurt)
	ChallengeModule.NotifyChallengeComplete(win, dupCid, levelCid, dmgRecords, getItems, oldMaxHurt)
end
