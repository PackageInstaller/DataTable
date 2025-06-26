-- chunkname: @IQIGame\\UI\\GetPanelUI.lua

local GetPanelUI = Base:Extend("GetPanelUI", "IQIGame.Onigao.UI.GetPanelUI", {})
local GetPanelItemCell = require("IQIGame.UI.GetPanel.GetPanelItemCell")

function GetPanelUI:OnInit()
	function self.DelegateUpdateItem(cell)
		self:UpdateItem(cell)
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	local wrapContent = self.ItemContainer:GetComponent("ScrollAreaList")

	wrapContent.onRenderCell = self.DelegateUpdateItem

	UGUIUtil.SetText(self.TextTitle, GetPanelUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextEng, GetPanelUIApi:GetString("TextEng"))

	self.goBtnTxt:GetComponent("Text").text = GetPanelUIApi:GetString("goBtnTxt")
end

function GetPanelUI:GetPreloadAssetPaths()
	return nil
end

function GetPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GetPanelUI:OnOpen(userData)
	if userData == nil then
		return
	end

	self.OpenTime = Time.realtimeSinceStartup

	self:UpdateView(tonumber(userData.cid), userData.items, userData.args)
end

function GetPanelUI:OnClose(userData)
	return
end

function GetPanelUI:OnPause()
	return
end

function GetPanelUI:OnResume()
	return
end

function GetPanelUI:OnCover()
	return
end

function GetPanelUI:OnReveal()
	return
end

function GetPanelUI:OnRefocus(userData)
	return
end

function GetPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GetPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GetPanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GetPanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GetPanelUI:OnDestroy()
	GetPanelItemCell.DisposeIn(self)
end

function GetPanelUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function GetPanelUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function GetPanelUI:OnClickCloseBtn()
	if Time.realtimeSinceStartup - self.OpenTime < 1 then
		return
	end

	UIModule.Close(Constant.UIControllerName.GetPanelUI)
end

function GetPanelUI:UpdateView(tipCid, items, args)
	self.RawItemDatas = items

	UGUIUtil.SetText(self.ContentText, getTipText(tipCid, unpack(args)))

	local wrapContent = self.ItemContainer:GetComponent("ScrollAreaList")

	wrapContent:Refresh(#items)
end

function GetPanelUI:UpdateItem(cell)
	local itemGo = cell.gameObject
	local rawItemData = self.RawItemDatas[cell.index + 1]
	local itemCell = GetPanelItemCell.PackageOrReuseView(self, itemGo)
	local itemData
	local tag = 0

	if rawItemData ~= nil then
		itemData = ItemData.CreateByCIDAndNumber(rawItemData.cid, rawItemData.num)
		tag = rawItemData.tag

		if rawItemData.placeGameEquipPOD ~= nil then
			itemData:Update(rawItemData)
		end
	end

	itemCell:SetItem(itemData, tag)
end

return GetPanelUI
