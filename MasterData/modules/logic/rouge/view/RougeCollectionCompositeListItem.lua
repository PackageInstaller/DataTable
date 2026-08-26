-- chunkname: @modules/logic/rouge/view/RougeCollectionCompositeListItem.lua

module("modules.logic.rouge.view.RougeCollectionCompositeListItem", package.seeall)

local RougeCollectionCompositeListItem = class("RougeCollectionCompositeListItem", ListScrollCellExtend)

function RougeCollectionCompositeListItem:onInitView()
	self._gocollectionicon = gohelper.findChild(self.viewGO, "go_collectionicon")
	self._gocancomposite = gohelper.findChild(self.viewGO, "go_cancomposite")
	self._goselectframe = gohelper.findChild(self.viewGO, "go_selectframe")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionCompositeListItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RougeCollectionCompositeListItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RougeCollectionCompositeListItem:_btnclickOnClick()
	RougeController.instance:dispatchEvent(RougeEvent.OnSelectCollectionCompositeItem, self._mo.id)
end

function RougeCollectionCompositeListItem:_editableInitView()
	return
end

function RougeCollectionCompositeListItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function RougeCollectionCompositeListItem:refreshUI()
	if not self._mo then
		return
	end

	local synthesisCfgId = self._mo.id
	local productId = self._mo.product
	local isCanComposite = self:checkIsCanComposite(synthesisCfgId)

	gohelper.setActive(self._gocancomposite, isCanComposite)

	local curSelectId = RougeCollectionCompositeListModel.instance:getCurSelectCellId()
	local isSelect = curSelectId == self._mo.id

	gohelper.setActive(self._goselectframe, isSelect)
	self:refreshProductIcon(productId)
end

function RougeCollectionCompositeListItem:refreshProductIcon(productId)
	if not self._iconItem then
		local setting = self._view.viewContainer:getSetting()
		local iconGO = self._view:getResInst(setting.otherRes[1], self._gocollectionicon, "itemicon")

		self._iconItem = RougeCollectionIconItem.New(iconGO)
	end

	self._iconItem:onUpdateMO(productId)
	self._iconItem:setHolesVisible(false)
end

function RougeCollectionCompositeListItem:checkIsCanComposite(synthesisId)
	local compositeIdAndCountMap = RougeCollectionConfig.instance:getCollectionCompositeIdAndCount(synthesisId)
	local isCanComposite = true

	if compositeIdAndCountMap then
		for compositeId, needCount in pairs(compositeIdAndCountMap) do
			local curHasCount = RougeCollectionModel.instance:getCollectionCountById(compositeId)

			if curHasCount < needCount then
				isCanComposite = false

				break
			end
		end
	end

	return isCanComposite
end

function RougeCollectionCompositeListItem:onSelect(isSelect)
	gohelper.setActive(self._goselectframe, isSelect)
end

function RougeCollectionCompositeListItem:onDestroyView()
	if self._iconItem then
		self._iconItem:destroy()

		self._iconItem = nil
	end
end

return RougeCollectionCompositeListItem
