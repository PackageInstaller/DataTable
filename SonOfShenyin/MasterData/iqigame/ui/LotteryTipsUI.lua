-- chunkname: @IQIGame\\UI\\LotteryTipsUI.lua

local UITabList = require("IQIGame.UI.Common.UITabList")
local LotteryTipsView_1 = require("IQIGame/UI/Lottery/LotteryTipsView/LotteryTipsView1")
local LotteryTipsView_2 = require("IQIGame/UI/Lottery/LotteryTipsView/LotteryTipsView2")
local LotteryTipsView_3 = require("IQIGame/UI/Lottery/LotteryTipsView/LotteryTipsView3")
local LotteryTipsUI = Base:Extend("LotteryTipsUI", "IQIGame.Onigao.UI.LotteryTipsUI", {
	cardJackpotID = 0
})

function LotteryTipsUI:OnInit()
	self.tabList = UITabList.Create()

	self.tabList:AddTableItem(self.tab1, function()
		return LotteryTipsView_1.New(self.tab1View)
	end, function(_isOn, _view)
		if _isOn then
			_view:Show(self.cardJackpotID)
		else
			_view:Hide()
		end
	end)
	self.tabList:AddTableItem(self.tab2, function()
		return LotteryTipsView_2.New(self.tab2View)
	end, function(_isOn, _view)
		if _isOn then
			_view:Show(self.cardJackpotID)
		else
			_view:Hide()
		end
	end)
	self.tabList:AddTableItem(self.tab3, function()
		return LotteryTipsView_3.New(self.tab3View)
	end, function(_isOn, _view)
		if _isOn then
			_view:Show(self.cardJackpotID)
		else
			_view:Hide()
		end
	end)

	function self.__delegateOnCloseBtnClick()
		UIModule.Close(Constant.UIControllerName.LotteryTipsUI)
	end
end

function LotteryTipsUI:GetPreloadAssetPaths()
	return nil
end

function LotteryTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LotteryTipsUI:IsManualShowOnOpen(userData)
	return false
end

function LotteryTipsUI:GetBGM(userData)
	return nil
end

function LotteryTipsUI:OnOpen(userData)
	self.cardJackpotID = userData.cardJackpotID

	self.tabList:ChangeSelectIndex(1)
end

function LotteryTipsUI:OnClose(userData)
	return
end

function LotteryTipsUI:OnAddListeners()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCloseBtnClick)
end

function LotteryTipsUI:OnRemoveListeners()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCloseBtnClick)
end

function LotteryTipsUI:OnPause()
	return
end

function LotteryTipsUI:OnResume()
	return
end

function LotteryTipsUI:OnCover()
	return
end

function LotteryTipsUI:OnReveal()
	return
end

function LotteryTipsUI:OnRefocus(userData)
	return
end

function LotteryTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LotteryTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LotteryTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LotteryTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LotteryTipsUI:OnDestroy()
	self.tabList:Dispose()
end

return LotteryTipsUI
