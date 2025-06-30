-- chunkname: @IQIGame\\UI\\MiningMainUI.lua

local MiningMainUI = {}

MiningMainUI = Base:Extend("MiningMainUI", "IQIGame.Onigao.UI.MiningMainUI", MiningMainUI)

require("IQIGame.UIExternalApi.MiningMainUIApi")

local TargetDisplayView = require("IQIGame.UI.Mining.MiningMain.TargetDisplayView")
local MiningTicketBuilder = require("IQIGame.UI.Mining.MiningTicketBuilder")

function MiningMainUI:OnInit()
	UGUIUtil.SetTextInChildren(self.BtnShop, MiningMainUIApi:GetString("BtnShopLabel"))

	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateOnBtnShop()
		self:OnBtnShop()
	end

	function self.DelegateUpdateMiningLayerEvent()
		self:OnUpdateMiningLayerEvent()
	end

	function self.DelegateBtnTip()
		self:OnBtnTip()
	end

	function self.DelegateBtnAutoMining()
		self:OnBtnAutoMining()
	end

	self.targetDisplayView = TargetDisplayView.New(self.TargetDisplay)
	self.miningTicketBuilder = MiningTicketBuilder.New(self.MoneyBuilder)
	self.energyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.moneyCellBuilder = MoneyCellsBuilder.New(self.goMoneyParent)

	self.EffectOpen:SetActive(false)
	self.EffectEnd:SetActive(false)
end

function MiningMainUI:GetPreloadAssetPaths()
	return nil
end

function MiningMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MiningMainUI:IsManualShowOnOpen(userData)
	return false
end

function MiningMainUI:GetBGM(userData)
	return nil
end

function MiningMainUI:OnOpen(userData)
	local haveDialog = MiningModule.CheckResumeDialog()

	if haveDialog then
		self.UIController.gameObject:SetActive(false)

		local time = Timer.New(function()
			self.UIController.gameObject:SetActive(true)
		end, 2)

		time:Start()
	end

	self.targetDisplayView:Open()

	local cfgLayer = CfgMiningLayerTable[MiningModule.miningLayerPOD.floor]
	local moneys = {}

	for i = 1, #cfgLayer.Cost, 2 do
		local id = cfgLayer.Cost[i]

		table.insert(moneys, id)
	end

	self.miningTicketBuilder:RefreshMiningTicketView(moneys)
	self.moneyCellBuilder:RefreshView(moneys)
	self:UpdateView()
end

function MiningMainUI:OnClose(userData)
	self.targetDisplayView:Close()
end

function MiningMainUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	self.BtnShop:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnShop)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.DelegateBtnTip)
	self.BtnAutoMining:GetComponent("Button").onClick:AddListener(self.DelegateBtnAutoMining)
	EventDispatcher.AddEventListener(EventID.UpdateMiningLayerEvent, self.DelegateUpdateMiningLayerEvent)
end

function MiningMainUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	self.BtnShop:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnShop)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnTip)
	self.BtnAutoMining:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnAutoMining)
	EventDispatcher.RemoveEventListener(EventID.UpdateMiningLayerEvent, self.DelegateUpdateMiningLayerEvent)
end

function MiningMainUI:OnPause()
	return
end

function MiningMainUI:OnResume()
	return
end

function MiningMainUI:OnCover()
	return
end

function MiningMainUI:OnReveal()
	return
end

function MiningMainUI:OnRefocus(userData)
	return
end

function MiningMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MiningMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MiningMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MiningMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MiningMainUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.targetDisplayView:Dispose()

	self.targetDisplayView = nil

	self.miningTicketBuilder:Dispose()

	self.miningTicketBuilder = nil

	self.energyCell:Dispose()

	self.energyCell = nil

	self.moneyCellBuilder:Dispose()

	self.moneyCellBuilder = nil
end

function MiningMainUI:OnUpdateMiningLayerEvent()
	log("开始播放关闭效果 " .. PlayerModule.GetServerTime())
	self:PlayEffect(2)

	local timer = Timer.New(function()
		log("播放开启效果 " .. PlayerModule.GetServerTime())
		self:PlayEffect(1)
		MiningModule.miningScene:RefreshPlant()

		MiningModule.miningScene.isLockInput = false

		self:UpdateView()
	end, 1.1)

	timer:Start()
end

function MiningMainUI:UpdateView()
	self.targetDisplayView:UpdateView()
	UGUIUtil.SetText(self.TextTitle, MiningMainUIApi:GetString("TextTitle", MiningModule.miningLayerPOD.floor))
end

function MiningMainUI:OnClickBtnBack()
	MiningModule.ExitMiningScene()
end

function MiningMainUI:PlayEffect(type)
	self.EffectOpen:SetActive(false)
	self.EffectEnd:SetActive(false)

	if type == 1 then
		self.EffectOpen:SetActive(true)
	else
		self.EffectEnd:SetActive(true)
	end
end

function MiningMainUI:OnBtnTip()
	UIModule.Open(Constant.UIControllerName.TextTipsUI, Constant.UILayer.UI, {
		MiningMainUIApi:GetString("BtnTipDes")
	})
end

function MiningMainUI:OnBtnShop()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.MiningShop)
end

function MiningMainUI:OnBtnAutoMining()
	UIModule.Open(Constant.UIControllerName.MiningMainDigFastUI, Constant.UILayer.UI)
end

return MiningMainUI
