-- chunkname: @modules/logic/sp02/operationactivity/view/AtomicOperationActivityPreparationView.lua

module("modules.logic.sp02.operationactivity.view.AtomicOperationActivityPreparationView", package.seeall)

local AtomicOperationActivityPreparationView = class("AtomicOperationActivityPreparationView", BaseView)

function AtomicOperationActivityPreparationView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "root/#simage_FullBG")
	self._simageArmFixed1 = gohelper.findChildSingleImage(self.viewGO, "root/layout/Talenttree/simage_weapon/#simage_ArmFixed_1")
	self._simageArmFixed2 = gohelper.findChildSingleImage(self.viewGO, "root/layout/Talenttree/simage_weapon/#simage_ArmFixed_2")
	self._simageArmFixed3 = gohelper.findChildSingleImage(self.viewGO, "root/layout/Talenttree/simage_weapon/#simage_ArmFixed_3")
	self._txtindex = gohelper.findChildText(self.viewGO, "root/layout/Detail/go_detail/#txt_index")
	self._txtname = gohelper.findChildText(self.viewGO, "root/layout/Detail/go_detail/#txt_name")
	self._scrollDesc = gohelper.findChildScrollRect(self.viewGO, "root/layout/Detail/go_detail/#scroll_Desc")
	self._gounlock = gohelper.findChild(self.viewGO, "root/layout/Detail/go_detail/btn/#go_unlock")
	self._golocked = gohelper.findChild(self.viewGO, "root/layout/Detail/go_detail/btn/#go_locked")
	self._txtlocked = gohelper.findChildText(self.viewGO, "root/layout/Detail/go_detail/btn/#go_locked/#txt_locked")
	self._gofinished = gohelper.findChild(self.viewGO, "root/layout/Detail/go_detail/btn/#go_finished")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicOperationActivityPreparationView:addEvents()
	self._btnUnlock:AddClickListener(self.onUnlockClick, self)
	self.addEventCb(self, AtomicOperationActivityController.instance, AtomicOperationActivityEvent.OnPreparationInfoUpdate, self.refreshUI, self)
end

function AtomicOperationActivityPreparationView:removeEvents()
	self._btnUnlock:RemoveClickListener()
	self.removeEventCb(self, AtomicOperationActivityController.instance, AtomicOperationActivityEvent.OnPreparationInfoUpdate, self.refreshUI, self)
end

function AtomicOperationActivityPreparationView:onUnlockClick()
	if not self.curIndex then
		return
	end

	if not AtomicOperationActivityModel.instance:isActivityOpen(self.actId) then
		return
	end

	if not self.infoMo:isPreparationUnlock(self.curIndex) then
		return
	end

	AtomicOperationActivityController.instance:activePreparation(self.actId, self.curIndex)
end

function AtomicOperationActivityPreparationView:_editableInitView()
	self._preparationItemList = self:getUserDataTb_()
	self._godetail = gohelper.findChild(self.viewGO, "root/layout/Detail/go_detail")
	self._txtDesc = gohelper.findChildTextMesh(self.viewGO, "root/layout/Detail/go_detail/#scroll_Desc/Viewport/Content/txt_Desc")
	self._btnUnlock = gohelper.findChildButton(self.viewGO, "root/layout/Detail/go_detail/btn/#go_unlock")
end

function AtomicOperationActivityPreparationView:onUpdateParam()
	return
end

function AtomicOperationActivityPreparationView:onOpen()
	self:checkParam()
	self:checkDefaultIndex()
	self:refreshUI()
end

function AtomicOperationActivityPreparationView:checkDefaultIndex()
	for _, config in ipairs(self.allConfig) do
		local id = config.id

		self.curIndex = config.id

		if self.infoMo:isPreparationUnlock(id) == false or self.infoMo:isPreparationFixed(id) == false then
			break
		end
	end
end

function AtomicOperationActivityPreparationView:checkParam()
	if not self.viewParam or not self.viewParam.actId then
		return
	end

	self.actId = self.viewParam.actId
	self.infoMo = AtomicOperationActivityModel.instance:getInfoMo(self.actId)
	self.allConfig = AtomicOperationActivityConfig.instance:getPreparationConfigList()
end

function AtomicOperationActivityPreparationView:refreshUI()
	self:refreshPreparationItem()
	self:onItemSelect(self.curIndex)
end

function AtomicOperationActivityPreparationView:refreshPreparationItem()
	local allConfig = AtomicOperationActivityConfig.instance:getPreparationConfigList()

	for index, config in ipairs(allConfig) do
		local item = self:getPreparationItem(index)

		if item then
			self:refreshSinglePreparationItem(item, config)
		end
	end
end

function AtomicOperationActivityPreparationView:refreshSinglePreparationItem(item, config)
	local isUnlock = self.infoMo:isPreparationUnlock(config.id)

	if isUnlock then
		::label_12_0::

		local isFixed = self.infoMo:isPreparationFixed(config.id)

		gohelper.setActive(item.goLocked, isUnlock)
		gohelper.setActive(item.goUnFixed, not isFixed)
		gohelper.setActive(item.goFixed, isFixed)
		gohelper.setActive(item.goUnlockTips, not isUnlock)

		if not isUnlock then
			item.txtUnlockTips.text = config.unlockdesc
		end
	end
end

function AtomicOperationActivityPreparationView:getPreparationItem(index)
	if not self._preparationItemList[index] then
		local item = self:createPreparationItem(index)

		self._preparationItemList[index] = item

		return item
	end

	return self._preparationItemList[index]
end

function AtomicOperationActivityPreparationView:createPreparationItem(index)
	local itemGo = gohelper.findChild(self.viewGO, string.format("root/layout/Talenttree/Part/Part%s", index))
	local item = self:getUserDataTb_()

	item.go = itemGo
	item.goLocked = gohelper.findChild(itemGo, "State/Locked")
	item.goUnFixed = gohelper.findChild(itemGo, "State/UnFixed")
	item.goFixed = gohelper.findChild(itemGo, "State/Fixed")
	item.goUnlockTips = gohelper.findChild(itemGo, "State/image_UnlockTips")
	item.txtUnlockTips = gohelper.findChildTextMesh(itemGo, "State/image_UnlockTips/#txt_UnlockTxt")
	item.reddot = gohelper.findChild(itemGo, "State/reddot")
	item.btnclick = gohelper.findChildButtonWithAudio(itemGo, "State/#btn_click")

	item.btnclick:AddClickListener(self.onItemClick, {
		target = self,
		index = index
	})

	return item
end

function AtomicOperationActivityPreparationView.onItemClick(param)
	local target = param.target
	local index = param.index

	target:onItemSelect(index)
end

function AtomicOperationActivityPreparationView:onItemSelect(index)
	if index == nil then
		gohelper.setActive(self._godetail, false)

		self.curIndex = nil

		return
	end

	self.curIndex = index

	gohelper.setActive(self._godetail, true)

	local config = AtomicOperationActivityConfig.instance:getPreparationConfig(index)

	self._txtDesc.text = config.buffdesc
	self._txtname.text = config.name
	self._txtindex.text = GameUtil.getRomanNums(config.id)

	local isUnlock = self.infoMo:isPreparationUnlock(config.id)

	if isUnlock then
		::label_16_0::

		local isFixed = self.infoMo:isPreparationFixed(config.id)

		gohelper.setActive(self._gounlock, isUnlock and not isFixed)
		gohelper.setActive(self._golocked, not isUnlock)
		gohelper.setActive(self._gofinished, isUnlock and isFixed)
	end
end

function AtomicOperationActivityPreparationView:onClose()
	return
end

function AtomicOperationActivityPreparationView:onDestroyView()
	for _, item in ipairs(self._preparationItemList) do
		item.btnclick:RemoveClickListener()
	end

	tabletool.clear(self._preparationItemList)

	self._preparationItemList = nil
end

return AtomicOperationActivityPreparationView
