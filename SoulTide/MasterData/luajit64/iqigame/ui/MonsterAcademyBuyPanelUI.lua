-- chunkname: @IQIGame\\UI\\MonsterAcademyBuyPanelUI.lua

local MonsterAcademyBuyPanelUI = {}

MonsterAcademyBuyPanelUI = Base:Extend("MonsterAcademyBuyPanelUI", "IQIGame.Onigao.UI.MonsterAcademyBuyPanelUI", MonsterAcademyBuyPanelUI)

require("IQIGame.UIExternalApi.MonsterAcademyBuyPanelUIApi")

local MonsterAcademyBuyView = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyShop.MonsterAcademyBuyView")

function MonsterAcademyBuyPanelUI:OnInit()
	UGUIUtil.SetText(self.goTitle, MonsterAcademyBuyPanelUIApi:GetString("goTitle"))

	self.buyView = MonsterAcademyBuyView.New(self.goViewTypeOne)

	function self.DelegateOnBtnClose1()
		self:OnBtnClose()
	end

	function self.DelegateOnBtnClose()
		self:OnBtnClose()
	end
end

function MonsterAcademyBuyPanelUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyBuyPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyBuyPanelUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyBuyPanelUI:GetBGM(userData)
	return nil
end

function MonsterAcademyBuyPanelUI:OnOpen(userData)
	self.mallCid = userData.mallCid

	self:UpdateView()
end

function MonsterAcademyBuyPanelUI:OnClose(userData)
	return
end

function MonsterAcademyBuyPanelUI:OnAddListeners()
	self.goBtnClose1:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClose1)
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClose)
end

function MonsterAcademyBuyPanelUI:OnRemoveListeners()
	self.goBtnClose1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClose1)
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClose)
end

function MonsterAcademyBuyPanelUI:OnPause()
	return
end

function MonsterAcademyBuyPanelUI:OnResume()
	return
end

function MonsterAcademyBuyPanelUI:OnCover()
	return
end

function MonsterAcademyBuyPanelUI:OnReveal()
	return
end

function MonsterAcademyBuyPanelUI:OnRefocus(userData)
	return
end

function MonsterAcademyBuyPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyBuyPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyBuyPanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyBuyPanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyBuyPanelUI:OnDestroy()
	self.buyView:Dispose()
end

function MonsterAcademyBuyPanelUI:UpdateView()
	local cfgShop = CfgGalgameMonsterShopTable[self.mallCid]

	self.buyView:SetData(cfgShop)
end

function MonsterAcademyBuyPanelUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

return MonsterAcademyBuyPanelUI
