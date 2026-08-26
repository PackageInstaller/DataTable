-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyHeroGroupEditView.lua

module("modules.logic.sp01.odyssey.view.OdysseyHeroGroupEditView", package.seeall)

local OdysseyHeroGroupEditView = class("OdysseyHeroGroupEditView", HeroGroupEditView)

function OdysseyHeroGroupEditView:onOpen()
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

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)

	local mainHeroConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TrialHeroId)
	local odysseyTrialId = tonumber(mainHeroConstCo.value)

	HeroGroupTrialModel.instance:setTrailByTrialIdList({
		odysseyTrialId
	}, 1)
	HeroGroupEditListModel.instance:setParam(self._originalHeroUid, self._adventure, self._isTowerBattle, self._groupType)
	HeroGroupQuickEditListModel.instance:setParam(self._adventure, self._isTowerBattle, self._groupType)

	self._heroMO = HeroGroupEditListModel.instance:copyCharacterCardList(true)

	self:_refreshEditMode()
	self:_refreshBtnIcon()
	self:_refreshCharacterInfo()
	self:_showRecommendCareer()
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
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._refreshCharacterInfo, self)
	self.addEventCb(self, AudioMgr.instance, AudioMgr.Evt_Trigger, self._onAudioTrigger, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
	gohelper.addUIClickAudio(self._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, self._initScrollContentPosY = transformhelper.getLocalPos(self._goScrollContent.transform)
end

function OdysseyHeroGroupEditView:_showRecommendCareer()
	OdysseyTalentModel.instance:setTrialCassandraTreeInfo()

	local fightParam = FightModel.instance:getFightParam()

	if fightParam == nil then
		return
	end

	local recommended, counter = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, self._goattrlist, self._goattritem)

	self._txtrecommendAttrDesc.text = #recommended == 0 and luaLang("herogroupeditview_notrecommend") or luaLang("herogroupeditview_recommend")

	gohelper.setActive(self._goattrlist, #recommended ~= 0)
end

function OdysseyHeroGroupEditView:_btnconfirmOnClick()
	if self._isShowQuickEdit then
		local newHeroUids = HeroGroupQuickEditListModel.instance:getHeroUids()

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

	local singleGroupMO = HeroSingleGroupModel.instance:getById(self._singleGroupMOId)

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
		elseif self._isTowerBattle and TowerModel.instance:isHeroBan(self._heroMO.heroId) then
			GameFacade.showToast(ToastEnum.TowerHeroGroupEdit)

			return
		end

		if self._heroMO.isPosLock then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		end

		if self._heroMO:isTrial() and not HeroSingleGroupModel.instance:isInGroup(self._heroMO.uid) and (singleGroupMO:isEmpty() or not singleGroupMO.trial) and HeroGroupEditListModel.instance:isTrialLimit() then
			GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

			return
		end

		local hasHero, hasHeroIndex = HeroSingleGroupModel.instance:hasHeroUids(self._heroMO.uid, self._singleGroupMOId)

		if hasHero then
			HeroSingleGroupModel.instance:removeFrom(hasHeroIndex)

			local heroGroupMo = OdysseyHeroGroupModel.instance:getCurHeroGroup()

			heroGroupMo:swapOdysseyEquips(hasHeroIndex - 1, self._singleGroupMOId - 1)
			HeroSingleGroupModel.instance:addTo(self._heroMO.uid, self._singleGroupMOId)

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

		if HeroSingleGroupModel.instance:isAidConflict(self._heroMO.heroId) then
			GameFacade.showToast(ToastEnum.HeroIsAidConflict)

			return
		end

		HeroSingleGroupModel.instance:addTo(self._heroMO.uid, self._singleGroupMOId)

		if self._heroMO:isTrial() then
			singleGroupMO:setTrial(self._heroMO.trialCo.id, self._heroMO.trialCo.trialTemplate)
		else
			singleGroupMO:setTrial()
		end

		FightAudioMgr.instance:playHeroVoiceRandom(self._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
		self:_saveCurGroupInfo()
		self:closeThis()
	else
		HeroSingleGroupModel.instance:removeFrom(self._singleGroupMOId)
		self:_saveCurGroupInfo()
		self:closeThis()
	end
end

return OdysseyHeroGroupEditView
