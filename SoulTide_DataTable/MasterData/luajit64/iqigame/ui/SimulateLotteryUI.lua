-- chunkname: @IQIGame\\UI\\SimulateLotteryUI.lua

local SimulateLotteryUI = Base:Extend("SimulateLotteryUI", "IQIGame.Onigao.UI.SimulateLotteryUI", {
	DelayCloseTime = 0
})
local LotteryUIVideoUI = require("IQIGame.UI.Lottery.LotteryUIVideoUI")

function SimulateLotteryUI:OnInit()
	self.VideoUIController = LotteryUIVideoUI.New(self.VideoUI, self)
end

function SimulateLotteryUI:GetPreloadAssetPaths()
	return nil
end

function SimulateLotteryUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SimulateLotteryUI:IsManualShowOnOpen(userData)
	return false
end

function SimulateLotteryUI:GetBGM(userData)
	return 4
end

function SimulateLotteryUI:OnOpen(userData)
	self.OnCompleteCallback = userData.onComplete

	if userData.delayCloseTime ~= nil then
		self.DelayCloseTime = userData.delayCloseTime
	else
		self.DelayCloseTime = 0
	end

	self.VideoUIController:OnRootUIOpen()
	self.VideoUIController:Show({
		autoClickDelay = -1,
		base = {},
		list = userData.items,
		onClose = function(base, list)
			self:OnComplete()
		end
	})
end

function SimulateLotteryUI:OnClose(userData)
	self.VideoUIController:OnRootUIClose()
	ModuleTimerUtil.Stop(Constant.UIControllerName.SimulateLotteryUI)
end

function SimulateLotteryUI:OnAddListeners()
	self.VideoUIController:OnAddListeners()
end

function SimulateLotteryUI:OnRemoveListeners()
	self.VideoUIController:OnRemoveListeners()
end

function SimulateLotteryUI:OnPause()
	return
end

function SimulateLotteryUI:OnResume()
	return
end

function SimulateLotteryUI:OnCover()
	return
end

function SimulateLotteryUI:OnReveal()
	return
end

function SimulateLotteryUI:OnRefocus(userData)
	return
end

function SimulateLotteryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.VideoUIController:OnUpdate(elapseSeconds, realElapseSeconds)
end

function SimulateLotteryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SimulateLotteryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SimulateLotteryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SimulateLotteryUI:OnDestroy()
	self.VideoUIController:Dispose()
end

function SimulateLotteryUI:OnComplete()
	local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.SimulateLotteryUI, function()
		UIModule.CloseSelf(self)

		if self.OnCompleteCallback ~= nil then
			self.OnCompleteCallback()

			self.OnCompleteCallback = nil
		end
	end, self.DelayCloseTime)

	timer:Start()
end

return SimulateLotteryUI
