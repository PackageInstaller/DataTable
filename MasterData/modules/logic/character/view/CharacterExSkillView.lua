-- chunkname: @modules/logic/character/view/CharacterExSkillView.lua

module("modules.logic.character.view.CharacterExSkillView", package.seeall)

local CharacterExSkillView = class("CharacterExSkillView", BaseView)

function CharacterExSkillView:onInitView()
	self._simagebgimg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bgimg")
	self._simagelefticon = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_lefticon")
	self._simagerighticon = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_righticon")
	self._simagerighticon2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_righticon2")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_mask")
	self._goglowcontainer = gohelper.findChild(self.viewGO, "bg/#go_glowcontainer")
	self._golvProgress = gohelper.findChild(self.viewGO, "#go_lvProgress")
	self._goitem = gohelper.findChild(self.viewGO, "materialCost/#go_item")
	self._txtcostnum = gohelper.findChildText(self.viewGO, "materialCost/#txt_costnum")
	self._btnup = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_up")
	self._golevelupeffect = gohelper.findChild(self.viewGO, "#btn_up/#go_levelupbeffect")
	self._gobtn = gohelper.findChild(self.viewGO, "#go_btn")
	self._goskillDetailTipView = gohelper.findChild(self.viewGO, "#go_skillDetailTipView")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_skillDetailTipView/tipViewBg/#go_arrow")
	self._goContent = gohelper.findChild(self.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content")
	self._godescripteList = gohelper.findChild(self.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content/#go_descripteList")
	self._godescitem = gohelper.findChild(self.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content/#go_descripteList/descripteitem")
	self._goBuffContainer = gohelper.findChild(self.viewGO, "#go_buffContainer")
	self._goJumpAnimationMask = gohelper.findChild(self.viewGO, "#go_jumpAnimationMask")
	self._gotrialtip = gohelper.findChild(self.viewGO, "#go_trialtip")
	self._gonewdestiny = gohelper.findChild(self.viewGO, "#go_skillDetailTipView/#btn_newdestiny")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterExSkillView:addEvents()
	self._btnup:AddClickListener(self._btnupOnClick, self)
end

function CharacterExSkillView:removeEvents()
	self._btnup:RemoveClickListener()
end

function CharacterExSkillView:_showReshape(isShow)
	local posY = 0
	local tarY = 0

	for i = 1, CharacterEnum.MaxSkillExLevel do
		local item = self:getDescItem(i)
		local itemHeight = item:_showReshape(isShow)

		if i == self.exSkillLevel then
			tarY = posY
		end

		posY = posY + itemHeight
	end

	self:rebuildLayout()
	recthelper.setAnchorY(self._goContent.transform, tarY)
end

CharacterExSkillView.NormalDescColor = "#b1b1b1"
CharacterExSkillView.NotHaveDescColor = "#b1b1b1"
CharacterExSkillView.NormalDescColorA = 1
CharacterExSkillView.NotHaveDescColorA = 0.4

function CharacterExSkillView:_btnupOnClick()
	if self._enoughCost then
		HeroRpc.instance:sendHeroUpgradeSkillRequest(self.heroId, 3, 1)
	else
		GameFacade.showToast(ToastEnum.CharacterExSkill)
	end
end

function CharacterExSkillView:_onEscapeBtnClick()
	self:closeThis()
end

function CharacterExSkillView:_editableInitView()
	self.goCircleNormal1 = gohelper.findChild(self.viewGO, "go_skills/#simage_circleup")
	self.goCircleNormal2 = gohelper.findChild(self.viewGO, "go_skills/#simage_circledown")
	self.goCircleMax1 = gohelper.findChild(self.viewGO, "go_skills/#simage_maxup")
	self.goCircleMax2 = gohelper.findChild(self.viewGO, "go_skills/#simage_maxdown")
	self._gocircle1 = gohelper.findChild(self.viewGO, "go_skills/decoration/#go_circle1")
	self._gocircle5 = gohelper.findChild(self.viewGO, "go_skills/decoration/#go_circle5")
	self._gosignature = gohelper.findChild(self.viewGO, "go_skills/signature")
	self._goclickani = gohelper.findChild(self.viewGO, "go_skills/click/ani")
	self._gomaxani = gohelper.findChild(self.viewGO, "go_skills/max/ani")
	self._simagefulllevel = gohelper.findChildSingleImage(self.viewGO, "go_skills/decoration/#simage_fulllevel")
	self._scrollskillDetailTipScroll = gohelper.findChildScrollRect(self.viewGO, "#go_skillDetailTipView/skillDetailTipScroll")

	self._scrollskillDetailTipScroll:AddOnValueChanged(self._refreshArrow, self)

	self.goMaterialCost = gohelper.findChild(self.viewGO, "materialCost")

	self._simagebgimg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	self._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	self._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	self._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	self._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	self._simagefulllevel:LoadImage(ResUrl.getCharacterExskill("zs_02"))

	self.skillContainerGo = gohelper.findChild(self.viewGO, "go_skills")
	self.skillCardGoDict = self:getUserDataTb_()

	for i = 1, 3 do
		local skillCardGo = self:getUserDataTb_()
		local go = gohelper.findChild(self.skillContainerGo, "skillicon" .. i)

		skillCardGo.go = go
		skillCardGo.icon = gohelper.findChildSingleImage(go, "ani/imgIcon")
		skillCardGo.tagIcon = gohelper.findChildSingleImage(go, "ani/tag/tagIcon")
		skillCardGo.gostar = gohelper.findChild(go, "ani/star")
		self.skillCardGoDict[i] = skillCardGo
	end

	self._buffBg = gohelper.findChild(self.viewGO, "#go_buffContainer/buff_bg")
	self._buffBgClick = gohelper.getClick(self._buffBg)

	self._buffBgClick:AddClickDownListener(self.hideBuffContainer, self)

	self._jumpAnimationClick = gohelper.getClick(self._goJumpAnimationMask)

	self._jumpAnimationClick:AddClickListener(self.onJumpAnimationClick, self)

	self._goBuffItem = gohelper.findChild(self.viewGO, "#go_buffContainer/#go_buffitem")
	self._txtBuffName = gohelper.findChildText(self.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name")
	self._goBuffTag = gohelper.findChild(self.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag")
	self._txtBuffTagName = gohelper.findChildText(self.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	self._txtBuffDesc = gohelper.findChildText(self.viewGO, "#go_buffContainer/#go_buffitem/txt_desc")
	self.golvList = self:getUserDataTb_()

	for i = 1, CharacterEnum.MaxSkillExLevel do
		table.insert(self.golvList, gohelper.findChild(self.viewGO, "#go_lvProgress/#go_lv" .. i))
	end

	gohelper.setActive(self._goBuffContainer, false)
	gohelper.setActive(self._godescitem, false)
	gohelper.setActive(self._gosignature, false)
	gohelper.setActive(self._goJumpAnimationMask, false)

	self.goSignatureAnimator = self._gosignature:GetComponent(typeof(UnityEngine.Animator))
	self.viewGoAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.viewGoAniEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	self.viewGoAniEventWrap:AddEventListener("end", self.onAniEnd, self)
	self.viewGoAniEventWrap:AddEventListener("refreshUI", self.onAniRefreshUI, self)
	self.viewGoAniEventWrap:AddEventListener("onJumpTargetFrame", self.onJumpTargetFrame, self)

	self.goClickAnimation = self._goclickani:GetComponent(typeof(UnityEngine.Animation))
	self.maxBuffContainerWidth = 570
end

function CharacterExSkillView:initViewParam()
	self.heroId = self.viewParam.heroId
	self._config = HeroConfig.instance:getHeroCO(self.heroId)
	self.showAttributeOption = self.viewParam.showAttributeOption
	self.fromHeroDetailView = self.viewParam.fromHeroDetailView

	if self.showAttributeOption == CharacterEnum.showAttributeOption.ShowMin then
		self.exSkillLevel = 0
	elseif self.showAttributeOption == CharacterEnum.showAttributeOption.ShowMax then
		self.exSkillLevel = CharacterEnum.MaxSkillExLevel
	elseif not self.viewParam.heroMo then
		local heroMo = HeroModel.instance:getByHeroId(self.heroId)

		self.exSkillLevel = heroMo.exSkillLevel
	end

	self._isOwnHero = self.viewParam.isOwnHero
	self._hideTrialTip = self.viewParam.hideTrialTip
end

function CharacterExSkillView:onOpen()
	self:initViewParam()
	self:_refreshUI()

	if self:_isSkillLevelTop() then
		gohelper.setActive(self._gosignature, true)
		self.goSignatureAnimator:Play(UIAnimationName.Open)
	end

	if self.fromHeroDetailView then
		self.viewContainer:hideHomeBtn()
	end

	if self:_isSkillLevelTop() then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_mould_opengeneral)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_mould_open)
	end

	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._onHeroExSkillUp, self)
	NavigateMgr.instance:addEscape(ViewName.CharacterExSkillView, self._onEscapeBtnClick, self)
end

function CharacterExSkillView:onUpdateParam()
	self:initViewParam()
	self:_refreshUI()
	gohelper.setActive(self._gosignature, self:_isSkillLevelTop())
end

function CharacterExSkillView:_refreshUI()
	self:refreshCircleAnimation()
	self:refreshSkillCardInfo()
	self:refreshExLevel()
	self:showSkillDetail()
	self:_refreshReshape()

	local isOwnHero = true

	if self.viewParam.heroMo then
		isOwnHero = self.viewParam.heroMo:isOwnHero()
	end

	local var_11_0

	if self._isOwnHero ~= nil then
		isOwnHero = self._isOwnHero
		var_11_0 = self:_isSkillLevelTop() and isOwnHero
	end

	self:setSkillLevelTop(var_11_0)
	gohelper.setActive(self._gotrialtip, not isOwnHero and not self._hideTrialTip)

	if self:_isSkillLevelTop() or self.fromHeroDetailView or not isOwnHero then
		self:hideItemAndBtn()
	else
		self:showItemAndBtn()
		self:refreshItem()
	end
end

function CharacterExSkillView:refreshCircleAnimation()
	local isTop = self:_isSkillLevelTop()

	gohelper.setActive(self.goCircleNormal1, not isTop)
	gohelper.setActive(self.goCircleNormal2, not isTop)
	gohelper.setActive(self.goCircleMax1, isTop)
	gohelper.setActive(self.goCircleMax2, isTop)
end

function CharacterExSkillView:refreshSkillCardInfo()
	local skillIdDict = SkillConfig.instance:getHeroBaseSkillIdDict(self._config.id, true)
	local heroMo = HeroModel.instance:getByHeroId(self._config.id)
	local skillCo, skillId
	local deviceMo = heroMo and heroMo:getDeviceMo()

	for i = 1, 3 do
		skillId = ((heroMo or nil) and SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(self._config.id, nil, heroMo))[i]

		if ((heroMo or nil) and SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(self._config.id, nil, heroMo))[i] ~= 0 then
			if not lua_skill.configDict[skillId] then
				logError(string.format("heroID : %s, skillId not found : %s", self._config.id, skillId))
			end

			local isDeviceSkill = false

			if deviceMo then
				local deviceSkillId = deviceMo:getSkillId(i)

				if deviceSkillId == skillId then
					isDeviceSkill = true
				end
			end

			local gostar = self.skillCardGoDict[i].gostar

			if gostar then
				gohelper.setActive(gostar, not isDeviceSkill)
			end

			self.skillCardGoDict[i].icon:LoadImage(ResUrl.getSkillIcon(lua_skill.configDict[skillId].icon))
			self.skillCardGoDict[i].tagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. lua_skill.configDict[skillId].showTag))
		end

		gohelper.setActive(self.skillCardGoDict[i].go.gameObject, skillId ~= 0)
	end
end

function CharacterExSkillView:refreshExLevel()
	for i = 1, self.exSkillLevel do
		gohelper.setActive(self.golvList[i], true)
	end

	for i = self.exSkillLevel + 1, CharacterEnum.MaxSkillExLevel do
		gohelper.setActive(self.golvList[i], false)
	end
end

function CharacterExSkillView:setSkillLevelTop(isTopLevel)
	if isTopLevel or self.fromHeroDetailView then
		recthelper.setHeight(self._scrollskillDetailTipScroll.transform, 638)
	else
		recthelper.setHeight(self._scrollskillDetailTipScroll.transform, 480)
	end

	gohelper.setActive(self._simagefulllevel.gameObject, isTopLevel)
	gohelper.setActive(self._gocircle5, isTopLevel)
	gohelper.setActive(self._gocircle1, isTopLevel == false)
end

function CharacterExSkillView:hideItemAndBtn()
	gohelper.setActive(self.goMaterialCost, false)
	gohelper.setActive(self._btnup.gameObject, false)
end

function CharacterExSkillView:showItemAndBtn()
	gohelper.setActive(self.goMaterialCost, true)
	gohelper.setActive(self._btnup.gameObject, true)
end

function CharacterExSkillView:refreshItem()
	if self:_isSkillLevelTop() then
		gohelper.setActive(self.goMaterialCost, false)

		return
	end

	gohelper.setActive(self.goMaterialCost, true)

	local exCo = SkillConfig.instance:getherolevelexskillCO(self.heroId, self.exSkillLevel + 1)

	self._itemIcon = self._itemIcon or IconMgr.instance:getCommonItemIcon(self._goitem)

	local itemco = string.splitToNumber(exCo.consume, "#")

	self._itemIcon:setMOValue(itemco[1], itemco[2], itemco[3])
	self._itemIcon:isShowCount(false)

	local count = ItemModel.instance:getItemQuantity(itemco[1], itemco[2])

	self._enoughCost = count >= itemco[3]
	self._txtcostnum.text = self._enoughCost and string.format("%s/%s", count, itemco[3]) or string.format("<color=#ce4949>%s</color>/%s", count, itemco[3])

	gohelper.setActive(self._golevelupeffect, self._enoughCost)
end

function CharacterExSkillView:_refreshArrow()
	if self._scrollskillDetailTipScroll.verticalNormalizedPosition > 0.01 then
		gohelper.setActive(self._goarrow, true)
	else
		gohelper.setActive(self._goarrow, false)
	end
end

function CharacterExSkillView:_isSkillLevelTop()
	return self.exSkillLevel == CharacterEnum.MaxSkillExLevel
end

function CharacterExSkillView:_onHeroExSkillUp()
	if not self.viewParam.heroMo then
		local heroMo = HeroModel.instance:getByHeroId(self.heroId)

		self.exSkillLevel = self.viewParam.heroMo.exSkillLevel

		self:resetJumpValue()
		gohelper.setActive(self._goJumpAnimationMask, true)

		if self:_isSkillLevelTop() then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mould_succeedspecial)
			self.viewGoAnimator:Play("max", 0, 0)
			gohelper.setActive(self._gosignature, true)
			self.goSignatureAnimator:Play("max", 0, 0)
		else
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mould_succeedgeneral)
			self.viewGoAnimator:Play("nomal", 0, 0)
		end

		gohelper.setActive(self.golvList[self.exSkillLevel], true)

		self.lvAnimator = self.golvList[self.exSkillLevel]:GetComponent(typeof(UnityEngine.Animator))

		self.lvAnimator:Play(UIAnimationName.Click, 0, 0)
		self._descList[self.exSkillLevel]:playHeroExSkillUPAnimation()
	end
end

function CharacterExSkillView:onAniEnd()
	gohelper.setActive(self._goJumpAnimationMask, false)
	gohelper.setActive(self._goclickani, true)
	gohelper.setActive(self._gomaxani, true)
end

function CharacterExSkillView:onAniRefreshUI()
	self:_refreshUI()
end

function CharacterExSkillView:onJumpTargetFrame()
	self.inPreTargetFrame = false
end

function CharacterExSkillView:resetJumpValue()
	self.inPreTargetFrame = true
	self.jumped = false
end

function CharacterExSkillView:getExSkillTipInfo(heroId, exSkillLevel)
	local co = SkillConfig.instance:getherolevelexskillCO(heroId, exSkillLevel)

	if not co then
		return
	end

	local exskillid = co.skillEx
	local skillinfo = lua_skill.configDict[exskillid]

	return skillinfo.name, skillinfo.desc, skillinfo.icon, skillinfo.desc_art
end

function CharacterExSkillView:showSkillDetail()
	local posY = 0
	local tarY = 0

	for i = 1, CharacterEnum.MaxSkillExLevel do
		local item = self:getDescItem(i)
		local itemHeight = item:updateInfo(self, self.heroId, i, self.exSkillLevel, self.fromHeroDetailView, self._isShowReshape)

		if i == self.exSkillLevel then
			tarY = posY
		end

		posY = posY + itemHeight
	end

	self._goContent:SetActive(true)
	self:rebuildLayout()
	recthelper.setAnchorY(self._goContent.transform, tarY)
end

function CharacterExSkillView:rebuildLayout()
	ZProj.UGUIHelper.RebuildLayout(self._godescripteList.transform)
	self:_refreshArrow()
end

function CharacterExSkillView:getDescItem(level)
	self._descList = self._descList or self:getUserDataTb_()

	local item = self._descList[level]

	if not item then
		item = CharacterSkillDescripteNew.New()

		local itemGo = gohelper.clone(self._godescitem, self._godescripteList)

		itemGo:SetActive(true)
		item:initView(itemGo)

		self._descList[level] = item
	end

	return item
end

function CharacterExSkillView:showBuffContainer(skillName, skillDesc, clickPosition)
	gohelper.setActive(self._goBuffContainer, true)

	self.buffItemWidth = GameUtil.getTextWidthByLine(self._txtBuffDesc, skillDesc, 24)
	self.buffItemWidth = self.buffItemWidth + 70

	if self.buffItemWidth > self.maxBuffContainerWidth then
		self.buffItemWidth = self.maxBuffContainerWidth
	end

	self._txtBuffName.text = skillName
	self._txtBuffDesc.text = skillDesc

	local buffTagName = FightConfig.instance:getBuffTag(skillName)

	gohelper.setActive(self._goBuffTag, not string.nilorempty(buffTagName))

	self._txtBuffTagName.text = buffTagName

	local reallyClickPosition = recthelper.screenPosToAnchorPos(clickPosition, self.viewGO.transform)

	recthelper.setAnchor(self._goBuffItem.transform, reallyClickPosition.x - 20, reallyClickPosition.y)
end

function CharacterExSkillView:hideBuffContainer()
	gohelper.setActive(self._goBuffContainer, false)
end

function CharacterExSkillView:getShowAttributeOption()
	return self.showAttributeOption
end

function CharacterExSkillView:onJumpAnimationClick()
	if self.jumped then
		return
	end

	if not self.inPreTargetFrame then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_mould)

	self.jumped = true

	if self:_isSkillLevelTop() then
		self.viewGoAnimator:Play("max", 0, 0.7913043478260869)
		self.goSignatureAnimator:Play("max", 0, 0.9479166666666666)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mould_skipspecial)
	else
		self.viewGoAnimator:Play("nomal", 0, 0.7913043478260869)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mould_skipgeneral)
	end

	self.goClickAnimation:Stop()
	gohelper.setActive(self._goclickani, false)
	gohelper.setActive(self._gomaxani, false)
	gohelper.setActive(self.golvList[self.exSkillLevel], true)
	self.lvAnimator:Play(UIAnimationName.Click, 0, 1)
	self._descList[self.exSkillLevel]:jumpAnimation()
	gohelper.setActive(self._goJumpAnimationMask, false)
end

function CharacterExSkillView:_refreshReshape()
	local heroMo = self.viewParam.heroMo
	local isEquipReshapeAttr = false

	if heroMo and heroMo.destinyStoneMo then
		local stoneCo = heroMo.destinyStoneMo:isEquipReshape()

		if stoneCo ~= nil then
			isEquipReshapeAttr = true
		end
	end

	local rot = isEquipReshapeAttr and 180 or 0
	local y = isEquipReshapeAttr and -300 or -156.6

	self:_showReshape(isEquipReshapeAttr)
	gohelper.setActive(self._gonewdestiny.gameObject, isEquipReshapeAttr)
	transformhelper.setLocalRotation(self._golvProgress.transform, rot, 0, 0)
	recthelper.setAnchorY(self._golvProgress.transform, y)
end

function CharacterExSkillView:onClose()
	for _, descItem in ipairs(self._descList) do
		descItem:onClose()
	end
end

function CharacterExSkillView:onDestroyView()
	self._buffBgClick:RemoveClickDownListener()
	self._jumpAnimationClick:RemoveClickListener()
	self._scrollskillDetailTipScroll:RemoveOnValueChanged()
	self._simagebgimg:UnLoadImage()
	self._simagelefticon:UnLoadImage()
	self._simagerighticon:UnLoadImage()
	self._simagerighticon2:UnLoadImage()
	self._simagemask:UnLoadImage()
	self._simagefulllevel:UnLoadImage()
	self.viewGoAniEventWrap:RemoveAllEventListener()

	for _, skillCardGo in pairs(self.skillCardGoDict) do
		skillCardGo.icon:UnLoadImage()
		skillCardGo.tagIcon:UnLoadImage()
	end
end

return CharacterExSkillView
