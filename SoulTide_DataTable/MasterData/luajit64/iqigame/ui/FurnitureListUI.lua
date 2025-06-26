-- chunkname: @IQIGame\\UI\\FurnitureListUI.lua

local FurnitureListUI = Base:Extend("FurnitureListUI", "IQIGame.Onigao.UI.FurnitureListUI", {})
local FurnitureLotteryGridMould = require("IQIGame.UI.FurnitureLottery.FurnitureLotteryGridMould")

function FurnitureListUI:OnInit()
	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.scrollPageTitleList = self.ScrollView:GetComponent("ScrollAreaListGroup")

	function self.scrollPageTitleList.onRenderGroupPage(renderPage, groupIndex)
		self:OnRenderGroupPage(renderPage, groupIndex)
	end

	function self.scrollPageTitleList.onRenderGroupCell(renderCell, groupIndex, gridIndex)
		self:OnRenderGroupCell(renderCell, groupIndex, gridIndex)
	end

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end
end

function FurnitureListUI:GetPreloadAssetPaths()
	return nil
end

function FurnitureListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FurnitureListUI:OnOpen(userData)
	self.furnitureLotteryData = userData

	self:UpdateView()
end

function FurnitureListUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateClickBtnClose)
end

function FurnitureListUI:OnClose(userData)
	return
end

function FurnitureListUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateClickBtnClose)
end

function FurnitureListUI:OnPause()
	return
end

function FurnitureListUI:OnResume()
	return
end

function FurnitureListUI:OnCover()
	return
end

function FurnitureListUI:OnReveal()
	return
end

function FurnitureListUI:OnRefocus(userData)
	return
end

function FurnitureListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FurnitureListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FurnitureListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FurnitureListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FurnitureListUI:OnDestroy()
	FurnitureLotteryGridMould.DisposeIn(self)
end

function FurnitureListUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.FurnitureListUI)
end

function FurnitureListUI:UpdateView()
	if self.furnitureLotteryData ~= nil then
		self.TextTitle:GetComponent("Text").text = self.furnitureLotteryData.cfgInfo.Name

		local showTab = {}

		for i = 1, #self.furnitureLotteryData.cfgInfo.OrderTitle do
			showTab[i] = #self.furnitureLotteryData.cfgInfo.List[i]
		end

		self.scrollPageTitleList:RefreshOnLua(showTab)
	end
end

function FurnitureListUI:OnRenderGroupPage(renderPage, groupIndex)
	local showNum = #self.furnitureLotteryData.cfgInfo.List[groupIndex + 1]

	renderPage.prefabPage.transform:Find("Text_01"):GetComponent("Text").text = self.furnitureLotteryData.cfgInfo.OrderTitle[groupIndex + 1] .. "(" .. showNum .. "/" .. showNum .. ")"
end

function FurnitureListUI:OnRenderGroupCell(renderCell, groupIndex, gridIndex)
	local date = self.furnitureLotteryData.cfgInfo.List[groupIndex + 1][gridIndex + 1]
	local tab = self.furnitureLotteryData.cfgInfo.ItemProbability[groupIndex + 1]
	local num

	if tab ~= nil then
		num = tab[gridIndex + 1]
	end

	local rewardCell = FurnitureLotteryGridMould.PackageOrReuseView(self, renderCell.gameObject)

	rewardCell:SetData(date, num)
end

return FurnitureListUI
