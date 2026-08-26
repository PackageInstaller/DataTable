-- chunkname: @modules/logic/seasonver/act123/view/Season123HeroGroupFightView.lua

module("modules.logic.seasonver.act123.view.Season123HeroGroupFightView", package.seeall)

local Season123HeroGroupFightView = class("Season123HeroGroupFightView", BaseView)

function Season123HeroGroupFightView:onInitView()
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._goreplayready = gohelper.findChild(self.viewGO, "#go_container/#go_replayready")
	self._gotopbtns = gohelper.findChild(self.viewGO, "#go_container/#go_btns/#go_topbtns")
	self._btnrecommend = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_btns/#go_topbtns/btn_recommend")
	self._btnrestrain = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_btns/#go_topbtns/#btn_RestraintInfo")
	self._gobtncontain = gohelper.findChild(self.viewGO, "#go_container/btnContain")
	self._btncloth = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/btnCloth")
	self._txtclothname = gohelper.findChildText(self.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName")
	self._txtclothnameen = gohelper.findChildText(self.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName/#txt_clothNameEn")
	self._btnstartseason = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#btn_startseason")
	self._btnstartseasonreplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#btn_startseasonreplay")
	self._btnseasonreplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay")
	self._imagereplaybg = gohelper.findChildImage(self.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#image_seasonreplaybg")
	self._imagereplayicon = gohelper.findChildImage(self.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#image_seasonreplayicon")
	self._txtreplaycount = gohelper.findChildText(self.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#txt_seasonreplaycount")
	self._dropseasonherogroup = gohelper.findChildDropdown(self.viewGO, "#go_container/btnContain/horizontal/#drop_seasonherogroup")
	self._goherogroupcontain = gohelper.findChild(self.viewGO, "herogroupcontain")
	self._gocontainer2 = gohelper.findChild(self.viewGO, "#go_container2")
	self._gomask = gohelper.findChild(self.viewGO, "#go_container2/#go_mask")
	self._goreplaybtn = gohelper.findChild(self.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn")
	self._gocost = gohelper.findChild(self.viewGO, "#go_container/btnContain/horizontal/#btn_startseason/#go_cost")
	self._btnseasonreplaygroup = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/btnReplay")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123HeroGroupFightView:addEvents()
	self._btncloth:AddClickListener(self._btnclothOnClock, self)
	self._btnrecommend:AddClickListener(self._btnrecommendOnClick, self)
	self._btnrestrain:AddClickListener(self._btnrestrainOnClick, self)
	self._btnstartseason:AddClickListener(self._btnstartseasonOnClick, self)
	self._btnstartseasonreplay:AddClickListener(self._btnstartseasonOnClick, self)
	self._btnseasonreplay:AddClickListener(self._btnseasonreplayOnClick, self)
	self._btnseasonreplaygroup:AddClickListener(self._btnseasonreplayOnClick, self)
	self._dropseasonherogroup:AddOnValueChanged(self._groupDropValueChanged, self)
end

function Season123HeroGroupFightView:removeEvents()
	self._btncloth:RemoveClickListener()
	self._btnrecommend:RemoveClickListener()
	self._btnrestrain:RemoveClickListener()
	self._btnstartseason:RemoveClickListener()
	self._btnseasonreplay:RemoveClickListener()
	self._btnseasonreplaygroup:RemoveClickListener()
	self._btnstartseasonreplay:RemoveClickListener()
	self._dropseasonherogroup:RemoveOnValueChanged()
end

function Season123HeroGroupFightView:_btnrecommendOnClick()
	FightFailRecommendController.instance:onClickRecommend()
	self:_updateRecommendEffect()
	DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(self._episodeId, self._receiveRecommend, self)
end

function Season123HeroGroupFightView:_btnclothOnClock()
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local clothUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill)

	if clothUnlock or PlayerClothModel.instance:getSpEpisodeClothID() then
		ViewMgr.instance:openView(ViewName.PlayerClothView)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function Season123HeroGroupFightView:_btnrestrainOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

Season123HeroGroupFightView.UIBlock_SeasonFight = "UIBlock_SeasonFight"

function Season123HeroGroupFightView:_btnstartseasonOnClick()
	if not self._blockStart then
		self:_onClickStart()

		self._blockStart = true

		UIBlockMgr.instance:startBlock(Season123HeroGroupFightView.UIBlock_SeasonFight)
	end
end

function Season123HeroGroupFightView:_btnseasonreplayOnClick()
	self:_onClickReplay()
end

function Season123HeroGroupFightView:_groupDropValueChanged(value)
	if self._isDropInited then
		GameFacade.showToast(ToastEnum.SeasonGroupChanged)
	end

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		local actId = self.viewParam.actId
		local subId = value + 1
		local seasonMO = Season123Model.instance:getActInfo(actId)

		if subId ~= seasonMO.heroGroupSnapshotSubId then
			Season123HeroGroupController.instance:switchHeroGroup(subId)
		end
	end
end

function Season123HeroGroupFightView:_editableInitView()
	self:_initComponent()
	self:_initData()
	self:_addEvents()
end

function Season123HeroGroupFightView:onDestroyView()
	if self._superCardItem then
		self._superCardItem:destroy()

		self._superCardItem = nil
	end

	Season123HeroGroupController.instance:onCloseView()
	UIBlockMgr.instance:endBlock(Season123HeroGroupFightView.UIBlock_SeasonFight)
end

function Season123HeroGroupFightView:onOpen()
	local actId, layer, episodeId, stage = self.viewParam.actId, self.viewParam.layer, self.viewParam.episodeId, self.viewParam.stage

	Season123HeroGroupController.instance:onOpenView(actId, layer, episodeId, stage)
	self:initSeason123FightGroupDrop()
	self:_checkFirstPosHasEquip()
	self:_refreshUI()
	self:_checkReplay()
	self:_refreshReplay()
	self:_updateRecommendEffect()
	self:_initDataOnOpen()

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		Season123Controller.instance:dispatchEvent(Season123Event.EnterMainEpiosdeHeroGroupView)
	end
end

function Season123HeroGroupFightView:_initComponent()
	self._anim = self._gocontainer:GetComponent(typeof(UnityEngine.Animator))
	self._heroContainAnim = self._goherogroupcontain:GetComponent(typeof(UnityEngine.Animator))
	self._btnContainAnim = self._gobtncontain:GetComponent(typeof(UnityEngine.Animator))
end

function Season123HeroGroupFightView:_initData()
	gohelper.addUIClickAudio(self._btnstartseason.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	gohelper.addUIClickAudio(self._btnseasonreplay.gameObject, AudioEnum.UI.Play_UI_Player_Interface_Close)
	gohelper.addUIClickAudio(self._btnrestrain.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	gohelper.addUIClickAudio(self._dropseasonherogroup.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Action_Cardsopen)
	NavigateMgr.instance:addEscape(Season123Controller.instance:getHeroGroupFightViewName(), self._onEscapeBtnClick, self)

	self._iconGO = self:getResInst(self.viewContainer:getSetting().otherRes[1], self._btncloth.gameObject)

	recthelper.setAnchor(self._iconGO.transform, -100, 1)

	self._tweeningId = 0
	self._replayMode = false

	gohelper.setActive(self._gomask, false)
end

function Season123HeroGroupFightView:_initDataOnOpen()
	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		local season123MO = Season123Model.instance:getActInfo(self.viewParam.actId)
		local snapshotSubId = season123MO.heroGroupSnapshotSubId

		self._dropseasonherogroup:SetValue(snapshotSubId - 1)
	else
		self._dropseasonherogroup:SetValue(1)
	end

	gohelper.setActive(self._goseasoncontain, true)

	self._isDropInited = true
end

function Season123HeroGroupFightView:_addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullView, self._onOpenFullView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onModifyHeroGroup, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onModifySnapshot, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.HeroGroupIndexChanged, self._onModifySnapshot, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, self._onClickHeroGroupItem, self)
	self.addEventCb(self, FightController.instance, FightEvent.RespBeginFight, self._respBeginFight, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupExitEffect, self._playHeroGroupExitEffect, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.PlayCloseHeroGroupAnimation, self._playCloseHeroGroupAnimation, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroup, self._onUseRecommendGroup, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, self._showGuideDragEffect, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.HeroMoveForward, self._heroMoveForward, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.StartFightFailed, self.handleStartFightFailed, self)
end

function Season123HeroGroupFightView:_checkReplay()
	local hasUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.star == DungeonEnum.StarType.Advanced and userDungeonMO.hasRecord
	local pass_model_record = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if hasUnlock and hasRecord and not string.nilorempty(pass_model_record) then
		pass_model_record = cjson.decode(pass_model_record)

		if pass_model_record[tostring(self._episodeId)] and not self._replayMode then
			self._replayMode = true

			self:_refreshBtns()

			self._replayFightGroupMO = HeroGroupModel.instance:getReplayParam()

			if not self._replayFightGroupMO then
				self.addEventCb(self, FightController.instance, FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
				FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)
			else
				self:_switchReplayGroup()
			end
		end
	end
end

function Season123HeroGroupFightView:initSeason123FightGroupDrop()
	local list = {}

	list = Season123HeroGroupModel.instance:isEpisodeSeason123() and {
		luaLang("season_herogroup_one"),
		luaLang("season_herogroup_two"),
		luaLang("season_herogroup_three"),
		luaLang("season_herogroup_four")
	} or {
		luaLang("season_herogroup_one")
	}

	self._dropseasonherogroup:ClearOptions()
	self._dropseasonherogroup:AddOptions(list)
end

function Season123HeroGroupFightView:_receiveRecommend(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, msg)
end

function Season123HeroGroupFightView:_onClickReplay()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		local desc, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightReplay)

		GameFacade.showToast(desc, param)

		return
	end

	if not HeroGroupModel.instance.episodeId then
		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.hasRecord
	local hasFirstBattle = episodeConfig and episodeConfig.firstBattleId > 0

	if not hasRecord and hasFirstBattle then
		GameFacade.showToast(ToastEnum.CantRecordReplay)

		return
	end

	if Season123Model.instance:isEpisodeAdvance(HeroGroupModel.instance.episodeId) and userDungeonMO.hasRecord then
		GameFacade.showToast(ToastEnum.SeasonAdvanceLevelNoReplay)

		return
	end

	if not hasRecord then
		GameFacade.showToast(ToastEnum.SeasonHeroGroupStarNoAdvanced)

		return
	end

	if self._replayMode then
		self._replayMode = false

		self._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)
	else
		self._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)

		self._replayMode = true
	end

	Season123HeroGroupModel.instance:saveMultiplication()
	self:_refreshBtns()

	if self._replayMode and not self._replayFightGroupMO then
		self.addEventCb(self, FightController.instance, FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
		FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)

		return
	end

	self:_switchReplayGroup(self._replayMode)
end

function Season123HeroGroupFightView:_switchReplayGroup(lastReplayMode)
	self:_refreshTips()
	gohelper.setActive(self._goreplayready, self._replayMode)
	UISpriteSetMgr.instance:setHeroGroupSprite(self._imagereplayicon, self._replayMode and "btn_replay_pause" or "btn_replay_play")

	if lastReplayMode ~= self._replayMode then
		TaskDispatcher.cancelTask(self._switchReplayMul, self)
		TaskDispatcher.runDelay(self._switchReplayMul, self, 0.1)
	else
		self:_switchReplayMul()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupHeroEffect, self._replayMode and "swicth" or "open")

	if self._replayMode then
		self:_updateReplayHeroGroupList()
	else
		Season123HeroGroupController.instance:changeReplayMode2Manual()
		self:_refreshCloth()
		gohelper.setActive(self._goherogroupcontain, false)
		gohelper.setActive(self._goherogroupcontain, true)
	end

	Season123Controller.instance:dispatchEvent(Season123Event.RecordRspMainCardRefresh)
end

function Season123HeroGroupFightView:_refreshTips()
	return
end

function Season123HeroGroupFightView:_updateReplayHeroGroupList()
	HeroGroupModel.instance:setReplayParam(self._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, self._replayFightGroupMO.id)
	self:_refreshCloth()
	gohelper.setActive(self._goherogroupcontain, false)
	gohelper.setActive(self._goherogroupcontain, true)
end

function Season123HeroGroupFightView:_switchReplayMul()
	self._txtreplaycount.text = self._replayMode and luaLang("multiple") .. Season123HeroGroupModel.instance.multiplication or ""
end

function Season123HeroGroupFightView:_heroMoveForward(heroId)
	HeroGroupEditListModel.instance:setMoveHeroId(tonumber(heroId))
end

function Season123HeroGroupFightView:handleStartFightFailed()
	self._blockStart = false

	UIBlockMgr.instance:endBlock(Season123HeroGroupFightView.UIBlock_SeasonFight)
end

function Season123HeroGroupFightView:isReplayMode()
	return self._replayMode
end

function Season123HeroGroupFightView:_onCurrencyChange(changeIds)
	if not changeIds[CurrencyEnum.CurrencyType.Power] then
		return
	end

	self:_refreshBtns()
end

function Season123HeroGroupFightView:_respBeginFight()
	gohelper.setActive(self._gomask, true)
end

function Season123HeroGroupFightView:_onOpenFullView(viewName)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
end

function Season123HeroGroupFightView:_onCloseView(viewName)
	if viewName == ViewName.EquipInfoTeamShowView then
		self:_checkFirstPosHasEquip()
	end
end

function Season123HeroGroupFightView:_getMultiplicationKey()
	return string.format("%s#%d", PlayerPrefsKey.Multiplication .. PlayerModel.instance:getMyUserId(), self._episodeId)
end

function Season123HeroGroupFightView:_updateRecommendEffect()
	gohelper.setActive(self._goRecommendEffect, FightFailRecommendController.instance:needShowRecommend(self._episodeId))
end

function Season123HeroGroupFightView:_onEscapeBtnClick()
	if not self._gomask.gameObject.activeInHierarchy then
		self.viewContainer:_closeCallback()
	end
end

function Season123HeroGroupFightView:_refreshUI()
	local heroGroupId = HeroGroupModel.instance:getCurGroupId()

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, heroGroupId)

	self._episodeId = HeroGroupModel.instance.episodeId
	self.episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	self._chapterConfig = DungeonConfig.instance:getChapterCO(self.episodeConfig.chapterId)

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		gohelper.setActive(self._btnrecommend, false)
	else
		gohelper.setActive(self._btnrecommend, true)
	end

	self:_refreshBtns()
	self:_refreshCloth()
end

function Season123HeroGroupFightView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	self:_removeEvents()
	ZProj.TweenHelper.KillById(self._tweeningId)
	TaskDispatcher.cancelTask(self._closeHeroContainAnim, self)

	if self._dragEffectLoader then
		self._dragEffectLoader:dispose()

		self._dragEffectLoader = nil
	end
end

function Season123HeroGroupFightView:_removeEvents()
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onModifySnapshot, self)
	self.removeEventCb(self, FightController.instance, FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
end

function Season123HeroGroupFightView:_refreshReplay()
	local showReplayBtn = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay)
	local replay_is_unlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)

	gohelper.setActive(self._btnseasonreplay.gameObject, self.episodeConfig and self.episodeConfig.canUseRecord == 1 and not self._replayMode)

	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.hasRecord

	ZProj.UGUIHelper.SetColorAlpha(self._imagereplaybg, replay_is_unlock and hasRecord and 1 or 0.75)

	self._txtreplaycount.text = self._replayMode and luaLang("multiple") .. Season123HeroGroupModel.instance.multiplication or ""

	UISpriteSetMgr.instance:setHeroGroupSprite(self._imagereplayicon, replay_is_unlock and hasRecord and "btn_replay_play" or "btn_replay_lack")
end

function Season123HeroGroupFightView:_refreshCloth()
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local clothShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)
	local cloth_id = curGroupMO.clothId
	local clothMO = PlayerClothModel.instance:getById(cloth_id)

	gohelper.setActive(self._txtclothname.gameObject, clothMO)

	if clothMO then
		local clothConfig = lua_cloth.configDict[clothMO.clothId]

		if not clothMO.level then
			self._txtclothname.text = clothConfig.name
			self._txtclothnameen.text = clothConfig.enname
		end
	end

	for _, clothCO in ipairs(lua_cloth.configList) do
		local icon = gohelper.findChild(self._iconGO, tostring(clothCO.id))

		if not gohelper.isNil(icon) then
			gohelper.setActive(icon, clothCO.id == cloth_id)
		end
	end

	gohelper.setActive(self._btncloth.gameObject, Season123HeroGroupFightView.showCloth())
end

function Season123HeroGroupFightView._getEpisodeConfigAndBattleConfig()
	local episodeCO = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local battleCO = episodeCO and lua_battle.configDict[episodeCO.battleId]

	return episodeCO, battleCO
end

function Season123HeroGroupFightView.showCloth()
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	local clothShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)

	if not clothShow then
		return false
	end

	local episodeCO, battleCO = Season123HeroGroupFightView._getEpisodeConfigAndBattleConfig()

	if battleCO and battleCO.noClothSkill == 1 then
		return false
	end

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local clothMO = PlayerClothModel.instance:getById(curGroupMO.clothId)
	local list = PlayerClothModel.instance:getList()
	local hasUnlock = false

	for _, clothMO in ipairs(list) do
		hasUnlock = true

		break
	end

	return hasUnlock
end

function Season123HeroGroupFightView:_onModifyHeroGroup()
	self:_refreshCloth()
end

function Season123HeroGroupFightView:_onModifySnapshot()
	self:_refreshCloth()
end

function Season123HeroGroupFightView:_onClickHeroGroupItem(id)
	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local equips = heroGroupMO:getPosEquips(id - 1).equipUid

	if heroGroupMO then
		HeroSingleGroupModel.instance:setSingleGroup(heroGroupMO, true)
	end

	if Season123HeroGroupModel.instance:isEpisodeSeason123() or Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
		self._param = tabletool.copy(self.viewParam)
		self._param.singleGroupMOId = id
		self._param.originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(id)
		self._param.equips = equips

		ViewMgr.instance:openView(Season123Controller.instance:getHeroGroupEditViewName(), self._param)
	else
		self._param = {}
		self._param.singleGroupMOId = id
		self._param.originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(id)
		self._param.adventure = HeroGroupModel.instance:isAdventureOrWeekWalk()
		self._param.equips = equips

		ViewMgr.instance:openView(ViewName.HeroGroupEditView, self._param)
	end
end

function Season123HeroGroupFightView:_checkFirstPosHasEquip()
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if not curGroupMO then
		return
	end

	local equips = curGroupMO:getPosEquips(0).equipUid
	local equipId = equips and equips[1]

	if equipId then
		::label_45_0::

		local equipMO = EquipModel.instance:getEquip(equipId)

		if equipMO then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFirstPosHasEquip)
		end
	end
end

function Season123HeroGroupFightView:_showGuideDragEffect(param)
	if self._dragEffectLoader then
		self._dragEffectLoader:dispose()

		self._dragEffectLoader = nil
	end

	local visible = tonumber(param) == 1

	if visible then
		self._dragEffectLoader = PrefabInstantiate.Create(self.viewGO)

		self._dragEffectLoader:startLoad("ui/viewres/guide/guide_herogroup.prefab")
	end
end

function Season123HeroGroupFightView:_onClickStart()
	local costs = string.split(self.episodeConfig.cost, "|")
	local cost1 = string.split(costs[1], "#")
	local value = tonumber((not cost1[3] or nil) and 0)
	local guideEpisodeId = 10104

	if HeroGroupModel.instance.episodeId == guideEpisodeId and not DungeonModel.instance:hasPassLevel(guideEpisodeId) then
		local list = HeroSingleGroupModel.instance:getList()
		local count = 0

		for i, v in ipairs(list) do
			if not v:isEmpty() then
				count = count + 1
			end
		end

		if count < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			return
		end
	end

	self:_enterFight()
end

function Season123HeroGroupFightView:_enterFight()
	if HeroGroupModel.instance.episodeId then
		self._closeWithEnteringFight = true

		local result = FightController.instance:setFightHeroGroup()

		if result then
			local fightParam = FightModel.instance:getFightParam()

			if self._replayMode then
				fightParam.isReplay = true
				fightParam.multiplication = Season123HeroGroupModel.instance.multiplication

				Season123HeroGroupController.instance:sendStartAct123Battle(fightParam.chapterId, fightParam.episodeId, fightParam, Season123HeroGroupModel.instance.multiplication, nil, true)
			else
				fightParam.isReplay = false
				fightParam.multiplication = 1

				Season123HeroGroupController.instance:sendStartAct123Battle(fightParam.chapterId, fightParam.episodeId, fightParam, 1)
			end

			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function Season123HeroGroupFightView:_onUseRecommendGroup()
	if self._replayMode then
		self._replayMode = false

		self:_refreshBtns()
		self:_switchReplayGroup()
	end
end

function Season123HeroGroupFightView:_refreshBtns()
	gohelper.setActive(self._goreplaybtn, self._replayMode)
	gohelper.setActive(self._dropseasonherogroup.gameObject, not self._replayMode)
	gohelper.setActive(self._gocost, self._replayMode)
	gohelper.setActive(self._btnseasonreplay, not self._replayMode)
	gohelper.setActive(self._btnstartseason, not self._replayMode)
	gohelper.setActive(self._btnstartseasonreplay, self._replayMode)
end

function Season123HeroGroupFightView:_onGetFightRecordGroupReply(fightGroupMO)
	self.removeEventCb(self, FightController.instance, FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
	Season123HeroGroupController.processReplayGroupMO(fightGroupMO)

	self._replayFightGroupMO = fightGroupMO

	if not self._replayMode then
		return
	end

	self:_switchReplayGroup()
	self:_updateReplayHeroGroup()
end

function Season123HeroGroupFightView:_updateReplayHeroGroup()
	HeroGroupModel.instance:setReplayParam(self._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, self._replayFightGroupMO.id)
	self:_refreshCloth()
	gohelper.setActive(self._goherogroupcontain, false)
	gohelper.setActive(self._goherogroupcontain, true)
	Season123Controller.instance:dispatchEvent(Season123Event.RecordRspMainCardRefresh)
end

function Season123HeroGroupFightView:_playHeroGroupExitEffect()
	self._anim:Play("close", 0, 0)
	self._btnContainAnim:Play("close", 0, 0)
end

function Season123HeroGroupFightView:_playCloseHeroGroupAnimation()
	self._anim:Play("close", 0, 0)
	self._btnContainAnim:Play("close", 0, 0)

	self._heroContainAnim.enabled = true

	self._heroContainAnim:Play("herogroupcontain_out", 0, 0)
	TaskDispatcher.runDelay(self._closeHeroContainAnim, self, 0.133)
end

function Season123HeroGroupFightView:_closeHeroContainAnim()
	if self._heroContainAnim then
		self._heroContainAnim.enabled = false
	end
end

return Season123HeroGroupFightView
