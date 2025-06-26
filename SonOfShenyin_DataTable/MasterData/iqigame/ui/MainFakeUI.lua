-- chunkname: @IQIGame\\UI\\MainFakeUI.lua

local MainFakeUI = {}

MainFakeUI = Base:Extend("MainFakeUI", "IQIGame.Onigao.UI.MainFakeUI", MainFakeUI)

function MainFakeUI:OnInit()
	self:InitDelegate()
	self:InitComponent()
end

function MainFakeUI:InitDelegate()
	function self.delegateOnClickButtonLottery()
		if StoryModule.GetNPCVariable(999, "guide") ~= 1 then
			return
		end

		UIModule.Open(Constant.UIControllerName.LotteryUI, Constant.UILayer.UI)
	end

	function self.delegateOnClickExploreBtn()
		StoryModule.SendTreeEvent(999, "0-12-2 Start", "GuideChapterButtonClick")
	end
end

function MainFakeUI:InitComponent()
	self.moneyCell = CurrencyCell.New(self.MoneyTopRoot)

	local npc = StoryModule.GetCharacterByNPCID(202)

	self.UIFollowerComponent = LuaUtility.GameObjectGetOrAddComponent(self.chapterRoot, typeof(UIFollower))

	self.UIFollowerComponent:Init(StoryModule.mainCamera, GameEntry.UICamera, npc.gameObject.transform, self.gameObject:GetComponent("Canvas"))
end

function MainFakeUI:OnAddListeners()
	self.ExploreBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickExploreBtn)
	self.buttonLottery:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonLottery)
end

function MainFakeUI:OnRemoveListeners()
	self.ExploreBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickExploreBtn)
	self.buttonLottery:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonLottery)
end

function MainFakeUI:OnOpen(userData)
	self:Refresh()
end

function MainFakeUI:OnClose(userData)
	return
end

function MainFakeUI:GetPreloadAssetPaths()
	return nil
end

function MainFakeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MainFakeUI:IsManualShowOnOpen(userData)
	return false
end

function MainFakeUI:GetBGM(userData)
	return nil
end

function MainFakeUI:OnPause()
	return
end

function MainFakeUI:OnResume()
	return
end

function MainFakeUI:OnCover()
	return
end

function MainFakeUI:OnReveal()
	return
end

function MainFakeUI:OnRefocus(userData)
	return
end

function MainFakeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MainFakeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MainFakeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MainFakeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MainFakeUI:Refresh()
	if not StoryModule.isDebugMod then
		self.moneyCell:RefreshItem(Constant.TopMoneyType.MainFakeUI)
	end
end

function MainFakeUI:OnDestroy()
	self.moneyCell:Dispose()
	AssetUtil.UnloadAsset(self)
end

return MainFakeUI
