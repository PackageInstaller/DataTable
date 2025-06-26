-- chunkname: @IQIGame\\UI\\CommonTips\\ItemTipsContent\\ItemTipsOperationContent.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local __btnItem = {}

function __btnItem.New(view)
	local obj = Clone(__btnItem)

	obj:__Init(view)

	return obj
end

function __btnItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__clickEventProxy()
		if self.OnClickEventHandler ~= nil then
			self.OnClickEventHandler()
		end
	end

	self.gameObject:GetComponent("Button").onClick:AddListener(self.__clickEventProxy)
end

function __btnItem:SetData(userData)
	self.useText:GetComponent("Text").text = userData.btnName
	self.OnClickEventHandler = userData.eventHandler

	self.gameObject:SetActive(true)
end

function __btnItem:Hide()
	self.OnClickEventHandler = nil

	self.gameObject:SetActive(false)
end

function __btnItem:Dispose()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.__clickEventProxy)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

local ItemTipsOperationContent = {
	buttons = {}
}

ItemTipsOperationContent.ButtonItem = __btnItem

function ItemTipsOperationContent.New(view)
	local obj = Clone(ItemTipsOperationContent)

	obj:Init(view)

	return obj
end

function ItemTipsOperationContent:Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.BtnTemplate:SetActive(false)

	local btnItemParent = self.BtnTemplate.transform.parent.transform

	self.btnItemPool = UIViewObjectPool.New(self.BtnTemplate, btnItemParent, function(_view)
		return self.ButtonItem.New(_view)
	end)

	self:AddListeners()
end

function ItemTipsOperationContent:AddListeners()
	return
end

function ItemTipsOperationContent:RemoveListeners()
	return
end

function ItemTipsOperationContent:Dispose()
	self:RemoveListeners()
	self.btnItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.btnItemPool = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function ItemTipsOperationContent:SetData(userData)
	self.btnItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	for i = 1, #userData do
		local item = self.btnItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		item:SetData(userData[i])
	end
end

function ItemTipsOperationContent:Hide()
	self.btnItemPool:ForItems(function(_item)
		_item:Hide()
	end)
	self.gameObject:SetActive(false)
end

return ItemTipsOperationContent
