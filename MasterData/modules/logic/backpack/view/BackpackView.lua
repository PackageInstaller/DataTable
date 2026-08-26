-- chunkname: @modules/logic/backpack/view/BackpackView.lua

module("modules.logic.backpack.view.BackpackView", package.seeall)

local BackpackView = class("BackpackView", BaseView)

function BackpackView:onInitView()
	self._scrollcategory = gohelper.findChildScrollRect(self.viewGO, "#scroll_category")
	self._scrollprop = gohelper.findChildScrollRect(self.viewGO, "#scroll_prop")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BackpackView:addEvents()
	BackpackController.instance:registerCallback(BackpackEvent.SelectCategory, self._onSelectCategoryChange, self)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, self._refreshView, self)
	CurrencyController.instance:registerCallback(CurrencyEvent.RefreshPowerMakerInfo, self._refreshPowerMakerInfo, self)
end

function BackpackView:removeEvents()
	BackpackController.instance:unregisterCallback(BackpackEvent.SelectCategory, self._onSelectCategoryChange, self)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, self._refreshView, self)
	CurrencyController.instance:unregisterCallback(CurrencyEvent.RefreshPowerMakerInfo, self._refreshPowerMakerInfo, self)
end

function BackpackView:onOpenFinish()
	self._anim.enabled = true

	local currentSelectCategoryId = BackpackModel.instance:getCurCategoryId()

	if currentSelectCategoryId ~= ItemEnum.CategoryType.Material and currentSelectCategoryId ~= ItemEnum.CategoryType.UseType and currentSelectCategoryId ~= ItemEnum.CategoryType.HeroExpBox then
		self:_onSelectCategoryChange()
	end
end

function BackpackView:onOpen()
	self._cateList = self.viewParam.data.cateList
	self._enableAni = true

	self:_refreshDeadline()
	CharacterBackpackEquipListModel.instance:openEquipView()
end

function BackpackView:onClose()
	BackpackModel.instance:setItemAniHasShown(false)
end

function BackpackView:_refreshView()
	self._cateList = BackpackController.instance:getCategoryCoList()

	BackpackModel.instance:setBackpackCategoryList(self._cateList)
	BackpackCategoryListModel.instance:setCategoryList(self._cateList)
end

function BackpackView:_refreshPowerMakerInfo()
	ItemPowerModel.instance:setPowerMakerItemsList()
	BackpackModel.instance:setPowerMakerItemsList()

	local id = BackpackModel.instance:getCurCategoryId()
	local itemList = BackpackModel.instance:getCategoryItemlist(id)

	BackpackPropListModel.instance:setCategoryPropItemList(itemList)
end

function BackpackView:_refreshDeadline()
	self._itemDeadline = BackpackModel.instance:getItemDeadline()

	if self._itemDeadline then
		TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
	end
end

function BackpackView:_onSelectCategoryChange()
	local currentSelectCategoryId = BackpackModel.instance:getCurCategoryId()

	if self.viewContainer:getCurrentSelectCategoryId() == currentSelectCategoryId and not self.viewParam.isJump then
		self.viewParam.isJump = false

		return
	end

	self:_refreshView()

	if currentSelectCategoryId == ItemEnum.CategoryType.Equip then
		self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, 2)
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	elseif currentSelectCategoryId == ItemEnum.CategoryType.Antique then
		self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, 3)
	else
		self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, 1)
		self:_refreshDeadline()
	end
end

function BackpackView:_onRefreshDeadline()
	if self._itemDeadline and self._itemDeadline > 0 then
		local limitSec = self._itemDeadline - ServerTime.now()

		if limitSec <= -1 then
			if self._sendCount then
				self._sendCount = self._sendCount + 1 or 1
			end

			if self._sendCount < 2 then
				ItemRpc.instance:autoUseExpirePowerItem()
			else
				self._sendCount = 0
			end
		end
	end
end

function BackpackView:onDestroyView()
	BackpackPropListModel.instance:clearList()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	self._imgBg:UnLoadImage()
end

function BackpackView:_editableInitView()
	self._imgBg = gohelper.findChildSingleImage(self.viewGO, "bg/bgimg")

	self._imgBg:LoadImage(ResUrl.getCommonViewBg("full/beibao_bj"))
end

return BackpackView
