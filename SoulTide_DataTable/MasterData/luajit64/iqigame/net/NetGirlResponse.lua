-- chunkname: @IQIGame\\Net\\NetGirlResponse.lua

function net_girl.viewMemoryResult(code)
	return
end

function net_girl.giveGiftResult_delegate(code, soulCid, giftCid, spAddition, addFavor)
	NetCommController.Responded()

	if code == 0 then
		GiftModule.GiveGiftResult(soulCid, giftCid, spAddition, addFavor)
	else
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, getErrorMsg(code))
	end

	GiftModule.isDelayShow = false
end

function net_girl.fondleResult(code, soulCid, actionCid, addFavor, dislike, fondleNum)
	FondleModule.FondleResult(soulCid, actionCid, addFavor, dislike, fondleNum)
end

function net_girl.notifyFondleNumRecovery(fondleNum, nextRecoveryFondleNumTime)
	FondleModule.NotifyFondleNumRecovery(fondleNum, nextRecoveryFondleNumTime)
end

function net_girl.viewNewStoryResult(code)
	return
end

function net_girl.connectiveResult(code, soulMarryId, soulCid, shows)
	GirlModule.ConnectiveResult(soulMarryId, soulCid, shows)
end

function net_girl.getSoulOathResult(code, soulCid, pod)
	GirlModule.GetSoulOathResult(soulCid, pod)
end
