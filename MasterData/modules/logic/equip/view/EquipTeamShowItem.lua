-- chunkname: @modules/logic/equip/view/EquipTeamShowItem.lua

module("modules.logic.equip.view.EquipTeamShowItem", package.seeall)

local EquipTeamShowItem = class("EquipTeamShowItem", BaseChildView)

function EquipTeamShowItem:onInitView()
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._txtlv = gohelper.findChildText(self.viewGO, "#go_container/top/#txt_lv")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_container/top/#txt_name")
	self._imagelock = gohelper.findChildImage(self.viewGO, "#go_container/top/#image_lock")
	self._golockicon = gohelper.findChild(self.viewGO, "#go_container/top/#image_lock/#go_lockicon")
	self._gostrengthenattr = gohelper.findChild(self.viewGO, "#go_container/scroll_center/Viewport/center/attribute/#go_strengthenattr")
	self._gosuiteffect = gohelper.findChild(self.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect")
	self._txtsuiteffect1 = gohelper.findChildText(self.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_advanceskill/suiteffect1/#txt_suiteffect1")
	self._txtsuiteffect2 = gohelper.findChildText(self.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_baseskill/suiteffect2/#txt_suiteffect2")
	self._goskillpos = gohelper.findChild(self.viewGO, "#go_container/#go_skillpos")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_container/bottom/#go_btns")
	self._goreplace = gohelper.findChild(self.viewGO, "#go_container/bottom/#go_btns/#go_replace")
	self._btnreplace = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/bottom/#go_btns/#go_replace/#btn_replace")
	self._txtreplace = gohelper.findChildText(self.viewGO, "#go_container/bottom/#go_btns/#go_replace/#txt_replace")
	self._txtreplaceen = gohelper.findChildText(self.viewGO, "#go_container/bottom/#go_btns/#go_replace/#txt_replaceen")
	self._btntrain = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/bottom/#go_btns/train/#btn_train")
	self._goremove = gohelper.findChild(self.viewGO, "#go_container/bottom/#go_btns/#go_remove")
	self._btnremove = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/bottom/#go_btns/#go_remove/#btn_remove")
	self._gocurrent = gohelper.findChild(self.viewGO, "#go_container/bottom/#go_current")
	self._imageskillcarrericon = gohelper.findChildImage(self.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_baseskill/basedestitle/#txt_basedestitle/#image_skillcarrericon")
	self._goadvanceskill = gohelper.findChild(self.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_advanceskill")
	self._gobaseskill = gohelper.findChild(self.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_baseskill")
	self._txtbasedestitle = gohelper.findChildText(self.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_baseskill/basedestitle/#txt_basedestitle")
	self._goinsigt = gohelper.findChild(self.viewGO, "#go_container/top/#go_insigt")
	self._image1 = gohelper.findChildImage(self.viewGO, "#go_container/top/#go_insigt/#image_1")
	self._image2 = gohelper.findChildImage(self.viewGO, "#go_container/top/#go_insigt/#image_2")
	self._image3 = gohelper.findChildImage(self.viewGO, "#go_container/top/#go_insigt/#image_3")
	self._image4 = gohelper.findChildImage(self.viewGO, "#go_container/top/#go_insigt/#image_4")
	self._image5 = gohelper.findChildImage(self.viewGO, "#go_container/top/#go_insigt/#image_5")
	self._goline = gohelper.findChild(self.viewGO, "#go_container/#go_line")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipTeamShowItem:addEvents()
	self._btnreplace:AddClickListener(self._btnreplaceOnClick, self)
	self._btntrain:AddClickListener(self._btntrainOnClick, self)
	self._btnremove:AddClickListener(self._btnremoveOnClick, self)
end

function EquipTeamShowItem:removeEvents()
	self._btnreplace:RemoveClickListener()
	self._btntrain:RemoveClickListener()
	self._btnremove:RemoveClickListener()
end

EquipTeamShowItem.numColor = "#975129"

function EquipTeamShowItem:_btnreplaceOnClick()
	local equipList = EquipTeamListModel.instance:getTeamEquip()
	local equipUid = equipList[1]
	local isReplace = not not (equipUid and EquipModel.instance:getEquip(equipUid))

	if HeroSingleGroupModel.instance:isTemp() then
		local _, index, equips = EquipTeamListModel.instance:getRequestData(self._uid)
		local equipTable = {}

		equipTable.index = index
		equipTable.equipUid = equips

		HeroGroupModel.instance:replaceEquips(equipTable, EquipTeamListModel.instance:getCurGroupMo())
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, index)

		if isReplace then
			GameFacade.showToast(ToastEnum.EquipTeamReplace)
		else
			GameFacade.showToast(ToastEnum.EquipTeamNoReplace)
		end
	else
		if EquipTeamListModel.instance:getEquipTeamPos(self._uid) then
			HeroGroupRpc.instance:sendSetHeroGroupEquipRequest(EquipTeamListModel.instance:getRequestDataByTargetUid(self._uid, "0"))
		end

		HeroGroupRpc.instance:showSetHeroGroupEquipTip(function()
			if isReplace then
				GameFacade.showToast(ToastEnum.EquipTeamReplace)
			else
				GameFacade.showToast(ToastEnum.EquipTeamNoReplace)
			end
		end)
		HeroGroupRpc.instance:sendSetHeroGroupEquipRequest(EquipTeamListModel.instance:getRequestData(self._uid))
	end

	self._parentView:closeThis()
end

function EquipTeamShowItem:_btntrainOnClick()
	local param = {}

	param.equipMO = self._equipMO
	param.defaultTabIds = {
		[2] = 2
	}

	EquipController.instance:openEquipView(param)
end

function EquipTeamShowItem:_btnremoveOnClick()
	EquipTeamShowItem.removeEquip(EquipTeamListModel.instance:getCurPosIndex())
	self._parentView:closeThis()
end

function EquipTeamShowItem.removeEquip(teamPos, dontSend)
	if HeroSingleGroupModel.instance:isTemp() or dontSend then
		local _, index, equips = EquipTeamListModel.instance:_getRequestData(teamPos, "0")
		local equipTable = {}

		equipTable.index = index
		equipTable.equipUid = equips

		HeroGroupModel.instance:replaceEquips(equipTable, EquipTeamListModel.instance:getCurGroupMo())

		if not dontSend then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, index)
		end
	else
		HeroGroupRpc.instance:sendSetHeroGroupEquipRequest(EquipTeamListModel.instance:_getRequestData(teamPos, "0"))
	end
end

function EquipTeamShowItem.replaceEquip(teamPos, equipUid, dontSend)
	if HeroSingleGroupModel.instance:isTemp() or dontSend then
		local _, index, equips = EquipTeamListModel.instance:_getRequestData(teamPos, equipUid)
		local equipTable = {}

		equipTable.index = index
		equipTable.equipUid = equips

		HeroGroupModel.instance:replaceEquips(equipTable, EquipTeamListModel.instance:getCurGroupMo())

		if not dontSend then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, index)
		end
	else
		HeroGroupRpc.instance:sendSetHeroGroupEquipRequest(EquipTeamListModel.instance:_getRequestData(teamPos, equipUid))
	end
end

function EquipTeamShowItem:_editableInitView()
	self._lockListener = gohelper.getClickWithAudio(self._golockicon)

	self._lockListener:AddClickDownListener(self._onLockDown, self)
	self._lockListener:AddClickListener(self._onLockClick, self)

	self._strengthenattrs = self:getUserDataTb_()
	self._txtDescList = self:getUserDataTb_()
	self._attrList = self:getUserDataTb_()

	gohelper.setActive(self._gostrengthenattr, false)
	gohelper.setActive(self._txtsuiteffect1.gameObject, false)
	gohelper.setActive(self._txtsuiteffect2.gameObject, false)

	self._advanceDesItems = self._advanceDesItems or self:getUserDataTb_()
	self._gobaseskillsuiteffect = gohelper.findChild(self.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_baseskill/suiteffect2/")
	self.canvasgroup = self._gobaseskillsuiteffect:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.addUIClickAudio(self._btnreplace.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Remember)
	gohelper.addUIClickAudio(self._btnremove.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
end

function EquipTeamShowItem:_onHyperLinkClick()
	local targetInScreenPos = recthelper.uiPosToScreenPos(self._goskillpos.transform, ViewMgr.instance:getUICanvas())

	EquipController.instance:openEquipSkillTipView({
		self._equipMO,
		nil,
		true,
		targetInScreenPos
	})
end

function EquipTeamShowItem:_onLockClick()
	self._lock = not self._lock

	UISpriteSetMgr.instance:setEquipSprite(self._imagelock, self._lock and "xinxiang_suo" or "xinxiang_jiesuo", true)
	EquipRpc.instance:sendEquipLockRequest(self._equipMO.id, self._lock)

	if self._lock then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Lock)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Unlock)
	end
end

function EquipTeamShowItem:onUpdateParam()
	self:initViewParam()
	self:_updateEquip()
	self:_setSkillTipPos()
	UISpriteSetMgr.instance:setEquipSprite(self._imagelock, self._lock and "xinxiang_suo" or "xinxiang_jiesuo", true)
end

function EquipTeamShowItem:onOpen()
	self:initViewParam()
	self:_updateEquip()
	self:_setSkillTipPos()
	UISpriteSetMgr.instance:setEquipSprite(self._imagelock, self._lock and "xinxiang_suo" or "xinxiang_jiesuo", true)
	self.addEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self._updateEquip, self)
end

function EquipTeamShowItem:initViewParam()
	self._uid = self.viewParam[1]
	self._inTeam = self.viewParam[2]
	self._compare = self.viewParam[3]
	self._parentView = self.viewParam[4]
	self._heroId = self.viewParam[5]
	self._posIndex = self.viewParam[6]
	self._equipMO = EquipModel.instance:getEquip(self._uid)
	self._curEquipCo = EquipConfig.instance:getEquipSkillCfg(self._equipMO.equipId, self._equipMO.refineLv)
	self._lock = self._equipMO.isLock
end

function EquipTeamShowItem:_updateEquip()
	self:showEquip(self._equipMO)
	self:showAttrList()
	self._gobtns:SetActive(false)
	self._gocurrent:SetActive(false)
	self._goremove:SetActive(false)
	gohelper.setActive(self._goline, self._posIndex ~= 1)

	if self._inTeam then
		if self._compare then
			self._gocurrent:SetActive(true)
		else
			self._gobtns:SetActive(true)
			self._goremove:SetActive(true)
		end
	else
		self._gobtns:SetActive(true)
		self._goreplace:SetActive(true)

		local equipList = EquipTeamListModel.instance:getTeamEquip()
		local equipUid = equipList[1]

		if equipUid and EquipModel.instance:getEquip(equipUid) then
			self._txtreplace.text = luaLang("equip_lang_22")
			self._txtreplaceen.text = "OVERWRITE"
		else
			self._txtreplace.text = luaLang("equip_lang_23")
			self._txtreplaceen.text = "MEMORIZE"
		end
	end
end

function EquipTeamShowItem:_setSkillTipPos()
	recthelper.setAnchorX(self._goskillpos.transform, 0)
end

function EquipTeamShowItem:showAttrList()
	self._config = self._equipMO.config

	local attr_dic, attr_list = EquipConfig.instance:getEquipNormalAttr(self._config.id, self._equipMO.level, HeroConfig.sortAttrForEquipView)

	gohelper.CreateObjList(self, self._attrItemShow, attr_list, self._gostrengthenattr.transform.parent.gameObject, self._gostrengthenattr)
	self:showSpDesc()
end

function EquipTeamShowItem:_attrItemShow(obj, data, index)
	local config = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(data.attrType))
	local transform = obj.transform
	local icon = transform:Find("image_icon"):GetComponent(gohelper.Type_Image)
	local name = transform:Find("txt_name"):GetComponent(gohelper.Type_TextMesh)
	local attr_value = transform:Find("txt_value"):GetComponent(gohelper.Type_TextMesh)

	UISpriteSetMgr.instance:setCommonSprite(icon, "icon_att_" .. config.id)

	name.text = config.name
	attr_value.text = data.value
end

function EquipTeamShowItem:showSpDesc()
	gohelper.setActive(self._gosuiteffect, true)

	if self._config.skillType <= 0 then
		gohelper.setActive(self._gosuiteffect, false)

		return
	end

	self:_showSkillAdvanceDes()
	self:_showSkillBaseDes()
end

function EquipTeamShowItem:_showSkillAdvanceDes()
	local skillAdvanceDesTab = EquipHelper.getEquipSkillAdvanceAttrDesTab(self._config.id, self._equipMO.refineLv, EquipTeamShowItem.numColor)

	if skillAdvanceDesTab and #skillAdvanceDesTab > 0 then
		gohelper.setActive(self._goadvanceskill, true)

		for index, desc in ipairs(skillAdvanceDesTab) do
			local item = self._advanceDesItems[index]

			if not item then
				local go = gohelper.cloneInPlace(self._txtsuiteffect1.gameObject, "item_" .. index)

				table.insert(self._advanceDesItems, go)

				item = go
			end

			gohelper.setActive(item.gameObject, true)

			local descTxt = item:GetComponent(gohelper.Type_TextMesh)

			descTxt.text = desc
		end

		for hideIndex = #skillAdvanceDesTab + 1, #self._advanceDesItems do
			gohelper.setActive(self._advanceDesItems[hideIndex], false)
		end
	else
		gohelper.setActive(self._goadvanceskill, false)
	end
end

function EquipTeamShowItem:_showSkillBaseDes()
	local skillBaseDesList, carrerIconName, skillNameColor = EquipHelper.getSkillBaseDescAndIcon(self._config.id, self._equipMO.refineLv, "#C78449")

	if #skillBaseDesList == 0 then
		gohelper.setActive(self._gobaseskill.gameObject, false)
	else
		gohelper.setActive(self._gobaseskill.gameObject, true)

		self._txtbasedestitle.text = string.format("<%s>%s</color>", skillNameColor, self._config.skillName)

		UISpriteSetMgr.instance:setCommonSprite(self._imageskillcarrericon, carrerIconName)

		local txt

		for index, desc in ipairs(skillBaseDesList) do
			txt = self._txtDescList[index]

			if not self._txtDescList[index] then
				local itemGo = gohelper.cloneInPlace(self._txtsuiteffect2.gameObject, "item_" .. index)

				txt = itemGo:GetComponent(gohelper.Type_TextMesh)

				table.insert(self._txtDescList, txt)
			end

			txt.text = desc

			gohelper.setActive(txt.gameObject, true)
		end

		for i = #skillBaseDesList + 1, #self._txtDescList do
			gohelper.setActive(self._txtDescList[i].gameObject, false)
		end

		EquipController.instance:dispatchEvent(EquipEvent.equipHasRefine)
	end

	self.canvasgroup.alpha = self._curEquipCo and EquipHelper.detectEquipSkillSuited(self._heroId, self._curEquipCo.id, self._equipMO.refineLv) and 1 or 0.45
end

function EquipTeamShowItem:showEquip(mo)
	self._mo = mo
	self._config = EquipConfig.instance:getEquipCo(mo.equipId)
	self._txtname.text = self._config.name

	local curBreakMaxLevel = string.format("%s", EquipConfig.instance:getCurrentBreakLevelMaxLevel(self._mo))

	self._txtlv.text = string.format("<color=#D9A06F>%s</color> /%s", self._mo.level, curBreakMaxLevel)

	for i = 1, 5 do
		UISpriteSetMgr.instance:setEquipSprite(self["_image" .. i], i <= self._mo.refineLv and "bg_xinxiang_dengji" or "bg_xinxiang_dengji_dis")
	end
end

function EquipTeamShowItem:isOneSuit()
	return true
end

function EquipTeamShowItem:onClose()
	self._lockListener:RemoveClickDownListener()
	self._lockListener:RemoveClickListener()
end

function EquipTeamShowItem:onDestroyView()
	return
end

return EquipTeamShowItem
