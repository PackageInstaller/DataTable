-- chunkname: @IQIGame\\Net\\NetOperationsHelpNewbiesResponse.lua

function net_operationsHelpNewbies.submitInviteCodeResult(code)
	ActiveWelcomeNewModule.SubmitInviteCodeResult()
end

function net_operationsHelpNewbies.submitInviteCodeResult_delegate(code, role)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 43015 then
			NoticeModule.ShowNotice(21045045)
		elseif code == 29009 then
			NoticeModule.ShowNotice(21045045)
		elseif code == 43014 then
			NoticeModule.ShowNotice(21045044)
		else
			NoticeModule.ShowServerError(code)
		end

		return
	end

	net_operationsHelpNewbies.submitInviteCodeResult(code)
end

function net_operationsHelpNewbies.confirmTaskResult(code, items)
	ActiveWelcomeNewModule.ConfirmTaskResult(items)
end

function net_centerEventHelpNewbies.getFollowersResult(code, retList)
	ActiveWelcomeNewModule.GetFollowersResult(retList)
end
