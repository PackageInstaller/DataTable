-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CollectionListItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_CollectionListItem", package.seeall)

local Rouge2_CollectionListItem = class("Rouge2_CollectionListItem", ListScrollCellExtend)

function Rouge2_CollectionListItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._gonew = gohelper.findChild(self.viewGO, "#go_normal/go_new")
	self._imagebg = gohelper.findChildImage(self.viewGO, "#go_normal/#image_bg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#image_collection")
	self._imagecollection = gohelper.findChildImage(self.viewGO, "#go_normal/#image_collection")
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._imagelockedRare = gohelper.findChildImage(self.viewGO, "#go_locked")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._godlctag = gohelper.findChild(self.viewGO, "#go_dlctag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CollectionListItem:addEvents()
	return
end

function Rouge2_CollectionListItem:removeEvents()
	return
end

function Rouge2_CollectionListItem:_editableInitView()
	self._click = gohelper.getClickWithAudio(self.viewGO, AudioEnum.UI.UI_Common_Click)
	self._color = self._imagecollection.color
	self._orderColor = self._txtnum.color

	gohelper.setActive(self._simagecollection.gameObject, true)

	self.animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
end

function Rouge2_CollectionListItem:_editableAddEvents()
	self._click:AddClickListener(self._onClickItem, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnClickCollectionListItem, self._onClickCollectionListItem, self)
end

function Rouge2_CollectionListItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function Rouge2_CollectionListItem:_onClickItem()
	Rouge2_CollectionListModel.instance:setSelectedConfig(self._mo)

	if self._showNewFlag then
		-- block empty
	end
end

function Rouge2_CollectionListItem:_onClickCollectionListItem()
	self:_updateSelected()
end

function Rouge2_CollectionListItem:_updateSelected()
	local selectedConfig = Rouge2_CollectionListModel.instance:getSelectedConfig()

	gohelper.setActive(self._goselected, selectedConfig and selectedConfig == self._mo)
end

function Rouge2_CollectionListItem:onUpdateMO(mo)
	self._mo = mo

	local isShow = mo ~= nil

	gohelper.setActive(self.viewGO, isShow)

	if not isShow then
		return
	end

	local isUnlock = Rouge2_OutsideModel.instance:collectionIsUnlock(mo.id)
	local isPass

	if isUnlock then
		isPass = Rouge2_OutsideModel.instance:collectionIsPass(mo.id)
		self._color.a = isPass and 1 or 0.3
		self._imagecollection.color = self._color
	end

	self._orderColor.a = isPass and 0.7 or 0.3
	self._txtnum.color = self._orderColor
	self._txtnum.text = tostring(Rouge2_CollectionListModel.instance:getItemIndex(self._mo.id))

	if not mo.rare then
		Rouge2_IconHelper.setAlchemyRareBg(mo.rare, self._imagebg)
		Rouge2_IconHelper.setAlchemyRareBg(mo.rare, self._imagelockedRare)
		gohelper.setActive(self._gonormal, isUnlock)
		gohelper.setActive(self._golocked, not isUnlock)
		self:_updateSelected()
		Rouge2_CollectionHelper.setItemIcon(self._simagecollection, mo.id)
		self:_updateNewFlag()
	end
end

function Rouge2_CollectionListItem:onDelayPlayUnlock()
	self.animator:Play("unlock", 0, 0)
	TaskDispatcher.cancelTask(self.onDelayPlayUnlock, self)
end

function Rouge2_CollectionListItem:_updateNewFlag()
	TaskDispatcher.cancelTask(self.onDelayPlayUnlock, self)

	local reddot = RedDotController.instance:addRedDot(self._gonew, RedDotEnum.DotNode.V3a2_Rouge_Favorite_Collection, self._mo.id)

	if reddot.show then
		Rouge2_OutsideController.instance:addShowRedDot(Rouge2_OutsideEnum.LocalData.Collection, self._mo.id)
		TaskDispatcher.runDelay(self.onDelayPlayUnlock, self, 0.5)
	else
		self.animator:Play("idle", 0, 0)
	end
end

function Rouge2_CollectionListItem:onSelect(isSelect)
	return
end

function Rouge2_CollectionListItem:onDestroyView()
	TaskDispatcher.cancelTask(self.onDelayPlayUnlock, self)
end

return Rouge2_CollectionListItem
