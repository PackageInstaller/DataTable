-- chunkname: @IQIGame\\UI\\Common\\BagView\\CommonBagItemView.lua

local BagItemView = {}

function BagItemView.New(view, viewClass)
	local obj = Clone(viewClass)

	obj:__Init(view)

	return obj
end

function BagItemView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__InitEventDelegate()
	self:__OnInit()
	self:__AddListener()
end

function BagItemView:__InitEventDelegate()
	self:__OnInitEventDelegate()
end

function BagItemView:__AddListener()
	self:__OnAddListener()
end

function BagItemView:__RemoveListener()
	self:__OnRemoveListener()
end

function BagItemView:Show(itemData)
	self.itemData = itemData

	self.gameObject:SetActive(true)
	self:__OnShow()
end

function BagItemView:Hide()
	self.gameObject:SetActive(false)
end

function BagItemView:ChangeSelectState(isSelect)
	return
end

function BagItemView:Dispose()
	self:__RemoveListener()
	self:__OnDispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function BagItemView:__OnInit()
	return
end

function BagItemView:__OnInitEventDelegate()
	return
end

function BagItemView:__OnAddListener()
	return
end

function BagItemView:__OnRemoveListener()
	return
end

function BagItemView:__OnShow()
	return
end

function BagItemView:__OnDispose()
	return
end

return BagItemView
