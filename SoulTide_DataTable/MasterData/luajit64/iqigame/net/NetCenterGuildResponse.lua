-- chunkname: @IQIGame\\Net\\NetCenterGuildResponse.lua

function net_centerGuild.createGuildResult(code)
	GuildModule.CreateGuildResult()
end

function net_centerGuild.createGuildResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 49008 then
			NoticeModule.ShowNotice(21066709)

			return
		end

		if code == 49002 then
			NoticeModule.ShowNotice(21066302)

			return
		end

		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.createGuildResult(code)
end

function net_centerGuild.enterGuildResult(code, guildPOD)
	GuildModule.EnterGuildResult(guildPOD)
end

function net_centerGuild.exitGuildResult(code)
	GuildModule.ExitGuildResult()
end

function net_centerGuild.getRecommendGuildListResult(code, guildBaseList)
	GuildModule.GetRecommendGuildListResult(guildBaseList)
end

function net_centerGuild.applyGuildResult(code)
	GuildModule.ApplyGuildResult()
end

function net_centerGuild.applyGuildResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 49008 then
			NoticeModule.ShowNotice(21066709)

			return
		end

		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.applyGuildResult(code)
end

function net_centerGuild.getMyApplyListResult(code, guildBaseList)
	GuildModule.GetMyApplyListResult(guildBaseList)
end

function net_centerGuild.cancelApplyGuildResult(code, guildId)
	GuildModule.CancelApplyGuildResult(guildId)
end

function net_centerGuild.getAuditListResult(code, auditList)
	GuildModule.GetAuditListResult(auditList)
end

function net_centerGuild.refuseApplyResult(code, pids)
	GuildModule.RefuseApplyResult(pids)
end

function net_centerGuild.acceptApplyResult(code, pid)
	GuildModule.AcceptApplyResult(pid)
end

function net_centerGuild.acceptApplyResult_delegate(code, pid)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 49010 then
			NoticeModule.ShowNotice(21066607)

			return
		end

		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.acceptApplyResult(code, pid)
end

function net_centerGuild.getMemberListResult(code, members)
	GuildModule.GetMemberListResult(members)
end

function net_centerGuild.appointPositionResult(code)
	GuildModule.AppointPositionResult()
end

function net_centerGuild.removeMemberResult(code)
	GuildModule.RemoveMemberResult()
end

function net_centerGuild.impeachmentResult(code)
	GuildModule.ImpeachmentResult()
end

function net_centerGuild.cancelImpeachmentResult(code)
	GuildModule.CancelImpeachmentResult()
end

function net_centerGuild.quitResult(code)
	GuildModule.QuitResult()
end

function net_centerGuild.editInfoResult(code)
	GuildModule.EditInfoResult()
end

function net_centerGuild.changeNameResult(code)
	GuildModule.ChangeNameResult()
end

function net_centerGuild.searchGuildResult(code, guildBaseList)
	GuildModule.SearchGuildResult(guildBaseList)
end

function net_centerGuild.searchGuildResult_delegate(code, guildBaseList)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 10009 then
			NoticeModule.ShowNotice(21066302)

			return
		end

		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.searchGuildResult(code, guildBaseList)
end

function net_centerGuild.upBuildingLevelResult(code, building)
	GuildModule.UpBuildingLevelResult(building)
end

function net_centerGuild.buyBuildingEffectResult(code, building)
	GuildModule.BuyBuildingEffectResult(building)
end

function net_centerGuild.notifyJoinGuild(guildId, guildName)
	GuildModule.NotifyJoinGuild(guildId, guildName)
end

function net_centerGuild.notifyQuitGuild()
	GuildModule.NotifyQuitGuild()
end

function net_centerGuild.notifyUpdateGuildBase(basePOD)
	GuildModule.NotifyUpdateGuildBase(basePOD)
end

function net_centerGuild.notifyUpdateGuild(pod)
	GuildModule.NotifyUpdateGuild(pod)
end

function net_centerGuild.notifyUpdateGuildFund(fund, fundDailyGetRecord)
	GuildModule.NotifyUpdateGuildFund(fund, fundDailyGetRecord)
end

function net_centerGuild.getQuestProgressResult(code, progress)
	GuildModule.GetQuestProgressResult(progress)
end

function net_centerGuild.notifyNewAudit(newAuditCount)
	GuildModule.NotifyNewAudit(newAuditCount)
end

function net_centerGuild.editNoticeResult(code, notice)
	GuildModule.EditNoticeResult(notice)
end

function net_centerGuild.getGuildTrainingIntegralResult(code, centerGuildTrainingPlayerRanks)
	GuildTrainingModule.GetGuildTrainingIntegralResult(centerGuildTrainingPlayerRanks)
end
