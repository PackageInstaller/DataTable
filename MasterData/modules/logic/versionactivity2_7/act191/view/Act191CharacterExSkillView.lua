-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191CharacterExSkillView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191CharacterExSkillView", package.seeall)

local Act191CharacterExSkillView = class("Act191CharacterExSkillView", BaseView)

function Act191CharacterExSkillView:onInitView()
	self._golvProgress = gohelper.findChild(self.viewGO, "#go_lvProgress")
	self._goitem = gohelper.findChild(self.viewGO, "materialCost/#go_item")
	self._goskillDetailTipView = gohelper.findChild(self.viewGO, "#go_skillDetailTipView")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_skillDetailTipView/tipViewBg/#go_arrow")
	self._goContent = gohelper.findChild(self.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content")
	self._godescripteList = gohelper.findChild(self.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content/#go_descripteList")
	self._godescitem = gohelper.findChild(self.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content/#go_descripteList/descripteitem")
	self._goBuffContainer = gohelper.findChild(self.viewGO, "#go_buffContainer")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191CharacterExSkillView:addEvents()
	return
end

function Act191CharacterExSkillView:removeEvents()
	return
end

Act191CharacterExSkillView.NormalDescColor = "#b1b1b1"
Act191CharacterExSkillView.NotHaveDescColor = "#b1b1b1"
Act191CharacterExSkillView.NormalDescColorA = 1
Act191CharacterExSkillView.NotHaveDescColorA = 0.4

function Act191CharacterExSkillView:_onEscapeBtnClick()
	self:closeThis()
end

function Act191CharacterExSkillView:_editableInitView()
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
	self._simagefulllevel:LoadImage(ResUrl.getCharacterExskill("zs_02"))

	self.skillContainerGo = gohelper.findChild(self.viewGO, "go_skills")
	self.skillCardGoDict = self:getUserDataTb_()

	for i = 1, 3 do
		local skillCardGo = self:getUserDataTb_()

		skillCardGo.icon = gohelper.findChildSingleImage(self.skillContainerGo, string.format("skillicon%s/ani/imgIcon", i))
		skillCardGo.tagIcon = gohelper.findChildSingleImage(self.skillContainerGo, string.format("skillicon%s/ani/tag/tagIcon", i))
		self.skillCardGoDict[i] = skillCardGo
	end

	self._buffBg = gohelper.findChild(self.viewGO, "#go_buffContainer/buff_bg")
	self._buffBgClick = gohelper.getClick(self._buffBg)

	self._buffBgClick:AddClickDownListener(self.hideBuffContainer, self)

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

	self.goSignatureAnimator = self._gosignature:GetComponent(typeof(UnityEngine.Animator))
	self.viewGoAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.viewGoAniEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	self.viewGoAniEventWrap:AddEventListener("end", self.onAniEnd, self)
	self.viewGoAniEventWrap:AddEventListener("refreshUI", self.onAniRefreshUI, self)
	self.viewGoAniEventWrap:AddEventListener("onJumpTargetFrame", self.onJumpTargetFrame, self)

	self.goClickAnimation = self._goclickani:GetComponent(typeof(UnityEngine.Animation))
	self.maxBuffContainerWidth = 570
end

function Act191CharacterExSkillView:initViewParam()
	self.config = self.viewParam.config
	self.exSkillLevel = self.config.exLevel
end

function Act191CharacterExSkillView:onOpen()
	self:initViewParam()
	self:_refreshUI()

	if self:_isSkillLevelTop() then
		gohelper.setActive(self._gosignature, true)
		self.goSignatureAnimator:Play(UIAnimationName.Open)
	end

	if self:_isSkillLevelTop() then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_mould_opengeneral)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_mould_open)
	end

	NavigateMgr.instance:addEscape(ViewName.Act191CharacterExSkillView, self._onEscapeBtnClick, self)
end

function Act191CharacterExSkillView:onUpdateParam()
	self:initViewParam()
	self:_refreshUI()
	gohelper.setActive(self._gosignature, self:_isSkillLevelTop())
end

function Act191CharacterExSkillView:_refreshUI()
	self:refreshCircleAnimation()
	self:refreshSkillCardInfo()
	self:refreshExLevel()
	self:showSkillDetail()
	self:setSkillLevelTop(self:_isSkillLevelTop())
end

function Act191CharacterExSkillView:refreshCircleAnimation()
	local isTop = self:_isSkillLevelTop()

	gohelper.setActive(self.goCircleNormal1, not isTop)
	gohelper.setActive(self.goCircleNormal2, not isTop)
	gohelper.setActive(self.goCircleMax1, isTop)
	gohelper.setActive(self.goCircleMax2, isTop)
end

function Act191CharacterExSkillView:refreshSkillCardInfo()
	local skillIdDict = Activity191Config.instance:getHeroSkillIdDic(self.config.id, true)
	local skillCo, skillId

	for i = 1, 3 do
		if not lua_skill.configDict[skillIdDict[i]] then
			logError(string.format("heroID : %s, skillId not found : %s", self.config.id, skillIdDict[i]))
		end

		self.skillCardGoDict[i].icon:LoadImage(ResUrl.getSkillIcon(lua_skill.configDict[skillIdDict[i]].icon))
		self.skillCardGoDict[i].tagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. lua_skill.configDict[skillIdDict[i]].showTag))
	end
end

function Act191CharacterExSkillView:refreshExLevel()
	for i = 1, self.exSkillLevel do
		gohelper.setActive(self.golvList[i], true)
	end

	for i = self.exSkillLevel + 1, CharacterEnum.MaxSkillExLevel do
		gohelper.setActive(self.golvList[i], false)
	end
end

function Act191CharacterExSkillView:setSkillLevelTop(isTopLevel)
	if isTopLevel then
		recthelper.setHeight(self._scrollskillDetailTipScroll.transform, 638)
	else
		recthelper.setHeight(self._scrollskillDetailTipScroll.transform, 750)
	end

	gohelper.setActive(self._simagefulllevel.gameObject, isTopLevel)
	gohelper.setActive(self._gocircle5, isTopLevel)
	gohelper.setActive(self._gocircle1, isTopLevel == false)
end

function Act191CharacterExSkillView:_refreshArrow()
	if self._scrollskillDetailTipScroll.verticalNormalizedPosition > 0.01 then
		gohelper.setActive(self._goarrow, true)
	else
		gohelper.setActive(self._goarrow, false)
	end
end

function Act191CharacterExSkillView:_isSkillLevelTop()
	return self.exSkillLevel == CharacterEnum.MaxSkillExLevel
end

function Act191CharacterExSkillView:onAniEnd()
	gohelper.setActive(self._goJumpAnimationMask, false)
	gohelper.setActive(self._goclickani, true)
	gohelper.setActive(self._gomaxani, true)
end

function Act191CharacterExSkillView:onAniRefreshUI()
	self:_refreshUI()
end

function Act191CharacterExSkillView:onJumpTargetFrame()
	self.inPreTargetFrame = false
end

function Act191CharacterExSkillView:resetJumpValue()
	self.inPreTargetFrame = true
	self.jumped = false
end

function Act191CharacterExSkillView:showSkillDetail()
	local posY = 0
	local tarY = 0

	for i = 1, CharacterEnum.MaxSkillExLevel do
		local itemHeight = self:addDescItem(i)

		if i == self.exSkillLevel then
			tarY = posY
		end

		posY = posY + itemHeight
	end

	self._goContent:SetActive(true)
	self:rebuildLayout()
	recthelper.setAnchorY(self._goContent.transform, tarY)
end

function Act191CharacterExSkillView:rebuildLayout()
	ZProj.UGUIHelper.RebuildLayout(self._godescripteList.transform)
	self:_refreshArrow()
end

function Act191CharacterExSkillView:addDescItem(level)
	self._descList = self._descList or self:getUserDataTb_()

	local item = self._descList[level]

	if not item then
		item = Act191CharacterSkillDesc.New()

		local itemGo = gohelper.clone(self._godescitem, self._godescripteList)

		itemGo:SetActive(true)
		item:initView(itemGo)

		self._descList[level] = item
	end

	return (item:updateInfo(self, self.config, level))
end

function Act191CharacterExSkillView:showBuffContainer(skillName, skillDesc, clickPosition)
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

function Act191CharacterExSkillView:hideBuffContainer()
	gohelper.setActive(self._goBuffContainer, false)
end

function Act191CharacterExSkillView:getShowAttributeOption()
	return CharacterEnum.showAttributeOption.ShowCurrent
end

function Act191CharacterExSkillView:onClose()
	for _, descItem in ipairs(self._descList) do
		descItem:onClose()
	end
end

function Act191CharacterExSkillView:onDestroyView()
	self._buffBgClick:RemoveClickDownListener()
	self._scrollskillDetailTipScroll:RemoveOnValueChanged()
	self._simagefulllevel:UnLoadImage()
	self.viewGoAniEventWrap:RemoveAllEventListener()

	for _, skillCardGo in pairs(self.skillCardGoDict) do
		skillCardGo.icon:UnLoadImage()
		skillCardGo.tagIcon:UnLoadImage()
	end
end

return Act191CharacterExSkillView
