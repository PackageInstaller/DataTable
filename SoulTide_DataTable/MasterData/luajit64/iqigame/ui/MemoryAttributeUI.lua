-- chunkname: @IQIGame\\UI\\MemoryAttributeUI.lua

local MemoryAttributeUI = Base:Extend("MemoryAttributeUI", "IQIGame.Onigao.UI.MemoryAttributeUI", {})

function MemoryAttributeUI:OnInit()
	UGUIUtil.SetText(self.TitleText3, MemoryUIApi:GetString("TitleText3"))
	UGUIUtil.SetText(self.TitleText4, MemoryUIApi:GetString("TitleText4"))

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end
end

function MemoryAttributeUI:GetPreloadAssetPaths()
	return nil
end

function MemoryAttributeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MemoryAttributeUI:OnOpen(userData)
	self.soulCid = userData[1]
	self.scrollPageList = self.Grid2:GetComponent("ScrollAreaList")

	function self.scrollPageList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	self:UpDateView()
end

function MemoryAttributeUI:OnClose(userData)
	return
end

function MemoryAttributeUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
end

function MemoryAttributeUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
end

function MemoryAttributeUI:OnPause()
	return
end

function MemoryAttributeUI:OnResume()
	return
end

function MemoryAttributeUI:OnCover()
	return
end

function MemoryAttributeUI:OnReveal()
	return
end

function MemoryAttributeUI:OnRefocus(userData)
	return
end

function MemoryAttributeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MemoryAttributeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MemoryAttributeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MemoryAttributeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MemoryAttributeUI:OnDestroy()
	return
end

function MemoryAttributeUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.MemoryAttributeUI)
end

function MemoryAttributeUI:UpDateView()
	self.tabAttribute = MemoryModule.GetTotalMemoryAdd(self.soulCid)
	self.attributeIDs = {}

	for i, v in pairs(self.tabAttribute) do
		table.insert(self.attributeIDs, i)
	end

	table.sort(self.attributeIDs, function(a, b)
		return a < b
	end)
	self.scrollPageList:Refresh(#self.attributeIDs)
end

function MemoryAttributeUI:OnRenderGridCell(cell)
	local item = cell.gameObject

	item:SetActive(true)

	local id = self.attributeIDs[cell.index + 1]
	local value = self.tabAttribute[id]
	local str = AttributeModule.GetAttName(id) .. "+" .. AttributeModule.GetAttShowValue(id, value)

	UGUIUtil.SetText(item.transform:Find("Text_01").gameObject, str)
end

return MemoryAttributeUI
