-- chunkname: @modules/logic/season/view/SeasonEquipView.lua

module("modules.logic.season.view.SeasonEquipView", package.seeall)

local SeasonEquipView = class("SeasonEquipView", BaseView)

function SeasonEquipView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._simagehero = gohelper.findChildSingleImage(self.viewGO, "left/hero/mask/#simage_hero")
	self._golackcards = gohelper.findChild(self.viewGO, "right/#go_lackcards")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "right/btncontain/#btn_equip")
	self._btnopenhandbook = gohelper.findChildButtonWithAudio(self.viewGO, "right/btncontain/#btn_openhandbook")
	self._goempty = gohelper.findChild(self.viewGO, "left/equipDesc/#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SeasonEquipView:addEvents()
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnopenhandbook:AddClickListener(self._btnhandbookOnClick, self)
end

function SeasonEquipView:removeEvents()
	self._btnequip:RemoveClickListener()
	self._btnopenhandbook:RemoveClickListener()
end

function SeasonEquipView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/hechengye_bj.jpg"))

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animEventWrap:AddEventListener("switch", self.handleSwitchAnimFrame, self)

	self._slotItems = {}
	self._descItems = {}
end

function SeasonEquipView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagehero:UnLoadImage()
	self._animEventWrap:RemoveAllEventListener()

	for _, slotItem in pairs(self._slotItems) do
		slotItem.btnClick:RemoveClickListener()
		gohelper.setActive(slotItem.goPos, true)

		if slotItem.icon then
			slotItem.icon:disposeUI()
			gohelper.destroy(slotItem.icon.viewGO)
		end

		if slotItem.animEventWrap then
			slotItem.animEventWrap:RemoveAllEventListener()
		end
	end

	Activity104EquipController.instance:onCloseView()
end

function SeasonEquipView:onOpen()
	if not self.viewParam.pos then
		local actId = self.viewParam.actId

		if not self.viewParam.slot then
			if not self.viewParam.group then
				local group = 1

				self.addEventCb(self, Activity104EquipController.instance, Activity104EquipEvent.EquipUpdate, self.handleEquipUpdate, self)
				self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self.handleSaveSucc, self)
				self.addEventCb(self, Activity104EquipController.instance, Activity104EquipEvent.EquipChangeCard, self.handleEquipCardChanged, self)
				self.addEventCb(self, Activity104EquipController.instance, Activity104EquipEvent.EquipChangeSlot, self.handleEquipSlotChanged, self)
				Activity104EquipController.instance:onOpenView(actId, group, self.viewParam.pos, self.viewParam.slot)
				self:refreshUI()
			end
		end
	end
end

function SeasonEquipView:onClose()
	return
end

function SeasonEquipView:refreshUI()
	local list = Activity104EquipItemListModel.instance:getList()
	local isEmptyList = not list or #list == 0

	gohelper.setActive(self._golackcards, isEmptyList)
	self:refreshSlots()
	self:refreshDescGroup()
end

function SeasonEquipView:handleEquipUpdate()
	self:refreshSlots()
	self:refreshDescGroup()
end

function SeasonEquipView:refreshSlots()
	local isEmptyShow = true

	for slotIndex = 1, Activity104EquipItemListModel.MaxPos do
		if Activity104EquipItemListModel.instance.curEquipMap[slotIndex] ~= Activity104EquipItemListModel.EmptyUid then
			isEmptyShow = false
		end

		self:refreshSlot(slotIndex)
	end

	gohelper.setActive(self._goempty, isEmptyShow)
end

function SeasonEquipView:refreshSlot(slotIndex)
	local item = self:getOrCreateSlot(slotIndex)
	local slotUnlockCount = Activity104EquipItemListModel.instance:getShowUnlockSlotCount()

	if slotUnlockCount < slotIndex then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local itemUid = Activity104EquipItemListModel.instance.curEquipMap[slotIndex]

	gohelper.setActive(item.goSelect, Activity104EquipItemListModel.instance.curSelectSlot == slotIndex)

	local isLock = Activity104EquipItemListModel.instance:slotIsLock(slotIndex)

	gohelper.setActive(item.goBtnAdd, not isLock)
	gohelper.setActive(item.goLock, isLock)

	if itemUid == Activity104EquipItemListModel.EmptyUid then
		gohelper.setActive(item.goPos, false)
		gohelper.setActive(item.goEmpty, true)
	else
		gohelper.setActive(item.goPos, true)
		gohelper.setActive(item.goEmpty, false)

		local icon = self:getOrCreateSlotIcon(item)
		local itemMO = Activity104EquipItemListModel.instance:getEquipMO(itemUid)

		if itemMO then
			icon:updateData(itemMO.itemId)
		end
	end
end

SeasonEquipView.MaxUISlot = 2

function SeasonEquipView:refreshDescGroup()
	for slot = 1, SeasonEquipView.MaxUISlot do
		local curShowItemUid = Activity104EquipItemListModel.instance.curEquipMap[slot]
		local descItem = self:getOrCreateDesc(slot)

		if not string.nilorempty(curShowItemUid) then
			self:refreshDesc(descItem, curShowItemUid, slot)
		end
	end
end

function SeasonEquipView:refreshDesc(descItem, itemUid, slotIndex)
	if gohelper.isNil(descItem.go) then
		return
	end

	if itemUid == Activity104EquipItemListModel.EmptyUid then
		gohelper.setActive(descItem.go, false)
	else
		gohelper.setActive(descItem.go, true)

		local itemMO = Activity104EquipItemListModel.instance:getEquipMO(itemUid)

		if itemMO then
			local itemCO = SeasonConfig.instance:getSeasonEquipCo(itemMO.itemId)

			if itemCO then
				descItem.txtName.text = string.format("[%s]", itemCO.name)

				local colorNameStr
				local colorDescStr = SeasonEquipMetaUtils.getCareerColorDarkBg(itemMO.itemId)

				if Activity104EquipItemListModel.instance.curSelectSlot ~= slotIndex then
					colorDescStr = colorDescStr .. SeasonEquipMetaUtils.No_Effect_Alpha
					colorNameStr = "#cac8c5" .. SeasonEquipMetaUtils.No_Effect_Alpha
				else
					colorNameStr = "#ec7731"
				end

				SLFramework.UGUI.GuiHelper.SetColor(descItem.txtName, colorNameStr)
				self:refreshProps(itemCO, descItem, colorDescStr)
				self:refreshSkills(itemCO, descItem, colorDescStr)
			else
				logError(string.format("can't find season equip config, id = [%s]", itemMO.itemId))
			end
		else
			logError(string.format("can't find season equip MO, itemUid = [%s]", itemUid))
		end
	end
end

function SeasonEquipView:refreshProps(itemCfg, descItem, colorStr)
	local processedSet = {}
	local isDirty = false

	if itemCfg and itemCfg.attrId ~= 0 then
		local propsList = SeasonEquipMetaUtils.getEquipPropsStrList(itemCfg.attrId)

		for index, propStr in ipairs(propsList) do
			local item = self:getOrCreatePropText(index, descItem)

			gohelper.setActive(item.go, true)

			item.txtDesc.text = propStr

			SLFramework.UGUI.GuiHelper.SetColor(item.txtDesc, colorStr)

			processedSet[item] = true
			isDirty = true
		end
	end

	for _, item in pairs(descItem.propItems) do
		if not processedSet[item] then
			gohelper.setActive(item.go, false)
		end
	end

	gohelper.setActive(descItem.goAttrParent, isDirty)
end

function SeasonEquipView:refreshSkills(itemCfg, descItem, colorStr)
	local skillList = SeasonEquipMetaUtils.getSkillEffectStrList(itemCfg)
	local processedSet = {}

	for index, skillStr in ipairs(skillList) do
		local item = self:getOrCreateSkillText(index, descItem)

		gohelper.setActive(item.go, true)

		item.txtDesc.text = skillStr

		SLFramework.UGUI.GuiHelper.SetColor(item.txtDesc, colorStr)

		processedSet[item] = true
	end

	for _, item in pairs(descItem.skillItems) do
		if not processedSet[item] then
			gohelper.setActive(item.go, false)
		end
	end
end

function SeasonEquipView:getOrCreatePropText(index, descItem)
	local item = descItem.propItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(descItem.goAttrDesc, "propname_" .. tostring(index))
		item.txtDesc = gohelper.findChildText(item.go, "txt_attributedesc")
		descItem.propItems[index] = item
	end

	return item
end

function SeasonEquipView:getOrCreateSkillText(index, descItem)
	local item = descItem.skillItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(descItem.goSkillDesc, "skill_" .. tostring(index))
		item.txtDesc = gohelper.findChildText(item.go, "txt_skilldesc")
		descItem.skillItems[index] = item
	end

	return item
end

function SeasonEquipView:getOrCreateSlot(slotIndex)
	local slotItem = self._slotItems[slotIndex]

	if not slotItem then
		slotItem = self:getUserDataTb_()
		slotItem.index = slotIndex
		slotItem.mainView = self
		slotItem.go = gohelper.findChild(self.viewGO, "left/equipSlot/slot" .. tostring(slotIndex))
		slotItem.goPos = gohelper.findChild(slotItem.go, "go_equip/go_pos")
		slotItem.goSelect = gohelper.findChild(slotItem.go, "go_equip/go_select")
		slotItem.goBtnAdd = gohelper.findChild(slotItem.go, "go_empty/btn_add")
		slotItem.goEmpty = gohelper.findChild(slotItem.go, "go_empty")
		slotItem.goLock = gohelper.findChild(slotItem.go, "go_lock")
		slotItem.btnClick = gohelper.findChildButtonWithAudio(slotItem.go, "btn_click")

		slotItem.btnClick:AddClickListener(self.onClickSlot, self, slotIndex)

		slotItem.animator = slotItem.go:GetComponent(typeof(UnityEngine.Animator))
		slotItem.animEventWrap = slotItem.go:GetComponent(typeof(ZProj.AnimationEventWrap))

		slotItem.animEventWrap:AddEventListener("switch", self.handleSlotSwitchAnimFrame, slotItem)

		self._slotItems[slotIndex] = slotItem
	end

	return slotItem
end

function SeasonEquipView:getOrCreateSlotIcon(slotItem)
	local icon = slotItem.icon

	if not icon then
		local path = self.viewContainer:getSetting().otherRes[2]
		local go = self:getResInst(path, slotItem.goPos, "icon")

		icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, SeasonCelebrityCardEquip)
		slotItem.icon = icon
	end

	return icon
end

function SeasonEquipView:getOrCreateDesc(index)
	local descItem = self._descItems[index]

	if not descItem then
		descItem = self:getUserDataTb_()
		descItem.go = gohelper.findChild(self.viewGO, "left/equipDesc/#go_equipDesc/#go_effect" .. tostring(index))
		descItem.txtName = gohelper.findChildText(descItem.go, "txt_name")
		descItem.goAttrDesc = gohelper.findChild(descItem.go, "desc/scroll_desc/Viewport/Content/attrlist/#go_attributeitem" .. tostring(index))
		descItem.goSkillDesc = gohelper.findChild(descItem.go, "desc/scroll_desc/Viewport/Content/skilldesc/#go_skilldescitem" .. tostring(index))
		descItem.goAttrParent = gohelper.findChild(descItem.go, "desc/scroll_desc/Viewport/Content/attrlist")
		descItem.propItems = {}
		descItem.skillItems = {}
		self._descItems[index] = descItem
	end

	return descItem
end

function SeasonEquipView:onClickSlot(slotIndex)
	if Activity104EquipItemListModel.instance.curSelectSlot ~= slotIndex then
		if not Activity104EquipItemListModel.instance:slotIsLock(slotIndex) then
			Activity104EquipController.instance:setSlot(slotIndex)
		else
			GameFacade.showToast(ToastEnum.SeasonEquipUnlock)
		end
	end
end

function SeasonEquipView:handleSaveSucc(snapshotId)
	if snapshotId == ModuleEnum.HeroGroupType.Season and self._isManualSave then
		GameFacade.showToast(Activity104EquipController.Toast_Save_Succ)
		self:closeThis()
	end
end

function SeasonEquipView:handleSwitchAnimFrame()
	self:refreshSlots()
	self:refreshDescGroup()
end

function SeasonEquipView.handleSlotSwitchAnimFrame(slotItem)
	local mainView = slotItem.mainView

	mainView:refreshDescGroup()
end

function SeasonEquipView:handleEquipCardChanged(param)
	local curSlot = Activity104EquipItemListModel.instance.curSelectSlot
	local slotItem = self:getOrCreateSlot(curSlot)
	local animName = param.isNew and "open" or "switch"

	slotItem.animator:Play(animName, 0, 0)

	if param.unloadSlot then
		slotItem = self:getOrCreateSlot(param.unloadSlot)

		slotItem.animator:Play("close", 0, 0)
	end

	self._animator:Play("switch", 0, 0)
end

function SeasonEquipView:handleEquipSlotChanged()
	self._animator:Play("switch", 0, 0)
	self:refreshSlots()
end

function SeasonEquipView:_btnequipOnClick()
	self._isManualSave = Activity104EquipController.instance:saveShowSlot()
end

function SeasonEquipView:_btnhandbookOnClick()
	ViewMgr.instance:openView(ViewName.SeasonEquipBookView, {
		actId = self.viewParam.actId
	})
end

return SeasonEquipView
