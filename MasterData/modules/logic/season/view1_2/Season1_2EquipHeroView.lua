-- chunkname: @modules/logic/season/view1_2/Season1_2EquipHeroView.lua

module("modules.logic.season.view1_2.Season1_2EquipHeroView", package.seeall)

local Season1_2EquipHeroView = class("Season1_2EquipHeroView", BaseView)

function Season1_2EquipHeroView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/right/#btn_equip")
	self._btnopenhandbook = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/right/#btn_openhandbook")
	self._btnopenhandbook2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_empty/#btn_openhandbook2")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_2EquipHeroView:addEvents()
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnopenhandbook:AddClickListener(self._btnhandbookOnClick, self)
	self._btnopenhandbook2:AddClickListener(self._btnhandbookOnClick, self)
end

function Season1_2EquipHeroView:removeEvents()
	self._btnequip:RemoveClickListener()
	self._btnopenhandbook:RemoveClickListener()
	self._btnopenhandbook2:RemoveClickListener()
end

function Season1_2EquipHeroView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/hechengye_bj.jpg"))

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animEventWrap:AddEventListener("switch", self.handleSwitchAnimFrame, self)

	self._goNormalRight = gohelper.findChild(self._gonormal, "right")
	self._slotItems = {}
end

function Season1_2EquipHeroView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._animEventWrap:RemoveAllEventListener()

	for _, slotItem in pairs(self._slotItems) do
		gohelper.setActive(slotItem.goPos, true)

		if slotItem.icon then
			slotItem.icon:disposeUI()
			gohelper.destroy(slotItem.icon.viewGO)
		end
	end

	if self._descItem and self._descItem.simageBlackMask then
		self._descItem.simageBlackMask:UnLoadImage()
	end

	Activity104EquipController.instance:onCloseView()
end

function Season1_2EquipHeroView:onOpen()
	local pos = Activity104EquipItemListModel.MainCharPos
	local actId = self.viewParam.actId

	if not self.viewParam.slot then
		if not self.viewParam.group then
			local group = 1

			self.addEventCb(self, Activity104EquipController.instance, Activity104EquipEvent.EquipUpdate, self.handleEquipUpdate, self)
			self.addEventCb(self, Activity104EquipController.instance, Activity104EquipEvent.EquipChangeCard, self.handleEquipCardChanged, self)
			self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self.handleSaveSucc, self)
			Activity104EquipController.instance:onOpenView(actId, group, pos, self.viewParam.slot)
			self:refreshUI()
		end
	end
end

function Season1_2EquipHeroView:onClose()
	return
end

function Season1_2EquipHeroView:refreshUI()
	local isEmptyList = Activity104EquipItemListModel.instance:getCount() == 0

	gohelper.setActive(self._goempty, isEmptyList)
	gohelper.setActive(self._goNormalRight, not isEmptyList)
	self:refreshDescGroup()
	self:refreshSlots()
end

function Season1_2EquipHeroView:handleEquipUpdate()
	self:refreshDescGroup()
	self:refreshSlots()
end

function Season1_2EquipHeroView:refreshSlots()
	for slotIndex = 1, Activity104EquipItemListModel.HeroMaxPos do
		self:refreshSlot(slotIndex)
	end
end

function Season1_2EquipHeroView:refreshSlot(slotIndex)
	local item = self:getOrCreateSlot(slotIndex)
	local itemUid = Activity104EquipItemListModel.instance.curEquipMap[slotIndex]

	gohelper.setActive(item.goSelect, false)

	if itemUid == Activity104EquipItemListModel.EmptyUid then
		gohelper.setActive(item.goPos, false)
		gohelper.setActive(item.goEmpty, true)
		gohelper.setActive(item.goRareEffect, false)
	else
		gohelper.setActive(item.goPos, true)
		gohelper.setActive(item.goRareEffect, true)
		gohelper.setActive(item.goEmpty, false)

		local icon = self:getOrCreateSlotIcon(item)
		local itemMO = Activity104EquipItemListModel.instance:getEquipMO(itemUid)

		if itemMO then
			icon:updateData(itemMO.itemId)
		end
	end
end

function Season1_2EquipHeroView:refreshDescGroup()
	local pos, slot = Activity104EquipItemListModel.instance.curPos, Activity104EquipItemListModel.instance.curSelectSlot
	local curShowItemUid = Activity104EquipItemListModel.instance.curEquipMap[slot]

	self:refreshDesc(self:getOrCreateDesc(), curShowItemUid)
end

function Season1_2EquipHeroView:refreshDesc(descItem, itemUid)
	if itemUid == Activity104EquipItemListModel.EmptyUid then
		gohelper.setActive(descItem.go, false)
	else
		gohelper.setActive(descItem.go, true)
		descItem.simageBlackMask:LoadImage(ResUrl.getSeasonIcon("black4.png"))

		local itemMO = Activity104EquipItemListModel.instance:getEquipMO(itemUid)

		if itemMO then
			local itemCO = SeasonConfig.instance:getSeasonEquipCo(itemMO.itemId)

			if itemCO then
				descItem.txtName.text = string.format("[%s]", itemCO.name)

				local colorStr = SeasonEquipMetaUtils.getCareerColorDarkBg(itemMO.itemId)

				self:refreshProps(itemCO, descItem, colorStr)
				self:refreshSkills(itemCO, descItem, colorStr)
			else
				logError(string.format("can't find season equip config, id = [%s]", itemMO.itemId))
			end
		else
			logError(string.format("can't find season equip MO, itemUid = [%s]", itemUid))
		end
	end
end

function Season1_2EquipHeroView:refreshProps(itemCfg, descItem, colorStr)
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

function Season1_2EquipHeroView:refreshSkills(itemCfg, descItem, colorStr)
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

function Season1_2EquipHeroView:getOrCreatePropText(index, descItem)
	local item = descItem.propItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(descItem.goAttrDesc, "propname_" .. tostring(index))
		item.txtDesc = gohelper.findChildText(item.go, "txt_attributedesc")
		descItem.propItems[index] = item
	end

	return item
end

function Season1_2EquipHeroView:getOrCreateSkillText(index, descItem)
	local item = descItem.skillItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(descItem.goSkillDesc, "skill_" .. tostring(index))
		item.txtDesc = gohelper.findChildText(item.go, "txt_skilldesc")
		descItem.skillItems[index] = item
	end

	return item
end

function Season1_2EquipHeroView:getOrCreateSlot(slotIndex)
	local slotItem = self._slotItems[slotIndex]

	if not slotItem then
		slotItem = self:getUserDataTb_()
		slotItem.go = gohelper.findChild(self.viewGO, "#go_normal/left/equipSlot/slot" .. tostring(slotIndex))
		slotItem.goEmpty = gohelper.findChild(slotItem.go, "go_empty")
		slotItem.goPos = gohelper.findChild(slotItem.go, "go_equip/go_pos")
		slotItem.goSelect = gohelper.findChild(slotItem.go, "go_equip/go_select")
		slotItem.goRareEffect = gohelper.findChild(slotItem.go, "go_rareeffect")
		self._slotItems[slotIndex] = slotItem
	end

	return slotItem
end

function Season1_2EquipHeroView:getOrCreateSlotIcon(slotItem)
	local icon = slotItem.icon

	if not icon then
		local path = self.viewContainer:getSetting().otherRes[2]
		local go = self:getResInst(path, slotItem.goPos, "icon")

		icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season1_2CelebrityCardEquip)
		slotItem.icon = icon
	end

	return icon
end

function Season1_2EquipHeroView:getOrCreateDesc()
	local descItem = self._descItem

	if not descItem then
		descItem = self:getUserDataTb_()
		descItem.go = gohelper.findChild(self.viewGO, "#go_normal/left/equipDesc/#go_equipDesc")
		descItem.goEffect = gohelper.findChild(descItem.go, "#go_effect")
		descItem.txtName = gohelper.findChildText(descItem.go, "#go_effect/txt_name")
		descItem.txtDesc = gohelper.findChildText(descItem.go, "#go_effect/scroll_desc/Viewport/#txt_desc")
		descItem.goAttrDesc = gohelper.findChild(descItem.go, "#go_effect/scroll_desc/Viewport/Content/attrlist/#go_attributeitem")
		descItem.goSkillDesc = gohelper.findChild(descItem.go, "#go_effect/scroll_desc/Viewport/Content/skilldesc/#go_skilldescitem")
		descItem.goAttrParent = gohelper.findChild(descItem.go, "#go_effect/scroll_desc/Viewport/Content/attrlist")
		descItem.simageBlackMask = gohelper.findChildSingleImage(descItem.go, "#go_effect/simage_blackmask")
		descItem.propItems = {}
		descItem.skillItems = {}
		self._descItem = descItem
	end

	return descItem
end

function Season1_2EquipHeroView:handleSaveSucc(snapshotId)
	if snapshotId == ModuleEnum.HeroGroupType.Season and self._isManualSave then
		GameFacade.showToast(Activity104EquipController.Toast_Save_Succ)
		self:closeThis()
	end
end

function Season1_2EquipHeroView:handleSwitchAnimFrame()
	logNormal("refresh by switch anim frame")
	self:refreshSlots()
	self:refreshDescGroup()
end

function Season1_2EquipHeroView:handleEquipCardChanged(param)
	self._animator:Play("switch", 0, 0)
end

function Season1_2EquipHeroView:_btnequipOnClick()
	self._isManualSave = Activity104EquipController.instance:saveShowSlot()
end

function Season1_2EquipHeroView:_btnhandbookOnClick()
	ViewMgr.instance:openView(ViewName.Season1_2EquipBookView, {
		actId = self.viewParam.actId
	})
end

return Season1_2EquipHeroView
