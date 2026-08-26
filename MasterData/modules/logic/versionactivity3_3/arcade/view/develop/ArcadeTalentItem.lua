-- chunkname: @modules/logic/versionactivity3_3/arcade/view/develop/ArcadeTalentItem.lua

module("modules.logic.versionactivity3_3.arcade.view.develop.ArcadeTalentItem", package.seeall)

local ArcadeTalentItem = class("ArcadeTalentItem", ListScrollCellExtend)

function ArcadeTalentItem:onInitView()
	self._goBg = gohelper.findChild(self.viewGO, "BG")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#simage_icon")
	self._txtlack = gohelper.findChildText(self.viewGO, "Name/#txt_lack")
	self._txtlight = gohelper.findChildText(self.viewGO, "Name/#txt_light")
	self._scrolldec = gohelper.findChildScrollRect(self.viewGO, "middle/#scroll_dec")
	self._txtdec = gohelper.findChildText(self.viewGO, "middle/#scroll_dec/Viewport/Content/#txt_dec")
	self._goLv = gohelper.findChild(self.viewGO, "middle/lv")
	self._goattribute = gohelper.findChild(self.viewGO, "middle/lv/#go_attribute")
	self._goattributedetail = gohelper.findChild(self.viewGO, "middle/lv/#go_attribute/item/#go_attributedetail")
	self._golvitem = gohelper.findChild(self.viewGO, "middle/lv/lvGroup/go_lvitem")
	self._btnlight = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_light", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._txtlightnum = gohelper.findChildText(self.viewGO, "bottom/#btn_light/#txt_num")
	self._txtbtnlight = gohelper.findChildText(self.viewGO, "bottom/#btn_light/txt_light")
	self._golightreddot = gohelper.findChild(self.viewGO, "bottom/#btn_light/#go_reddot")
	self._imagelighticon = gohelper.findChildImage(self.viewGO, "bottom/#btn_light/#image_icon")
	self._btnupgrade = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_upgrade", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._txtupgradenum = gohelper.findChildText(self.viewGO, "bottom/#btn_upgrade/#txt_num")
	self._txtbtnupgrade = gohelper.findChildText(self.viewGO, "bottom/#btn_upgrade/txt_light")
	self._goupgradereddot = gohelper.findChild(self.viewGO, "bottom/#btn_upgrade/#go_reddot")
	self._imageupgradeicon = gohelper.findChildImage(self.viewGO, "bottom/#btn_upgrade/#image_icon")
	self._golighted = gohelper.findChild(self.viewGO, "bottom/#go_lighted")
	self._gomax = gohelper.findChild(self.viewGO, "bottom/#go_max")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeTalentItem:addEvents()
	self._btnlight:AddClickListener(self._btnlightOnClick, self)
	self._btnupgrade:AddClickListener(self._btnupgradeOnClick, self)
	self._view.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.UpLevelTalent, self._refreshView, self)
end

function ArcadeTalentItem:removeEvents()
	self._btnlight:RemoveClickListener()
	self._btnupgrade:RemoveClickListener()
	self._view.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.UpLevelTalent, self._refreshView, self)
end

function ArcadeTalentItem:_btnlightOnClick()
	self:_onUpLevel()
end

function ArcadeTalentItem:_btnupgradeOnClick()
	self:_onUpLevel()
end

function ArcadeTalentItem:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId == 1 and tabId == 2 then
		self:_playOpenAnim()
	end
end

function ArcadeTalentItem:_editableInitView()
	self._complicatedItems = self:getUserDataTb_()
	self._statusList = self:getUserDataTb_()
	self._statusList.lack = self:getUserDataTb_()
	self._statusList.light = self:getUserDataTb_()

	local bgLack = gohelper.findChild(self._goBg, "lack")
	local bglight = gohelper.findChild(self._goBg, "light")

	table.insert(self._statusList.lack, bgLack)
	table.insert(self._statusList.lack, self._txtlack)
	table.insert(self._statusList.light, bglight)
	table.insert(self._statusList.light, self._txtlight)

	self._gosimpleitem = gohelper.findChild(self.viewGO, "middle/lv/#go_attribute/item")
	self._simpleItems = self:getUserDataTb_()
	self._simpleLvItems = self:getUserDataTb_()
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self:_playOpenAnim()
end

function ArcadeTalentItem:onUpdateMO(mo)
	self.mo = mo

	self:_refreshView()
	UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imageicon, mo:getIconCo())
end

function ArcadeTalentItem:_playOpenAnim()
	self._anim:Play(UIAnimationName.Open, 0, 0)
end

function ArcadeTalentItem:_refreshView()
	self.level = self.mo:getLevel()

	local values = ArcadeOutSizeModel.instance:getAttrValues(ArcadeEnum.AttributeConst.DiamondCount)
	local curNum = values or 0

	self._isEnough = curNum >= self.mo:getCost()

	self:_refreshSkillInfo()
	self:_refreshBtn()
	self:_refreshStatus()
end

function ArcadeTalentItem:_refreshSkillInfo()
	local level = self.mo:isLock() and 1 or self.level
	local co = self.mo:getLevelCo(level)

	if not co then
		return
	end

	self._txtlack.text = co.name
	self._txtlight.text = co.name

	local type = co.displayType

	if not type then
		return
	end

	self["_refreshSkill_" .. type](self)
	gohelper.setActive(self._scrolldec.gameObject, type == ArcadeEnum.TalentType.Complicated)
	gohelper.setActive(self._goLv.gameObject, type == ArcadeEnum.TalentType.Simple)
end

function ArcadeTalentItem:_refreshSkill_complicated()
	local skillIds = self.mo:isLock() and self.mo:getSkillIdsByLevel(1) or self.mo:getSkillIdsByLevel(self.level)
	local count = 0

	if skillIds then
		for i, skillId in ipairs(skillIds) do
			local skillCo = ArcadeConfig.instance:getPassiveSkillCfg(skillId)

			if skillCo then
				local item = self:_getComplicatedItem(i)

				item.txt.text = skillCo.skillDesc
				count = count + 1
			end
		end
	end

	for i = 1, #self._complicatedItems do
		gohelper.setActive(self._complicatedItems[i].go, i <= count)
	end
end

function ArcadeTalentItem:_refreshSkill_simple()
	local maxLevel = self.mo:getMaxLevel()
	local isMax = maxLevel <= self.level
	local count = 0

	if isMax then
		local skillIds = self.mo:getSkillIdsByLevel(self.level)

		if skillIds then
			for i, skillId in ipairs(skillIds) do
				local desc, level, value = self:_getLevelValueBySkillId(skillId)

				if desc and level and value then
					local item = self:_getSimpleItem(i)

					item.txtdesc.text = desc
					item.txtnextnum.text = value

					gohelper.setActive(item.txtprenum.gameObject, false)

					count = count + 1
				end
			end
		end
	else
		local skillIds = self.mo:getSkillIdsByLevel(self.level)
		local nextSkillIds = self.mo:getSkillIdsByLevel(self.level + 1)

		for i, skillId in ipairs(nextSkillIds) do
			local desc, level, value = self:_getLevelValueBySkillId(skillId)
			local prevalue = 0

			if skillIds and skillIds[i] then
				local _, _, _prevalue = self:_getLevelValueBySkillId(skillIds[i])

				prevalue = _prevalue
			end

			if desc and level and value then
				local item = self:_getSimpleItem(i)

				item.txtdesc.text = desc
				item.txtnextnum.text = value
				item.txtprenum.text = prevalue

				gohelper.setActive(item.txtprenum.gameObject, true)

				count = count + 1
			end
		end
	end

	for i = 1, #self._complicatedItems do
		gohelper.setActive(self._complicatedItems[i].go, i <= count)
	end

	for i = 1, maxLevel do
		local item = self:_getSimpleLVItem(i)

		gohelper.setActive(item.golack, i > self.level)
		gohelper.setActive(item.golight, i <= self.level)
	end

	for i = 1, #self._simpleLvItems do
		local item = self._simpleLvItems[i]

		gohelper.setActive(item.go, i <= maxLevel)
	end
end

function ArcadeTalentItem:_getLevelValueBySkillId(skillId)
	if skillId then
		::label_14_0::

		local skillCo = ArcadeConfig.instance:getPassiveSkillCfg(skillId)

		if not skillCo or string.nilorempty(skillCo.skillDesc) then
			return
		end

		local desc, level, value = string.match(skillCo.skillDesc, "(.-)%【<level：(%d-)>(%d-)%】")

		return desc, level, value
	end
end

function ArcadeTalentItem:_getComplicatedItem(index)
	local item = self._complicatedItems[index]

	if not item then
		item = self:getUserDataTb_()

		if index == 1 then
			item.go = self._txtdec.gameObject or gohelper.cloneInPlace(self._txtdec.gameObject)
		end

		item.txt = item.go:GetComponent(gohelper.Type_TextMesh)
		self._complicatedItems[index] = item
	end

	return item
end

function ArcadeTalentItem:_getSimpleItem(index)
	local item = self._simpleItems[index]

	if not item then
		item = self:getUserDataTb_()

		if index == 1 then
			item.go = self._gosimpleitem.gameObject or gohelper.cloneInPlace(self._gosimpleitem.gameObject)
		end

		item.txtdesc = gohelper.findChildText(item.go, "txt_attributeRankUp")
		item.txtprenum = gohelper.findChildText(item.go, "#go_attributedetail/attributeItem/txt_prevnum")
		item.txtnextnum = gohelper.findChildText(item.go, "#go_attributedetail/attributeItem/txt_nextnum")
		self._simpleItems[index] = item
	end

	return item
end

function ArcadeTalentItem:_getSimpleLVItem(index)
	local item = self._simpleLvItems[index]

	if not item then
		item = self:getUserDataTb_()

		if index == 1 then
			item.go = self._golvitem.gameObject or gohelper.cloneInPlace(self._golvitem.gameObject)
		end

		item.golack = gohelper.findChild(item.go, "lack")
		item.golight = gohelper.findChild(item.go, "light")
		self._simpleLvItems[index] = item
	end

	return item
end

function ArcadeTalentItem:_refreshBtn()
	local isLock = self.mo:isLock()
	local isMaxLevel = self.mo:isMaxLevel()

	self._txtlightnum.color = Color.red

	gohelper.setActive(self._btnlight.gameObject, not self._isEnough)
	gohelper.setActive(self._btnupgrade.gameObject, self._isEnough and not isMaxLevel)

	if self.mo:isLock() then
		local var_18_0 = self.mo:getLevelCo(1)

		if not var_18_0 then
			var_18_0 = self.mo:getCurLevelCo()

			local co = var_18_0
			local type = co.displayType
			local isSimple = type == ArcadeEnum.TalentType.Simple

			gohelper.setActive(self._gomax.gameObject, not isLock and isMaxLevel and isSimple)
			gohelper.setActive(self._golighted.gameObject, not isLock and isMaxLevel and not isSimple)

			local txtStr = isLock and "p_v3a3_eliminate_talentview_light" or "p_versionactivity_1_2_dungeonmaplevelupitem_lvup"

			if self._isEnough then
				self._txtbtnupgrade.text = luaLang(txtStr)
			else
				self._txtbtnlight.text = luaLang(txtStr)
			end

			local cost = self.mo:getCost()

			self._txtlightnum.text = cost
			self._txtupgradenum.text = cost
		end
	end
end

function ArcadeTalentItem:_refreshStatus()
	gohelper.setActive(self._golightreddot.gameObject, self._isEnough)
	gohelper.setActive(self._goupgradereddot.gameObject, self._isEnough)

	for _, go in pairs(self._statusList.lack) do
		gohelper.setActive(go.gameObject, self.mo:isLock())
	end

	for _, go in pairs(self._statusList.light) do
		gohelper.setActive(go.gameObject, not self.mo:isLock())
	end
end

function ArcadeTalentItem:_onUpLevel()
	if self._isPlayAnim then
		return
	end

	if not self._isEnough then
		GameFacade.showToast(ToastEnum.V3a3ArcadeNoEnoughDiamond)

		return
	end

	local talent = self.mo.id
	local level = self.mo._level

	self._anim:Play("lvup", 0, 0)

	self._isPlayAnim = true

	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_attribute_upgrade)
	ArcadeOutSideRpc.instance:sendArcadeTalentUpgradeRequest(talent, level, self._refreshView, self)
	TaskDispatcher.runDelay(self._onFinishLvUpAnim, self, 1.067)
end

function ArcadeTalentItem:_onFinishLvUpAnim()
	self._isPlayAnim = false
end

function ArcadeTalentItem:onDestroyView()
	TaskDispatcher.cancelTask(self._onFinishLvUpAnim, self)
end

return ArcadeTalentItem
