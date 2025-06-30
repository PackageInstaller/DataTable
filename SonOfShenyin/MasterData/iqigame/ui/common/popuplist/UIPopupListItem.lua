-- chunkname: @IQIGame\\UI\\Common\\PopupList\\UIPopupListItem.lua

local UIPopupListItem = {}

function UIPopupListItem.New(view, clickEvent)
	local obj = Clone(UIPopupListItem)

	obj:__Init(view, clickEvent)

	return obj
end

function UIPopupListItem:__Init(view, clickEvent)
	self.gameObject = view
	self.onClickEventHandler = clickEvent

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	if self.ExtendInitFunc ~= nil then
		self.ExtendInitFunc(self)
	end

	function self.OnItemClickEventProxy()
		self:OnItemClickEventHandler()
	end

	self:__AddListeners()
end

function UIPopupListItem:__AddListeners()
	self.gameObject:GetComponent("Button").onClick:AddListener(self.OnItemClickEventProxy)

	if self.ExtendAddListenersFunc ~= nil then
		self.ExtendAddListenersFunc(self)
	end
end

function UIPopupListItem:__RemoveListeners()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.OnItemClickEventProxy)

	if self.ExtendRemoveListenersFunc ~= nil then
		self.ExtendRemoveListenersFunc(self)
	end
end

function UIPopupListItem:Dispose()
	self:__RemoveListeners()

	if self.ExtendDisposeFunc ~= nil then
		self.ExtendDisposeFunc(self)
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function UIPopupListItem:Show(index, itemData, isSelect)
	self.Index = index

	self.gameObject:SetActive(true)

	if self.ExtendShowFunc ~= nil then
		self.ExtendShowFunc(self, itemData, isSelect)
	end
end

function UIPopupListItem:Hide()
	self.gameObject:SetActive(false)
end

function UIPopupListItem:OnItemClickEventHandler()
	if self.onClickEventHandler ~= nil then
		self.onClickEventHandler(self)
	end
end

return UIPopupListItem
