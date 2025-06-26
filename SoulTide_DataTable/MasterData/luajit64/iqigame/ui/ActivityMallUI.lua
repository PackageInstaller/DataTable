-- chunkname: @IQIGame\\UI\\ActivityMallUI.lua

local ActivityMallUI = {}

ActivityMallUI = Base:Extend("ActivityMallUI", "IQIGame.Onigao.UI.ActivityMallUI", ActivityMallUI)

local MallView = require("IQIGame.UI.ActivityMall.MallView")

function ActivityMallUI:OnInit()
	self:Initialize()
end

function ActivityMallUI:GetPreloadAssetPaths()
	return nil
end

function ActivityMallUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActivityMallUI:IsManualShowOnOpen(userData)
	return false
end

function ActivityMallUI:GetBGM(userData)
	return nil
end

function ActivityMallUI:OnOpen(userData)
	self.GuildTip:SetActive(userData.entranceType == Constant.Mall_EntranceType.Guild)
	self:Refresh(userData.entranceType, userData.customMallCids)
end

function ActivityMallUI:OnClose(userData)
	self:OnHide()
end

function ActivityMallUI:OnPause()
	return
end

function ActivityMallUI:OnResume()
	return
end

function ActivityMallUI:OnCover()
	return
end

function ActivityMallUI:OnReveal()
	return
end

function ActivityMallUI:OnRefocus(userData)
	return
end

function ActivityMallUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.mallView ~= nil then
		self.mallView:OnUpdate(elapseSeconds, realElapseSeconds)
	end
end

function ActivityMallUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ActivityMallUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActivityMallUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActivityMallUI:Initialize()
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.mallView = MallView.New(self.goView, self)
	self.moneyCellBuilder = MoneyCellsBuilder.New(self.goMoneyParent)

	UGUIUtil.SetText(self.GuildTip, MallUIApi:GetString("GuildTip"))
end

function ActivityMallUI:Refresh(entranceType, customMallCids)
	self.mallView:Refresh(entranceType, customMallCids)

	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = MallUIApi:GetString("goTitle", entranceType)
end

function ActivityMallUI:OnHide()
	self.mallView:OnHide()
end

function ActivityMallUI:OnDestroy()
	self.moneyCellBuilder:Dispose()
	self.mallView:OnDestroy()
end

function ActivityMallUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function ActivityMallUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function ActivityMallUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function ActivityMallUI:RefreshMoneyCells(goodDatum)
	local tempDic = {}
	local ids = {}

	for i, v in pairs(goodDatum) do
		local tempIds = {}

		if v.SellType == Constant.Mall_SellType.Item then
			tempIds[#tempIds + 1] = v.Price[1]
		elseif v.SellType == Constant.Mall_SellType.PayPoint then
			tempIds[#tempIds + 1] = Constant.ItemID.ID_PAYPOINT_SHOW
		elseif v.SellType == Constant.Mall_SellType.RMB then
			tempIds[#tempIds + 1] = Constant.ItemID.ID_PAYPOINT_SHOW
		end

		for m, n in pairs(v.Item) do
			if n == Constant.ItemID.MONEY or n == Constant.ItemID.TREASURE or n == Constant.ItemID.ID_PAYPOINT_SHOW then
				tempIds[#tempIds + 1] = n
			end
		end

		for m, n in pairs(tempIds) do
			if tempDic[n] == nil then
				ids[#ids + 1] = n
			end

			tempDic[n] = n
		end
	end

	table.sort(ids, function(a, b)
		return a == nil or b == nil or a < b
	end)
	self.moneyCellBuilder:RefreshView(ids)
end

return ActivityMallUI
