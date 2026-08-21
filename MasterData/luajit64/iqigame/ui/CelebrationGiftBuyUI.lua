-- chunkname: @IQIGame\\UI\\CelebrationGiftBuyUI.lua

local CelebrationGiftBuyUI = {}

CelebrationGiftBuyUI = Base:Extend("CelebrationGiftBuyUI", "IQIGame.Onigao.UI.CelebrationGiftBuyUI", CelebrationGiftBuyUI)

local CelebrationGiftCell = require("IQIGame.UI.CelebrationGift.CelebrationGiftCell")

function CelebrationGiftBuyUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnBtnClose()
	end

	function self.DelegatePlayerInfoChanged()
		self:OnPlayerInfoChange()
	end

	self.baseCell = CelebrationGiftCell.New(self.goBaseCell, 1)
	self.superCell = CelebrationGiftCell.New(self.goSuperCell, 2)
end

function CelebrationGiftBuyUI:GetPreloadAssetPaths()
	return nil
end

function CelebrationGiftBuyUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CelebrationGiftBuyUI:IsManualShowOnOpen(userData)
	return false
end

function CelebrationGiftBuyUI:GetBGM(userData)
	return nil
end

function CelebrationGiftBuyUI:OnOpen(userData)
	self.cid = userData.Cid

	self:UpdateView()
end

function CelebrationGiftBuyUI:OnClose(userData)
	return
end

function CelebrationGiftBuyUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.PlayerInfoChanged, self.DelegatePlayerInfoChanged)
end

function CelebrationGiftBuyUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.PlayerInfoChanged, self.DelegatePlayerInfoChanged)
end

function CelebrationGiftBuyUI:OnPause()
	return
end

function CelebrationGiftBuyUI:OnResume()
	return
end

function CelebrationGiftBuyUI:OnCover()
	return
end

function CelebrationGiftBuyUI:OnReveal()
	return
end

function CelebrationGiftBuyUI:OnRefocus(userData)
	return
end

function CelebrationGiftBuyUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CelebrationGiftBuyUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CelebrationGiftBuyUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CelebrationGiftBuyUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CelebrationGiftBuyUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.baseCell:Dispose()

	self.baseCell = nil

	self.superCell:Dispose()

	self.superCell = nil
end

function CelebrationGiftBuyUI:UpdateView()
	local cfgGiftBoxData = CfgGiftBoxTable[self.cid]

	self.baseCell:SetData(self.cid, cfgGiftBoxData.GiftBoxMall[1])
	self.superCell:SetData(self.cid, cfgGiftBoxData.GiftBoxMall[2])
end

function CelebrationGiftBuyUI:OnPlayerInfoChange()
	local openGiftBox = CelebrationGiftModule.GetOpenGiftBox()
	local result = table.indexOf(openGiftBox, self.cid) == -1

	if result then
		self:OnBtnClose()
	end
end

function CelebrationGiftBuyUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

return CelebrationGiftBuyUI
