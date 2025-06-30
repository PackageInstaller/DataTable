-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\DiySkillInfoView\\DiySkillBagItemCell.lua

local m = {
	isSelect = false,
	isLimit = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.__OnDelegateUpdateItemEvent(updateItems)
		self:__OnDelegateUpdateItem(updateItems)
	end

	self.itemCell = ItemCell.New(self.CommonSlotUI, false, false, false)

	self:AddListeners()
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.__OnDelegateUpdateItemEvent)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.__OnDelegateUpdateItemEvent)
end

function m:SetData(itemData, heroCid, index)
	self.itemData = itemData
	self.heroCid = heroCid

	self.itemCell:SetItem(itemData)
	self.itemCell:SetItemLv(itemData.skillData.lv)
	self.itemCell:SetHeroTag(itemData.skillData.heroCid)
	self.itemCell:SetLockVisable(itemData.skillData.lock)

	self.isLimit = not DiySkillModule.GetDiySkillIsLimit(self.itemData.skillData, self.heroCid)
	self.View.name = index

	LuaUtility.SetGameObjectShow(self.limitImg, self.isLimit)

	if self.isSelect and self.lastItemId == self.itemData.id then
		self:OnSelect()
	end
end

function m:OnSelect()
	self.lastItemId = self.itemData.id
	self.isSelect = true

	self.itemCell:SetSelectFrame(true)
end

function m:OnCancelSelect()
	self.lastItemId = nil
	self.isSelect = false

	self.itemCell:SetSelectFrame(false)
end

function m:__OnDelegateUpdateItem(updateItems)
	for _, itemData in pairs(updateItems) do
		if self.itemData.id == itemData.id then
			self:SetData(itemData)

			return
		end
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
