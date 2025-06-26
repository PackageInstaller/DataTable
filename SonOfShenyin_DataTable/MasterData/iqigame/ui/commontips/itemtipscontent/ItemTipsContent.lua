-- chunkname: @IQIGame\\UI\\CommonTips\\ItemTipsContent\\ItemTipsContent.lua

local ItemTipsHeadContent = require("IQIGame.UI.CommonTips.ItemTipsContent.ItemTipsHeadContent")
local ItemTipsInfoContent = require("IQIGame.UI.CommonTips.ItemTipsContent.ItemTipsInfoContent")
local ItemTipsOperationContent = require("IQIGame.UI.CommonTips.ItemTipsContent.ItemTipsOperationContent")
local CommonTipsHelper = require("IQIGame.UI.CommonTips.CommonTipsHelper")
local ItemTipsContent = {}

function ItemTipsContent.New(view)
	local obj = Clone(ItemTipsContent)

	obj:Init(view)

	return obj
end

function ItemTipsContent:Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.headContent = ItemTipsHeadContent.New(self.ItemTopParent)
	self.infoContent = ItemTipsInfoContent.New(self.ItemContentParent)
	self.operationContent = ItemTipsOperationContent.New(self.OperationParent)

	self:AddListeners()
end

function ItemTipsContent:AddListeners()
	return
end

function ItemTipsContent:RemoveListeners()
	return
end

function ItemTipsContent:Dispose()
	self:RemoveListeners()
	self.headContent:Dispose()
	self.infoContent:Dispose()
	self.operationContent:Dispose()

	self.itemData = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function ItemTipsContent:SetData(userData)
	self.itemData = userData.data

	self.headContent:SetData(self.itemData, userData)
	self.infoContent:SetData(self.itemData, userData)

	if not userData.cbParams.forShow then
		self.operationContent:SetData(CommonTipsHelper.GetTipsOperationButtonsDataByItemData(self.itemData, function()
			self:__UseSuccess()
		end))
	else
		self.operationContent:Hide()
	end
end

function ItemTipsContent:__UseSuccess(...)
	UIModule.Close(Constant.UIControllerName.CommonItemTipsUI)
end

return ItemTipsContent
