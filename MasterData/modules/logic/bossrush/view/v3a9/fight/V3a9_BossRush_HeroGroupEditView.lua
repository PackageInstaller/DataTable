-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_HeroGroupEditView.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_HeroGroupEditView", package.seeall)

local V3a9_BossRush_HeroGroupEditView = class("V3a9_BossRush_HeroGroupEditView", BaseView)

function V3a9_BossRush_HeroGroupEditView:onInitView()
	self._gononecharacter = gohelper.findChild(self.viewGO, "characterinfo/#go_nonecharacter")
	self._gocharacterinfo = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo")
	self._imagedmgtype = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/#image_dmgtype")
	self._imagecareericon = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/career/#image_careericon")
	self._txtname = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/name/#txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/name/#txt_nameen")
	self._gospecialitem = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem")
	self._golevel = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/level")
	self._txtlevel = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/level/#txt_level")
	self._txtlevelmax = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/level/#txt_level/#txt_levelmax")
	self._btncharacter = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/level/#btn_character")
	self._btntrial = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/level/#btn_trial")
	self._goBalance = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/level/#go_balance")
	self._goheroLvTxt = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/level/Text")
	self._golevelWithTalent = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent")
	self._txtlevelWithTalent = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level")
	self._txtlevelmaxWithTalent = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level/#txt_levelmax")
	self._btncharacterWithTalent = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_character")
	self._btntrialWithTalent = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_trial")
	self._goBalanceWithTalent = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#go_balance")
	self._goheroLvTxtWithTalent = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/Text")
	self._txttalent = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talent")
	self._txttalentType = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talentType")
	self._btnattribute = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/attribute/#btn_attribute")
	self._goattribute = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	self._goskill = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/#go_skill")
	self._btnpassiveskill = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/#btn_passiveskill")
	self._txtpassivename = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/bg/#txt_passivename")
	self._gopassiveskills = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills")
	self._gorolecontainer = gohelper.findChild(self.viewGO, "#go_rolecontainer")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/mask/#scroll_card")
	self._goScrollContent = gohelper.findChild(self.viewGO, "#go_rolecontainer/mask/#scroll_card/scrollcontent")
	self._scrollquickedit = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/mask/#scroll_quickedit")
	self._gorolesort = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort")
	self._btnlvrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	self._btnexskillrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	self._btnclassify = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	self._btnquickedit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_quickedit")
	self._goexarrow = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")
	self._gobondsGrid = gohelper.findChild(self.viewGO, "#go_rolecontainer/mask/#go_bondsGrid")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_cancel")
	self._txtrecommendAttrDesc = gohelper.findChildText(self.viewGO, "#go_recommendAttr/bg/#txt_desc")
	self._goattrlist = gohelper.findChild(self.viewGO, "#go_recommendAttr/bg/#go_attrlist")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_recommendAttr/bg/#go_attrlist/#go_attritem")
	self._btnassist = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_assist")
	self._btnrelease = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_release")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_HeroGroupEditView:addEvents()
	self._btnlvrank:AddClickListener(self._btnlvrankOnClick, self)
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnexskillrank:AddClickListener(self._btnexskillrankOnClick, self)
	self._btnclassify:AddClickListener(self._btnclassifyOnClick, self)
	self._btncharacter:AddClickListener(self._btncharacterOnClick, self)
	self._btntrial:AddClickListener(self._btntrialOnClick, self)
	self._btncharacterWithTalent:AddClickListener(self._btncharacterOnClick, self)
	self._btntrialWithTalent:AddClickListener(self._btntrialOnClick, self)
	self._btnattribute:AddClickListener(self._btnattributeOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnpassiveskill:AddClickListener(self._btnpassiveskillOnClick, self)
	self._btnquickedit:AddClickListener(self._btnquickeditOnClick, self)
	self._btnassist:AddClickListener(self._btnassistOnClick, self)
	self._btnrelease:AddClickListener(self._btnreleaseOnClick, self)
end

function V3a9_BossRush_HeroGroupEditView:removeEvents()
	self._btnlvrank:RemoveClickListener()
	self._btnrarerank:RemoveClickListener()
	self._btnexskillrank:RemoveClickListener()
	self._btnclassify:RemoveClickListener()
	self._btncharacter:RemoveClickListener()
	self._btntrial:RemoveClickListener()
	self._btncharacterWithTalent:RemoveClickListener()
	self._btntrialWithTalent:RemoveClickListener()
	self._btnattribute:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnpassiveskill:RemoveClickListener()
	self._btnquickedit:RemoveClickListener()
	self._btnassist:RemoveClickListener()
	self._btnrelease:RemoveClickListener()
end

function V3a9_BossRush_HeroGroupEditView:_btnassistOnClick()
	PickAssistController.instance:openPickAssistView(PickAssistEnum.Type.BossRushActMode, self._actId, nil, self._pickOverCallBack, self, true)
end

function V3a9_BossRush_HeroGroupEditView:_btnreleaseOnClick()
	V3a9_BossRushModel.instance:clearAssistMo()
	self:_updateHeroList()
	self:_refreshAssistBtn()
	GameFacade.showToast(ToastEnum.CancelAssist)
end

function V3a9_BossRush_HeroGroupEditView:_pickOverCallBack(mo)
	self:_updateHeroList()
	self:_refreshAssistBtn()

	self._scrollcard.verticalNormalizedPosition = 1
	self._scrollquickedit.verticalNormalizedPosition = 1
end

function V3a9_BossRush_HeroGroupEditView:_btnclassifyOnClick()
	local param = {
		filterType = CharacterEnum.FilterType.HeroGroup,
		EnterType = V3a9BossRushEnum.SearchFilterType.HeroGroup
	}

	ViewMgr.instance:openView(ViewName.V3a9_BossRush_SearchFilterView, param)
end

function V3a9_BossRush_HeroGroupEditView:_btnresetOnClick()
	self:_refreshBtnIcon()
end

function V3a9_BossRush_HeroGroupEditView:_btnpassiveskillOnClick()
	if not self._heroMO then
		return
	end

	local info = {}

	info.tag = "passiveskill"
	info.heroid = self._heroMO.heroId
	info.heroMo = self._heroMO
	info.tipPos = Vector2.New(851, -59)
	info.buffTipsX = 1603
	info.anchorParams = {
		Vector2.New(0, 0.5),
		Vector2.New(0, 0.5)
	}
	info.isBalance = HeroGroupBalanceHelper.getIsBalanceMode() and not self._heroMO:isOtherPlayerHero()

	CharacterController.instance:openCharacterTipView(info)
end

function V3a9_BossRush_HeroGroupEditView:_btnconfirmOnClick()
	if self._isShowQuickEdit then
		self:_saveQuickGroupInfo()
		self:closeThis()

		return
	end

	if not self:_normalEditHasChange() then
		self:closeThis()

		return
	end

	self:_saveCurGroupInfo()
	self:closeThis()
end

function V3a9_BossRush_HeroGroupEditView:checkTrialNum()
	return false
end

function V3a9_BossRush_HeroGroupEditView:_btncancelOnClick()
	self:closeThis()
end

function V3a9_BossRush_HeroGroupEditView:_btncharacterOnClick()
	if self._heroMO then
		local heroMoList = self._isShowQuickEdit and V3a9_BossRush_HeroGroupQuickEditListModel.instance:getList() or V3a9_BossRush_HeroGroupEditListModel.instance:getList()
		local newList = {}

		for k, heroMo in ipairs(heroMoList) do
			if not heroMo:isOtherPlayerHero() then
				table.insert(newList, heroMo)
			end
		end

		CharacterController.instance:openCharacterView(self._heroMO, newList)
	end
end

function V3a9_BossRush_HeroGroupEditView:_btntrialOnClick()
	if self._heroMO then
		local heroMoList = self._isShowQuickEdit and V3a9_BossRush_HeroGroupQuickEditListModel.instance:getList() or V3a9_BossRush_HeroGroupEditListModel.instance:getList()
		local newList = {}

		for k, heroMo in ipairs(heroMoList) do
			if heroMo:isOtherPlayerHero() then
				table.insert(newList, heroMo)
			end
		end

		CharacterController.instance:openCharacterView(self._heroMO, newList)
	end
end

function V3a9_BossRush_HeroGroupEditView:_btnattributeOnClick()
	if self._heroMO then
		local mo = HeroGroupTrialModel.instance:getById(self._originalHeroUid)
		local trialEquipMo
		local info = {}

		info.tag = "attribute"
		info.heroid = self._heroMO.heroId
		info.equips = self._equips
		info.showExtraAttr = true
		info.fromHeroGroupEditView = true
		info.heroMo = self._heroMO
		info.trialEquipMo = (mo or nil) and mo.trialEquipMo
		info.isBalance = HeroGroupBalanceHelper.getIsBalanceMode() and not self._heroMO:isOtherPlayerHero()

		CharacterController.instance:openCharacterTipView(info)
	end
end

function V3a9_BossRush_HeroGroupEditView:_btnexskillrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshBtnIcon()
	self:_refreshCurScrollBySort()
end

function V3a9_BossRush_HeroGroupEditView:_btnlvrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshBtnIcon()
	self:_refreshCurScrollBySort()
end

function V3a9_BossRush_HeroGroupEditView:_btnrarerankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshBtnIcon()
	self:_refreshCurScrollBySort()
end

function V3a9_BossRush_HeroGroupEditView:_btnquickeditOnClick()
	self._isShowQuickEdit = not self._isShowQuickEdit

	self:_refreshBtnIcon()
	self:_refreshEditMode()

	if self._cardTweenId then
		ZProj.TweenHelper.KillById(self._cardTweenId)
	end

	if self._quickTweenId then
		ZProj.TweenHelper.KillById(self._quickTweenId)
	end

	if self._isShowQuickEdit then
		self:_onHeroItemClick(nil)
		V3a9_BossRush_HeroGroupQuickEditListModel.instance:cancelAllSelected()
		V3a9_BossRush_HeroGroupQuickEditListModel.instance:copyQuickEditCardList()

		local mo = V3a9_BossRush_HeroGroupQuickEditListModel.instance:getById(self._originalHeroUid)

		if mo then
			local index = V3a9_BossRush_HeroGroupQuickEditListModel.instance:getIndex(mo)

			V3a9_BossRush_HeroGroupQuickEditListModel.instance:selectCell(index, true)
		end
	else
		V3a9_BossRush_HeroGroupQuickEditListModel.instance:cancelAllErrorSelected()
		self:_saveQuickGroupInfo()
		self:_onHeroItemClick()
		V3a9_BossRush_HeroGroupEditListModel.instance:cancelAllSelected()
		V3a9_BossRush_HeroGroupEditListModel.instance:copyCharacterCardList(true)
	end
end

function V3a9_BossRush_HeroGroupEditView:_onEditorHeroItem()
	V3a9_BossRushExpandBondModel.instance:refreshAddBondGroupId()
	self._bondGroupGrid:refreshExpandBonds()

	if self._isShowQuickEdit then
		if self._needShowToastRestrict2 then
			V3a9_BossRush_HeroGroupQuickEditListModel.instance:checkIsAllHeroRestrict(true)

			self._needShowToastRestrict2 = false
		else
			local emptyPos = V3a9_BossRush_HeroGroupQuickEditListModel.instance:getEmptyPos()

			if emptyPos and emptyPos < 5 then
				self._needShowToastRestrict2 = true
			end
		end
	end
end

function V3a9_BossRush_HeroGroupEditView:_onHeroItemClick(heroMO)
	self._heroMO = heroMO

	self:_refreshCharacterInfo()
end

function V3a9_BossRush_HeroGroupEditView:_getEditorList()
	return self._isShowQuickEdit and V3a9_BossRush_HeroGroupQuickEditListModel.instance:getHeroUids() or V3a9_BossRush_HeroGroupEditListModel.instance:getReplaceHeroList(self._singleGroupMOId, (self._heroMO or nil) and (self._heroMO.uid or "0"))
end

function V3a9_BossRush_HeroGroupEditView:_refreshCharacterInfo()
	if self._heroMO then
		gohelper.setActive(self._gononecharacter, false)
		gohelper.setActive(self._gocharacterinfo, true)
		self:_refreshSkill()
		self:_refreshMainInfo()
		self:_refreshAttribute()
		self:_refreshPassiveSkill()
	else
		gohelper.setActive(self._gononecharacter, true)
		gohelper.setActive(self._gocharacterinfo, false)
	end
end

function V3a9_BossRush_HeroGroupEditView:_refreshMainInfo()
	if self._heroMO then
		gohelper.setActive(self._btntrial.gameObject, self._heroMO:isOtherPlayerHero())
		gohelper.setActive(self._btntrialWithTalent.gameObject, self._heroMO:isOtherPlayerHero())
		UISpriteSetMgr.instance:setCommonSprite(self._imagecareericon, "sx_biandui_" .. tostring(self._heroMO.config.career))
		UISpriteSetMgr.instance:setCommonSprite(self._imagedmgtype, "dmgtype" .. tostring(self._heroMO.config.dmgType))

		self._txtname.text = self._heroMO:getHeroName()
		self._txtnameen.text = self._heroMO.config.nameEng

		local isShowTalent = self._heroMO.rank >= CharacterEnum.TalentRank and self._heroMO.talent > 0

		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
			isShowTalent = false
		end

		local balanceLv = 0
		local balanceRank = 0
		local balanceTalent = 0
		local isShowBalanceTalent = false

		if not self._heroMO:isOtherPlayerHero() then
			balanceLv, balanceRank, balanceTalent = HeroGroupBalanceHelper.getHeroBalanceInfo(self._heroMO.heroId)

			if balanceRank and balanceRank >= CharacterEnum.TalentRank and balanceTalent > 0 then
				isShowBalanceTalent = true
			end
		end

		local isBalance = balanceLv and balanceLv > self._heroMO.level
		local isBalanceTalent = isShowBalanceTalent and (not isShowTalent or balanceTalent > self._heroMO.talent)

		if isShowTalent or isShowBalanceTalent then
			gohelper.setActive(self._golevel, false)
			gohelper.setActive(self._golevelWithTalent, true)
			gohelper.setActive(self._goBalanceWithTalent, isBalance or isBalanceTalent)
			gohelper.setActive(self._goheroLvTxtWithTalent, true)

			if isBalance then
				local showLevel, rank = HeroConfig.instance:getShowLevel(balanceLv)
				local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, rank)[1]
				local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

				self._txtlevelWithTalent.text = "<color=#8fb1cc>" .. tostring(showLevel)
				self._txtlevelmaxWithTalent.text = string.format("/%d", showMaxLevel)
			else
				local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, self._heroMO.rank)[1]
				local showLevel = HeroConfig.instance:getShowLevel(self._heroMO.level)
				local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

				self._txtlevelWithTalent.text = tostring(showLevel)
				self._txtlevelmaxWithTalent.text = string.format("/%d", showMaxLevel)
			end

			self._txttalent.text = isBalanceTalent and "<color=#8fb1cc>Lv.<size=40>" .. tostring(balanceTalent) or "Lv.<size=40>" .. tostring(self._heroMO.talent)
			self._txttalentType.text = luaLang("talent_character_talentcn" .. self._heroMO:getTalentTxtByHeroType())
		else
			gohelper.setActive(self._golevel, true)
			gohelper.setActive(self._golevelWithTalent, false)
			gohelper.setActive(self._goBalance, isBalance)
			gohelper.setActive(self._goheroLvTxt, not isBalance)

			if isBalance then
				local showLevel, rank = HeroConfig.instance:getShowLevel(balanceLv)
				local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, rank)[1]
				local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

				self._txtlevel.text = "<color=#8fb1cc>" .. tostring(showLevel)
				self._txtlevelmax.text = string.format("/%d", showMaxLevel)
			else
				local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, self._heroMO.rank)[1]
				local showLevel = HeroConfig.instance:getShowLevel(self._heroMO.level)
				local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

				self._txtlevel.text = tostring(showLevel)
				self._txtlevelmax.text = string.format("/%d", showMaxLevel)
			end
		end

		local tags = {}
		local battleTag = self._heroMO:getHeroBattleTag()

		if not string.nilorempty(battleTag) then
			tags = string.split(battleTag, "#")
		end

		for i = 1, #tags do
			local careerTable = self._careerGOs[i]

			if not careerTable then
				careerTable = self:getUserDataTb_()
				careerTable.go = gohelper.cloneInPlace(self._gospecialitem, "item" .. i)
				careerTable.textfour = gohelper.findChildText(careerTable.go, "#go_fourword/name")
				careerTable.textthree = gohelper.findChildText(careerTable.go, "#go_threeword/name")
				careerTable.texttwo = gohelper.findChildText(careerTable.go, "#go_twoword/name")
				careerTable.containerfour = gohelper.findChild(careerTable.go, "#go_fourword")
				careerTable.containerthree = gohelper.findChild(careerTable.go, "#go_threeword")
				careerTable.containertwo = gohelper.findChild(careerTable.go, "#go_twoword")

				table.insert(self._careerGOs, careerTable)
			end

			local desc = HeroConfig.instance:getBattleTagConfigCO(tags[i]).tagName
			local wordCount = GameUtil.utf8len(desc)

			gohelper.setActive(careerTable.containertwo, wordCount <= 2)
			gohelper.setActive(careerTable.containerthree, wordCount == 3)
			gohelper.setActive(careerTable.containerfour, wordCount >= 4)

			if wordCount <= 2 then
				careerTable.texttwo.text = desc
			elseif wordCount == 3 then
				careerTable.textthree.text = desc
			else
				careerTable.textfour.text = desc
			end

			gohelper.setActive(careerTable.go, true)
		end

		for i = #tags + 1, #self._careerGOs do
			gohelper.setActive(self._careerGOs[i].go, false)
		end
	end
end

function V3a9_BossRush_HeroGroupEditView:_refreshAttribute()
	if self._heroMO then
		local mo = HeroGroupTrialModel.instance:getById(self._originalHeroUid)
		local trialEquipMo
		local var_25_0

		if mo then
			trialEquipMo = mo.trialEquipMo
			var_25_0 = HeroGroupBalanceHelper.getIsBalanceMode() and not self._heroMO:isOtherPlayerHero()
		end

		local attrDict = self._heroMO:getTotalBaseAttrDict(self._equips, nil, nil, var_25_0, trialEquipMo)

		for index, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
			local co = HeroConfig.instance:getHeroAttributeCO(attrId)

			self._attributevalues[index].name.text = co.name
			self._attributevalues[index].value.text = attrDict[attrId]

			CharacterController.instance:SetAttriIcon(self._attributevalues[index].icon, attrId)
		end
	end
end

function V3a9_BossRush_HeroGroupEditView:_refreshPassiveSkill()
	if not self._heroMO then
		return
	end

	local pskills = self._heroMO:getpassiveskillsCO()
	local firstSkill = pskills[1]
	local skillId = firstSkill.skillPassive
	local passiveSkillConfig = lua_skill.configDict[skillId]

	if not passiveSkillConfig then
		logError("找不到角色被动技能, skillId: " .. tostring(skillId))
	else
		self._txtpassivename.text = passiveSkillConfig.name
	end

	local balanceLv = 0

	if not self._heroMO:isOtherPlayerHero() then
		balanceLv = HeroGroupBalanceHelper.getHeroBalanceLv(self._heroMO.heroId)
	end

	local isBalance = balanceLv > self._heroMO.level
	local passiveLevel, rank = SkillConfig.instance:getHeroExSkillLevelByLevel(self._heroMO.heroId, math.max(self._heroMO.level, balanceLv))

	for i = 1, #pskills do
		local unlock = i <= passiveLevel

		gohelper.setActive(self._passiveskillitems[i].on, unlock and not isBalance)
		gohelper.setActive(self._passiveskillitems[i].off, not unlock)
		gohelper.setActive(self._passiveskillitems[i].balance, unlock and isBalance)
		gohelper.setActive(self._passiveskillitems[i].go, true)
	end

	for i = #pskills + 1, #self._passiveskillitems do
		gohelper.setActive(self._passiveskillitems[i].go, false)
	end

	if pskills[0] then
		gohelper.setActive(self._passiveskillitems[0].on, true)
		gohelper.setActive(self._passiveskillitems[0].off, false)
		gohelper.setActive(self._passiveskillitems[0].balance, isBalance)
		gohelper.setActive(self._passiveskillitems[0].go, true)
	else
		gohelper.setActive(self._passiveskillitems[0].go, false)
	end
end

function V3a9_BossRush_HeroGroupEditView:_refreshSkill()
	local var_27_0 = self._heroMO
	local var_27_1

	if self._heroMO then
		var_27_0 = self._heroMO.heroId
		var_27_1 = HeroGroupBalanceHelper.getIsBalanceMode() and not self._heroMO:isOtherPlayerHero()
	end

	self._skillContainer:onUpdateMO(var_27_0, nil, self._heroMO, var_27_1, CharacterEnum.DeviceViewType.V3a9_BossRush_HeroGroupEditView)
end

function V3a9_BossRush_HeroGroupEditView:_refreshBtnIcon()
	local state = CharacterModel.instance:getRankState()
	local tag = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup)

	gohelper.setActive(self._lvBtns[1], tag ~= 1)
	gohelper.setActive(self._lvBtns[2], tag == 1)
	gohelper.setActive(self._rareBtns[1], tag ~= 2)
	gohelper.setActive(self._rareBtns[2], tag == 2)

	local hasFilter = CharacterSearchFilterModel.instance:hasFilter()

	gohelper.setActive(self._classifyBtns[1], not hasFilter)
	gohelper.setActive(self._classifyBtns[2], hasFilter)
	HeroGroupTrialModel.instance:sortByLevelAndRare(tag == 1, state[tag] == 1)
	transformhelper.setLocalScale(self._lvArrow[1], 1, state[1], 1)
	transformhelper.setLocalScale(self._lvArrow[2], 1, state[1], 1)
	transformhelper.setLocalScale(self._rareArrow[1], 1, state[2], 1)
	transformhelper.setLocalScale(self._rareArrow[2], 1, state[2], 1)
end

function V3a9_BossRush_HeroGroupEditView:_updateHeroList()
	self:_refreshBtnIcon()

	if self._isShowQuickEdit then
		V3a9_BossRush_HeroGroupQuickEditListModel.instance:copyQuickEditCardList()
	else
		V3a9_BossRush_HeroGroupEditListModel.instance:copyCharacterCardList()
	end
end

function V3a9_BossRush_HeroGroupEditView:replaceSelectHeroDefaultEquip()
	if self._heroMO and self._heroMO:hasDefaultEquip() then
		local heroGroupMo = V3a9_BossRushModel.instance:getCurGroupMO()
		local heroGroupEquipMoList = heroGroupMo.equips

		for i, heroGroupEquipMo in pairs(heroGroupEquipMoList) do
			if heroGroupEquipMo.equipUid[1] == self._heroMO.defaultEquipUid then
				heroGroupEquipMo.equipUid[1] = "0"

				break
			end
		end

		heroGroupEquipMoList[self._singleGroupMOId - 1].equipUid[1] = self._heroMO.defaultEquipUid
	end

	V3a9_BossRushModel.instance:refreshShowEquips(self._stage)
end

function V3a9_BossRush_HeroGroupEditView:replaceQuickGroupHeroDefaultEquip(heroUids)
	V3a9_BossRushModel.instance:quickModifyHeroEquip(self._stage, heroUids)
end

function V3a9_BossRush_HeroGroupEditView:_saveCurGroupInfo()
	self:replaceSelectHeroDefaultEquip()

	local stage = self._stage

	if self._heroMO then
		if not self._heroMO.uid then
			local uid = "0"

			V3a9_BossRushModel.instance:modifyHeroGroup(stage, uid, self._singleGroupMOId)
		end
	end
end

function V3a9_BossRush_HeroGroupEditView:_saveQuickGroupInfo()
	if V3a9_BossRush_HeroGroupQuickEditListModel.instance:getIsDirty() then
		local newHeroUids = V3a9_BossRush_HeroGroupQuickEditListModel.instance:getHeroUids()
		local stage = self._stage

		V3a9_BossRushModel.instance:quickModifyHeroGroup(stage, newHeroUids)
		self:replaceQuickGroupHeroDefaultEquip(newHeroUids)
	end
end

function V3a9_BossRush_HeroGroupEditView:_onAttributeChanged(level, heroId)
	CharacterModel.instance:setFakeLevel(heroId, level)
end

function V3a9_BossRush_HeroGroupEditView:_normalEditHasChange()
	if Activity104Model.instance:isSeasonChapter() then
		return true
	end

	if self._originalHeroUid and self._heroMO and self._originalHeroUid == self._heroMO.uid then
		return false
	elseif (not self._originalHeroUid or self._originalHeroUid == "0") and not self._heroMO then
		return false
	else
		return true
	end
end

function V3a9_BossRush_HeroGroupEditView:_refreshEditMode()
	gohelper.setActive(self._scrollquickedit.gameObject, self._isShowQuickEdit)
	gohelper.setActive(self._scrollcard.gameObject, not self._isShowQuickEdit)
	gohelper.setActive(self._goBtnEditQuickMode.gameObject, self._isShowQuickEdit)
	gohelper.setActive(self._goBtnEditNormalMode.gameObject, not self._isShowQuickEdit)
end

function V3a9_BossRush_HeroGroupEditView:_refreshCurScrollBySort()
	if self._isShowQuickEdit then
		if V3a9_BossRush_HeroGroupQuickEditListModel.instance:getIsDirty() then
			self:_saveQuickGroupInfo()
		end

		local originalMO = self._heroMO

		V3a9_BossRush_HeroGroupQuickEditListModel.instance:copyQuickEditCardList()

		if originalMO ~= self._heroMO then
			V3a9_BossRush_HeroGroupQuickEditListModel.instance:cancelAllSelected()
		end
	else
		V3a9_BossRush_HeroGroupEditListModel.instance:copyCharacterCardList()
	end
end

function V3a9_BossRush_HeroGroupEditView:_onGroupModify()
	if self._isShowQuickEdit then
		V3a9_BossRush_HeroGroupQuickEditListModel.instance:copyQuickEditCardList()
	else
		V3a9_BossRush_HeroGroupEditListModel.instance:copyCharacterCardList()
	end
end

function V3a9_BossRush_HeroGroupEditView:_editableInitView()
	gohelper.setActive(self._gospecialitem, false)

	self._careerGOs = {}
	self._imgBg = gohelper.findChildSingleImage(self.viewGO, "bg/bgimg")
	self._simageredlight = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_redlight")

	self._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	self._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))

	self._lvBtns = self:getUserDataTb_()
	self._lvArrow = self:getUserDataTb_()
	self._rareBtns = self:getUserDataTb_()
	self._rareArrow = self:getUserDataTb_()
	self._classifyBtns = self:getUserDataTb_()
	self._maskLayout = gohelper.findChild(self.viewGO, "#go_rolecontainer/mask"):GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))

	for i = 1, 2 do
		self._lvBtns[i] = gohelper.findChild(self._btnlvrank.gameObject, "btn" .. tostring(i))
		self._lvArrow[i] = gohelper.findChild(self._lvBtns[i], "txt/arrow").transform
		self._rareBtns[i] = gohelper.findChild(self._btnrarerank.gameObject, "btn" .. tostring(i))
		self._rareArrow[i] = gohelper.findChild(self._rareBtns[i], "txt/arrow").transform
		self._classifyBtns[i] = gohelper.findChild(self._btnclassify.gameObject, "btn" .. tostring(i))
	end

	self._goBtnEditQuickMode = gohelper.findChild(self._btnquickedit.gameObject, "btn2")
	self._goBtnEditNormalMode = gohelper.findChild(self._btnquickedit.gameObject, "btn1")
	self._attributevalues = {}

	for i = 1, 5 do
		local o = self:getUserDataTb_()

		o.value = gohelper.findChildText(self._goattribute, "attribute" .. tostring(i) .. "/txt_attribute")
		o.name = gohelper.findChildText(self._goattribute, "attribute" .. tostring(i) .. "/name")
		o.icon = gohelper.findChildImage(self._goattribute, "attribute" .. tostring(i) .. "/icon")
		self._attributevalues[i] = o
	end

	self._passiveskillitems = {}

	for i = 1, 3 do
		self._passiveskillitems[i] = self:_findPassiveskillitems(i)
	end

	self._passiveskillitems[0] = self:_findPassiveskillitems(4)
	self._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(self._goskill, CharacterSkillContainer)

	self._skillContainer:setBalanceHelper(HeroGroupBalanceHelper)
	gohelper.setActive(self._gononecharacter, false)
	gohelper.setActive(self._gocharacterinfo, false)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local param = {
		isShowMaxNum = true,
		isOpenTipView = true,
		isPlayAnim = true
	}

	self._bondGroupGrid = MonoHelper.addNoUpdateLuaComOnceToGo(self._gobondsGrid, V3a9_BossRush_ExpandBondsGrid, param)

	local path = self.viewContainer:getSetting().otherRes[2]
	local itemRes = self.viewContainer:getRes(path)
	local tiproot = gohelper.findChild(self.viewGO, "tipRoot")

	self._bondGroupGrid:setItemRes(itemRes, tiproot)
	gohelper.setActive(self._btnassist.gameObject, false)
	gohelper.setActive(self._btnrelease.gameObject, false)
end

function V3a9_BossRush_HeroGroupEditView:_findPassiveskillitems(index)
	local o = self:getUserDataTb_()

	o.go = gohelper.findChild(self._gopassiveskills, "passiveskill" .. index)
	o.on = gohelper.findChild(o.go, "on")
	o.off = gohelper.findChild(o.go, "off")
	o.balance = gohelper.findChild(o.go, "balance")

	return o
end

function V3a9_BossRush_HeroGroupEditView:_onRefreshDestiny()
	self:_refreshExpandBonds()
end

function V3a9_BossRush_HeroGroupEditView:_refreshExpandBonds()
	if not self._bondGroupGrid then
		return
	end

	local list = self:_getEditorList()

	V3a9_BossRushModel.instance:setEditorHeroList(list)
	self._bondGroupGrid:refreshExpandBonds()
end

function V3a9_BossRush_HeroGroupEditView:onOpen()
	self._isShowQuickEdit = true
	self._scrollcard.verticalNormalizedPosition = 1
	self._scrollquickedit.verticalNormalizedPosition = 1
	self._originalHeroUid = self.viewParam.originalHeroUid
	self._singleGroupMOId = self.viewParam.singleGroupMOId
	self._adventure = self.viewParam.adventure
	self._equips = self.viewParam.equips
	self._stage = self.viewParam.stage
	self._actId = self.viewParam.actId
	self._needShowToastRestrict2 = false

	V3a9_BossRushModel.instance:resetEditorHeroList()
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	V3a9_BossRush_HeroGroupEditListModel.instance:setParam(self._actId, self._stage, self._originalHeroUid, self._singleGroupMOId)
	V3a9_BossRush_HeroGroupQuickEditListModel.instance:setParam(self._actId, self._stage)
	V3a9_BossRush_HeroGroupEditListModel.instance:copyCharacterCardList(true)
	V3a9_BossRush_HeroGroupQuickEditListModel.instance:copyQuickEditCardList()

	self._heroMO = V3a9_BossRush_HeroGroupQuickEditListModel.instance:getById(self._originalHeroUid)

	self:_refreshEditMode()
	self:_refreshBtnIcon()
	self:_refreshCharacterInfo()
	self:_showRecommendCareer()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._onRefreshHero, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._onRefreshHero, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._onRefreshHero, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, self._onHeroItemClick, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._refreshCharacterInfo, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.levelUpAttribute, self._onAttributeChanged, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.showCharacterRankUpView, self._showCharacterRankUpView, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, self._markFavorSuccess, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onGroupModify, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onGroupModify, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._refreshCharacterInfo, self)
	self.addEventCb(self, AudioMgr.instance, AudioMgr.Evt_Trigger, self._onAudioTrigger, self)
	self.addEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, self._onRefreshDestiny, self, LuaEventSystem.Low)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, self._onEditorHeroItem, self)
	self.addEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.onClickBondHeroItem, self._onClickBondHeroItem, self)
	gohelper.addUIClickAudio(self._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, self._initScrollContentPosY = transformhelper.getLocalPos(self._goScrollContent.transform)

	self:_refreshAssistBtn()
	self:_refreshExpandBonds()
end

function V3a9_BossRush_HeroGroupEditView:onClose()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._onRefreshHero, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._onRefreshHero, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._onRefreshHero, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, self._onHeroItemClick, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._refreshCharacterInfo, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.levelUpAttribute, self._onAttributeChanged, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.showCharacterRankUpView, self._showCharacterRankUpView, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, self._markFavorSuccess, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onGroupModify, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onGroupModify, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._refreshCharacterInfo, self)
	self.removeEventCb(self, AudioMgr.instance, AudioMgr.Evt_Trigger, self._onAudioTrigger, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
	self.removeEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, self._onRefreshDestiny, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, self._onEditorHeroItem, self)
	self.removeEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.onClickBondHeroItem, self._onClickBondHeroItem, self)
	CharacterModel.instance:setFakeLevel()
	V3a9_BossRush_HeroGroupEditListModel.instance:cancelAllSelected()
	V3a9_BossRush_HeroGroupEditListModel.instance:clear()
	V3a9_BossRush_HeroGroupQuickEditListModel.instance:cancelAllSelected()
	V3a9_BossRush_HeroGroupQuickEditListModel.instance:clear()
	HeroGroupTrialModel.instance:setFilter()
	CommonHeroHelper.instance:resetGrayState()
	CharacterController.instance:closeCharacterFilterView()
	CharacterSearchFilterModel.instance:exitParentView()
	V3a9_BossRushExpandBondModel.instance:refreshExpandBondGroup(self._stage)

	local stageMo = V3a9_BossRushModel.instance:getStageMo(self._actId, self._stage)

	V3a9_BossRushExpandBondModel.instance:setStageEditorAddBondGroupId(stageMo)

	if self._skillContainer then
		self._skillContainer:onClose()
	end

	V3a9_BossRushController.instance:closeExpandBondsTipView()
end

function V3a9_BossRush_HeroGroupEditView:_onRefreshHero()
	self:_updateHeroList()
	self:_refreshCharacterInfo()
end

function V3a9_BossRush_HeroGroupEditView:_onAudioTrigger(audioId)
	return
end

function V3a9_BossRush_HeroGroupEditView:_onOpenView(viewName)
	return
end

function V3a9_BossRush_HeroGroupEditView:_markFavorSuccess()
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function V3a9_BossRush_HeroGroupEditView:_showRecommendCareer()
	local recommended, counter = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, self._goattrlist, self._goattritem)

	self._txtrecommendAttrDesc.text = #recommended == 0 and luaLang("herogroupeditview_notrecommend") or luaLang("herogroupeditview_recommend")

	gohelper.setActive(self._goattrlist, #recommended ~= 0)
end

function V3a9_BossRush_HeroGroupEditView:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function V3a9_BossRush_HeroGroupEditView:_onCloseView(viewName)
	return
end

function V3a9_BossRush_HeroGroupEditView:_showCharacterRankUpView(func)
	func()
end

function V3a9_BossRush_HeroGroupEditView:_onFilterList(param)
	local dmgs, careers = param.dmgs1, param.careers2

	HeroGroupTrialModel.instance:setFilter(dmgs, careers)
	self:_refreshBtnIcon()
	self:_refreshCurScrollBySort()
	ViewMgr.instance:closeView(ViewName.CharacterLevelUpView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function V3a9_BossRush_HeroGroupEditView:_refreshAssistBtn()
	local assistMo = V3a9_BossRushModel.instance:getEditorAssistMo()

	gohelper.setActive(self._btnassist.gameObject, assistMo == nil)
	gohelper.setActive(self._btnrelease.gameObject, assistMo ~= nil)
end

function V3a9_BossRush_HeroGroupEditView:_onClickBondHeroItem(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if not heroMo then
		return
	end

	local heroMoList = self._isShowQuickEdit and V3a9_BossRush_HeroGroupQuickEditListModel.instance:getList() or V3a9_BossRush_HeroGroupEditListModel.instance:getList()
	local index

	if heroMoList then
		for i, mo in ipairs(heroMoList) do
			if mo.heroId == heroId then
				index = i

				break
			end
		end

		if index then
			local column = math.ceil(index / 5)
			local totalColumn = math.ceil(#heroMoList / 5)
			local vnp = 1 - (column - 1) / (totalColumn - 1)

			if self._isShowQuickEdit then
				local cur = self._scrollquickedit.verticalNormalizedPosition

				if cur ~= vnp then
					self._quickTweenId = ZProj.TweenHelper.DOTweenFloat(cur, vnp, 0.4, self._quickFrameCallback, nil, self, nil, EaseType.Linear)
				end
			else
				local cur = self._scrollcard.verticalNormalizedPosition

				if cur ~= vnp then
					self._cardTweenId = ZProj.TweenHelper.DOTweenFloat(cur, vnp, 0.4, self._normalFrameCallback, nil, self, nil, EaseType.Linear)
				end
			end
		end
	end
end

function V3a9_BossRush_HeroGroupEditView:_quickFrameCallback(value)
	self._scrollquickedit.verticalNormalizedPosition = value
end

function V3a9_BossRush_HeroGroupEditView:_normalFrameCallback(value)
	self._scrollcard.verticalNormalizedPosition = value
end

function V3a9_BossRush_HeroGroupEditView:onDestroyView()
	self._imgBg:UnLoadImage()
	self._simageredlight:UnLoadImage()

	self._imgBg = nil
	self._simageredlight = nil

	if self._cardTweenId then
		ZProj.TweenHelper.KillById(self._cardTweenId)
	end

	if self._quickTweenId then
		ZProj.TweenHelper.KillById(self._quickTweenId)
	end
end

return V3a9_BossRush_HeroGroupEditView
