-- chunkname: @IQIGame\\UI\\PandaSceneMainUI.lua

local PandaSceneMainUI = {
	speed = 0.008,
	haveNum = 0,
	EntityId = 0,
	showLoading = false,
	perCent = 0
}

PandaSceneMainUI = Base:Extend("PandaSceneMainUI", "IQIGame.Onigao.UI.PandaSceneMainUI", PandaSceneMainUI)

require("IQIGame.UIExternalApi.PandaSceneMainUIApi")

function PandaSceneMainUI:OnInit()
	function self.delegateOnClickExitBtn()
		self:OnClickExitBtn()
	end

	function self.delegateBtnExplore()
		self:OnBtnExplore()
	end

	function self.delegateOnClickTip()
		self:OnClickTip()
	end

	function self.delegateUpdateOperations()
		self:OnUpdateOperations()
	end

	function self.delegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	UGUIUtil.SetText(self.TitleText, PandaSceneMainUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.BtnExploreLabel, PandaSceneMainUIApi:GetString("BtnExploreLabel"))
	UGUIUtil.SetText(self.TextDes, PandaSceneMainUIApi:GetString("TextDes"))
	UGUIUtil.SetText(self.TextSpendName, PandaSceneMainUIApi:GetString("TextSpendName", CfgItemTable[Constant.ItemID.VACATION_TIME].Name))

	local moneyPath = UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemID.EXPLORATION_ORDER].Icon)

	AssetUtil.LoadImage(self, moneyPath, self.ExplorationOrderIcon:GetComponent("Image"))
	AssetUtil.LoadImage(self, moneyPath, self.IconSpend:GetComponent("Image"))
end

function PandaSceneMainUI:GetPreloadAssetPaths()
	return nil
end

function PandaSceneMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PandaSceneMainUI:IsManualShowOnOpen(userData)
	return false
end

function PandaSceneMainUI:GetBGM(userData)
	return nil
end

function PandaSceneMainUI:OnOpen(userData)
	self.PercentView:SetActive(false)
	self:RefreshMoney()
	self:UpdateView()
end

function PandaSceneMainUI:OnClose(userData)
	self:HideEntity()
end

function PandaSceneMainUI:OnAddListeners()
	self.ExitBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickExitBtn)
	self.BtnExplore:GetComponent("Button").onClick:AddListener(self.delegateBtnExplore)
	self.MoneyView:GetComponent("Button").onClick:AddListener(self.delegateOnClickTip)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function PandaSceneMainUI:OnRemoveListeners()
	self.ExitBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickExitBtn)
	self.BtnExplore:GetComponent("Button").onClick:RemoveListener(self.delegateBtnExplore)
	self.MoneyView:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickTip)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function PandaSceneMainUI:OnPause()
	return
end

function PandaSceneMainUI:OnResume()
	return
end

function PandaSceneMainUI:OnCover()
	return
end

function PandaSceneMainUI:OnReveal()
	return
end

function PandaSceneMainUI:OnRefocus(userData)
	return
end

function PandaSceneMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.showLoading then
		self.perCent = self.perCent + self.speed

		if self.perCent >= 1 then
			self.showLoading = false

			self:LoadingEnd()
		end

		self:SetPercent()
	end
end

function PandaSceneMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PandaSceneMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PandaSceneMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PandaSceneMainUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function PandaSceneMainUI:OnUpdateOperations()
	self:RefreshMoney()
end

function PandaSceneMainUI:RefreshMoney()
	self.haveNum = 0

	local data = ActivePandaModule.GetPandaPOD(ActivePandaModule.currentOperateEventID)

	if data then
		self.haveNum = data.exploreCount
	end

	UGUIUtil.SetText(self.ExplorationOrder, PandaSceneMainUIApi:GetString("ExplorationOrder", self.haveNum, CfgDiscreteDataTable[6520068].Data[1]))
end

function PandaSceneMainUI:UpdateView()
	UGUIUtil.SetText(self.TextSpendNum, PandaSceneMainUIApi:GetString("TextSpendNum", 1))

	local eventPOD = ActiveOperationEventModule.GetActiveOperationData(ActivePandaModule.currentOperateEventID)
	local cfgPandaActivityGlobalData = CfgPandaActivityGlobalTable[eventPOD.dataCfgId]

	self:ShowPanda(cfgPandaActivityGlobalData.PandaSpine)
end

function PandaSceneMainUI:ShowPanda(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.PercentSpine.transform, Vector3.zero)
end

function PandaSceneMainUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function PandaSceneMainUI:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(80, 80, 80)
		self.EntityObj = args.Entity.gameObject
		args.Entity.gameObject.transform.localPosition = Vector3(0, 0, 0)

		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "walk", true)
		end

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")
	end
end

function PandaSceneMainUI:StartPlayPercent()
	self.showLoading = true
	self.perCent = 0

	self.PercentView:SetActive(true)
	self:SetPercent()
end

function PandaSceneMainUI:SetPercent()
	self.PercentSpine.transform.anchoredPosition = Vector2.New(self.perCent * 670 - 30, 0)
	self.PercentBar:GetComponent("Image").fillAmount = self.perCent
end

function PandaSceneMainUI:OnClickExitBtn()
	ActivePandaModule.ExitPandaScene()
end

function PandaSceneMainUI:OnBtnExplore()
	if self.showLoading then
		return
	end

	if self.haveNum <= 0 then
		NoticeModule.ShowNotice(21052002)

		return
	end

	if #ActivePandaModule.sceneEvents > 0 then
		NoticeModule.ShowNotice(21045036, function()
			self:StartPlayPercent()
		end)
	else
		self:StartPlayPercent()
	end
end

function PandaSceneMainUI:LoadingEnd()
	self.showLoading = false
	self.perCent = 1

	self.PercentView:SetActive(false)
	ActivePandaModule.Explore()
end

function PandaSceneMainUI:OnClickTip()
	UIModule.Open(Constant.UIControllerName.MoneyPanelInfoUI, Constant.UILayer.UI, {
		Constant.ItemID.EXPLORATION_ORDER,
		self.MoneyView.transform
	})
end

return PandaSceneMainUI
