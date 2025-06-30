-- chunkname: @IQIGame\\UI\\RoleDevelopmentUI.lua

local RoleDevelopmentUI = Base:Extend("RoleDevelopmentUI", "IQIGame.Onigao.UI.RoleDevelopmentUI", {
	IsDevelopmentUIOpen = false
})
local UpgradeCoreView = require("IQIGame.UI.RoleDevelopment.UpgradeCoreView")
local DevelopmentView = require("IQIGame.UI.RoleDevelopment.RoleTraining.DevelopmentView")

function RoleDevelopmentUI:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)
	self:InitComponent()
	self:IniDelegate()

	RoleExtendModule.RoleDevelopment_UIController = self.UIController
end

function RoleDevelopmentUI:InitComponent()
	self.MainView = UpgradeCoreView.New(self.UpgradeCoreView)
	self.DevelopmentView = DevelopmentView.New(self.RoleTrainingCenter, self)
	self.moneyCell = CurrencyCell.New(self.CurrencyParent)
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	self.commonReturnBtn:RegisterReturnEvent(function()
		self:OnClickCloseBtn()
	end)
end

function RoleDevelopmentUI:IniDelegate()
	function self.DelegateChangeHeroEvent(heroCid)
		self:OnChangeHeroEvent(heroCid)
	end

	function self.DelegateScrollChangeHeroEvent(heroCid)
		self:OnScrollChangeHeroEvent(heroCid)
	end

	function self.DelegateOnClickDevelopmentButton()
		self:OnClickDevelopmentButton()
	end

	function self.DelegateOnClickPersonalityButton()
		self:OnClickPersonalityButton()
	end
end

function RoleDevelopmentUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.ChangeHeroEvent, self.DelegateChangeHeroEvent)
	EventDispatcher.AddEventListener(EventID.ScrollChangeHeroEvent, self.DelegateScrollChangeHeroEvent)
	self.DevelopmentButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDevelopmentButton)
	self.PersonalityButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPersonalityButton)
end

function RoleDevelopmentUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.ChangeHeroEvent, self.DelegateChangeHeroEvent)
	EventDispatcher.RemoveEventListener(EventID.ScrollChangeHeroEvent, self.DelegateScrollChangeHeroEvent)
	self.DevelopmentButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDevelopmentButton)
	self.PersonalityButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPersonalityButton)
end

function RoleDevelopmentUI:GetPreloadAssetPaths()
	return nil
end

function RoleDevelopmentUI:GetOpenPreloadAssetPaths(userData)
	return
end

function RoleDevelopmentUI:IsManualShowOnOpen(userData)
	return false
end

function RoleDevelopmentUI:GetBGM(userData)
	return 10000011
end

function RoleDevelopmentUI:OnOpen(userData)
	self.SelectHeroCid = userData[1]
	self.SelectHeroList = userData[2]

	self.MainView:InitHeroData(self.SelectHeroCid, self.SelectHeroList)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.RoleDevelopmentUI)
	self.commonReturnBtn:SetHomeBtnState(SceneTransferModule.GetCanBackHome())
	self:InitPanelState()

	if userData and userData.AutoSelectFavorStage then
		UIModule.Open(Constant.UIControllerName.RoleInfoDetailsUI, Constant.UILayer.UI, {
			AutoSelectFavorStage = true,
			heroCid = self.SelectHeroCid
		})
	end
end

function RoleDevelopmentUI:InitPanelState()
	self.DevelopmentView:Hide()
	self.MainView:SetCurActiveState(true)
	self.MainView:SetRoleImgState(true)
end

function RoleDevelopmentUI:OnClose(userData)
	return
end

function RoleDevelopmentUI:OnPause()
	return
end

function RoleDevelopmentUI:OnResume()
	return
end

function RoleDevelopmentUI:OnCover()
	return
end

function RoleDevelopmentUI:OnReveal()
	return
end

function RoleDevelopmentUI:OnRefocus(userData)
	return
end

function RoleDevelopmentUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RoleDevelopmentUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RoleDevelopmentUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RoleDevelopmentUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RoleDevelopmentUI:OnDestroy()
	self.DevelopmentView:Dispose()
	self.moneyCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
	self.commonReturnBtn:Dispose()
end

function RoleDevelopmentUI:OnChangeHeroEvent(heroCid)
	if self.SelectHeroCid == heroCid then
		return
	end

	self.SelectHeroCid = heroCid
	RoleDevelopmentModule.CurSelectHeroCid = heroCid
	WarlockModule.curWarlockData = WarlockModule.WarlockDataDic[heroCid]

	self.MainView:InitHeroData(self.SelectHeroCid, self.SelectHeroList)
end

function RoleDevelopmentUI:OnScrollChangeHeroEvent(heroCid)
	self.SelectHeroCid = heroCid
	RoleDevelopmentModule.CurSelectHeroCid = heroCid
	WarlockModule.curWarlockData = WarlockModule.WarlockDataDic[heroCid]
end

function RoleDevelopmentUI:OnClickCloseBtn()
	if self.IsDevelopmentUIOpen then
		self.DevelopmentView:Hide()

		self.IsDevelopmentUIOpen = false
	else
		UIModule.Close(Constant.UIControllerName.RoleDevelopmentUI)
	end

	self.MainView:SetCurActiveState(true)
	self.MainView:SetRoleImgState(true)
end

function RoleDevelopmentUI:OnClickDevelopmentButton()
	self.DevelopmentView:SetData(self.SelectHeroCid, self.SelectHeroList)
	self.DevelopmentView:Show()

	self.IsDevelopmentUIOpen = true
end

function RoleDevelopmentUI:OnClickPersonalityButton()
	UIModule.Open(Constant.UIControllerName.PersonalitySystemPanel, Constant.UILayer.UI)
end

function RoleDevelopmentUI:HideMainView()
	self.MainView:Hide()
end

function RoleDevelopmentUI:ShowMainView()
	self.MainView:Show()
end

function RoleDevelopmentUI:OnlyShowRole()
	self.MainView:OnlyShowRole()
end

return RoleDevelopmentUI
