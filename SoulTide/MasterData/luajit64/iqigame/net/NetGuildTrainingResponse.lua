-- chunkname: @IQIGame\\Net\\NetGuildTrainingResponse.lua

function net_guildTraining.attackResult(code)
	GuildTrainingModule.AttackResult()
end

function net_guildTraining.attackResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 21066715 then
			NoticeModule.ShowServerError(code)

			return
		end

		NoticeModule.ShowServerError(code)

		return
	end

	net_guildTraining.attackResult(code)
end

function net_guildTraining.notifyAttackEnd(win, dmgRecords, items, maxScore, getAward)
	GuildTrainingModule.NotifyAttackEnd(win, dmgRecords, items, maxScore, getAward)
end
