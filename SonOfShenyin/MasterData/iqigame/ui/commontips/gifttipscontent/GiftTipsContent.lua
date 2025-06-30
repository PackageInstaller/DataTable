-- chunkname: @IQIGame\\UI\\CommonTips\\GiftTipsContent\\GiftTipsContent.lua

local GiftTipsHeadContent = require("IQIGame.UI.CommonTips.GiftTipsContent.GiftTipsHeadContent")
local GiftTipsInfoContent = require("IQIGame.UI.CommonTips.GiftTipsContent.GiftTipsInfoContent")
local ItemTipsOperationContent = require("IQIGame.UI.CommonTips.ItemTipsContent.ItemTipsOperationContent")
local CommonTipsHelper = require("IQIGame.UI.CommonTips.CommonTipsHelper")
local GiftTipsContent = {}

function GiftTipsContent.New(view)
	local obj = Clone(GiftTipsContent)

	obj:__Init(view)

	return obj
end

function GiftTipsContent:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.headContent = GiftTipsHeadContent.New(self.GiftTopParent)
	self.infoContent = GiftTipsInfoContent.New(self.GiftContentParent)
	self.operationContent = ItemTipsOperationContent.New(self.OperationParent)

	self:__AddListeners()
end

function GiftTipsContent:__AddListeners()
	return
end

function GiftTipsContent:__RemoveListeners()
	return
end

function GiftTipsContent:Dispose()
	self:__RemoveListeners()
	self.headContent:Dispose()
	self.infoContent:Dispose()
	self.operationContent:Dispose()

	self.itemData = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function GiftTipsContent:SetData(userData)
	self.itemData = userData.data

	self.headContent:SetData(self.itemData, userData)
	self.infoContent:SetData(self.itemData, userData)

	if not userData.cbParams.forShow then
		self.operationContent:SetData(CommonTipsHelper.GetTipsOperationButtonsDataByItemData(self.itemData, function()
			return
		end))
	else
		self.operationContent:Hide()
	end
end

function GiftTipsContent:__UseSuccess()
	UIModule.Close(Constant.UIControllerName.CommonGiftTipsUI)
end

return GiftTipsContent
