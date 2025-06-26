-- chunkname: @IQIGame\\UI\\PushShop\\PushItemDetailView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.commonSlotUI = ItemCell.New(self.CommonSlotUI, true)

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(previewItemsData)
	self.commonSlotUI:SetItemByCid(previewItemsData.cid)
	self.commonSlotUI:SetNum(previewItemsData.count)
	UGUIUtil.SetText(self.itemName, CfgItemTable[previewItemsData.cid].Name)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.commonSlotUI:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
