-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9EquipHeroView.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9EquipHeroView", package.seeall)

local Season123_1_9EquipHeroView = class("Season123_1_9EquipHeroView", BaseView)

function Season123_1_9EquipHeroView:onInitView()
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

function Season123_1_9EquipHeroView:addEvents()
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnopenhandbook:AddClickListener(self._btnhandbookOnClick, self)
	self._btnopenhandbook2:AddClickListener(self._btnhandbookOnClick, self)
end

function Season123_1_9EquipHeroView:removeEvents()
	self._btnequip:RemoveClickListener()
	self._btnopenhandbook:RemoveClickListener()
	self._btnopenhandbook2:RemoveClickListener()
end

function Season123_1_9EquipHeroView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/hechengye_bj.jpg"))

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animEventWrap:AddEventListener("switch", self.handleSwitchAnimFrame, self)

	self._goNormalRight = gohelper.findChild(self._gonormal, "right")
	self._slotItems = {}
	self._descItems = {}
end

function Season123_1_9EquipHeroView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._animEventWrap:RemoveAllEventListener()

	for _, slotItem in pairs(self._slotItems) do
		gohelper.setActive(slotItem.goPos, true)

		if slotItem.icon then
			slotItem.icon:disposeUI()
			gohelper.destroy(slotItem.icon.viewGO)
		end

		if slotItem.btnClick then
			slotItem.btnClick:RemoveClickListener()
		end
	end

	Season123EquipHeroController.instance:onCloseView()
end

function Season123_1_9EquipHeroView:onOpen()
	local actId = self.viewParam.actId

	if not self.viewParam.slot then
		if not self.viewParam.group then
			self.addEventCb(self, Season123EquipHeroController.instance, Season123EquipEvent.EquipUpdate, self.handleEquipUpdate, self)
			self.addEventCb(self, Season123EquipHeroController.instance, Season123EquipEvent.EquipChangeCard, self.handleEquipCardChanged, self)
			self.addEventCb(self, Season123EquipHeroController.instance, Season123EquipEvent.EquipChangeSlot, self.handleEquipSlotChanged, self)
			self.addEventCb(self, Season123EquipBookController.instance, Season123Event.OnItemChange, self.refreshUI, self)
			Season123EquipHeroController.instance:onOpenView(actId, self.viewParam.stage, self.viewParam.slot, self.handleSaveSucc, self, self.viewParam.equipUidList)
			self:refreshUI()
		end
	end
end

function Season123_1_9EquipHeroView:onClose()
	return
end

function Season123_1_9EquipHeroView:refreshUI()
	local isEmptyList = Season123EquipHeroItemListModel.instance:getCount() == 0

	gohelper.setActive(self._goempty, isEmptyList)
	gohelper.setActive(self._goNormalRight, not isEmptyList)
	self:refreshDescGroup()
	self:refreshSlots()
end

function Season123_1_9EquipHeroView:handleEquipUpdate()
	self:refreshDescGroup()
	self:refreshSlots()
end

function Season123_1_9EquipHeroView:refreshSlots()
	for slotIndex = 1, Activity123Enum.MainCardNum do
		self:refreshSlot(slotIndex)
	end
end

function Season123_1_9EquipHeroView:refreshSlot(slotIndex)
	local item = self:getOrCreateSlot(slotIndex)
	local slotUnlockCount = Season123EquipHeroItemListModel.instance:getShowUnlockSlotCount()

	if slotUnlockCount < slotIndex then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local itemUid = Season123EquipHeroItemListModel.instance.curEquipMap[slotIndex]

	gohelper.setActive(item.goSelect, Season123EquipHeroItemListModel.instance.curSelectSlot == slotIndex)

	local isLock = Season123EquipHeroItemListModel.instance:slotIsLock(slotIndex)

	gohelper.setActive(item.goBtnAdd, not isLock)
	gohelper.setActive(item.goLock, isLock)

	if itemUid == Activity123Enum.EmptyUid then
		gohelper.setActive(item.goPos, false)
		gohelper.setActive(item.goEmpty, true)
	else
		gohelper.setActive(item.goPos, true)
		gohelper.setActive(item.goEmpty, false)

		local icon = self:getOrCreateSlotIcon(item)
		local itemMO = Season123EquipHeroItemListModel.instance:getEquipMO(itemUid)

		if itemMO then
			icon:updateData(itemMO.itemId)
		end
	end
end

Season123_1_9EquipHeroView.MaxUISlot = 2

function Season123_1_9EquipHeroView:refreshDescGroup()
	for slot = 1, Season123_1_9EquipHeroView.MaxUISlot do
		local curShowItemUid = Season123EquipHeroItemListModel.instance.curEquipMap[slot]
		local descItem = self:getOrCreateDesc(slot)

		if not string.nilorempty(curShowItemUid) then
			self:refreshDesc(descItem, curShowItemUid, slot)
		end
	end
end

function Season123_1_9EquipHeroView:refreshDesc(descItem, itemUid, slotIndex)
	if gohelper.isNil(descItem.go) then
		return
	end

	if itemUid == Activity123Enum.EmptyUid then
		gohelper.setActive(descItem.go, false)
	else
		gohelper.setActive(descItem.go, true)

		local itemMO = Season123EquipHeroItemListModel.instance:getEquipMO(itemUid)
		local itemId = itemMO and itemMO.itemId

		if itemId then
			local itemCO = Season123Config.instance:getSeasonEquipCo(itemId)

			if itemCO then
				descItem.txtName.text = string.format("[%s]", itemCO.name)

				local colorNameStr
				local colorDescStr = Season123EquipMetaUtils.getCareerColorDarkBg(itemId)

				if Season123EquipHeroItemListModel.instance.curSelectSlot ~= slotIndex then
					colorDescStr = colorDescStr .. Season123EquipMetaUtils.No_Effect_Alpha
					colorNameStr = "#cac8c5" .. Season123EquipMetaUtils.No_Effect_Alpha
				else
					colorNameStr = "#ec7731"
				end

				SLFramework.UGUI.GuiHelper.SetColor(descItem.txtName, colorNameStr)
				self:refreshProps(itemCO, descItem, colorDescStr)
				self:refreshSkills(itemCO, descItem, colorDescStr)
			else
				logError(string.format("can't find season equip config, id = [%s]", itemId))
			end
		else
			logError(string.format("can't find season equip MO, itemUid = [%s]", itemUid))
		end
	end
end

function Season123_1_9EquipHeroView:refreshProps(itemCfg, descItem, colorStr)
	local processedSet = {}
	local isDirty = false

	if itemCfg and itemCfg.attrId ~= 0 then
		local propsList = Season123EquipMetaUtils.getEquipPropsStrList(itemCfg.attrId)

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

function Season123_1_9EquipHeroView:refreshSkills(itemCfg, descItem, colorStr)
	local skillList = Season123EquipMetaUtils.getSkillEffectStrList(itemCfg)
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

function Season123_1_9EquipHeroView:getOrCreatePropText(index, descItem)
	local item = descItem.propItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(descItem.goAttrDesc, "propname_" .. tostring(index))
		item.txtDesc = gohelper.findChildText(item.go, "txt_attributedesc")
		descItem.propItems[index] = item
	end

	return item
end

function Season123_1_9EquipHeroView:getOrCreateSkillText(index, descItem)
	local item = descItem.skillItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(descItem.goSkillDesc, "skill_" .. tostring(index))
		item.txtDesc = gohelper.findChildText(item.go, "txt_skilldesc")
		descItem.skillItems[index] = item
	end

	return item
end

function Season123_1_9EquipHeroView:getOrCreateSlot(slotIndex)
	local slotItem = self._slotItems[slotIndex]

	if not slotItem then
		slotItem = self:getUserDataTb_()
		slotItem.index = slotIndex
		slotItem.mainView = self
		slotItem.go = gohelper.findChild(self.viewGO, "#go_normal/left/equipSlot/slot" .. tostring(slotIndex))
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

function Season123_1_9EquipHeroView:getOrCreateSlotIcon(slotItem)
	local icon = slotItem.icon

	if not icon then
		local path = self.viewContainer:getSetting().otherRes[2]
		local go = self:getResInst(path, slotItem.goPos, "icon")

		icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season123_1_9CelebrityCardEquip)
		slotItem.icon = icon
	end

	return icon
end

function Season123_1_9EquipHeroView:getOrCreateDesc(index)
	local descItem = self._descItems[index]

	if not descItem then
		descItem = self:getUserDataTb_()
		descItem.go = gohelper.findChild(self.viewGO, "#go_normal/left/equipDesc/#go_equipDesc/#go_effect" .. tostring(index))
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

function Season123_1_9EquipHeroView:onClickSlot(slotIndex)
	if Season123EquipHeroItemListModel.instance.curSelectSlot ~= slotIndex then
		if not Season123EquipHeroItemListModel.instance:slotIsLock(slotIndex) then
			Season123EquipHeroController.instance:setSlot(slotIndex)
		else
			GameFacade.showToast(ToastEnum.SeasonEquipUnlock)
		end
	end
end

function Season123_1_9EquipHeroView:handleSwitchAnimFrame()
	self:refreshSlots()
	self:refreshDescGroup()
end

function Season123_1_9EquipHeroView.handleSlotSwitchAnimFrame(slotItem)
	local mainView = slotItem.mainView

	mainView:refreshDescGroup()
end

function Season123_1_9EquipHeroView:handleEquipCardChanged(param)
	local curSlot = Season123EquipHeroItemListModel.instance.curSelectSlot
	local slotItem = self:getOrCreateSlot(curSlot)
	local animName = param.isNew and "open" or "switch"

	slotItem.animator:Play(animName, 0, 0)

	if param.unloadSlot then
		slotItem = self:getOrCreateSlot(param.unloadSlot)

		slotItem.animator:Play("close", 0, 0)
	end

	self._animator:Play("switch", 0, 0)
end

function Season123_1_9EquipHeroView:handleEquipSlotChanged()
	self._animator:Play("switch", 0, 0)
	self:refreshSlots()
end

function Season123_1_9EquipHeroView:handleSaveSucc()
	if self._isManualSave then
		GameFacade.showToast(Season123EquipHeroController.Toast_Save_Succ)
		self:closeThis()
	end
end

function Season123_1_9EquipHeroView:_btnequipOnClick()
	self._isManualSave = Season123EquipHeroController.instance:checkCanSaveSlot()

	if self._isManualSave then
		Season123EquipHeroController.instance:saveShowSlot()
	end
end

function Season123_1_9EquipHeroView:_btnhandbookOnClick()
	Season123Controller.instance:openSeasonEquipBookView(self.viewParam.actId)
end

return Season123_1_9EquipHeroView
