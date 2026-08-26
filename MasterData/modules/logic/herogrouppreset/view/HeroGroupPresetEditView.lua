-- chunkname: @modules/logic/herogrouppreset/view/HeroGroupPresetEditView.lua

module("modules.logic.herogrouppreset.view.HeroGroupPresetEditView", package.seeall)

local HeroGroupPresetEditView = class("HeroGroupPresetEditView", BaseView)

function HeroGroupPresetEditView:onInitView()
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
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/#scroll_card")
	self._goScrollContent = gohelper.findChild(self.viewGO, "#go_rolecontainer/#scroll_card/scrollcontent")
	self._scrollquickedit = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/#scroll_quickedit")
	self._gorolesort = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort")
	self._btnlvrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	self._btnexskillrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	self._btnclassify = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	self._btnquickedit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_quickedit")
	self._goexarrow = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_cancel")
	self._txtrecommendAttrDesc = gohelper.findChildText(self.viewGO, "#go_recommendAttr/bg/#txt_desc")
	self._goattrlist = gohelper.findChild(self.viewGO, "#go_recommendAttr/bg/#go_attrlist")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_recommendAttr/bg/#go_attrlist/#go_attritem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupPresetEditView:addEvents()
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
end

function HeroGroupPresetEditView:removeEvents()
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
end

function HeroGroupPresetEditView:_btnclassifyOnClick()
	local param = {
		filterType = CharacterEnum.FilterType.HeroGroup
	}

	CharacterController.instance:openCharacterFilterView(param)
end

function HeroGroupPresetEditView:_btnpassiveskillOnClick()
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
	info.isBalance = HeroGroupBalanceHelper.getIsBalanceMode() and not self._heroMO:isTrial()

	CharacterController.instance:openCharacterTipView(info)
end

function HeroGroupPresetEditView:_btnconfirmOnClick()
	if self._isShowQuickEdit then
		local newHeroUids = self._heroGroupQuickEditListModel:getHeroUids()

		if newHeroUids and #newHeroUids > 0 then
			if self._adventure then
				for k, heroUid in pairs(newHeroUids) do
					local mo = HeroModel.instance:getById(heroUid)

					if mo then
						local cd = WeekWalkModel.instance:getCurMapHeroCd(mo.heroId)

						if cd > 0 then
							GameFacade.showToast(ToastEnum.HeroGroupEdit)

							return
						end
					end
				end
			elseif self._isWeekWalk_2 then
				for k, heroUid in pairs(newHeroUids) do
					local mo = HeroModel.instance:getById(heroUid)

					if mo then
						local cd = WeekWalk_2Model.instance:getCurMapHeroCd(mo.heroId)

						if cd > 0 then
							GameFacade.showToast(ToastEnum.HeroGroupEdit)

							return
						end
					end
				end
			elseif self._isTowerBattle then
				for k, heroUid in pairs(newHeroUids) do
					local mo = HeroModel.instance:getById(heroUid)

					if mo and TowerModel.instance:isHeroBan(mo.heroId) then
						GameFacade.showToast(ToastEnum.TowerHeroGroupEdit)

						return
					end
				end
			elseif self._isAbyss then
				for k, heroUid in pairs(newHeroUids) do
					local mo = HeroModel.instance:getById(heroUid)

					if mo and AbyssModel.instance:isCurHeroLocked(mo.heroId) then
						GameFacade.showToast(ToastEnum.AbyssHeroGroupEdit)

						return
					end
				end
			end
		end

		self:_saveQuickGroupInfo()
		self:closeThis()

		return
	end

	if not self:_normalEditHasChange() then
		self:closeThis()

		return
	end

	local singleGroupMO = self._heroSingleGroupModel:getById(self._singleGroupMOId)

	if singleGroupMO.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if self._heroMO then
		if self._adventure then
			local cd = WeekWalkModel.instance:getCurMapHeroCd(self._heroMO.heroId)

			if cd > 0 then
				GameFacade.showToast(ToastEnum.HeroGroupEdit)

				return
			end
		elseif self._isWeekWalk_2 then
			local cd = WeekWalk_2Model.instance:getCurMapHeroCd(self._heroMO.heroId)

			if cd > 0 then
				GameFacade.showToast(ToastEnum.HeroGroupEdit)

				return
			end
		elseif self._isTowerBattle then
			if TowerModel.instance:isHeroBan(self._heroMO.heroId) then
				GameFacade.showToast(ToastEnum.TowerHeroGroupEdit)

				return
			end
		elseif self._isAbyss and AbyssModel.instance:isCurHeroLocked(self._heroMO.heroId) then
			GameFacade.showToast(ToastEnum.AbyssHeroGroupEdit)

			return
		end

		if self._heroMO.isPosLock then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		end

		if self._heroMO:isTrial() and not self._heroSingleGroupModel:isInGroup(self._heroMO.uid) and (singleGroupMO:isEmpty() or not singleGroupMO.trial) and self._heroGroupEditListModel:isTrialLimit() then
			GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

			return
		end

		local hasHero, hasHeroIndex = self._heroSingleGroupModel:hasHeroUids(self._heroMO.uid, self._singleGroupMOId)

		if hasHero then
			self._heroSingleGroupModel:removeFrom(hasHeroIndex)
			self._heroSingleGroupModel:addTo(self._heroMO.uid, self._singleGroupMOId)

			if self._heroMO:isTrial() then
				singleGroupMO:setTrial(self._heroMO.trialCo.id, self._heroMO.trialCo.trialTemplate)
			else
				singleGroupMO:setTrial()
			end

			self:_saveCurGroupInfo()
			self:closeThis()

			return
		end

		if self._heroSingleGroupModel:isAidConflict(self._heroMO.heroId) then
			GameFacade.showToast(ToastEnum.HeroIsAidConflict)

			return
		end

		self._heroSingleGroupModel:addTo(self._heroMO.uid, self._singleGroupMOId)

		if self._heroMO:isTrial() then
			singleGroupMO:setTrial(self._heroMO.trialCo.id, self._heroMO.trialCo.trialTemplate)
		else
			singleGroupMO:setTrial()
		end

		self:_saveCurGroupInfo()
		self:closeThis()
	else
		self._heroSingleGroupModel:removeFrom(self._singleGroupMOId)
		self:_saveCurGroupInfo()
		self:closeThis()
	end
end

function HeroGroupPresetEditView:checkTrialNum()
	return false
end

function HeroGroupPresetEditView:_btncancelOnClick()
	self:closeThis()
end

function HeroGroupPresetEditView:_btncharacterOnClick()
	if self._heroMO then
		local heroMoList = self._isShowQuickEdit and self._heroGroupQuickEditListModel:getList() or self._heroGroupEditListModel:getList()
		local newList = {}

		for k, heroMo in ipairs(heroMoList) do
			if not heroMo:isTrial() then
				table.insert(newList, heroMo)
			end
		end

		CharacterController.instance:openCharacterView(self._heroMO, newList)
	end
end

function HeroGroupPresetEditView:_btntrialOnClick()
	if self._heroMO then
		local heroMoList = self._isShowQuickEdit and self._heroGroupQuickEditListModel:getList() or self._heroGroupEditListModel:getList()
		local newList = {}

		for k, heroMo in ipairs(heroMoList) do
			if heroMo:isTrial() then
				table.insert(newList, heroMo)
			end
		end

		CharacterController.instance:openCharacterView(self._heroMO, newList)
	end
end

function HeroGroupPresetEditView:_btnattributeOnClick()
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
		info.isBalance = HeroGroupBalanceHelper.getIsBalanceMode() and not self._heroMO:isTrial()

		CharacterController.instance:openCharacterTipView(info)
	end
end

function HeroGroupPresetEditView:_btnexskillrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshBtnIcon()
	self:_refreshCurScrollBySort()
end

function HeroGroupPresetEditView:_btnlvrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshBtnIcon()
	self:_refreshCurScrollBySort()
end

function HeroGroupPresetEditView:_btnrarerankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshBtnIcon()
	self:_refreshCurScrollBySort()
end

function HeroGroupPresetEditView:_btnquickeditOnClick()
	self._isShowQuickEdit = not self._isShowQuickEdit

	self:_refreshBtnIcon()
	self:_refreshEditMode()

	if self._isShowQuickEdit then
		self:_onHeroItemClick(nil)
		self._heroGroupQuickEditListModel:cancelAllSelected()
		self._heroGroupQuickEditListModel:copyQuickEditCardList()

		local mo = self._heroGroupQuickEditListModel:getById(self._originalHeroUid)

		if mo then
			local index = self._heroGroupQuickEditListModel:getIndex(mo)

			self._heroGroupQuickEditListModel:selectCell(index, true)
		end
	else
		self._heroGroupQuickEditListModel:cancelAllErrorSelected()
		self:_saveQuickGroupInfo()
		self:_onHeroItemClick(nil)
		self._heroGroupEditListModel:cancelAllSelected()

		local curHeroUid = self._heroSingleGroupModel:getHeroUid(self._singleGroupMOId)

		if curHeroUid ~= "0" then
			local mo = self._heroGroupEditListModel:getById(curHeroUid)
			local index = self._heroGroupEditListModel:getIndex(mo)

			self._heroGroupEditListModel:selectCell(index, true)
		end

		self._heroGroupEditListModel:copyCharacterCardList()
	end
end

function HeroGroupPresetEditView:_onHeroItemClick(heroMO)
	self._heroMO = heroMO

	self:_refreshCharacterInfo()
end

function HeroGroupPresetEditView:_refreshCharacterInfo()
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

function HeroGroupPresetEditView:_refreshMainInfo()
	if self._heroMO then
		gohelper.setActive(self._btntrial.gameObject, self._heroMO:isTrial())
		gohelper.setActive(self._btntrialWithTalent.gameObject, self._heroMO:isTrial())
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

		if not self._heroMO:isTrial() then
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

		if not string.nilorempty(self._heroMO.config.battleTag) then
			tags = string.split(self._heroMO.config.battleTag, "#")
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

function HeroGroupPresetEditView:_refreshAttribute()
	if self._heroMO then
		local mo = HeroGroupTrialModel.instance:getById(self._originalHeroUid)
		local trialEquipMo
		local var_19_0

		if mo then
			trialEquipMo = mo.trialEquipMo
			var_19_0 = HeroGroupBalanceHelper.getIsBalanceMode() and not self._heroMO:isTrial()
		end

		local attrDict = self._heroMO:getTotalBaseAttrDict(self._equips, nil, nil, var_19_0, trialEquipMo)

		for index, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
			local co = HeroConfig.instance:getHeroAttributeCO(attrId)

			self._attributevalues[index].name.text = co.name
			self._attributevalues[index].value.text = attrDict[attrId]

			CharacterController.instance:SetAttriIcon(self._attributevalues[index].icon, attrId)
		end
	end
end

function HeroGroupPresetEditView:_refreshPassiveSkill()
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

	if not self._heroMO:isTrial() then
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

function HeroGroupPresetEditView:_refreshSkill()
	local var_21_0 = self._heroMO
	local var_21_1

	if self._heroMO then
		var_21_0 = self._heroMO.heroId
		var_21_1 = HeroGroupBalanceHelper.getIsBalanceMode() and not self._heroMO:isTrial()
	end

	self._skillContainer:onUpdateMO(var_21_0, nil, self._heroMO, var_21_1, CharacterEnum.DeviceViewType.HeroGroupEditView)
end

function HeroGroupPresetEditView:_refreshBtnIcon()
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

function HeroGroupPresetEditView:_updateHeroList()
	self:_refreshBtnIcon()

	if self._isShowQuickEdit then
		self._heroGroupQuickEditListModel:copyQuickEditCardList()
	else
		self._heroGroupEditListModel:copyCharacterCardList()
	end
end

function HeroGroupPresetEditView:replaceSelectHeroDefaultEquip()
	if self._heroMO and self._heroMO:hasDefaultEquip() then
		local heroGroupMo = self._heroGroupModel:getCurGroupMO()
		local heroGroupEquipMoList = heroGroupMo.equips

		for i, heroGroupEquipMo in pairs(heroGroupEquipMoList) do
			if heroGroupEquipMo.equipUid[1] == self._heroMO.defaultEquipUid then
				heroGroupEquipMo.equipUid[1] = "0"

				break
			end
		end

		heroGroupEquipMoList[self._singleGroupMOId - 1].equipUid[1] = self._heroMO.defaultEquipUid
	end
end

function HeroGroupPresetEditView:replaceQuickGroupHeroDefaultEquip(heroUids)
	local heroGroupMo = self._heroGroupModel:getCurGroupMO()
	local heroGroupEquipMoList = heroGroupMo.equips
	local heroMo

	for index, heroUid in ipairs(heroUids) do
		heroMo = HeroModel.instance:getById(heroUid)

		if heroMo and heroMo:hasDefaultEquip() then
			for _, heroGroupEquipMo in pairs(heroGroupEquipMoList) do
				if heroGroupEquipMo.equipUid[1] == heroMo.defaultEquipUid then
					heroGroupEquipMo.equipUid[1] = "0"

					break
				end
			end

			heroGroupEquipMoList[index - 1].equipUid[1] = heroMo.defaultEquipUid
		end
	end
end

function HeroGroupPresetEditView:_saveCurGroupInfo()
	local newHeroUids = self._heroSingleGroupModel:getHeroUids()
	local heroGroupMO = self._heroGroupModel:getCurGroupMO()

	self:replaceSelectHeroDefaultEquip()
	self._heroGroupModel:replaceSingleGroup()
	HeroGroupPresetController.instance:updateFightHeroGroup()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	self._heroGroupModel:saveCurGroupData()
end

function HeroGroupPresetEditView:_saveQuickGroupInfo()
	if self._heroGroupQuickEditListModel:getIsDirty() then
		local newHeroUids = self._heroGroupQuickEditListModel:getHeroUids()
		local heroGroupMO = self._heroGroupModel:getCurGroupMO()

		self:replaceQuickGroupHeroDefaultEquip(newHeroUids)

		for i = 1, self._heroGroupModel:getBattleRoleNum() do
			local heroUid = newHeroUids[i]

			if heroUid ~= nil then
				self._heroSingleGroupModel:addTo(heroUid, i)

				local singleGroupMO = self._heroSingleGroupModel:getByIndex(i)

				if tonumber(heroUid) < 0 then
					local heroMO = HeroGroupTrialModel.instance:getById(heroUid)

					if heroMO then
						singleGroupMO:setTrial(heroMO.trialCo.id, heroMO.trialCo.trialTemplate)
					else
						singleGroupMO:setTrial()
					end
				else
					singleGroupMO:setTrial()
				end
			end
		end

		self._heroGroupModel:replaceSingleGroup()
		self._heroGroupModel:replaceSingleGroupEquips()
		HeroGroupPresetController.instance:updateFightHeroGroup()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		self._heroGroupModel:saveCurGroupData()
	end
end

function HeroGroupPresetEditView:_onAttributeChanged(level, heroId)
	CharacterModel.instance:setFakeLevel(heroId, level)
end

function HeroGroupPresetEditView:_normalEditHasChange()
	if Activity104Model.instance:isSeasonChapter() then
		return true
	end

	if self._heroSingleGroupModel:getHeroUid(self._singleGroupMOId) ~= self._originalHeroUid then
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

function HeroGroupPresetEditView:_refreshEditMode()
	gohelper.setActive(self._scrollquickedit.gameObject, self._isShowQuickEdit)
	gohelper.setActive(self._scrollcard.gameObject, not self._isShowQuickEdit)
	gohelper.setActive(self._goBtnEditQuickMode.gameObject, self._isShowQuickEdit)
	gohelper.setActive(self._goBtnEditNormalMode.gameObject, not self._isShowQuickEdit)
end

function HeroGroupPresetEditView:_refreshCurScrollBySort()
	if self._isShowQuickEdit then
		if self._heroGroupQuickEditListModel:getIsDirty() then
			self:_saveQuickGroupInfo()
		end

		local originalMO = self._heroMO

		self._heroGroupQuickEditListModel:copyQuickEditCardList()

		if originalMO ~= self._heroMO then
			self._heroGroupQuickEditListModel:cancelAllSelected()
		end
	else
		self._heroGroupEditListModel:copyCharacterCardList()
	end
end

function HeroGroupPresetEditView:_onGroupModify()
	if self._isShowQuickEdit then
		self._heroGroupQuickEditListModel:copyQuickEditCardList()
	else
		local heroUid = self._heroSingleGroupModel:getHeroUid(self._singleGroupMOId)

		if self._originalHeroUid ~= heroUid then
			self._originalHeroUid = heroUid

			self._heroGroupEditListModel:setParam(heroUid, self._adventure)
			self:_onHeroItemClick(nil)
			self._heroGroupEditListModel:cancelAllSelected()

			local mo = self._heroGroupEditListModel:getById(heroUid)
			local index = self._heroGroupEditListModel:getIndex(mo)

			self._heroGroupEditListModel:selectCell(index, true)
		end

		self._heroGroupEditListModel:copyCharacterCardList()
	end
end

function HeroGroupPresetEditView:_editableInitView()
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
end

function HeroGroupPresetEditView:_findPassiveskillitems(index)
	local o = self:getUserDataTb_()

	o.go = gohelper.findChild(self._gopassiveskills, "passiveskill" .. index)
	o.on = gohelper.findChild(o.go, "on")
	o.off = gohelper.findChild(o.go, "off")
	o.balance = gohelper.findChild(o.go, "balance")

	return o
end

function HeroGroupPresetEditView:_getGroupType()
	local episodeId = self._heroGroupModel.episodeId
	local episodeCO = episodeId and lua_episode.configDict[episodeId]
	local episodeType = episodeCO and episodeCO.type

	if episodeType == DungeonEnum.EpisodeType.WeekWalk_2 then
		return HeroGroupEnum.GroupType.WeekWalk_2
	elseif episodeType == DungeonEnum.EpisodeType.Abyss then
		return HeroGroupEnum.GroupType.Abyss
	end
end

function HeroGroupPresetEditView:onOpen()
	self._heroGroupEditListModel = HeroGroupPresetEditListModel.instance
	self._heroGroupQuickEditListModel = HeroGroupPresetQuickEditListModel.instance
	self._heroSingleGroupModel = HeroGroupPresetSingleGroupModel.instance
	self._heroGroupModel = HeroGroupPresetModel.instance
	self._isShowQuickEdit = false
	self._scrollcard.verticalNormalizedPosition = 1
	self._scrollquickedit.verticalNormalizedPosition = 1
	self._originalHeroUid = self.viewParam.originalHeroUid
	self._singleGroupMOId = self.viewParam.singleGroupMOId
	self._adventure = self.viewParam.adventure
	self._equips = self.viewParam.equips
	self._isTowerBattle = TowerModel.instance:isInTowerBattle()
	self._groupType = self:_getGroupType()
	self._isWeekWalk_2 = self._groupType == HeroGroupEnum.GroupType.WeekWalk_2
	self._isAbyss = self._groupType == HeroGroupEnum.GroupType.Abyss

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	self._heroGroupEditListModel:setParam(self._originalHeroUid, self._adventure, self._isTowerBattle, self._groupType)
	self._heroGroupQuickEditListModel:setParam(self._adventure, self._isTowerBattle, self._groupType)

	self._heroMO = self._heroGroupEditListModel:copyCharacterCardList(true)

	self:_refreshEditMode()
	self:_refreshBtnIcon()
	self:_refreshCharacterInfo()

	self._txtrecommendAttrDesc.text = self.viewParam.heroGroupName

	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, self._onHeroItemClick, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._refreshCharacterInfo, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._refreshCharacterInfo, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshCharacterInfo, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._refreshCharacterInfo, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshCharacterInfo, self)
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
	gohelper.addUIClickAudio(self._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, self._initScrollContentPosY = transformhelper.getLocalPos(self._goScrollContent.transform)

	if self.viewParam.onlyQuickEdit then
		self:_btnquickeditOnClick()

		self._btnquickedit.button.interactable = false
	end
end

function HeroGroupPresetEditView:onClose()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._updateHeroList, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, self._onHeroItemClick, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._refreshCharacterInfo, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._refreshCharacterInfo, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshCharacterInfo, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._refreshCharacterInfo, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshCharacterInfo, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.levelUpAttribute, self._onAttributeChanged, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.showCharacterRankUpView, self._showCharacterRankUpView, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, self._markFavorSuccess, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onGroupModify, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onGroupModify, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._refreshCharacterInfo, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
	self.removeEventCb(self, AudioMgr.instance, AudioMgr.Evt_Trigger, self._onAudioTrigger, self)
	CharacterModel.instance:setFakeLevel()
	self._heroGroupEditListModel:cancelAllSelected()
	self._heroGroupEditListModel:clear()
	self._heroGroupQuickEditListModel:cancelAllSelected()
	self._heroGroupQuickEditListModel:clear()
	HeroGroupTrialModel.instance:setFilter()
	CommonHeroHelper.instance:resetGrayState()
	CharacterController.instance:closeCharacterFilterView()
	CharacterSearchFilterModel.instance:exitParentView()

	if self._skillContainer then
		self._skillContainer:onClose()
	end
end

function HeroGroupPresetEditView:_onAudioTrigger(audioId)
	return
end

function HeroGroupPresetEditView:_onOpenView(viewName)
	return
end

function HeroGroupPresetEditView:_markFavorSuccess()
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function HeroGroupPresetEditView:_showRecommendCareer()
	local recommended, counter = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, self._goattrlist, self._goattritem)

	self._txtrecommendAttrDesc.text = #recommended == 0 and luaLang("herogroupeditview_notrecommend") or luaLang("herogroupeditview_recommend")

	gohelper.setActive(self._goattrlist, #recommended ~= 0)
end

function HeroGroupPresetEditView:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function HeroGroupPresetEditView:_onFilterList(param)
	local dmgs, careers = param.dmgs1, param.careers2

	HeroGroupTrialModel.instance:setFilter(dmgs, careers)
	self:_refreshBtnIcon()
	self:_refreshCurScrollBySort()
	ViewMgr.instance:closeView(ViewName.CharacterLevelUpView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function HeroGroupPresetEditView:_onCloseView(viewName)
	return
end

function HeroGroupPresetEditView:_showCharacterRankUpView(func)
	func()
end

function HeroGroupPresetEditView:onDestroyView()
	self._imgBg:UnLoadImage()
	self._simageredlight:UnLoadImage()

	self._imgBg = nil
	self._simageredlight = nil
end

return HeroGroupPresetEditView
