-- chunkname: @IQIGame\\UI\\Lottery\\LotteryTipsView\\LotteryTipsView.lua

local LotteryTipsView = {
	cardJackpotID = 0
}

function LotteryTipsView:Init(view)
	self.view = view

	self:__Init()
end

function LotteryTipsView:__Init()
	return
end

function LotteryTipsView:Show(cardJackpotID)
	self.cardJackpotID = cardJackpotID

	self.view.gameObject:SetActive(true)
	self:__Show()
end

function LotteryTipsView:__Show()
	return
end

function LotteryTipsView:Hide()
	self.view.gameObject:SetActive(false)
	self:__Hide()
end

function LotteryTipsView:__Hide()
	return
end

function LotteryTipsView:Dispose()
	self:__Dispose()

	self.view = nil
end

function LotteryTipsView:__Dispose()
	return
end

return LotteryTipsView
