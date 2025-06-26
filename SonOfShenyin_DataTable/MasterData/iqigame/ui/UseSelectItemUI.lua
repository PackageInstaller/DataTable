-- chunkname: @IQIGame\\UI\\UseSelectItemUI.lua

local UseSelectItemUI = {
	selectIndex = 0,
	Items = {}
}

UseSelectItemUI = Base:Extend("UseSelectItemUI", "IQIGame.Onigao.UI.UseSelectItemUI", UseSelectItemUI)

local PackItemCell = require("IQIGame.UI.ItemTips.PackItemSelectCell")

function UseSelectItemUI:OnInit()
	self:Initialize()
end

function UseSelectItemUI:GetPreloadAssetPaths()
	return nil
end

function UseSelectItemUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function UseSelectItemUI:IsManualShowOnOpen(userData)
	return false
end

function UseSelectItemUI:GetBGM(userData)
	return nil
end

function UseSelectItemUI:OnOpen(userData)
	self.itemData = userData.itemData
	self.useNum = userData.useNum
	self.selectIndex = 0

	self:GetSelectItemList()
	self:UnselectedHeadCells()
end

function UseSelectItemUI:OnClose(userData)
	return
end

function UseSelectItemUI:OnPause()
	return
end

function UseSelectItemUI:OnResume()
	return
end

function UseSelectItemUI:OnCover()
	return
end

function UseSelectItemUI:OnReveal()
	return
end

function UseSelectItemUI:OnRefocus(userData)
	return
end

function UseSelectItemUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function UseSelectItemUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function UseSelectItemUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function UseSelectItemUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function UseSelectItemUI:OnDestroy()
	return
end

function UseSelectItemUI:Initialize()
	function self.DelegateBtnClose()
		self:OnCloseBtnClick()
	end

	function self.DelegateBtnUse()
		self:OnUseBtnClick()
	end

	self.wrapContent = self.ItemScrollView:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	function self.wrapContent.onSelectedCell(cell)
		self:OnSelectCell(cell)
	end
end

function UseSelectItemUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.goBtnUse:GetComponent("Button").onClick:AddListener(self.DelegateBtnUse)
end

function UseSelectItemUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.goBtnUse:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnUse)
end

function UseSelectItemUI:GetSelectItemList()
	self.SelectItemList = {}

	local CfgitemList = self.itemData:GetCfg().ActionParams

	for i = 1, #CfgitemList, 2 do
		table.insert(self.SelectItemList, {
			cid = CfgitemList[i],
			num = CfgitemList[i + 1]
		})
	end

	self.wrapContent:Refresh(#self.SelectItemList)
end

function UseSelectItemUI:OnRenderItem(cell)
	local ItemData = self.SelectItemList[cell.index + 1]
	local itemObj = self.Items[cell.gameObject]

	if itemObj == nil then
		itemObj = PackItemCell.New(cell.gameObject)
		self.Items[cell.gameObject] = itemObj
	end

	itemObj:SetData(ItemData)
end

function UseSelectItemUI:OnSelectCell(cell)
	local headCell = self.Items[cell.gameObject]

	self:UnselectedHeadCells()
	headCell:OnClickCell()

	self.selectIndex = cell.index + 1
end

function UseSelectItemUI:UnselectedHeadCells()
	for i, v in pairs(self.Items) do
		v:OnUnselected()
	end
end

function UseSelectItemUI:OnCloseBtnClick()
	UIModule.CloseSelf(self)
end

function UseSelectItemUI:OnUseBtnClick()
	if self.selectIndex == 0 then
		NoticeModule.ShowNotice(20034)

		return
	end

	local useItemPods = {}

	useItemPods.selectIndex = self.selectIndex
	useItemPods.id = self.itemData.id
	useItemPods.num = self.useNum

	ItemModule.UseItem({
		useItemPods
	})
	self:OnCloseBtnClick()
end

return UseSelectItemUI
