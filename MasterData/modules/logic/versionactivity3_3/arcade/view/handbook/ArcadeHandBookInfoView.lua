-- chunkname: @modules/logic/versionactivity3_3/arcade/view/handbook/ArcadeHandBookInfoView.lua

module("modules.logic.versionactivity3_3.arcade.view.handbook.ArcadeHandBookInfoView", package.seeall)

local ArcadeHandBookInfoView = class("ArcadeHandBookInfoView", BaseView)

function ArcadeHandBookInfoView:onInitView()
	self._goinfo = gohelper.findChild(self.viewGO, "#go_view/root/#go_info")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_view/root/#go_info/role/#simage_bg")
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "#go_view/root/#go_info/role/node/#simage_role")
	self._imagerole = gohelper.findChildImage(self.viewGO, "#go_view/root/#go_info/role/node/#simage_role")
	self._btnrole = gohelper.findChildButtonWithAudio(self.viewGO, "#go_view/root/#go_info/role/node/#simage_role/#btn_role", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._gounknownrole = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/role/node/unknown")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/layout/#txt_name")
	self._gobase = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/layout/#go_base/go_baseitem")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/layout/#go_base/go_baseitem/#txt_num")
	self._imagebase = gohelper.findChildImage(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/layout/#go_base/go_baseitem/#txt_num/#image_base")
	self._gounlock = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_unlock")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/title/txt_title")
	self._scrolldes = gohelper.findChildScrollRect(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/#scroll_des")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/#scroll_des/viewport/content/#txt_Desc")
	self._btnboom = gohelper.findChildButtonWithAudio(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#btn_boom", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._txtboomnum = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#btn_boom/#txt_num")
	self._imageboomicon = gohelper.findChildImage(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#btn_boom/image_icon")
	self._goboomcanUse = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#btn_boom/#go_canUse")
	self._goboomhasUse = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#btn_boom/#go_hasUse")
	self._txtboomtime = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#btn_boom/#go_hasUse/#txt_time")
	self._goboomlack = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#btn_boom/#go_lack")
	self._btnskill = gohelper.findChildButtonWithAudio(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#btn_skill", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._imageskillicon = gohelper.findChildImage(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#btn_skill/#image_icon")
	self._goskillcanUse = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#btn_skill/#go_canUse")
	self._goskillhasUse = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#btn_skill/#go_hasUse")
	self._txtskillcd = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#btn_skill/#go_hasUse/#txt_cd")
	self._gocollection = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_collection")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem")
	self._simagecollectionicon = gohelper.findChildSingleImage(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/#image_icon")
	self._imagecollectionicon = gohelper.findChildImage(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/#image_icon")
	self._txtcollectionnum = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/#txt_num")
	self._btncollection = gohelper.findChildButtonWithAudio(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/btn_click", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._gotips = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_tips")
	self._golock = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_lock")
	self._txtlocktitle = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_lock/title/txt_title")
	self._txtlock = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_lock/#txt_lock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeHandBookInfoView:addEvents()
	self._btnrole:AddClickListener(self._btnroleOnClick, self)
	self._btnboom:AddClickListener(self._btnboomOnClick, self)
	self._btnskill:AddClickListener(self._btnskillOnClick, self)
	self._btncollection:AddClickListener(self._btncollectionOnClick, self)
	self:addEventCbs()
end

function ArcadeHandBookInfoView:removeEvents()
	self._btnrole:RemoveClickListener()
	self._btnboom:RemoveClickListener()
	self._btnskill:RemoveClickListener()
	self._btncollection:RemoveClickListener()
	self:removeEventCbs()
end

function ArcadeHandBookInfoView:_btnroleOnClick()
	return
end

function ArcadeHandBookInfoView:_btnboomOnClick()
	if not self._boomMo then
		local effectList = self._mo:getEffect()

		self._boomMo = effectList and effectList[ArcadeEnum.EffectType.Bomb]

		if not self._boomMo then
			return
		end
	end

	local anchor = {
		x = 103,
		y = -164
	}
	local param = {
		SkillMo = self._boomMo,
		AnchorPos = anchor,
		orignViewName = self.viewName
	}

	ArcadeController.instance:openTipView(ArcadeEnum.TipType.Skill, param)
end

function ArcadeHandBookInfoView:_btnskillOnClick()
	if not self._skillMo then
		local effectList = self._mo:getEffect()

		self._skillMo = effectList and effectList[ArcadeEnum.EffectType.Skill]

		if not self._skillMo then
			return
		end
	end

	local anchor = {
		x = -160,
		y = -164
	}
	local param = {
		SkillMo = self._skillMo,
		AnchorPos = anchor,
		orignViewName = self.viewName
	}

	ArcadeController.instance:openTipView(ArcadeEnum.TipType.Skill, param)
end

function ArcadeHandBookInfoView:_btncollectionOnClick()
	if not self._collectionMo then
		local effectList = self._mo:getEffect()

		self._collectionMo = effectList and effectList[ArcadeEnum.EffectType.Collection]

		if not self._collectionMo then
			return
		end
	end

	local anchor = {
		x = 386,
		y = -623
	}
	local param = {
		CollectionMo = self._collectionMo,
		AnchorPos = anchor,
		orignViewName = self.viewName
	}

	ArcadeController.instance:openTipView(ArcadeEnum.TipType.Collection, param)
end

function ArcadeHandBookInfoView:addEventCbs()
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnCutHandBookTab, self._onCutHandBookTab, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnClickHandBookItem, self._onClickHandBookItem, self)
end

function ArcadeHandBookInfoView:removeEventCbs()
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnCutHandBookTab, self._onCutHandBookTab, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnClickHandBookItem, self._onClickHandBookItem, self)
end

function ArcadeHandBookInfoView:_onCutHandBookTab(type)
	TaskDispatcher.cancelTask(self.refreshView, self)
	self._anim:Play("open1", 0, 0)
	self:refreshView()
end

function ArcadeHandBookInfoView:_onClickHandBookItem(type, id)
	self._infoAnim:Play(UIAnimationName.Switch, 0, 0)
	TaskDispatcher.runDelay(self.refreshView, self, 0.167)
end

function ArcadeHandBookInfoView:_editableInitView()
	self._attrItemList = self:getUserDataTb_()
	self._skillDescItemList = self:getUserDataTb_()

	gohelper.setActive(self._txtDesc.gameObject, false)

	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._infoAnim = self._goinfo:GetComponent(typeof(UnityEngine.Animator))

	local golockattr = gohelper.findChild(self._golock, "layout/go_base")

	self._lockAttrIcons = self:getUserDataTb_()

	for attr, param in pairs(ArcadeEnum.AttributeParams) do
		self._lockAttrIcons[attr] = gohelper.findChildImage(golockattr, string.format("%s/icon", param.Sort))
	end
end

function ArcadeHandBookInfoView:onUpdateParam()
	return
end

function ArcadeHandBookInfoView:onOpen()
	TaskDispatcher.cancelTask(self.refreshView, self)
	gohelper.setActive(self._gobase, false)
	self:refreshView()
end

function ArcadeHandBookInfoView:refreshView()
	self._mo = ArcadeHandBookModel.instance:getCurShowMo()

	local param = ArcadeEnum.HandBookParams[self._mo:getType()]

	if param then
		if not param.DetailTitle then
			local detailTitle = "arcade_hankbook_detail_character"
			local desc = luaLang(detailTitle)

			self._txttitle.text = desc
			self._txtlocktitle.text = desc

			self:_refreshStatus()
		end
	end
end

function ArcadeHandBookInfoView:_refreshStatus()
	self._isLock = self._mo:isLock()

	gohelper.setActive(self._golock, self._isLock)
	gohelper.setActive(self._gounlock, not self._isLock)
	self:_refreshInfo()

	if self._isLock then
		self._txtlock.text = self._mo:getLockTip()

		for attr, param in pairs(ArcadeEnum.AttributeParams) do
			local imgIcon = self._lockAttrIcons[attr]

			if imgIcon then
				UISpriteSetMgr.instance:setV3a3EliminateSprite(imgIcon, param.Icon, true)
			end
		end
	else
		self:_refreshAttribute()
		self:_refreshEffect()
	end
end

function ArcadeHandBookInfoView:_refreshInfo()
	if not self._isLock then
		local icon = self._mo:getBigIcon()
		local hasIcon = string.nilorempty(icon)

		if not hasIcon then
			self._simagerole:LoadImage(ResUrl.getEliminateIcon(icon), function()
				self._imagerole:SetNativeSize()
			end, self)
		end

		local anchorX, anchorY, scaleX, scaleY = self._mo:getBigIconTrans()

		recthelper.setAnchor(self._simagerole.transform, anchorX, anchorY)
		transformhelper.setLocalScale(self._simagerole.transform, scaleX, scaleY, 1)
	end

	self._txtname.text = self._mo:getName()

	self:_refreshSkillDesc()
	gohelper.setActive(self._gounknownrole.gameObject, self._isLock)
	gohelper.setActive(self._simagerole.gameObject, not self._isLock)
end

function ArcadeHandBookInfoView:_refreshSkillDesc()
	local count = 0

	if self._isLock then
		local item = self:_getSkillDescItem(1)

		item.txt.text = ArcadeEnum.Unknown
		count = 1
	else
		for i, desc in ipairs(self._mo:getDescList()) do
			local item = self:_getSkillDescItem(i)

			item.txt.text = desc
			count = count + 1
		end
	end

	for i, item in ipairs(self._skillDescItemList) do
		gohelper.setActive(item.go.gameObject, i <= count)
	end
end

function ArcadeHandBookInfoView:_getSkillDescItem(index)
	local item = self._skillDescItemList[index]

	if not item then
		item = self:getUserDataTb_()

		if index == 1 then
			if not self._txtDesc.gameObject then
				local go = gohelper.cloneInPlace(self._txtDesc.gameObject)

				item.go = go
				item.txt = go:GetComponent(gohelper.Type_TextMesh)
				self._skillDescItemList[index] = item
			end
		end
	end

	return item
end

function ArcadeHandBookInfoView:_refreshAttribute()
	local attrList = self._mo:getAttribute()

	for type, item in pairs(self._attrItemList) do
		local isShow = attrList and attrList[type]

		gohelper.setActive(item.go, isShow)
	end

	if attrList then
		for type, attr in pairs(attrList) do
			local item = self:_getAttributeItem(type)
			local param = ArcadeEnum.AttributeParams[type]

			if self._isLock then
				item.txtNum.text = ArcadeEnum.Unknown or attr.value
			end

			UISpriteSetMgr.instance:setV3a3EliminateSprite(item.imgIcon, param.Icon, true)
			gohelper.setActive(item.go, true)
			gohelper.setSibling(item.go, param.Sort)
		end
	end
end

function ArcadeHandBookInfoView:_getAttributeItem(type)
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

function ArcadeHandBookInfoView:_refreshEffect()
	local effectList = self._mo:getEffect()

	self._skillMo = effectList and effectList[ArcadeEnum.EffectType.Skill]
	self._boomMo = effectList and effectList[ArcadeEnum.EffectType.Bomb]
	self._collectionMo = effectList and effectList[ArcadeEnum.EffectType.Collection]

	gohelper.setActive(self._btnskill.gameObject, self._skillMo ~= nil)
	gohelper.setActive(self._btnboom.gameObject, self._boomMo ~= nil)
	gohelper.setActive(self._gocollection.gameObject, self._collectionMo ~= nil)

	local height = effectList and tabletool.len(effectList) > 0 and 165 or 350

	recthelper.setHeight(self._scrolldes.transform, height)
	self:_refreshSkill()
	self:_refreshBoom()
	self:_refreshCollection()
end

function ArcadeHandBookInfoView:_refreshBoom()
	if self._boomMo == nil then
		return
	end

	local icon = self._boomMo:getIcon()

	if not string.nilorempty(icon) then
		UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imageboomicon, icon)
	end

	self._txtboomnum.text = self._boomMo:getCount()
end

function ArcadeHandBookInfoView:_refreshSkill()
	if self._skillMo == nil then
		return
	end

	local icon = self._skillMo:getIcon()

	if not string.nilorempty(icon) then
		UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imageskillicon, icon)
	end
end

function ArcadeHandBookInfoView:_refreshCollection()
	if self._collectionMo == nil then
		return
	end

	local icon = self._collectionMo:getIcon()

	if not string.nilorempty(icon) then
		self._simagecollectionicon:LoadImage(ResUrl.getEliminateIcon(icon))
	end
end

function ArcadeHandBookInfoView:onClose()
	TaskDispatcher.cancelTask(self.refreshView, self)
end

function ArcadeHandBookInfoView:onDestroyView()
	self._simagerole:UnLoadImage()
	self._simagecollectionicon:UnLoadImage()
end

return ArcadeHandBookInfoView
