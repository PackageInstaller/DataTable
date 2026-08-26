-- chunkname: @modules/logic/rouge/view/RougeHeroGroupEditView.lua

module("modules.logic.rouge.view.RougeHeroGroupEditView", package.seeall)

local RougeHeroGroupEditView = class("RougeHeroGroupEditView", BaseView)

function RougeHeroGroupEditView:onInitView()
	self._gononecharacter = gohelper.findChild(self.viewGO, "characterinfo/#go_nonecharacter")
	self._gocharacterinfo = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo")
	self._imagedmgtype = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/#image_dmgtype")
	self._imagecareericon = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/career/#image_careericon")
	self._txtname = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/name/#txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/name/#txt_nameen")
	self._gospecialitem = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem")
	self._golevel = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/level")
	self._txtlevel = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/level/#txt_level")
	self._gorank = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/level/#txt_level/#go_rank")
	self._txtlevelmax = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/level/#txt_level/#txt_levelmax")
	self._btncharacter = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/level/#btn_character")
	self._btntrial = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/level/#btn_trial")
	self._goBalance = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/level/#go_balance")
	self._goheroLvTxt = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/level/Text")
	self._golevelWithTalent = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent")
	self._txtlevelWithTalent = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level")
	self._gowithtalentrank = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level/#go_rank")
	self._txtlevelmaxWithTalent = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level/#txt_levelmax")
	self._btncharacterWithTalent = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_character")
	self._btntrialWithTalent = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_trial")
	self._goBalanceWithTalent = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#go_balance")
	self._goheroLvTxtWithTalent = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/Text")
	self._txttalent = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talent")
	self._txttalenticon = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talent/icon")
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
	self._gorecommendAttrDesc = gohelper.findChild(self.viewGO, "#go_recommendAttr")
	self._txtrecommendAttrDesc = gohelper.findChildText(self.viewGO, "#go_recommendAttr/bg/#txt_desc")
	self._goattrlist = gohelper.findChild(self.viewGO, "#go_recommendAttr/bg/#go_attrlist")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_recommendAttr/bg/#go_attrlist/#go_attritem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeHeroGroupEditView:addEvents()
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

function RougeHeroGroupEditView:removeEvents()
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

function RougeHeroGroupEditView:_btnclassifyOnClick()
	local param = {
		filterType = CharacterEnum.FilterType.HeroGroup
	}

	CharacterController.instance:openCharacterFilterView(param)
end

function RougeHeroGroupEditView:_btnpassiveskillOnClick()
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
	info.isBalance = RougeHeroGroupBalanceHelper.getIsBalanceMode() and not self._heroMO:isTrial()
	info.balanceHelper = RougeHeroGroupBalanceHelper

	CharacterController.instance:openCharacterTipView(info)
end

function RougeHeroGroupEditView:_btnconfirmOnClick()
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
		if self.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
			local selectList = self.viewContainer:getQuickSelectHeroList()

			if #selectList <= 0 then
				GameFacade.showMessageBox(MessageBoxIdDefine.RougeTeamSelectedHeroConfirm, MsgBoxEnum.BoxType.Yes_No, function()
					self:_saveQuickGroupInfo(true)
					self:closeThis()
				end, nil, nil, self)

				return
			end
		end

		self:_saveQuickGroupInfo(true)
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

		if self:_isFightEditType() then
			local teamInfo = RougeModel.instance:getTeamInfo()
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
		self._heroSingleGroupModel:removeFrom(self._singleGroupMOId)
		self:_saveCurGroupInfo()
		self:closeThis()
	end
end

function RougeHeroGroupEditView:checkTrialNum()
	return false
end

function RougeHeroGroupEditView:_btncancelOnClick()
	if self.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		self.viewContainer:_overrideClose()

		return
	end

	self:closeThis()
end

function RougeHeroGroupEditView:_btncharacterOnClick()
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

function RougeHeroGroupEditView:_btntrialOnClick()
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

function RougeHeroGroupEditView:_btnattributeOnClick()
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
		info.isBalance = RougeHeroGroupBalanceHelper.getIsBalanceMode() and not self._heroMO:isTrial()
		info.balanceHelper = RougeHeroGroupBalanceHelper

		CharacterController.instance:openCharacterTipView(info)
	end
end

function RougeHeroGroupEditView:_btnexskillrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshCurScrollBySort()
	self:_refreshBtnIcon()
end

function RougeHeroGroupEditView:_btnlvrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshCurScrollBySort()
	self:_refreshBtnIcon()
end

function RougeHeroGroupEditView:_btnrarerankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshCurScrollBySort()
	self:_refreshBtnIcon()
end

function RougeHeroGroupEditView:_btnquickeditOnClick()
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

	self:_updateTotalCapacity()
	RougeController.instance:dispatchEvent(RougeEvent.OnSwitchHeroGroupEditMode)
end

function RougeHeroGroupEditView:_onClickHeroEditItem(heroMO)
	self:_onHeroItemClick(heroMO)
	self:_updateTotalCapacity()
end

function RougeHeroGroupEditView:_onHeroItemClick(heroMO)
	self._heroMO = heroMO

	self:_refreshCharacterInfo()
end

function RougeHeroGroupEditView:_refreshCharacterInfo()
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

function RougeHeroGroupEditView:_refreshMainInfo()
	if self._heroMO then
		gohelper.setActive(self._btntrial.gameObject, self._heroMO:isTrial())
		gohelper.setActive(self._btntrialWithTalent.gameObject, self._heroMO:isTrial())
		UISpriteSetMgr.instance:setCommonSprite(self._imagecareericon, "lssx_" .. tostring(self._heroMO.config.career))
		UISpriteSetMgr.instance:setCommonSprite(self._imagedmgtype, "dmgtype" .. tostring(self._heroMO.config.dmgType))

		self._txtname.text = self._heroMO.config.name
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
			balanceLv, balanceRank, balanceTalent = RougeHeroGroupBalanceHelper.getHeroBalanceInfo(self._heroMO.heroId)

			if balanceRank and balanceRank >= CharacterEnum.TalentRank and balanceTalent > 0 then
				isShowBalanceTalent = true
			end
		end

		local isBalance = balanceLv and balanceLv > self._heroMO.level
		local isBalanceTalent = isShowBalanceTalent and (not isShowTalent or balanceTalent > self._heroMO.talent)

		if isShowTalent or isShowBalanceTalent then
			gohelper.setActive(self._golevel, false)
			gohelper.setActive(self._golevelWithTalent, true)
			gohelper.setActive(self._goBalanceWithTalent, false)
			gohelper.setActive(self._goheroLvTxtWithTalent, true)

			if isBalance then
				local showLevel, rank = HeroConfig.instance:getShowLevel(balanceLv)
				local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, rank)[1]
				local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

				self._txtlevelWithTalent.text = "<color=#8fb1cc>" .. tostring(showLevel)
				self._txtlevelmaxWithTalent.text = string.format("/%d", showMaxLevel)

				self:refreshWithTalentRankIcon(rank, true)
			else
				local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, self._heroMO.rank)[1]
				local showLevel = HeroConfig.instance:getShowLevel(self._heroMO.level)
				local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

				self._txtlevelWithTalent.text = tostring(showLevel)
				self._txtlevelmaxWithTalent.text = string.format("/%d", showMaxLevel)

				self:refreshWithTalentRankIcon(self._heroMO.rank)
			end

			if isBalanceTalent then
				self._txttalent.text = "<color=#8fb1cc>Lv.<size=40>" .. tostring(balanceTalent)
				self._txttalenticon.color = GameUtil.parseColor("#89dafd")
			else
				self._txttalent.text = "Lv.<size=40>" .. tostring(self._heroMO.talent)
				self._txttalenticon.color = GameUtil.parseColor("#D3CCBF")
			end

			self._txttalentType.text = luaLang("talent_character_talentcn" .. self._heroMO:getTalentTxtByHeroType())
		else
			gohelper.setActive(self._golevel, true)
			gohelper.setActive(self._golevelWithTalent, false)
			gohelper.setActive(self._goBalance, false)
			gohelper.setActive(self._goheroLvTxt, not isBalance)

			if isBalance then
				local showLevel, rank = HeroConfig.instance:getShowLevel(balanceLv)
				local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, rank)[1]
				local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

				self._txtlevel.text = "<color=#8fb1cc>" .. tostring(showLevel)
				self._txtlevelmax.text = string.format("/%d", showMaxLevel)

				self:refreshRankIcon(rank, true)
			else
				local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, self._heroMO.rank)[1]
				local showLevel = HeroConfig.instance:getShowLevel(self._heroMO.level)
				local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

				self._txtlevel.text = tostring(showLevel)
				self._txtlevelmax.text = string.format("/%d", showMaxLevel)

				self:refreshRankIcon(self._heroMO.rank)
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

function RougeHeroGroupEditView:refreshRankIcon(rank, isBalance)
	self:initRankGoList()

	for i, go in ipairs(self.rankGoList) do
		gohelper.setActive(go, i == rank - 1)
		SLFramework.UGUI.GuiHelper.SetColor(go:GetComponent(gohelper.Type_Image), isBalance and "#89dafd" or "#D3CCBF")
	end
end

function RougeHeroGroupEditView:initRankGoList()
	if not self.rankGoList then
		self.rankGoList = self:getUserDataTb_()

		for i = 1, 3 do
			table.insert(self.rankGoList, gohelper.findChild(self._gorank, "rank" .. i))
		end
	end

	return self.rankGoList
end

function RougeHeroGroupEditView:refreshWithTalentRankIcon(rank, isBalance)
	self:initRankGoWithTalentList()

	for i, go in ipairs(self.rankGoWithTalentList) do
		gohelper.setActive(go, i == rank - 1)
		SLFramework.UGUI.GuiHelper.SetColor(go:GetComponent(gohelper.Type_Image), isBalance and "#89dafd" or "#D3CCBF")
	end
end

function RougeHeroGroupEditView:initRankGoWithTalentList()
	if not self.rankGoWithTalentList then
		self.rankGoWithTalentList = self:getUserDataTb_()

		for i = 1, 3 do
			table.insert(self.rankGoWithTalentList, gohelper.findChild(self._gowithtalentrank, "rank" .. i))
		end
	end

	return self.rankGoList
end

function RougeHeroGroupEditView:_refreshAttribute()
	if self._heroMO then
		local mo = HeroGroupTrialModel.instance:getById(self._originalHeroUid)
		local trialEquipMo
		local var_25_0

		if mo then
			trialEquipMo = mo.trialEquipMo
			var_25_0 = RougeHeroGroupBalanceHelper.getIsBalanceMode() and not self._heroMO:isTrial()
		end

		local attrDict = self._heroMO:getTotalBaseAttrDict(self._equips, nil, nil, var_25_0, trialEquipMo, RougeHeroGroupBalanceHelper.getHeroBalanceInfo)

		for index, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
			local co = HeroConfig.instance:getHeroAttributeCO(attrId)

			self._attributevalues[index].name.text = co.name
			self._attributevalues[index].value.text = attrDict[attrId]

			CharacterController.instance:SetAttriIcon(self._attributevalues[index].icon, attrId)
		end
	end
end

function RougeHeroGroupEditView:_refreshPassiveSkill()
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
		balanceLv = RougeHeroGroupBalanceHelper.getHeroBalanceLv(self._heroMO.heroId)
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

function RougeHeroGroupEditView:_refreshSkill()
	local var_27_0 = self._heroMO
	local var_27_1

	if self._heroMO then
		var_27_0 = self._heroMO.heroId
		var_27_1 = RougeHeroGroupBalanceHelper.getIsBalanceMode() and not self._heroMO:isTrial()
	end

	self._skillContainer:onUpdateMO(var_27_0, nil, self._heroMO, var_27_1, CharacterEnum.DeviceViewType.HeroGroupEditView)
end

function RougeHeroGroupEditView:_refreshBtnIcon()
	local state = CharacterModel.instance:getRankState()
	local tag = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup)

	gohelper.setActive(self._lvBtns[1], tag ~= 1)
	gohelper.setActive(self._lvBtns[2], tag == 1)
	gohelper.setActive(self._rareBtns[1], tag ~= 2)
	gohelper.setActive(self._rareBtns[2], tag == 2)

	local hasFilter = CharacterSearchFilterModel.instance:hasFilter()

	gohelper.setActive(self._classifyBtns[1], not hasFilter)
	gohelper.setActive(self._classifyBtns[2], hasFilter)
	transformhelper.setLocalScale(self._lvArrow[1], 1, state[1], 1)
	transformhelper.setLocalScale(self._lvArrow[2], 1, state[1], 1)
	transformhelper.setLocalScale(self._rareArrow[1], 1, state[2], 1)
	transformhelper.setLocalScale(self._rareArrow[2], 1, state[2], 1)
end

function RougeHeroGroupEditView:_updateHeroList()
	self:_refreshBtnIcon()

	if self._isShowQuickEdit then
		self._heroGroupQuickEditListModel:copyQuickEditCardList()
	else
		self._heroGroupEditListModel:copyCharacterCardList()
	end
end

function RougeHeroGroupEditView:replaceSelectHeroDefaultEquip()
	if self._heroMO and self._heroMO:hasDefaultEquip() and self._singleGroupMOId <= RougeEnum.FightTeamNormalHeroNum then
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

function RougeHeroGroupEditView:replaceQuickGroupHeroDefaultEquip(heroUids)
	if self._isInitType then
		return
	end

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

function RougeHeroGroupEditView:_saveCurGroupInfo()
	if not self:_isFightEditType() then
		if self._isInitType then
			local heroGroupMO = self._heroSingleGroupModel:getCurGroupMO()
			local heroList = self._heroSingleGroupModel.instance:getList()

			heroGroupMO:replaceHeroList(heroList)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)

		return
	end

	local newHeroUids = self._heroSingleGroupModel:getHeroUids()
	local heroGroupMO = self._heroGroupModel:getCurGroupMO()

	self:replaceSelectHeroDefaultEquip()
	self._heroGroupModel:replaceSingleGroup()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	self._heroGroupModel:saveCurGroupData()
	self._heroGroupModel:rougeSaveCurGroup()
end

function RougeHeroGroupEditView:_saveQuickGroupInfo(isCheckSelectHeroResult)
	if self.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		if isCheckSelectHeroResult then
			self.viewContainer:checkSelectHeroResult()
		end

		return
	end

	local roleNum = self._isInitType and RougeEnum.InitTeamHeroNum or self._heroGroupModel:getBattleRoleNum()

	if self._heroGroupQuickEditListModel:getIsDirty() then
		local newHeroUids = self._heroGroupQuickEditListModel:getHeroUids()

		self:replaceQuickGroupHeroDefaultEquip(newHeroUids)

		for i = 1, roleNum do
			local heroUid = newHeroUids[i]

			if heroUid ~= nil then
				local hasHero, hasHeroIndex = self._heroSingleGroupModel:hasHeroUids(heroUid, self._singleGroupMOId)

				if hasHero then
					self._heroSingleGroupModel:removeFrom(hasHeroIndex)
				end

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

		if self._isInitType then
			return
		end

		self._heroGroupModel:saveCurGroupData()
		self._heroGroupModel:rougeSaveCurGroup()
	end
end

function RougeHeroGroupEditView:_onAttributeChanged(level, heroId)
	CharacterModel.instance:setFakeLevel(heroId, level)
end

function RougeHeroGroupEditView:_normalEditHasChange()
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

function RougeHeroGroupEditView:_refreshEditMode()
	gohelper.setActive(self._scrollquickedit.gameObject, self._isShowQuickEdit)
	gohelper.setActive(self._scrollcard.gameObject, not self._isShowQuickEdit)
	gohelper.setActive(self._goBtnEditQuickMode.gameObject, self._isShowQuickEdit)
	gohelper.setActive(self._goBtnEditNormalMode.gameObject, not self._isShowQuickEdit)
end

function RougeHeroGroupEditView:_refreshCurScrollBySort()
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

function RougeHeroGroupEditView:_onGroupModify()
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

function RougeHeroGroupEditView:_editableInitView()
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

	self._skillContainer:setBalanceHelper(RougeHeroGroupBalanceHelper)
	gohelper.setActive(self._gononecharacter, false)
	gohelper.setActive(self._gocharacterinfo, false)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gorecommendAttrDesc, false)

	self._fightTip = gohelper.findChild(self.viewGO, "#go_chooserole/fight")
	self._fightAssitTip = gohelper.findChild(self.viewGO, "#go_chooserole/assit")
end

function RougeHeroGroupEditView:_findPassiveskillitems(index)
	local o = self:getUserDataTb_()

	o.go = gohelper.findChild(self._gopassiveskills, "passiveskill" .. index)
	o.on = gohelper.findChild(o.go, "on")
	o.off = gohelper.findChild(o.go, "off")
	o.balance = gohelper.findChild(o.go, "balance")

	return o
end

function RougeHeroGroupEditView:_isFightEditType()
	return self.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.Fight or self.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.FightAssit
end

function RougeHeroGroupEditView:_initFightTip()
	local editType = self.viewParam.heroGroupEditType

	gohelper.setActive(self._fightTip, editType == RougeEnum.HeroGroupEditType.Fight)
	gohelper.setActive(self._fightAssitTip, editType == RougeEnum.HeroGroupEditType.FightAssit)
end

function RougeHeroGroupEditView:_initCapacity()
	self._selectHeroCapacity = self.viewParam.selectHeroCapacity
	self._curCapacity = self.viewParam.curCapacity
	self._totalCapacity = self.viewParam.totalCapacity
	self._assistCapacity = self.viewParam.assistCapacity
	self._assistPos = self.viewParam.assistPos
	self._assistHeroId = self.viewParam.assistHeroId

	RougeHeroGroupEditListModel.instance:setCapacityInfo(self._selectHeroCapacity, self._curCapacity, self._totalCapacity, self._assistCapacity, self._assistPos, self._assistHeroId)

	if not self._capacityComp then
		local volumeGo = gohelper.findChild(self.viewGO, "characterinfo/volumebg/volume")
		local txttitletips = gohelper.findChildText(self.viewGO, "characterinfo/volumebg/txt_titletips")

		txttitletips.text = self.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero and luaLang("p_rougeinitteamview_txt_titletips") or luaLang("p_rougeinitteamview_txt_titletips2")

		local spriteType

		self._capacityComp = RougeCapacityComp.Add(volumeGo, self._curCapacity, self._totalCapacity, true, (self:_isFightEditType() or nil) and RougeCapacityComp.SpriteType2)

		self._capacityComp:showChangeEffect(true)
	else
		self._capacityComp:updateCurAndMaxNum(self._curCapacity, self._totalCapacity)
	end
end

function RougeHeroGroupEditView:_updateTotalCapacity()
	if self._isShowQuickEdit then
		local totalCapacity = RougeHeroGroupQuickEditListModel.instance:calcTotalCapacity()

		self._capacityComp:updateCurAndMaxNum(totalCapacity, self._totalCapacity)

		return
	end

	local totalCapacity = RougeHeroGroupEditListModel.instance:calcTotalCapacity(self._singleGroupMOId, self._heroMO)

	self._capacityComp:updateCurAndMaxNum(totalCapacity, self._totalCapacity)
end

function RougeHeroGroupEditView:onUpdateParam()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
end

function RougeHeroGroupEditView:_initFakeLevelList(heroList)
	if not RougeHeroGroupBalanceHelper.getIsBalanceMode() then
		return
	end

	local fakeLevelList = {}

	for i, v in ipairs(heroList) do
		local lv = RougeHeroGroupBalanceHelper.getHeroBalanceLv(v.heroId)

		if lv > v.level then
			fakeLevelList[v.heroId] = lv
		end
	end

	CharacterModel.instance:setFakeList(fakeLevelList)
end

function RougeHeroGroupEditView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)

	self._isShowQuickEdit = false
	self._scrollcard.verticalNormalizedPosition = 1
	self._scrollquickedit.verticalNormalizedPosition = 1
	self._originalHeroUid = self.viewParam.originalHeroUid
	self._singleGroupMOId = self.viewParam.singleGroupMOId
	self._adventure = self.viewParam.adventure
	self._equips = self.viewParam.equips
	self._heroGroupEditListModel = RougeHeroGroupEditListModel.instance
	self._heroGroupQuickEditListModel = RougeHeroGroupQuickEditListModel.instance
	self._heroSingleGroupModel = RougeHeroSingleGroupModel.instance
	self._heroGroupModel = RougeHeroGroupModel.instance

	local heroList = self:_isFightEditType() and RougeHeroGroupEditListModel.instance:getTeamNoSortedList() or HeroModel.instance:getList()

	CharacterModel.instance:setHeroList(heroList)
	self:_initFakeLevelList(heroList)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	self._heroGroupEditListModel:setParam(self._originalHeroUid, self._adventure, self._heroHps)
	self._heroGroupQuickEditListModel:setParam(self._adventure, self._heroHps)
	self._heroGroupEditListModel:setHeroGroupEditType(self.viewParam.heroGroupEditType)

	self._isInitType = self.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.Init

	self.viewContainer:_setHomeBtnVisible(self:_isFightEditType())
	self:_initCapacity()
	self:_initFightTip()

	self._heroMO = self._heroGroupEditListModel:copyCharacterCardList(true)

	self:_refreshEditMode()
	self:_refreshBtnIcon()
	self:_refreshCharacterInfo()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, self._onClickHeroEditItem, self)
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
	self.addEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._refreshCharacterInfo, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
	gohelper.addUIClickAudio(self._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, self._initScrollContentPosY = transformhelper.getLocalPos(self._goScrollContent.transform)

	gohelper.setActive(self._btnquickedit, self.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.Fight or self._isInitType)

	if self.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		self:_btnquickeditOnClick()
	end

	self:_updateTotalCapacity()
end

function RougeHeroGroupEditView:onClose()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._updateHeroList, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, self._onClickHeroEditItem, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._refreshCharacterInfo, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._refreshCharacterInfo, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshCharacterInfo, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._refreshCharacterInfo, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshCharacterInfo, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.levelUpAttribute, self._onAttributeChanged, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.showCharacterRankUpView, self._showCharacterRankUpView, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onGroupModify, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onGroupModify, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._refreshCharacterInfo, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
	CharacterModel.instance:clearFakeList()
	CharacterModel.instance:setFakeLevel()
	self._heroGroupEditListModel:cancelAllSelected()
	self._heroGroupEditListModel:clear()
	self._heroGroupQuickEditListModel:cancelAllSelected()
	self._heroGroupQuickEditListModel:clear()
	HeroGroupTrialModel.instance:setFilter()
	CommonHeroHelper.instance:resetGrayState()
	CharacterController.instance:closeCharacterFilterView()
	CharacterSearchFilterModel.instance:exitParentView()

	if self._isStopBgm then
		TaskDispatcher.cancelTask(self._delyStopBgm, self)
		self:_delyStopBgm()
	end

	if self._skillContainer then
		self._skillContainer:onClose()
	end
end

function RougeHeroGroupEditView:_onOpenView(viewName)
	if viewName == ViewName.CharacterView and self._isStopBgm then
		TaskDispatcher.cancelTask(self._delyStopBgm, self)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Unsatisfied_Music)

		return
	end
end

function RougeHeroGroupEditView:_showRecommendCareer()
	local recommended, counter = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, self._goattrlist, self._goattritem)

	self._txtrecommendAttrDesc.text = #recommended == 0 and luaLang("herogroupeditview_notrecommend") or luaLang("herogroupeditview_recommend")

	gohelper.setActive(self._goattrlist, #recommended ~= 0)
end

function RougeHeroGroupEditView:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function RougeHeroGroupEditView:_onCloseView(viewName)
	if viewName == ViewName.CharacterView then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UIMusic)

		self._isStopBgm = true

		TaskDispatcher.cancelTask(self._delyStopBgm, self)
		TaskDispatcher.runDelay(self._delyStopBgm, self, 1)
	end
end

function RougeHeroGroupEditView:_delyStopBgm()
	self._isStopBgm = false

	AudioMgr.instance:trigger(AudioEnum.Bgm.Pause_FightingMusic)
end

function RougeHeroGroupEditView:_showCharacterRankUpView(func)
	func()
end

function RougeHeroGroupEditView:_onFilterList(param)
	local dmgs, careers = param.dmgs1, param.careers2

	HeroGroupTrialModel.instance:setFilter(dmgs, careers)
	self:_refreshBtnIcon()
	self:_refreshCurScrollBySort()
	ViewMgr.instance:closeView(ViewName.CharacterLevelUpView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function RougeHeroGroupEditView:onDestroyView()
	CharacterModel.instance:clearFakeList()
	CharacterModel.instance:setHeroList(nil)

	if self:_isFightEditType() then
		CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	end

	self._imgBg:UnLoadImage()
	self._simageredlight:UnLoadImage()

	self._imgBg = nil
	self._simageredlight = nil
end

return RougeHeroGroupEditView
