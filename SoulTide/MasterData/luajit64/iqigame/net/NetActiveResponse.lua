-- chunkname: @IQIGame\\Net\\NetActiveResponse.lua

function net_active.signResult(code, signInfo, rewards)
	SignInModule.OnReqSignResult(signInfo, rewards)
end

function net_active.reciveFoodResult(code, cid)
	table.insert(PlayerModule.PlayerInfo.dailySupplyList, cid)
	NoticeModule.ShowNotice(21054003)
	EventDispatcher.Dispatch(EventID.UpdateDailySupply)
end

function net_active.notifySign(signInfo)
	SignInModule.NotifySign(signInfo)
end

function net_active.luckDrawResult(code, showItems)
	ActiveLuckyTurnTableModule.LuckDrawResult(showItems)
end

function net_active.getLuckDrawHistoryResult(code, luckDrawHistorys)
	ActiveLuckyTurnTableModule.GetLuckDrawHistoryResult(luckDrawHistorys)
end

function net_active.getLvReachRewardListResult(code, idsList)
	ActiveModule.GetLvReachRewardListResult(idsList)
end

function net_active.getLvReachRewardResult(code, itemList)
	ActiveModule.GetLvReachRewardResult(itemList)
end

function net_active.getRefundsGiftPacksResult(code, showItems)
	RefundsGiftPackModule.GetRefundsGiftPacksResult(showItems)
end

function net_active.notifyRefundsGiftPacksUpdate(refundsGiftPacks, refundsGiftPackRewards)
	RefundsGiftPackModule.NotifyRefundsGiftPacksUpdate(refundsGiftPacks, refundsGiftPackRewards)
end
