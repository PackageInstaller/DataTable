-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotHeroGroupEditView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupEditView", package.seeall)

local V1a6_CachotHeroGroupEditView = class("V1a6_CachotHeroGroupEditView", BaseView)

function V1a6_CachotHeroGroupEditView:onInitView()
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
	self._goseatlevel = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_level")
	self._seatIcon = gohelper.findChildImage(self.viewGO, "#go_rolecontainer/#go_level/bg/#txt_title/icon")
	self._seatEffect = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_level/bg/#txt_title/quality_effect")
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_level/bg/#txt_title/#btn_tips")
	self._goempty = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_empty")
	self._gosearchfilter = gohelper.findChild(self.viewGO, "#go_searchfilter")
	self._btnclosefilterview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/#btn_closefilterview")
	self._godmgitem = gohelper.findChild(self.viewGO, "#go_searchfilter/container/dmgContainer/#go_dmgitem")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_searchfilter/container/attrContainer/#go_attritem")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/#btn_reset")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/#btn_ok")
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

function V1a6_CachotHeroGroupEditView:addEvents()
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
	self._btnclosefilterview:AddClickListener(self._btncloseFilterViewOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
end

function V1a6_CachotHeroGroupEditView:removeEvents()
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
	self._btnclosefilterview:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnok:RemoveClickListener()
	self._btntips:RemoveClickListener()
end

function V1a6_CachotHeroGroupEditView:_btntipsOnClick()
	HelpController.instance:showHelp(HelpEnum.HelpId.Cachot1_6HeroGroupHelp)
end

function V1a6_CachotHeroGroupEditView:_btncloseFilterViewOnClick()
	self._selectDmgs = LuaUtil.deepCopy(self._curDmgs)
	self._selectAttrs = LuaUtil.deepCopy(self._curAttrs)
	self._selectLocations = LuaUtil.deepCopy(self._curLocations)

	self:_refreshBtnIcon()
	gohelper.setActive(self._gosearchfilter, false)
end

function V1a6_CachotHeroGroupEditView:_btnclassifyOnClick()
	gohelper.setActive(self._gosearchfilter, true)
	self:_refreshFilterView()
end

function V1a6_CachotHeroGroupEditView:_btnresetOnClick()
	for i = 1, 2 do
		self._selectDmgs[i] = false
	end

	for i = 1, 6 do
		self._selectAttrs[i] = false
	end

	for i = 1, 6 do
		self._selectLocations[i] = false
	end

	self:_refreshBtnIcon()
	self:_refreshFilterView()
end

function V1a6_CachotHeroGroupEditView:_btnokOnClick()
	gohelper.setActive(self._gosearchfilter, false)

	local dmgs = {}

	for i = 1, 2 do
		if self._selectDmgs[i] then
			table.insert(dmgs, i)
		end
	end

	local careers = {}

	for i = 1, 6 do
		if self._selectAttrs[i] then
			table.insert(careers, i)
		end
	end

	local locations = {}

	for i = 1, 6 do
		if self._selectLocations[i] then
			table.insert(locations, i)
		end
	end

	if #dmgs == 0 then
		dmgs = {
			1,
			2
		}
	end

	if #careers == 0 then
		careers = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #locations == 0 then
		locations = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)

	local filterParam = {}

	filterParam.dmgs = dmgs
	filterParam.careers = careers
	filterParam.locations = locations

	CharacterModel.instance:filterCardListByDmgAndCareer(filterParam, false, CharacterEnum.FilterType.HeroGroup)
	HeroGroupTrialModel.instance:setFilter(dmgs, careers)

	self._curDmgs = LuaUtil.deepCopy(self._selectDmgs)
	self._curAttrs = LuaUtil.deepCopy(self._selectAttrs)
	self._curLocations = LuaUtil.deepCopy(self._selectLocations)

	self:_refreshBtnIcon()
	self:_refreshCurScrollBySort()
	ViewMgr.instance:closeView(ViewName.CharacterLevelUpView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function V1a6_CachotHeroGroupEditView:_btnpassiveskillOnClick()
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

	self:_addCachotProp(info)
	CharacterController.instance:openCharacterTipView(info)
end

function V1a6_CachotHeroGroupEditView:_addCachotProp(info)
	local level, talentLevel = V1a6_CachotTeamModel.instance:getHeroMaxLevel(self._heroMO, self._seatLevel)
	local showLevel, rank = HeroConfig.instance:getShowLevel(level)

	info.level = level
	info.rank = rank
	info.passiveSkillLevel = {}
	info.seatLevel = self._seatLevel

	for i = 1, rank - 1 do
		table.insert(info.passiveSkillLevel, i)
	end

	local controller = V1a6_CachotHeroGroupController.instance

	info.setEquipInfo = {
		controller.getCharacterTipEquipInfo,
		controller,
		{
			isCachot = true,
			seatLevel = self._seatLevel
		}
	}
	info.talentCubeInfos = self._talentCubeInfos
end

function V1a6_CachotHeroGroupEditView:_btnconfirmOnClick()
	if self._adventure then
		local newHeroUids = self._heroGroupQuickEditListModel:getHeroUids()

		if newHeroUids and #newHeroUids > 0 then
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
		elseif self._heroMO then
			local cd = WeekWalkModel.instance:getCurMapHeroCd(self._heroMO.heroId)

			if cd > 0 then
				GameFacade.showToast(ToastEnum.HeroGroupEdit)

				return
			end
		end
	end

	if self._isShowQuickEdit then
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
		if self._heroMO.isPosLock then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		end

		if self._heroMO:isTrial() and not self._heroSingleGroupModel:isInGroup(self._heroMO.uid) and (singleGroupMO:isEmpty() or not singleGroupMO.trial) and self._heroGroupEditListModel:isTrialLimit() then
			GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

			return
		end

		if self.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Fight then
			local teamInfo = V1a6_CachotModel.instance:getTeamInfo()
			local hpInfo = teamInfo:getHeroHp(self._heroMO.heroId)

			if hpInfo then
				if not hpInfo.life then
					local hpValue = 0

					if hpValue <= 0 then
						GameFacade.showToast(ToastEnum.V1a6CachotToast04)

						return
					end
				end
			end
		end

		local hasHero, hasHeroIndex = self._heroSingleGroupModel:hasHeroUids(self._heroMO.uid, self._singleGroupMOId)

		if hasHero then
			if self.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event then
				GameFacade.showToast(ToastEnum.V1a6CachotToast03)

				return
			end

			self._heroSingleGroupModel:removeFrom(hasHeroIndex)
			self._heroSingleGroupModel:addTo(self._heroMO.uid, self._singleGroupMOId)

			if self._heroMO:isTrial() then
				singleGroupMO:setTrial(self._heroMO.trialCo.id, self._heroMO.trialCo.trialTemplate)
			else
				singleGroupMO:setTrial()
			end

			FightAudioMgr.instance:playHeroVoiceRandom(self._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
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

		FightAudioMgr.instance:playHeroVoiceRandom(self._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
		self:_saveCurGroupInfo()
		self:closeThis()
	else
		if self.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event then
			self.viewContainer:_overrideClose()

			return
		end

		self._heroSingleGroupModel:removeFrom(self._singleGroupMOId)
		self:_saveCurGroupInfo()
		self:closeThis()
	end
end

function V1a6_CachotHeroGroupEditView:checkTrialNum()
	return false
end

function V1a6_CachotHeroGroupEditView:_btncancelOnClick()
	if self.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event then
		self.viewContainer:_overrideClose()

		return
	end

	self:closeThis()
end

function V1a6_CachotHeroGroupEditView:_btncharacterOnClick()
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

function V1a6_CachotHeroGroupEditView:_btntrialOnClick()
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

function V1a6_CachotHeroGroupEditView:_btnattributeOnClick()
	if self._heroMO then
		local info = {}

		info.tag = "attribute"
		info.heroid = self._heroMO.heroId
		info.equips = self._equips
		info.showExtraAttr = true
		info.fromHeroGroupEditView = true
		info.heroMo = self._heroMO
		info.isBalance = HeroGroupBalanceHelper.getIsBalanceMode() and not self._heroMO:isTrial()

		self:_addCachotProp(info)
		CharacterController.instance:openCharacterTipView(info)
	end
end

function V1a6_CachotHeroGroupEditView:_btnexskillrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshCurScrollBySort()
	self:_refreshBtnIcon()
end

function V1a6_CachotHeroGroupEditView:_btnlvrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshCurScrollBySort()
	self:_refreshBtnIcon()
end

function V1a6_CachotHeroGroupEditView:_btnrarerankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshCurScrollBySort()
	self:_refreshBtnIcon()
end

function V1a6_CachotHeroGroupEditView:_btnquickeditOnClick()
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

function V1a6_CachotHeroGroupEditView:_attrBtnOnClick(i)
	self._selectAttrs[i] = not self._selectAttrs[i]

	self:_refreshFilterView()
end

function V1a6_CachotHeroGroupEditView:_dmgBtnOnClick(i)
	if not self._selectDmgs[i] then
		self._selectDmgs[3 - i] = self._selectDmgs[i]
	end

	self._selectDmgs[i] = not self._selectDmgs[i]

	self:_refreshFilterView()
end

function V1a6_CachotHeroGroupEditView:_locationBtnOnClick(i)
	self._selectLocations[i] = not self._selectLocations[i]

	self:_refreshFilterView()
end

function V1a6_CachotHeroGroupEditView:_onHeroItemClick(heroMO)
	self._heroMO = heroMO

	self:_refreshCharacterInfo()
end

function V1a6_CachotHeroGroupEditView:_refreshCharacterInfo()
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

function V1a6_CachotHeroGroupEditView:_refreshMainInfo()
	if self._heroMO then
		gohelper.setActive(self._btntrial.gameObject, self._heroMO:isTrial())
		gohelper.setActive(self._btntrialWithTalent.gameObject, self._heroMO:isTrial())
		UISpriteSetMgr.instance:setCommonSprite(self._imagecareericon, "sx_biandui_" .. tostring(self._heroMO.config.career))
		UISpriteSetMgr.instance:setCommonSprite(self._imagedmgtype, "dmgtype" .. tostring(self._heroMO.config.dmgType))

		self._txtname.text = self._heroMO.config.name
		self._txtnameen.text = self._heroMO.config.nameEng

		local level, talentLevel = V1a6_CachotTeamModel.instance:getHeroMaxLevel(self._heroMO, self._seatLevel)
		local showLevel, rank = HeroConfig.instance:getShowLevel(level)
		local isShowTalent = rank >= CharacterEnum.TalentRank

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
				local level, talentLevel = V1a6_CachotTeamModel.instance:getHeroMaxLevel(self._heroMO, self._seatLevel)
				local showLevel, rank = HeroConfig.instance:getShowLevel(level)
				local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, rank)[1]
				local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

				self._txtlevelWithTalent.text = tostring(showLevel)
				self._txtlevelmaxWithTalent.text = string.format("/%d", showMaxLevel)
			end

			if isBalanceTalent then
				self._txttalent.text = "<color=#8fb1cc>Lv.<size=40>" .. tostring(balanceTalent)
			else
				local level, talentLevel = V1a6_CachotTeamModel.instance:getHeroMaxLevel(self._heroMO, self._seatLevel)

				self._txttalent.text = "Lv.<size=40>" .. tostring(talentLevel)
			end
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
				local level, talentLevel = V1a6_CachotTeamModel.instance:getHeroMaxLevel(self._heroMO, self._seatLevel)
				local showLevel, rank = HeroConfig.instance:getShowLevel(level)
				local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, rank)[1]
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

function V1a6_CachotHeroGroupEditView:_modifyEquipMo(equipMO)
	local level = V1a6_CachotTeamModel.instance:getEquipMaxLevel(equipMO, self._seatLevel)

	if level == equipMO.level then
		return equipMO
	end

	local newEquipMo = EquipMO.New()

	newEquipMo:initByConfig(nil, equipMO.equipId, level, equipMO.refineLv)

	return newEquipMo
end

function V1a6_CachotHeroGroupEditView:_refreshAttribute()
	self._talentCubeInfos = nil

	if self._heroMO then
		local level, talentLevel = V1a6_CachotTeamModel.instance:getHeroMaxLevel(self._heroMO, self._seatLevel)
		local showLevel, rank = HeroConfig.instance:getShowLevel(level)
		local talentCubeInfos

		if talentLevel ~= self._heroMO.talent and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
			talentCubeInfos = rank >= CharacterEnum.TalentRank and HeroMo.getTalentCubeInfos(self._heroMO.heroId, talentLevel) or nil
			self._talentCubeInfos = talentCubeInfos
		end

		local attrDict = self._heroMO:getCachotTotalBaseAttrDict(self._equips, level, rank, nil, talentCubeInfos, self._modifyEquipMo, self)

		for index, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
			local co = HeroConfig.instance:getHeroAttributeCO(attrId)

			self._attributevalues[index].name.text = co.name
			self._attributevalues[index].value.text = attrDict[attrId]

			CharacterController.instance:SetAttriIcon(self._attributevalues[index].icon, attrId)
		end
	end
end

function V1a6_CachotHeroGroupEditView:_refreshPassiveSkill()
	if not self._heroMO then
		return
	end

	local pskills = SkillConfig.instance:getpassiveskillsCO(self._heroMO.heroId)
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

	local level, talentLevel = V1a6_CachotTeamModel.instance:getHeroMaxLevel(self._heroMO, self._seatLevel)
	local isBalance = level < balanceLv
	local passiveLevel, rank = SkillConfig.instance:getHeroExSkillLevelByLevel(self._heroMO.heroId, math.max(level, balanceLv))

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
end

function V1a6_CachotHeroGroupEditView:_refreshSkill()
	local var_30_0 = self._heroMO
	local var_30_1

	if self._heroMO then
		var_30_0 = self._heroMO.heroId
		var_30_1 = HeroGroupBalanceHelper.getIsBalanceMode() and not self._heroMO:isTrial()
	end

	self._skillContainer:onUpdateMO(var_30_0, nil, self._heroMO, var_30_1)
end

function V1a6_CachotHeroGroupEditView:_refreshBtnIcon()
	local state = CharacterModel.instance:getRankState()
	local tag = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup)

	gohelper.setActive(self._lvBtns[1], tag ~= 1)
	gohelper.setActive(self._lvBtns[2], tag == 1)
	gohelper.setActive(self._rareBtns[1], tag ~= 2)
	gohelper.setActive(self._rareBtns[2], tag == 2)

	local hasFilter = false

	for _, v in pairs(self._selectDmgs) do
		if v then
			hasFilter = true
		end
	end

	for _, v in pairs(self._selectAttrs) do
		if v then
			hasFilter = true
		end
	end

	for _, v in pairs(self._selectLocations) do
		if v then
			hasFilter = true
		end
	end

	gohelper.setActive(self._classifyBtns[1], not hasFilter)
	gohelper.setActive(self._classifyBtns[2], hasFilter)
	transformhelper.setLocalScale(self._lvArrow[1], 1, state[1], 1)
	transformhelper.setLocalScale(self._lvArrow[2], 1, state[1], 1)
	transformhelper.setLocalScale(self._rareArrow[1], 1, state[2], 1)
	transformhelper.setLocalScale(self._rareArrow[2], 1, state[2], 1)
end

function V1a6_CachotHeroGroupEditView:_refreshFilterView()
	for i = 1, 2 do
		gohelper.setActive(self._dmgUnselects[i], not self._selectDmgs[i])
		gohelper.setActive(self._dmgSelects[i], self._selectDmgs[i])
	end

	for i = 1, 6 do
		gohelper.setActive(self._attrUnselects[i], not self._selectAttrs[i])
		gohelper.setActive(self._attrSelects[i], self._selectAttrs[i])
	end

	for i = 1, 6 do
		gohelper.setActive(self._locationUnselects[i], not self._selectLocations[i])
		gohelper.setActive(self._locationSelects[i], self._selectLocations[i])
	end
end

function V1a6_CachotHeroGroupEditView:_updateHeroList()
	local dmgs = {}

	for i = 1, 2 do
		if self._selectDmgs[i] then
			table.insert(dmgs, i)
		end
	end

	local careers = {}

	for i = 1, 6 do
		if self._selectAttrs[i] then
			table.insert(careers, i)
		end
	end

	local locations = {}

	for i = 1, 6 do
		if self._selectLocations[i] then
			table.insert(locations, i)
		end
	end

	if #dmgs == 0 then
		dmgs = {
			1,
			2
		}
	end

	if #careers == 0 then
		careers = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #locations == 0 then
		locations = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local filterParam = {}

	filterParam.dmgs = dmgs
	filterParam.careers = careers
	filterParam.locations = locations

	CharacterModel.instance:filterCardListByDmgAndCareer(filterParam, false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshBtnIcon()

	if self._isShowQuickEdit then
		self._heroGroupQuickEditListModel:copyQuickEditCardList()
	else
		self._heroGroupEditListModel:copyCharacterCardList()
	end
end

function V1a6_CachotHeroGroupEditView:replaceSelectHeroDefaultEquip()
	if self._heroMO and self._heroMO:hasDefaultEquip() then
		local heroGroupMo = self._heroSingleGroupModel:getCurGroupMO()
		local heroGroupEquipMoList = heroGroupMo.equips

		for i, heroGroupEquipMo in pairs(heroGroupEquipMoList) do
			if heroGroupEquipMo.equipUid[1] == self._heroMO.defaultEquipUid then
				heroGroupEquipMo.equipUid[1] = "0"
			end
		end

		heroGroupEquipMoList[self._singleGroupMOId - 1].equipUid[1] = self._heroMO.defaultEquipUid
	end
end

function V1a6_CachotHeroGroupEditView:replaceFightSelectHeroDefaultEquip()
	local teamInfo = V1a6_CachotModel.instance:getTeamInfo()

	if self._heroMO and self._heroMO:hasDefaultEquip() and teamInfo:hasEquip(self._heroMO.defaultEquipUid) then
		local heroGroupMo = self._heroSingleGroupModel:getCurGroupMO()
		local heroGroupEquipMoList = heroGroupMo.equips

		for i, heroGroupEquipMo in pairs(heroGroupEquipMoList) do
			if heroGroupEquipMo.equipUid[1] == self._heroMO.defaultEquipUid then
				heroGroupEquipMo.equipUid[1] = "0"
			end
		end

		heroGroupEquipMoList[self._singleGroupMOId - 1].equipUid[1] = self._heroMO.defaultEquipUid
	end
end

function V1a6_CachotHeroGroupEditView:replaceQuickGroupHeroDefaultEquip(heroUids)
	local heroGroupMo = self._heroSingleGroupModel:getCurGroupMO()
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

function V1a6_CachotHeroGroupEditView:_saveCurGroupInfo()
	if self.viewParam.heroGroupEditType ~= V1a6_CachotEnum.HeroGroupEditType.Fight then
		if self.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Init then
			self:replaceSelectHeroDefaultEquip()

			local heroGroupMO = self._heroSingleGroupModel:getCurGroupMO()
			local heroList = V1a6_CachotHeroSingleGroupModel.instance:getList()

			heroGroupMO:replaceHeroList(heroList)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)

		return
	end

	local newHeroUids = self._heroSingleGroupModel:getHeroUids()
	local heroGroupMO = self._heroSingleGroupModel:getCurGroupMO()

	self:replaceFightSelectHeroDefaultEquip()
	self._heroGroupModel:replaceSingleGroup()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	self._heroGroupModel:saveCurGroupData()
	self._heroGroupModel:cachotSaveCurGroup()
end

function V1a6_CachotHeroGroupEditView:_saveQuickGroupInfo()
	if self._heroGroupQuickEditListModel:getIsDirty() then
		local newHeroUids = self._heroGroupQuickEditListModel:getHeroUids()
		local heroGroupMO = self._heroSingleGroupModel:getCurGroupMO()

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
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		self._heroGroupModel:saveCurGroupData()
	end
end

function V1a6_CachotHeroGroupEditView:_onAttributeChanged(level, heroId)
	CharacterModel.instance:setFakeLevel(heroId, level)
end

function V1a6_CachotHeroGroupEditView:_normalEditHasChange()
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

function V1a6_CachotHeroGroupEditView:_refreshEditMode()
	gohelper.setActive(self._scrollquickedit.gameObject, self._isShowQuickEdit)
	gohelper.setActive(self._scrollcard.gameObject, not self._isShowQuickEdit)
	gohelper.setActive(self._goBtnEditQuickMode.gameObject, self._isShowQuickEdit)
	gohelper.setActive(self._goBtnEditNormalMode.gameObject, not self._isShowQuickEdit)
end

function V1a6_CachotHeroGroupEditView:_refreshCurScrollBySort()
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

function V1a6_CachotHeroGroupEditView:_onGroupModify()
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

function V1a6_CachotHeroGroupEditView:_editableInitView()
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
	self._selectDmgs = {}
	self._dmgSelects = self:getUserDataTb_()
	self._dmgUnselects = self:getUserDataTb_()
	self._dmgBtnClicks = self:getUserDataTb_()
	self._selectAttrs = {}
	self._attrSelects = self:getUserDataTb_()
	self._attrUnselects = self:getUserDataTb_()
	self._attrBtnClicks = self:getUserDataTb_()
	self._selectLocations = {}
	self._locationSelects = self:getUserDataTb_()
	self._locationUnselects = self:getUserDataTb_()
	self._locationBtnClicks = self:getUserDataTb_()
	self._curDmgs = {}
	self._curAttrs = {}
	self._curLocations = {}

	for i = 1, 2 do
		self._lvBtns[i] = gohelper.findChild(self._btnlvrank.gameObject, "btn" .. tostring(i))
		self._lvArrow[i] = gohelper.findChild(self._lvBtns[i], "txt/arrow").transform
		self._rareBtns[i] = gohelper.findChild(self._btnrarerank.gameObject, "btn" .. tostring(i))
		self._rareArrow[i] = gohelper.findChild(self._rareBtns[i], "txt/arrow").transform
		self._classifyBtns[i] = gohelper.findChild(self._btnclassify.gameObject, "btn" .. tostring(i))
		self._dmgUnselects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/unselected")
		self._dmgSelects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/selected")
		self._dmgBtnClicks[i] = gohelper.findChildButtonWithAudio(self._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/click")

		self._dmgBtnClicks[i]:AddClickListener(self._dmgBtnOnClick, self, i)
	end

	for i = 1, 6 do
		self._attrUnselects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/unselected")
		self._attrSelects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/selected")
		self._attrBtnClicks[i] = gohelper.findChildButtonWithAudio(self._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/click")

		self._attrBtnClicks[i]:AddClickListener(self._attrBtnOnClick, self, i)
	end

	for i = 1, 6 do
		self._locationUnselects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/unselected")
		self._locationSelects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/selected")
		self._locationBtnClicks[i] = gohelper.findChildButtonWithAudio(self._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/click")

		self._locationBtnClicks[i]:AddClickListener(self._locationBtnOnClick, self, i)
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
		local o = self:getUserDataTb_()

		o.go = gohelper.findChild(self._gopassiveskills, "passiveskill" .. tostring(i))
		o.on = gohelper.findChild(o.go, "on")
		o.off = gohelper.findChild(o.go, "off")
		o.balance = gohelper.findChild(o.go, "balance")
		self._passiveskillitems[i] = o
	end

	self._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(self._goskill, CharacterSkillContainer)

	gohelper.setActive(self._gononecharacter, false)
	gohelper.setActive(self._gocharacterinfo, false)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if GuideModel.instance:isGuideFinish(V1a6_CachotEnum.HelpUnlockGuideId) then
		self._btntips:AddClickListener(self._btntipsOnClick, self)
	end
end

function V1a6_CachotHeroGroupEditView:_initFakeLevelList()
	if not self.viewParam.seatLevel then
		return
	end

	local fakeLevelList = {}
	local heroList = HeroModel.instance:getList()

	for i, v in ipairs(heroList) do
		fakeLevelList[v.heroId] = V1a6_CachotTeamModel.instance:getHeroMaxLevel(v, self.viewParam.seatLevel)
	end

	CharacterModel.instance:setFakeList(fakeLevelList)
end

function V1a6_CachotHeroGroupEditView:onOpen()
	self._isShowQuickEdit = false
	self._scrollcard.verticalNormalizedPosition = 1
	self._scrollquickedit.verticalNormalizedPosition = 1
	self._originalHeroUid = self.viewParam.originalHeroUid
	self._singleGroupMOId = self.viewParam.singleGroupMOId
	self._adventure = self.viewParam.adventure
	self._equips = self.viewParam.equips

	for i = 1, 2 do
		self._selectDmgs[i] = false
	end

	for i = 1, 6 do
		self._selectAttrs[i] = false
	end

	for i = 1, 6 do
		self._selectLocations[i] = false
	end

	self._heroGroupEditListModel = V1a6_CachotHeroGroupEditListModel.instance
	self._heroGroupQuickEditListModel = HeroGroupQuickEditListModel.instance
	self._heroSingleGroupModel = V1a6_CachotHeroSingleGroupModel.instance
	self._heroGroupModel = V1a6_CachotHeroGroupModel.instance

	self:_initFakeLevelList()
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	CharacterModel.instance:setCardListByRareAndSort(false, CharacterEnum.FilterType.HeroGroup, false)
	self._heroGroupEditListModel:setParam(self._originalHeroUid, self._adventure, self._heroHps)
	self._heroGroupQuickEditListModel:setParam(self._adventure, self._heroHps)
	self._heroGroupEditListModel:setHeroGroupEditType(self.viewParam.heroGroupEditType)
	self.viewContainer:_setHomeBtnVisible(self.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Fight)

	local seatLevel = self.viewParam.seatLevel

	self._seatLevel = seatLevel

	self._heroGroupEditListModel:setSeatLevel(seatLevel)
	gohelper.setActive(self._goseatlevel, seatLevel)

	if seatLevel then
		UISpriteSetMgr.instance:setV1a6CachotSprite(self._seatIcon, "v1a6_cachot_quality_0" .. seatLevel)

		if not self._qualityEffectList then
			self._qualityEffectList = self:getUserDataTb_()

			local transform = self._seatEffect.transform
			local childCount = transform.childCount

			for i = 1, childCount do
				local child = transform:GetChild(i - 1)

				self._qualityEffectList[child.name] = child
			end
		end

		local targetName = "effect_0" .. seatLevel

		for k, v in pairs(self._qualityEffectList) do
			gohelper.setActive(v, k == targetName)
		end
	end

	self._heroMO = self._heroGroupEditListModel:copyCharacterCardList(true)

	self:_refreshEditMode()
	self:_refreshBtnIcon()
	self:_refreshCharacterInfo()
	gohelper.setActive(self._btnquickedit, false)
	gohelper.setActive(self._btncancel, not self.viewParam.hideCancel)
	gohelper.setActive(self._btncharacter, false)
	gohelper.setActive(self._btncharacterWithTalent, false)

	if self.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event then
		local allHeroList = self._heroGroupEditListModel:getList()

		gohelper.setActive(self._goempty, #allHeroList <= 0)

		local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
		local teamInfo = rogueInfo.teamInfo
		local heroList = teamInfo:getAllHeroUids()

		if #heroList >= #allHeroList then
			gohelper.setActive(self._btncancel, true)
			gohelper.setActive(self._btnconfirm, false)
			recthelper.setAnchorX(self._btncancel.transform, -192)
		end
	end

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
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onGroupModify, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onGroupModify, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	gohelper.addUIClickAudio(self._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, self._initScrollContentPosY = transformhelper.getLocalPos(self._goScrollContent.transform)
end

function V1a6_CachotHeroGroupEditView:onClose()
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
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onGroupModify, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onGroupModify, self)
	CharacterModel.instance:clearFakeList()
	CharacterModel.instance:setFakeLevel()
	self._heroGroupEditListModel:cancelAllSelected()
	self._heroGroupEditListModel:clear()
	self._heroGroupQuickEditListModel:cancelAllSelected()
	self._heroGroupQuickEditListModel:clear()
	HeroGroupTrialModel.instance:setFilter()
	CommonHeroHelper.instance:resetGrayState()

	self._selectDmgs = {}
	self._selectAttrs = {}
	self._selectLocations = {}

	if self._isStopBgm then
		TaskDispatcher.cancelTask(self._delyStopBgm, self)
		self:_delyStopBgm()
	end
end

function V1a6_CachotHeroGroupEditView:_onOpenView(viewName)
	if viewName == ViewName.CharacterView and self._isStopBgm then
		TaskDispatcher.cancelTask(self._delyStopBgm, self)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Unsatisfied_Music)

		return
	end
end

function V1a6_CachotHeroGroupEditView:_showRecommendCareer()
	local recommended, counter = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, self._goattrlist, self._goattritem)

	self._txtrecommendAttrDesc.text = #recommended == 0 and luaLang("herogroupeditview_notrecommend") or luaLang("herogroupeditview_recommend")

	gohelper.setActive(self._goattrlist, #recommended ~= 0)
end

function V1a6_CachotHeroGroupEditView:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function V1a6_CachotHeroGroupEditView:_onCloseView(viewName)
	if viewName == ViewName.CharacterView then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UIMusic)

		self._isStopBgm = true

		TaskDispatcher.cancelTask(self._delyStopBgm, self)
		TaskDispatcher.runDelay(self._delyStopBgm, self, 1)
	end
end

function V1a6_CachotHeroGroupEditView:_delyStopBgm()
	self._isStopBgm = false

	AudioMgr.instance:trigger(AudioEnum.Bgm.Pause_FightingMusic)
end

function V1a6_CachotHeroGroupEditView:_showCharacterRankUpView(func)
	func()
end

function V1a6_CachotHeroGroupEditView:onDestroyView()
	self._imgBg:UnLoadImage()
	self._simageredlight:UnLoadImage()

	self._imgBg = nil
	self._simageredlight = nil

	for i = 1, 2 do
		self._dmgBtnClicks[i]:RemoveClickListener()
	end

	for i = 1, 6 do
		self._attrBtnClicks[i]:RemoveClickListener()
	end

	for i = 1, 6 do
		self._locationBtnClicks[i]:RemoveClickListener()
	end
end

return V1a6_CachotHeroGroupEditView
