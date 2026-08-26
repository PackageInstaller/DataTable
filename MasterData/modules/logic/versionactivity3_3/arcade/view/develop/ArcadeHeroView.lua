-- chunkname: @modules/logic/versionactivity3_3/arcade/view/develop/ArcadeHeroView.lua

module("modules.logic.versionactivity3_3.arcade.view.develop.ArcadeHeroView", package.seeall)

local ArcadeHeroView = class("ArcadeHeroView", BaseView)

function ArcadeHeroView:onInitView()
	self._gohero = gohelper.findChild(self.viewGO, "bottom/#go_hero")
	self._heroRoot = gohelper.findChild(self.viewGO, "bottom/#go_hero/scroll_hero/Viewport/Content")
	self._goheroitem = gohelper.findChild(self.viewGO, "bottom/#go_hero/#go_heroitem")
	self._btnselect = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/btn/#btn_select", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._gounlockTips = gohelper.findChild(self.viewGO, "bottom/btn/#go_unlockTips")
	self._txtunlockTips = gohelper.findChildText(self.viewGO, "bottom/btn/#go_unlockTips/#txt_unlockTips")
	self._goequiped = gohelper.findChild(self.viewGO, "bottom/btn/#go_equiped")
	self._goequipedEffect = gohelper.findChild(self.viewGO, "bottom/btn/#go_equiped/#effect")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_info/role/#simage_bg")
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "#go_info/role/node/#simage_role")
	self._imagerole = gohelper.findChildImage(self.viewGO, "#go_info/role/node/#simage_role")
	self._btnrole = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/role/node/#simage_role/#btn_role", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._goroleunlock = gohelper.findChild(self.viewGO, "#go_info/role/node")
	self._gorolelock = gohelper.findChild(self.viewGO, "#go_info/role/lock")
	self._gounlock = gohelper.findChild(self.viewGO, "#go_info/info/#go_unlock")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_info/info/#go_unlock/layout/#txt_name")
	self._gobase = gohelper.findChild(self.viewGO, "#go_info/info/#go_unlock/layout/#go_base/go_baseitem")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_info/info/#go_unlock/title/txt_title")
	self._scrolldes = gohelper.findChildScrollRect(self.viewGO, "#go_info/info/#go_unlock/#scroll_des")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_info/info/#go_unlock/#scroll_des/viewport/content/#txt_Desc")
	self._btnboom = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/info/#go_unlock/skill/#btn_boom", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._txtboomnum = gohelper.findChildText(self.viewGO, "#go_info/info/#go_unlock/skill/#btn_boom/#txt_num")
	self._imageboomicon = gohelper.findChildImage(self.viewGO, "#go_info/info/#go_unlock/skill/#btn_boom/image_icon")
	self._goboomcanUse = gohelper.findChild(self.viewGO, "#go_info/info/#go_unlock/skill/#btn_boom/#go_canUse")
	self._goboomhasUse = gohelper.findChild(self.viewGO, "#go_info/info/#go_unlock/skill/#btn_boom/#go_hasUse")
	self._txtboomtime = gohelper.findChildText(self.viewGO, "#go_info/info/#go_unlock/skill/#btn_boom/#go_hasUse/#txt_time")
	self._goboomlack = gohelper.findChild(self.viewGO, "#go_info/info/#go_unlock/skill/#btn_boom/#go_lack")
	self._btnskill = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/info/#go_unlock/skill/#btn_skill", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._imageskillicon = gohelper.findChildImage(self.viewGO, "#go_info/info/#go_unlock/skill/#btn_skill/#image_icon")
	self._goskillcanUse = gohelper.findChild(self.viewGO, "#go_info/info/#go_unlock/skill/#btn_skill/#go_canUse")
	self._goskillhasUse = gohelper.findChild(self.viewGO, "#go_info/info/#go_unlock/skill/#btn_skill/#go_hasUse")
	self._txtskillcd = gohelper.findChildText(self.viewGO, "#go_info/info/#go_unlock/skill/#btn_skill/#go_hasUse/#txt_cd")
	self._gocollection = gohelper.findChild(self.viewGO, "#go_info/info/#go_unlock/skill/#go_collection")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem")
	self._simagecollectionicon = gohelper.findChildSingleImage(self.viewGO, "#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/#image_icon")
	self._imagecollectionicon = gohelper.findChildImage(self.viewGO, "#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/#image_icon")
	self._txtcollectionnum = gohelper.findChildText(self.viewGO, "#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/#txt_num")
	self._btncollection = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/btn_click", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._goherolock = gohelper.findChild(self.viewGO, "#go_info/info/#go_lock")
	self._txtlockname = gohelper.findChildText(self.viewGO, "#go_info/info/#go_lock/layout/#txt_name")
	self._txtlock = gohelper.findChildText(self.viewGO, "#go_info/info/#go_lock/#txt_lock")
	self._txtlocktitle = gohelper.findChildText(self.viewGO, "#go_info/info/#go_lock/title/txt_title")
	self._gotips = gohelper.findChild(self.viewGO, "#go_info/info/skill/#go_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeHeroView:addEvents()
	self._btnselect:AddClickListener(self._btnselectOnClick, self)
	self._btnboom:AddClickListener(self._btnboomOnClick, self)
	self._btnskill:AddClickListener(self._btnskillOnClick, self)
	self._btncollection:AddClickListener(self._btncollectionOnClick, self)
	self:_editableAddEvents()
end

function ArcadeHeroView:removeEvents()
	self._btnselect:RemoveClickListener()
	self._btnboom:RemoveClickListener()
	self._btnskill:RemoveClickListener()
	self._btncollection:RemoveClickListener()
	self:_editableRemoveEvents()
end

function ArcadeHeroView:_btnselectOnClick()
	local heroId = self._selectHeroMo:getId()

	ArcadeHeroModel.instance:setEquipHeroId(heroId)
	ArcadeOutSideRpc.instance:sendArcadeSwitchCharacterRequest(heroId)
end

function ArcadeHeroView:_btnboomOnClick()
	if not self._boomMo then
		local effectList = self._selectHeroMo:getEffect()

		self._boomMo = effectList and effectList[ArcadeEnum.EffectType.Bomb]

		if not self._boomMo then
			return
		end
	end

	local anchor = {
		x = 106,
		y = 0
	}
	local param = {
		SkillMo = self._boomMo,
		AnchorPos = anchor,
		orignViewName = self.viewName
	}

	ArcadeController.instance:openTipView(ArcadeEnum.TipType.Skill, param)
end

function ArcadeHeroView:_btnskillOnClick()
	if not self._skillMo then
		local effectList = self._selectHeroMo:getEffect()

		self._skillMo = effectList and effectList[ArcadeEnum.EffectType.Skill]

		if not self._skillMo then
			return
		end
	end

	local anchor = {
		x = -187,
		y = 0
	}
	local param = {
		SkillMo = self._skillMo,
		AnchorPos = anchor,
		orignViewName = self.viewName
	}

	ArcadeController.instance:openTipView(ArcadeEnum.TipType.Skill, param)
end

function ArcadeHeroView:_btncollectionOnClick()
	if not self._collectionMo then
		local effectList = self._selectHeroMo:getEffect()

		self._collectionMo = effectList and effectList[ArcadeEnum.EffectType.Collection]

		if not self._collectionMo then
			return
		end
	end

	local anchor = {
		x = 375,
		y = -342
	}
	local param = {
		CollectionMo = self._collectionMo,
		AnchorPos = anchor,
		orignViewName = self.viewName
	}

	ArcadeController.instance:openTipView(ArcadeEnum.TipType.Collection, param)
end

function ArcadeHeroView:_editableAddEvents()
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnClickHeroItem, self._onClickSelectItem, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnEquipHero, self._onEquipHero, self)
end

function ArcadeHeroView:_editableRemoveEvents()
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnClickHeroItem, self._onClickSelectItem, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnEquipHero, self._onEquipHero, self)
end

function ArcadeHeroView:_onClickSelectItem()
	self._infoAnim:Play(UIAnimationName.Switch, 0, 0)
	self:_refreshHeroItem()
	TaskDispatcher.runDelay(self._refreshHeroInfo, self, 0.167)
	gohelper.setActive(self._goequipedEffect, false)
end

function ArcadeHeroView:_onEquipHero()
	self:refreshView()
	gohelper.setActive(self._goequipedEffect, true)
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_role_shangzhen)
end

function ArcadeHeroView:_editableInitView()
	local equipId = ArcadeHeroModel.instance:getEquipHeroId()

	ArcadeHeroModel.instance:setSelectHeroId(equipId)
	gohelper.setActive(self._goheroitem, false)
	gohelper.setActive(self._gobase, false)

	self._attrItemList = self:getUserDataTb_()

	local param = ArcadeEnum.HandBookParams[ArcadeEnum.HandBookType.Character]

	if param then
		if not param.DetailTitle then
			local detailTitle = "arcade_hankbook_detail_character"
			local desc = luaLang(detailTitle)

			self._txttitle.text = desc
			self._txtlocktitle.text = desc
			self._infoAnim = self._goinfo:GetComponent(typeof(UnityEngine.Animator))
			self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

			gohelper.setActive(self._goequipedEffect, false)

			local golockattr = gohelper.findChild(self._goherolock, "layout/go_base")

			self._lockAttrIcons = self:getUserDataTb_()

			for attr, param in pairs(ArcadeEnum.AttributeParams) do
				self._lockAttrIcons[attr] = gohelper.findChildImage(golockattr, string.format("%s/icon", param.Sort))
			end
		end
	end
end

function ArcadeHeroView:onUpdateParam()
	return
end

function ArcadeHeroView:onOpen()
	self:refreshView()
end

function ArcadeHeroView:onTabSwitchOpen()
	TaskDispatcher.cancelTask(self._refreshHeroInfo, self)
	self._anim:Play("open1", 0, 0)
	TaskDispatcher.runDelay(self._onFinishPlayOpenAnim, self, 0.333)
end

function ArcadeHeroView:_onFinishPlayOpenAnim()
	ArcadeController.instance:dispatchEvent(ArcadeEvent.onFinishPlayOpenAnimHeroView)
end

function ArcadeHeroView:_refreshHeroInfo()
	self._isLock = self._selectHeroMo:isLock()

	gohelper.setActive(self._goherolock, self._isLock)
	gohelper.setActive(self._gorolelock, self._isLock)
	gohelper.setActive(self._gounlock, not self._isLock)
	gohelper.setActive(self._goroleunlock.gameObject, not self._isLock)

	if not self._isLock then
		local icon = self._selectHeroMo.handbookMo:getBigIcon()

		if not string.nilorempty(icon) then
			self._simagerole:LoadImage(ResUrl.getEliminateIcon(icon))
		end

		local co = self._selectHeroMo.handbookMo:getConfig()
		local offset = {
			0,
			0
		}

		if co and co.icon2Offset2 then
			offset[1] = co.icon2Offset2[1] and tonumber(co.icon2Offset2[1]) or 0
			offset[2] = co.icon2Offset2[2] and tonumber(co.icon2Offset2[2]) or 0
		end

		recthelper.setAnchor(self._simagerole.transform, offset[1], offset[2])
	end

	self:_refreshInfo()
	self:_refreshBtn()
end

function ArcadeHeroView:_refreshHeroItem()
	local selectId = ArcadeHeroModel.instance:getSelectHeroId()

	self._selectHeroMo = ArcadeHeroModel.instance:getHeroMoById(selectId)

	local moList = ArcadeHeroModel.instance:getHeroMoList()

	gohelper.CreateObjList(self, self._createHeroItem, moList, self._heroRoot, self._goheroitem, ArcadeHeroItem)
end

function ArcadeHeroView:refreshView()
	self:_refreshHeroItem()
	self:_refreshHeroInfo()
end

function ArcadeHeroView:_createHeroItem(obj, data, index)
	obj:onUpdateMO(data)
	gohelper.setActive(obj.viewGO, true)
end

function ArcadeHeroView:_refreshBtn()
	local isEquip = self._selectHeroMo:isEquip()

	gohelper.setActive(self._btnselect.gameObject, not self._isLock and not isEquip)
	gohelper.setActive(self._goequiped.gameObject, not self._isLock and isEquip)
	gohelper.setActive(self._gounlockTips.gameObject, self._isLock)
end

function ArcadeHeroView:_refreshInfo()
	local handbookMo = self._selectHeroMo.handbookMo

	if self._isLock then
		local tipStr = handbookMo:getLockTip()

		self._txtlock.text = tipStr
		self._txtunlockTips.text = tipStr

		for attr, param in pairs(ArcadeEnum.AttributeParams) do
			local imgIcon = self._lockAttrIcons[attr]

			if imgIcon then
				UISpriteSetMgr.instance:setV3a3EliminateSprite(imgIcon, param.Icon, true)
			end
		end
	else
		self._txtname.text = handbookMo:getName()
		self._txtDesc.text = handbookMo:getDesc()

		self:_refreshAttribute()
		self:_refreshEffect()
	end
end

function ArcadeHeroView:_refreshAttribute()
	local attrList = self._selectHeroMo:getAttribute()

	for type, item in pairs(self._attrItemList) do
		local isShow = attrList and attrList[type]

		gohelper.setActive(item.go, isShow)
	end

	if attrList then
		for type, attr in pairs(attrList) do
			local item = self:_getAttributeItem(type)
			local param = ArcadeEnum.AttributeParams[type]

			if self._isLock then
				item.txtNum.text = ArcadeEnum.Unknown or attr:getValue()
			end

			UISpriteSetMgr.instance:setV3a3EliminateSprite(item.imgIcon, param.Icon, true)
			gohelper.setActive(item.go, true)
			gohelper.setSibling(item.go, param.Sort)
		end
	end
end

function ArcadeHeroView:_getAttributeItem(type)
	local item = self._attrItemList[type]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gobase, "attr_" .. type)

		item.go = go
		item.txtNum = gohelper.findChildText(go, "#txt_num")
		item.imgIcon = gohelper.findChildImage(go, "#txt_num/#image_base")
		self._attrItemList[type] = item
	end

	return item
end

function ArcadeHeroView:_refreshEffect()
	if not self._isLock then
		-- block empty
	end

	local effectList = self._selectHeroMo:getEffect()

	self._skillMo = effectList and effectList[ArcadeEnum.EffectType.Skill]
	self._boomMo = effectList and effectList[ArcadeEnum.EffectType.Bomb]
	self._collectionMo = effectList and effectList[ArcadeEnum.EffectType.Collection]

	gohelper.setActive(self._btnskill.gameObject, self._skillMo ~= nil)
	gohelper.setActive(self._btnboom.gameObject, self._boomMo ~= nil)
	gohelper.setActive(self._gocollection.gameObject, self._collectionMo ~= nil)
	self:_refreshSkill()
	self:_refreshBoom()
	self:_refreshCollection()
end

function ArcadeHeroView:_refreshBoom()
	if self._boomMo == nil then
		return
	end

	local icon = self._boomMo:getIcon()

	if not string.nilorempty(icon) then
		UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imageboomicon, icon)
	end

	self._txtboomnum.text = self._boomMo:getCount()
end

function ArcadeHeroView:_refreshSkill()
	if self._skillMo == nil then
		return
	end

	local icon = self._skillMo:getIcon()

	if not string.nilorempty(icon) then
		UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imageskillicon, icon)
	end
end

function ArcadeHeroView:_refreshCollection()
	if self._collectionMo == nil then
		return
	end

	local icon = self._collectionMo:getIcon()

	if not string.nilorempty(icon) then
		self._simagecollectionicon:LoadImage(ResUrl.getEliminateIcon(icon))
	end
end

function ArcadeHeroView:onClose()
	TaskDispatcher.cancelTask(self._refreshHeroInfo, self)
	TaskDispatcher.cancelTask(self._onFinishPlayOpenAnim, self)
end

function ArcadeHeroView:onDestroyView()
	self._simagerole:UnLoadImage()
	self._simagecollectionicon:UnLoadImage()
end

return ArcadeHeroView
