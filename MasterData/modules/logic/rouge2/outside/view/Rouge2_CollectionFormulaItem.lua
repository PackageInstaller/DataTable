-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CollectionFormulaItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_CollectionFormulaItem", package.seeall)

local Rouge2_CollectionFormulaItem = class("Rouge2_CollectionFormulaItem", ListScrollCellExtend)

function Rouge2_CollectionFormulaItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._imagebg = gohelper.findChildImage(self.viewGO, "#go_normal/#image_bg")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#image_collection")
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._imagelockedRare = gohelper.findChildImage(self.viewGO, "#go_locked")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._godlctag = gohelper.findChild(self.viewGO, "#go_dlctag")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CollectionFormulaItem:_editableInitView()
	self._gonew = gohelper.findChild(self.viewGO, "#go_normal/go_new")
	self._click = gohelper.getClickWithAudio(self.viewGO, AudioEnum.UI.UI_Common_Click)
	self.animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
end

function Rouge2_CollectionFormulaItem:_editableAddEvents()
	self._click:AddClickListener(self._onClickItem, self)
end

function Rouge2_CollectionFormulaItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function Rouge2_CollectionFormulaItem:_onClickItem()
	if self.type == Rouge2_OutsideEnum.CollectionType.Formula then
		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnSelectCollectionFormulaItem, self._mo.itemId)
	elseif self.type == Rouge2_OutsideEnum.CollectionType.Material then
		local param = {}

		param.selectMaterialId = self._mo.itemId

		Rouge2_OutsideController.instance:openMaterialListView(param)
	end
end

function Rouge2_CollectionFormulaItem:onUpdateMO(mo)
	self._mo = mo
	self.type = mo.type
	self.itemId = mo.itemId
	self.needCount = mo.needCount
	self.showRedDot = mo.showRedDot

	self:refreshUI()
end

function Rouge2_CollectionFormulaItem:refreshUI()
	local id = self.itemId

	gohelper.setActive(self._txtnum, self.type == Rouge2_OutsideEnum.CollectionType.Material)

	if self.showRedDot and self.type == Rouge2_OutsideEnum.CollectionType.Formula then
		TaskDispatcher.cancelTask(self.onDelayPlayUnlock, self)

		local reddot = RedDotController.instance:addRedDot(self._gonew, RedDotEnum.DotNode.V3a2_Rouge_Favorite_Formula, id)

		if reddot.show then
			Rouge2_OutsideController.instance:addShowRedDot(Rouge2_OutsideEnum.LocalData.Formula, id)
			TaskDispatcher.runDelay(self.onDelayPlayUnlock, self, 1)
		else
			self.animator:Play("idle", 0, 0)
		end
	end

	if self.type == Rouge2_OutsideEnum.CollectionType.Formula then
		local isUnlock = Rouge2_AlchemyModel.instance:isFormulaUnlock(id)

		gohelper.setActive(self._golocked, not isUnlock)
		gohelper.setActive(self._gonormal, isUnlock)

		local formulaConfig = Rouge2_OutSideConfig.instance:getFormulaConfig(id)

		if not isUnlock then
			Rouge2_IconHelper.setAlchemyRareBg(formulaConfig.rare, self._imagelockedRare)

			return
		end

		Rouge2_IconHelper.setFormulaIcon(id, self._simagecollection)
		Rouge2_IconHelper.setAlchemyRareBg(formulaConfig.rare, self._imagebg)
	elseif self.type == Rouge2_OutsideEnum.CollectionType.Material then
		local materialConfig = Rouge2_OutSideConfig.instance:getMaterialConfig(id)

		Rouge2_IconHelper.setMaterialIcon(id, self._simagecollection)

		local rare = materialConfig.rare

		Rouge2_IconHelper.setMaterialRareBg(rare, self._imagebg)
		Rouge2_IconHelper.setMaterialRareBg(rare, self._imagelockedRare)

		local count = self.needCount

		self._txtnum.text = tostring(count)
	end
end

function Rouge2_CollectionFormulaItem:onDelayPlayUnlock()
	self.animator:Play("unlock", 0, 0)
	TaskDispatcher.cancelTask(self.onDelayPlayUnlock, self)
end

function Rouge2_CollectionFormulaItem:onSelect(isSelect)
	TaskDispatcher.cancelTask(self.onDelayPlayUnlock, self)
	gohelper.setActive(self._goselected, isSelect)
end

function Rouge2_CollectionFormulaItem:onDestroyView()
	return
end

return Rouge2_CollectionFormulaItem
