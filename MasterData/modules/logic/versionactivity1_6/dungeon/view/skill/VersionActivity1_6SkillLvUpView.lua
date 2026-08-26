-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/skill/VersionActivity1_6SkillLvUpView.lua

module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillLvUpView", package.seeall)

local VersionActivity1_6SkillLvUpView = class("VersionActivity1_6SkillLvUpView", BaseView)
local maxBuffContainerWidth = 570
local skillLvLinePath = "v1a6_talent_paint_line_%s_%s"

function VersionActivity1_6SkillLvUpView:onInitView()
	self._btnLvUp = gohelper.findChildButtonWithAudio(self.viewGO, "#go_skillDetailTipView/#btn_LvUp")
	self._btnLvDown = gohelper.findChildButtonWithAudio(self.viewGO, "#go_skillDetailTipView/#btn_LvDown")
	self._btnLvUpDisable = gohelper.findChildButtonWithAudio(self.viewGO, "#go_skillDetailTipView/#btn_LvUpDisable")
	self._btnLvDownDisable = gohelper.findChildButtonWithAudio(self.viewGO, "#go_skillDetailTipView/#btn_LvDownDisable")
	self._textLvUpCost = gohelper.findChildText(self.viewGO, "#go_skillDetailTipView/#btn_LvUp/#txt_Num")
	self._textLvDownCost = gohelper.findChildText(self.viewGO, "#go_skillDetailTipView/#btn_LvDown/#txt_Num")
	self._iamgeBtnLvUp = gohelper.findChildImage(self.viewGO, "#go_skillDetailTipView/#btn_LvUp/#txt_Num/#simage_Prop")
	self._imageBtnLvDown = gohelper.findChildImage(self.viewGO, "#go_skillDetailTipView/#btn_LvDown/#txt_Num/#simage_Prop")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Left/Title/txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "Left/Title/txt_TitleEn")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "Left/#image_Icon")
	self._imageIconGold = gohelper.findChildImage(self.viewGO, "Left/#image_Icon_gold")
	self._imageIconSliver = gohelper.findChildImage(self.viewGO, "Left/#image_Icon_sliver")
	self._txtDesc = gohelper.findChildText(self.viewGO, "Left/#txt_Descr")
	self._btnSkillPointProp = gohelper.findChildButtonWithAudio(self.viewGO, "SkillPoint/#btn_Info/Click")
	self._btnSkillPointTips = gohelper.findChildButtonWithAudio(self.viewGO, "SkillPoint/#btn_Info")
	self._btnTipsClose = gohelper.findChildButtonWithAudio(self.viewGO, "SkillPoint/#btn_Info/image_TipsBG/#btn_Tips_Close")
	self._goSkilPointTips = gohelper.findChild(self.viewGO, "SkillPoint/#btn_Info/image_TipsBG")
	self._txtSkillPointNum = gohelper.findChildText(self.viewGO, "SkillPoint/#btn_Info/image_TipsBG/txt_Tips_Num")
	self._txtRemainSkillPointNum = gohelper.findChildText(self.viewGO, "SkillPoint/txt_Skill_Num")
	self._imageSkillPoint = gohelper.findChildImage(self.viewGO, "SkillPoint/#simage_Prop")
	self._goSkillIconEffect = gohelper.findChild(self.viewGO, "Left/eff")
	self._goSkillPointEffect = gohelper.findChild(self.viewGO, "SkillPoint/eff")
	self._goSkilPointAttrContent = gohelper.findChild(self.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content")
	self._goSkilPointAttrItem = gohelper.findChild(self.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content/#go_descripteList")
	self._goBuffContainer = gohelper.findChild(self.viewGO, "#go_buffContainer")
	self._buffBg = gohelper.findChild(self.viewGO, "#go_buffContainer/buff_bg")
	self._buffBgClick = gohelper.getClick(self._buffBg)
	self._goBuffItem = gohelper.findChild(self.viewGO, "#go_buffContainer/#go_buffitem")
	self._txtBuffName = gohelper.findChildText(self.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name")
	self._goBuffTag = gohelper.findChild(self.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag")
	self._txtBuffTagName = gohelper.findChildText(self.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	self._txtBuffDesc = gohelper.findChildText(self.viewGO, "#go_buffContainer/#go_buffitem/txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_6SkillLvUpView:addEvents()
	self._btnLvUp:AddClickListener(self._btnLvUpOnClick, self)
	self._btnLvUpDisable:AddClickListener(self._btnLvUpOnClick, self)
	self._btnLvDown:AddClickListener(self._btnLvDownOnClick, self)
	self._btnLvDownDisable:AddClickListener(self._btnLvDownOnClick, self)
	self._btnSkillPointProp:AddClickListener(self._btnSkillPointOnClick, self)
	self._btnSkillPointTips:AddClickListener(self._btnSkillPointTipsOnClick, self)
	self._btnTipsClose:AddClickListener(self._btnSkillPointTipsCloseOnClick, self)
	self._buffBgClick:AddClickDownListener(self.hideBuffContainer, self)
end

function VersionActivity1_6SkillLvUpView:removeEvents()
	self._btnLvUp:RemoveClickListener()
	self._btnLvDown:RemoveClickListener()
	self._btnLvUpDisable:RemoveClickListener()
	self._btnLvDownDisable:RemoveClickListener()
	self._btnSkillPointTips:RemoveClickListener()
	self._btnSkillPointProp:RemoveClickListener()
	self._btnTipsClose:RemoveClickListener()
	self._buffBgClick:RemoveClickDownListener()
end

function VersionActivity1_6SkillLvUpView:_editableInitView()
	self.skillAttrItemDict = {}

	gohelper.setActive(self._goSkilPointAttrItem, false)
	gohelper.setActive(self._goBuffContainer, false)
end

function VersionActivity1_6SkillLvUpView:onUpdateParam()
	return
end

function VersionActivity1_6SkillLvUpView:onOpen()
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, Act148Event.SkillLvDown, self._onLvChange, self)
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, Act148Event.SkillLvUp, self._onLvChange, self)
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.SkillPointReturnBack, self._skillPointReturnBack, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)

	self._skillType = self.viewParam and self.viewParam.skillType
	self._skillMo = VersionActivity1_6DungeonSkillModel.instance:getAct148SkillMo(self._skillType)
	self._curLv = self._skillMo:getLevel()

	gohelper.setActive(self._goSkilPointTips, false)
end

function VersionActivity1_6SkillLvUpView:onOpenFinish()
	self:initCenterSkillNodes()
	self:refreshCenterSkillNodes()
	self:_refreshSkillPointNum()
	self:refreshSkillInfo()
	self:refreshSkillIcon()
	self:initSkillAttrItems()
	self:refreshSkillAttrs()
	self:refreshBtnCost()
	self:_refreshSkillPointIcon()
	self:_refreshBtnVisible()
end

function VersionActivity1_6SkillLvUpView:onClose()
	return
end

function VersionActivity1_6SkillLvUpView:onDestroyView()
	return
end

function VersionActivity1_6SkillLvUpView:_onLvChange(newLv)
	self._skillMo = VersionActivity1_6DungeonSkillModel.instance:getAct148SkillMo(self._skillType)

	local isLvDown = newLv < self._curLv

	AudioMgr.instance:trigger((isLvDown or nil) and (AudioEnum.UI.Act1_6DungeonSkillViewLvDown or AudioEnum.UI.Act1_6DungeonSkillViewLvUp))

	self._curLv = newLv

	self:doSkillLvChangeView(newLv)
	self:refreshSkillAttrs(isLvDown)
	self:refreshCenterSkillNodes()
	self:_refreshSkillNodeEffect(isLvDown)
	self:_refreshSkillPointNum()
	self:refreshBtnCost()
	self:refreshSkillIcon()
	self:_refreshBtnVisible()
end

function VersionActivity1_6SkillLvUpView:initCenterSkillNodes()
	self._skillLvPoints = self:getUserDataTb_()

	local skillTypeNum = VersionActivity1_6DungeonEnum.skillTypeNum

	for i = 1, skillTypeNum do
		local root = gohelper.findChild(self.viewGO, "#go_Paint" .. i)

		gohelper.setActive(root, i == self._skillType)
	end

	local skillPointRoot = gohelper.findChild(self.viewGO, "#go_Paint" .. self._skillType)

	self._imageSkillNodeLine = gohelper.findChildImage(skillPointRoot, "image_PaintLineFG")
	self._animatorSkillNodeLine = self._imageSkillNodeLine:GetComponent(typeof(UnityEngine.Animator))

	local skillPointMaxNum = VersionActivity1_6DungeonEnum.skillPointMaxNum
	local nodeItemTemp = gohelper.findChild(skillPointRoot, "#go_Lv")

	for i = 1, skillPointMaxNum do
		local skillNodeRootGo = gohelper.findChild(skillPointRoot, "#go_Lv" .. i)
		local skillNodeGo = gohelper.clone(nodeItemTemp, skillNodeRootGo, "node")

		gohelper.setActive(skillNodeGo, true)

		self._skillLvPoints[i] = self:getUserDataTb_()
		self._skillLvPoints[i].normalPointDark = gohelper.findChild(skillNodeGo, "#go_Point1-1")
		self._skillLvPoints[i].normalPoint = gohelper.findChild(skillNodeGo, "#go_Point1-2")
		self._skillLvPoints[i].keyPointDark = gohelper.findChild(skillNodeGo, "#go_Point2-1")
		self._skillLvPoints[i].keyPoint = gohelper.findChild(skillNodeGo, "#go_Point2-2")
		self._skillLvPoints[i].effect = gohelper.findChild(skillNodeGo, "eff")
	end
end

function VersionActivity1_6SkillLvUpView:refreshCenterSkillNodes()
	local KeyPointIdxs = VersionActivity1_6DungeonEnum.SkillKeyPointIdxs
	local skillPointMaxNum = VersionActivity1_6DungeonEnum.skillPointMaxNum

	for i = 1, skillPointMaxNum do
		local isKeyPoint = KeyPointIdxs[i]
		local normalDarkPointShow, keyDarkPoint = i > self._curLv, i > self._curLv
		local normalPoint, keyPoint = i <= self._curLv, i <= self._curLv

		if isKeyPoint then
			normalDarkPointShow = false
			normalPoint = false
		else
			keyPoint = false
			keyDarkPoint = false
		end

		gohelper.setActive(self._skillLvPoints[i].normalPoint, normalPoint)
		gohelper.setActive(self._skillLvPoints[i].normalPointDark, normalDarkPointShow)
		gohelper.setActive(self._skillLvPoints[i].keyPoint, keyPoint)
		gohelper.setActive(self._skillLvPoints[i].keyPointDark, keyDarkPoint)
	end

	gohelper.setActive(self._imageSkillNodeLine.gameObject, self._curLv > 1)

	if self._curLv > 1 then
		local lineImagePath = string.format(skillLvLinePath, self._skillType, self._curLv - 1)

		UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(self._imageSkillNodeLine, lineImagePath)

		if self._animatorSkillNodeLine then
			self._animatorSkillNodeLine:Play(UIAnimationName.Open, 0, 0)
		end
	end
end

function VersionActivity1_6SkillLvUpView:_refreshSkillNodeEffect(isDownLv)
	if isDownLv then
		gohelper.setActive(self._goSkillPointEffect, false)
		gohelper.setActive(self._goSkillPointEffect, true)
	end

	gohelper.setActive(self._goSkillIconEffect, false)
	gohelper.setActive(self._goSkillIconEffect, true)

	local skillPointMaxNum = VersionActivity1_6DungeonEnum.skillPointMaxNum

	for i = 1, skillPointMaxNum do
		if not isDownLv then
			gohelper.setActive(self._skillLvPoints[i].effect, self._curLv == i)
		end
	end
end

local remainSkillPointNumColor = "#E4C599"

function VersionActivity1_6SkillLvUpView:_refreshSkillPointNum()
	local maxSkillPointNum = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillPointNum)
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a6DungeonSkill)

	if currencyMO then
		if not currencyMO.quantity then
			self._txtRemainSkillPointNum.text = 0

			SLFramework.UGUI.GuiHelper.SetColor(self._txtRemainSkillPointNum, remainSkillPointNumColor)

			local totalGotSkillPointNum = VersionActivity1_6DungeonSkillModel.instance:getTotalGotSkillPointNum()

			self._txtSkillPointNum.text = string.format("<color=#EB5F34>%s</color>/%s", totalGotSkillPointNum or 0, maxSkillPointNum)
		end
	end
end

function VersionActivity1_6SkillLvUpView:refreshSkillInfo()
	local skillLv = self._skillMo and self._skillMo:getLevel() or 0
	local skillCfg = Activity148Config.instance:getAct148CfgByTypeLv(self._skillType, skillLv)
	local skillTypeCfg = Activity148Config.instance:getAct148SkillTypeCfg(self._skillType)

	if skillLv == 0 then
		skillCfg = Activity148Config.instance:getAct148CfgByTypeLv(self._skillType, 1)
	end

	self._txtTitle.text = skillTypeCfg.skillName
	self._txtTitleEn.text = skillTypeCfg.skillNameEn
	self._txtDesc.text = skillTypeCfg.skillInfoDesc
end

function VersionActivity1_6SkillLvUpView:refreshSkillIcon()
	local skillLv = self._skillMo and self._skillMo:getLevel() or 0
	local skillCfg = Activity148Config.instance:getAct148CfgByTypeLv(self._skillType, skillLv)
	local skillTypeCfg = Activity148Config.instance:getAct148SkillTypeCfg(self._skillType)
	local skillSmallIcon = skillLv == 0 and Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.SkillOriginIcon[self._skillType]) or skillCfg.skillSmallIcon

	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(self._imageIcon, skillSmallIcon)

	local silverEffectSkillLv = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.SilverEffectSkillLv)
	local goldEffectSkillLv = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.GoldEffectSkillLv)

	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(self._imageIconGold, skillSmallIcon)
	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(self._imageIconSliver, skillSmallIcon)

	local isGold = skillLv >= tonumber(goldEffectSkillLv)
	local isSilver = skillLv >= tonumber(silverEffectSkillLv)

	if isGold then
		gohelper.setActive(self._imageIconSliver.gameObject, false)
		gohelper.setActive(self._imageIconGold.gameObject, true)
	elseif isSilver then
		gohelper.setActive(self._imageIconSliver.gameObject, true)
		gohelper.setActive(self._imageIconGold.gameObject, false)
	else
		gohelper.setActive(self._imageIconSliver.gameObject, false)
		gohelper.setActive(self._imageIconGold.gameObject, false)
	end
end

function VersionActivity1_6SkillLvUpView:initSkillAttrItems()
	local skillCfgs = Activity148Config.instance:getAct148CfgDictByType(self._skillType)

	for i, skillCfg in pairs(skillCfgs) do
		local skillAttrItemGo = gohelper.cloneInPlace(self._goSkilPointAttrItem, "item" .. i)

		gohelper.setActive(skillAttrItemGo, true)

		self.skillAttrItemDict[skillCfg.id] = self:createSkillAttrItem(skillAttrItemGo, skillCfg)
	end
end

function VersionActivity1_6SkillLvUpView:createSkillAttrItem(skillAttrGo, skillCfg)
	local skillAttrItem = VersionActivity1_6SkillDescItem.New()

	skillAttrItem:init(skillAttrGo, skillCfg, self)
	skillAttrItem:refreshInfo()

	return skillAttrItem
end

function VersionActivity1_6SkillLvUpView:refreshSkillAttrs(isLvDown)
	local skillCfgs = Activity148Config.instance:getAct148CfgDictByType(self._skillType)

	for i, skillCfg in pairs(skillCfgs) do
		local skillAttrItem = self.skillAttrItemDict[skillCfg.id]

		skillAttrItem.canvasGroup.alpha = self._curLv < skillAttrItem.lv and 0.5 or 1
		skillAttrItem.txtlvcanvasGroup.alpha = self._curLv < skillAttrItem.lv and 0.5 or 1

		gohelper.setActive(skillAttrItem.goCurLvFlag, self._curLv == skillAttrItem.lv - 1)
	end

	local autoMoveContentSkillLvDown = 5

	if isLvDown and autoMoveContentSkillLvDown > self._curLv or not isLvDown and self._curLv > 3 then
		local posY = 0
		local tarY = 0

		for i = 1, VersionActivity1_6DungeonEnum.skillMaxLv do
			local skillCfg = skillCfgs[i]
			local skillAttrItem = self.skillAttrItemDict[skillCfg.id]
			local itemHeight = skillAttrItem.height

			if i == self._curLv then
				tarY = posY
			end

			posY = posY + itemHeight
		end

		recthelper.setAnchorY(self._goSkilPointAttrContent.transform, tarY)
	end
end

function VersionActivity1_6SkillLvUpView:doSkillLvChangeView(newLv)
	for i, skillAttrItem in pairs(self.skillAttrItemDict) do
		gohelper.setActive(skillAttrItem.vx, newLv == skillAttrItem.lv)
	end
end

function VersionActivity1_6SkillLvUpView:refreshBtnCost()
	local curLv = self._curLv
	local nextLv = curLv + 1
	local curLvSkillCfg = Activity148Config.instance:getAct148CfgByTypeLv(self._skillType, curLv)
	local textLvDownCostStr = ""

	if curLvSkillCfg then
		local costStr = curLvSkillCfg.cost
		local attribute = string.splitToNumber(costStr, "#")
		local costNum = attribute[3]

		textLvDownCostStr = "+" .. costNum
	end

	self._textLvDownCost.text = textLvDownCostStr

	local textLvUpCostStr = ""
	local nextLvSkillCfg = Activity148Config.instance:getAct148CfgByTypeLv(self._skillType, nextLv)

	if nextLvSkillCfg then
		local costStr = nextLvSkillCfg.cost
		local attribute = string.splitToNumber(costStr, "#")
		local costNum = attribute[3]

		textLvUpCostStr = "-" .. costNum
	end

	self._textLvUpCost.text = textLvUpCostStr
end

function VersionActivity1_6SkillLvUpView:_refreshBtnVisible()
	local curLv = self._curLv
	local nextLv = curLv + 1
	local preLv = curLv - 1
	local nextLvSkillCfg = Activity148Config.instance:getAct148CfgByTypeLv(self._skillType, nextLv)
	local ableToLvUp = nextLvSkillCfg ~= nil
	local ableToLvDown = preLv >= 0

	gohelper.setActive(self._btnLvUp, ableToLvUp)
	gohelper.setActive(self._btnLvUpDisable, not ableToLvUp)
	gohelper.setActive(self._btnLvDown, ableToLvDown)
	gohelper.setActive(self._btnLvDownDisable, not ableToLvDown)
end

function VersionActivity1_6SkillLvUpView:_refreshSkillPointIcon()
	local currencyCfg = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a6DungeonSkill)
	local currencyname = string.format("%s_1", currencyCfg and currencyCfg.icon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageSkillPoint, currencyname)
	UISpriteSetMgr.instance:setCurrencyItemSprite(self._iamgeBtnLvUp, currencyname)
	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageBtnLvDown, currencyname)
end

function VersionActivity1_6SkillLvUpView:showBuffContainer(skillName, skillDesc, clickPosition)
	gohelper.setActive(self._goBuffContainer, true)

	self.buffItemWidth = GameUtil.getTextWidthByLine(self._txtBuffDesc, skillDesc, 24)
	self.buffItemWidth = self.buffItemWidth + 70

	if self.buffItemWidth > maxBuffContainerWidth then
		self.buffItemWidth = maxBuffContainerWidth
	end

	self._txtBuffName.text = skillName
	self._txtBuffDesc.text = skillDesc

	local buffTagName = FightConfig.instance:getBuffTag(skillName)

	gohelper.setActive(self._goBuffTag, not string.nilorempty(buffTagName))

	self._txtBuffTagName.text = buffTagName

	local reallyClickPosition = recthelper.screenPosToAnchorPos(clickPosition, self.viewGO.transform)

	recthelper.setAnchor(self._goBuffItem.transform, reallyClickPosition.x - 20, reallyClickPosition.y)
end

function VersionActivity1_6SkillLvUpView:hideBuffContainer()
	gohelper.setActive(self._goBuffContainer, false)
end

function VersionActivity1_6SkillLvUpView:_btnLvUpOnClick()
	local curLv = self._curLv
	local nextLv = curLv + 1
	local nextLvSkillCfg = Activity148Config.instance:getAct148CfgByTypeLv(self._skillType, nextLv)

	if not nextLvSkillCfg then
		GameFacade.showToast(ToastEnum.Act1_6DungeonToast60201)
	else
		local costStr = nextLvSkillCfg.cost
		local attribute = string.splitToNumber(costStr, "#")
		local costId = attribute[2]
		local costNum = attribute[3]
		local quantity = CurrencyModel.instance:getCurrency(costId).quantity

		if quantity < costNum then
			GameFacade.showToast(ToastEnum.Act1_6DungeonToast60203)

			return
		end

		VersionActivity1_6DungeonRpc.instance:sendAct148UpLevelRequest(self._skillType)
	end
end

function VersionActivity1_6SkillLvUpView:_btnLvDownOnClick()
	local curLv = self._curLv
	local preLv = curLv - 1

	if preLv < 0 then
		GameFacade.showToast(ToastEnum.Act1_6DungeonToast60202)
	else
		VersionActivity1_6DungeonRpc.instance:sendAct148DownLevelRequest(self._skillType)
	end
end

function VersionActivity1_6SkillLvUpView:_btnSkillPointOnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a6DungeonSkill, false, nil, false)
end

function VersionActivity1_6SkillLvUpView:_btnSkillPointTipsOnClick()
	self:refreshSkillPointTips(true)
end

function VersionActivity1_6SkillLvUpView:_btnSkillPointTipsCloseOnClick()
	self:refreshSkillPointTips(false)
end

function VersionActivity1_6SkillLvUpView:refreshSkillPointTips(show)
	gohelper.setActive(self._goSkilPointTips, show)
end

function VersionActivity1_6SkillLvUpView:_skillPointReturnBack()
	self:_refreshSkillPointNum()
end

function VersionActivity1_6SkillLvUpView:_onCurrencyChange()
	self:_refreshSkillPointNum()
end

return VersionActivity1_6SkillLvUpView
