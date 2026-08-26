-- chunkname: @modules/logic/seasonver/act166/view2_6/Season166_2_6HeroGroupFightView.lua

module("modules.logic.seasonver.act166.view2_6.Season166_2_6HeroGroupFightView", package.seeall)

local Season166_2_6HeroGroupFightView = class("Season166_2_6HeroGroupFightView", BaseView)

function Season166_2_6HeroGroupFightView:onInitView()
	self._btnassist = gohelper.findChildButtonWithAudio(self.viewGO, "btnContain/horizontal/#btn_assist")
	self._goassist = gohelper.findChild(self.viewGO, "btnContain/horizontal/#btn_assist/#go_assist")
	self._gocancelAssist = gohelper.findChild(self.viewGO, "btnContain/horizontal/#btn_assist/#go_cancelAssist")
	self._gofullAssist = gohelper.findChild(self.viewGO, "btnContain/horizontal/#btn_assist/#go_fullAssist")
	self._btnstartseason = gohelper.findChildButtonWithAudio(self.viewGO, "btnContain/horizontal/#btn_startseason")
	self._btncloth = gohelper.findChildButtonWithAudio(self.viewGO, "btnContain/#btn_cloth")
	self._txtclothName = gohelper.findChildText(self.viewGO, "btnContain/#btn_cloth/#txt_clothName")
	self._txtclothNameEn = gohelper.findChildText(self.viewGO, "btnContain/#btn_cloth/#txt_clothName/#txt_clothNameEn")
	self._btntalentTree = gohelper.findChildButtonWithAudio(self.viewGO, "btnContain/#btn_talentTree")
	self._btntalentInfo = gohelper.findChildButtonWithAudio(self.viewGO, "btnContain/#btn_talentTree/#btn_talentInfo")
	self._btntalentTreeAdd = gohelper.findChildButtonWithAudio(self.viewGO, "btnContain/#btn_talentTreeAdd")
	self._imageTalent = gohelper.findChildImage(self.viewGO, "btnContain/#btn_talentTree/#image_talen")
	self._goEquipSlot = gohelper.findChild(self.viewGO, "btnContain/#btn_talentTree/equipslot")
	self._gotalentReddot = gohelper.findChild(self.viewGO, "btnContain/#btn_talentTree/#go_talentReddot")
	self._gomainFrameBg = gohelper.findChild(self.viewGO, "frame/#go_mainFrameBg")
	self._gohelpFrameBg = gohelper.findChild(self.viewGO, "frame/#go_helpFrameBg")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._goruleWindow = gohelper.findChild(self.viewGO, "#go_rulewindow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166_2_6HeroGroupFightView:addEvents()
	self._btnassist:AddClickListener(self._btnassistOnClick, self)
	self._btnstartseason:AddClickListener(self._btnstartseasonOnClick, self)
	self._btncloth:AddClickListener(self._btnclothOnClick, self)
	self._btntalentTree:AddClickListener(self._btntalentTreeOnClick, self)
	self._btntalentTreeAdd:AddClickListener(self._btntalentTreeOnClick, self)
	self._btntalentInfo:AddClickListener(self._btntalentInfoOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullView, self._onOpenFullView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onModifyHeroGroup, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, self._onClickHeroGroupItem, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, self._showGuideDragEffect, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.StartFightFailed, self.handleStartFightFailed, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.OnSelectPickAssist, self.refreshAssistBtn, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self.refreshAssistBtn, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.SetTalentId, self._onTalentChange, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.SetTalentSkill, self._onTalentSkillChange, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.checkOneActivityIsEnd, self)
end

function Season166_2_6HeroGroupFightView:removeEvents()
	self._btnassist:RemoveClickListener()
	self._btnstartseason:RemoveClickListener()
	self._btncloth:RemoveClickListener()
	self._btntalentTree:RemoveClickListener()
	self._btntalentTreeAdd:RemoveClickListener()
	self._btntalentInfo:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullView, self._onOpenFullView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onModifyHeroGroup, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, self._onClickHeroGroupItem, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, self._showGuideDragEffect, self)
	self.removeEventCb(self, Season166Controller.instance, Season166Event.StartFightFailed, self.handleStartFightFailed, self)
	self.removeEventCb(self, Season166Controller.instance, Season166Event.OnSelectPickAssist, self.refreshAssistBtn, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self.refreshAssistBtn, self)
	self.removeEventCb(self, Season166Controller.instance, Season166Event.SetTalentId, self._onTalentChange, self)
	self.removeEventCb(self, Season166Controller.instance, Season166Event.SetTalentSkill, self._onTalentSkillChange, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.checkOneActivityIsEnd, self)
end

function Season166_2_6HeroGroupFightView:_btnassistOnClick()
	if self.assistMO then
		Season166HeroGroupModel.instance:cleanAssistData()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	elseif self.isFullHero then
		GameFacade.showToast(ToastEnum.Season166HeroGroupFull)
	elseif not self.isHasAssist then
		Season166Controller.instance:dispatchEvent(Season166Event.OpenPickAssistView)
	end
end

Season166_2_6HeroGroupFightView.UIBlock_SeasonFight = "UIBlock_Season166Fight"

function Season166_2_6HeroGroupFightView:_btnstartseasonOnClick()
	if not self._blockStart then
		self._blockStart = true

		self:_onClickStart()
	end
end

function Season166_2_6HeroGroupFightView:_btnclothOnClick()
	local clothUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill)

	if clothUnlock or PlayerClothModel.instance:getSpEpisodeClothID() then
		ViewMgr.instance:openView(ViewName.PlayerClothView, {
			groupModel = Season166HeroGroupModel.instance
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function Season166_2_6HeroGroupFightView:_btntalentTreeOnClick()
	local talentId
	local isSpotEpisode = Season166HeroGroupModel.instance:isSeason166BaseSpotEpisode(self.episodeId)
	local viewParam = {
		showEquip = true,
		talentId = (isSpotEpisode or nil) and self.baseSpotTalentId
	}

	ViewMgr.instance:openView(ViewName.Season166TalentView, viewParam)
end

function Season166_2_6HeroGroupFightView:_btntalentInfoOnClick()
	Season166Controller.instance:openTalentInfoView()
end

function Season166_2_6HeroGroupFightView:_onEscapeBtnClick()
	if not self._goruleWindow.activeInHierarchy then
		self.viewContainer:_closeCallback()
	end
end

function Season166_2_6HeroGroupFightView:_editableInitView()
	NavigateMgr.instance:addEscape(ViewName.Season166HeroGroupFightView, self._onEscapeBtnClick, self)

	self._iconGO = self:getResInst(self.viewContainer:getSetting().otherRes[1], self._btncloth.gameObject)

	recthelper.setAnchor(self._iconGO.transform, -100, 1)

	self.talentSlotTab = self:getUserDataTb_()

	for i = 1, 3 do
		local talentSlotItem = {}

		talentSlotItem.item = gohelper.findChild(self._goEquipSlot, i)
		talentSlotItem.light = gohelper.findChild(talentSlotItem.item, "light")
		talentSlotItem.imageLight = gohelper.findChildImage(talentSlotItem.item, "light")
		talentSlotItem.lineLight = gohelper.findChild(talentSlotItem.item, "line_light")
		talentSlotItem.lineDark = gohelper.findChild(talentSlotItem.item, "line_dark")
		talentSlotItem.effect1 = gohelper.findChild(talentSlotItem.item, "light/qi1")
		talentSlotItem.effect2 = gohelper.findChild(talentSlotItem.item, "light/qi2")
		talentSlotItem.effect3 = gohelper.findChild(talentSlotItem.item, "light/qi3")
		self.talentSlotTab[i] = talentSlotItem
	end
end

function Season166_2_6HeroGroupFightView:onUpdateParam()
	return
end

function Season166_2_6HeroGroupFightView:onOpen()
	self:initData()
	self:_checkFirstPosHasEquip()
	self:_checkEquipClothSkill()
	self:refreshUI()
	self:refreshTalent()
	self:refreshTalentReddot()
	self:setFightTalentParam()
end

function Season166_2_6HeroGroupFightView:initData()
	self.actId = self.viewParam.actId
	self.episodeId = self.viewParam.episodeId or Season166HeroGroupModel.instance.episodeId
	self.episodeConfig = DungeonConfig.instance:getEpisodeCO(self.episodeId)
	self.battleId = self.viewParam.battleId or self.episodeConfig.battleId
	self.battleConfig = self.battleId and lua_battle.configDict[self.episodeConfig.battleId]

	Season166HeroGroupController.instance:onOpenViewInitData(self.actId, self.episodeId)

	self.maxHeroCount = Season166HeroGroupModel.instance:getMaxHeroCountInGroup()
	self.isTrainEpisode = Season166HeroGroupModel.instance:isSeason166TrainEpisode(self.episodeId)
	self.baseSpotTalentId = self:getBaseSpotTalentId()
end

function Season166_2_6HeroGroupFightView:getBaseSpotTalentId()
	local talentId
	local baseCfgList = lua_activity166_base.configList

	for _, cfg in pairs(baseCfgList) do
		if cfg.episodeId == self.episodeId then
			talentId = cfg.talentId
		end
	end

	return talentId
end

function Season166_2_6HeroGroupFightView:refreshUI()
	self:refreshCloth()
	self:refreshAssistBtn()

	self.context = Season166Model.instance:getBattleContext()

	gohelper.setActive(self._btntalentTree.gameObject, not self.context.teachId)
end

function Season166_2_6HeroGroupFightView:refreshCloth()
	local canShowCloth = self:getShowClothState()

	gohelper.setActive(self._btncloth.gameObject, canShowCloth)

	if not canShowCloth then
		return
	end

	local curGroupMO = Season166HeroGroupModel.instance:getCurGroupMO()
	local cloth_id = curGroupMO.clothId
	local clothMO = PlayerClothModel.instance:getById(cloth_id)

	gohelper.setActive(self._txtclothName.gameObject, clothMO)

	if clothMO then
		local clothConfig = lua_cloth.configDict[clothMO.clothId]

		if not clothMO.level then
			self._txtclothName.text = clothConfig.name
			self._txtclothNameEn.text = clothConfig.enname
		end
	end

	for _, clothCO in ipairs(lua_cloth.configList) do
		local icon = gohelper.findChild(self._iconGO, tostring(clothCO.id))

		if not gohelper.isNil(icon) then
			gohelper.setActive(icon, clothCO.id == cloth_id)
		end
	end
end

function Season166_2_6HeroGroupFightView:refreshAssistBtn()
	gohelper.setActive(self._btnassist.gameObject, self.isTrainEpisode)

	if not self.isTrainEpisode then
		return
	end

	local heroCount = self:getCurHeroCount()

	self.isFullHero = heroCount == self.maxHeroCount
	self.assistMO = Season166HeroSingleGroupModel.instance.assistMO

	gohelper.setActive(self._goassist, not self.assistMO and not self.isFullHero)
	gohelper.setActive(self._gocancelAssist, self.assistMO)
	gohelper.setActive(self._gofullAssist, not self.assistMO and self.isFullHero)
end

function Season166_2_6HeroGroupFightView:getCurHeroCount()
	local heroCount = 0
	local curHeroGroup = Season166HeroGroupModel.instance:getCurGroupMO()
	local heroList = curHeroGroup.heroList

	for index, heroUId in ipairs(heroList) do
		if heroUId ~= "0" then
			heroCount = heroCount + 1
		end
	end

	return heroCount
end

function Season166_2_6HeroGroupFightView:getShowClothState()
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	local clothShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)

	if not clothShow then
		return false
	end

	if self.battleConfig and self.battleConfig.noClothSkill == 1 then
		return false
	end

	local list = PlayerClothModel.instance:getList()

	return tabletool.len(list) > 0
end

function Season166_2_6HeroGroupFightView:_onClickStart()
	local guideEpisodeId = 10104

	if Season166HeroGroupModel.instance.episodeId == guideEpisodeId and not DungeonModel.instance:hasPassLevel(guideEpisodeId) then
		local list = Season166HeroSingleGroupModel.instance:getList()
		local count = 0

		for i, v in ipairs(list) do
			if not v:isEmpty() then
				count = count + 1
			end
		end

		if count < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			self._blockStart = false

			return
		end
	end

	self:_enterFight()
end

function Season166_2_6HeroGroupFightView:_enterFight()
	local context = Season166Model.instance:getBattleContext()
	local talentId = context.talentId

	if not talentId then
		GameFacade.showToast(ToastEnum.Season166TalentEmpty)

		self._blockStart = false

		return
	end

	if Season166HeroGroupModel.instance.episodeId then
		local result = self:setFightHeroGroup()

		if result then
			UIBlockMgr.instance:startBlock(Season166_2_6HeroGroupFightView.UIBlock_SeasonFight)

			local fightParam = FightModel.instance:getFightParam()
			local configId = Season166HeroGroupModel.instance:getEpisodeConfigId(fightParam.episodeId)

			Season166HeroGroupController.instance:sendStartAct166Battle(configId, fightParam.chapterId, fightParam.episodeId, talentId, fightParam, 1)
		end
	else
		logError("没选中关卡，无法开始战斗")

		self._blockStart = false
	end
end

function Season166_2_6HeroGroupFightView:setFightHeroGroup()
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return false
	end

	local curGroupMO = Season166HeroGroupModel.instance:getCurGroupMO()

	if not curGroupMO then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		self._blockStart = false

		return false
	end

	local main, mainCount = curGroupMO:getMainList()
	local sub, subCount = curGroupMO:getSubList()
	local alreadyList = Season166HeroSingleGroupModel.instance:getList()
	local equips = curGroupMO:getAllHeroEquips()

	for i = 1, #main do
		if main[i] ~= alreadyList[i].heroUid then
			main[i] = "0"
			mainCount = mainCount - 1

			if equips[i] then
				equips[i].heroUid = "0"
			end
		end
	end

	for i = #main + 1, math.min(#main + #sub, #alreadyList) do
		if sub[i - #main] ~= alreadyList[i].heroUid then
			sub[i - #main] = "0"
			subCount = subCount - 1

			if equips[i] then
				equips[i].heroUid = "0"
			end
		end
	end

	if (not curGroupMO.aidDict or #curGroupMO.aidDict <= 0) and mainCount + subCount == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		self._blockStart = false

		return false
	end

	local battleId = fightParam.battleId
	local battleConfig = battleId and lua_battle.configDict[battleId]

	if battleConfig and battleConfig.noClothSkill == 0 then
		if not curGroupMO.clothId then
			local clothId = 0

			fightParam:setMySide(clothId, main, sub, curGroupMO:getAllHeroEquips())

			return true
		end
	end
end

function Season166_2_6HeroGroupFightView:_checkFirstPosHasEquip()
	local curGroupMO = Season166HeroGroupModel.instance:getCurGroupMO()

	if not curGroupMO then
		return
	end

	local equips = curGroupMO:getPosEquips(0).equipUid
	local equipId = equips and equips[1]

	if equipId then
		::label_23_0::

		local equipMO = EquipModel.instance:getEquip(equipId)

		if equipMO then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFirstPosHasEquip)
		end
	end
end

function Season166_2_6HeroGroupFightView:_checkEquipClothSkill()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local curGroupMO = Season166HeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(curGroupMO.clothId) then
		return
	end

	local list = PlayerClothModel.instance:getList()

	for _, clothMO in ipairs(list) do
		if PlayerClothModel.instance:hasCloth(clothMO.id) then
			Season166HeroGroupModel.instance:replaceCloth(clothMO.id)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
			Season166HeroGroupModel.instance:saveCurGroupData()

			break
		end
	end
end

function Season166_2_6HeroGroupFightView:_onOpenFullView(viewName)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
end

function Season166_2_6HeroGroupFightView:_onCloseView(viewName)
	if viewName == ViewName.EquipInfoTeamShowView then
		self:_checkFirstPosHasEquip()
	end

	if viewName == ViewName.Season166TalentView then
		self:refreshTalentReddot()
	end
end

function Season166_2_6HeroGroupFightView:_onModifyHeroGroup()
	self:refreshCloth()
	self:refreshAssistBtn()
end

function Season166_2_6HeroGroupFightView:_onClickHeroGroupItem(id)
	local heroGroupMO = Season166HeroGroupModel.instance:getCurGroupMO()
	local equips = heroGroupMO:getPosEquips(id - 1).equipUid

	self._param = tabletool.copy(self.viewParam)
	self._param.singleGroupMOId = id
	self._param.originalHeroUid = Season166HeroSingleGroupModel.instance:getHeroUid(id)
	self._param.equips = equips

	ViewMgr.instance:openView(ViewName.Season166HeroGroupEditView, self._param)
end

function Season166_2_6HeroGroupFightView:_showGuideDragEffect(param)
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

function Season166_2_6HeroGroupFightView:handleStartFightFailed()
	self._blockStart = false

	UIBlockMgr.instance:endBlock(Season166_2_6HeroGroupFightView.UIBlock_SeasonFight)
end

function Season166_2_6HeroGroupFightView:_onTalentChange(talentId)
	local context = Season166Model.instance:getBattleContext()

	if context then
		context.talentId = talentId
		self.newTalentId = talentId

		self:_onTalentSkillChange()
	end
end

function Season166_2_6HeroGroupFightView:_onTalentSkillChange()
	self:refreshTalentReddot()
	self:refreshTalent()
	self:setFightTalentParam()
end

function Season166_2_6HeroGroupFightView:refreshTalent()
	local var_33_0 = self.baseSpotTalentId

	if not self.baseSpotTalentId then
		var_33_0 = self.newTalentId

		if not self.newTalentId then
			local talentId = Season166Model.getPrefsTalent()

			if not talentId then
				gohelper.setActive(self._btntalentTreeAdd.gameObject, not self.context.teachId)
				gohelper.setActive(self._btntalentTree.gameObject, false)

				return
			end

			gohelper.setActive(self._btntalentTreeAdd.gameObject, false)
			gohelper.setActive(self._btntalentTree.gameObject, not self.context.teachId)

			local talentMO = Season166Model.instance:getTalentInfo(self.actId, talentId)
			local talentId = talentMO.config.talentId
			local talentConfig = lua_activity166_talent.configDict[self.actId][talentId]

			UISpriteSetMgr.instance:setSeason166Sprite(self._imageTalent, "season166_talentree_btn_talen" .. talentConfig.sortIndex, true)

			local talentSlotCount = talentMO.config.slot
			local talentEuipCount = #talentMO.skillIds

			for index, talentSlotItem in ipairs(self.talentSlotTab) do
				gohelper.setActive(talentSlotItem.item, index <= talentSlotCount)
				gohelper.setActive(talentSlotItem.light, index <= talentEuipCount)
				gohelper.setActive(talentSlotItem.lineLight, index > 1 and index <= talentEuipCount)
				gohelper.setActive(talentSlotItem.lineDark, index > 1 and talentEuipCount < index)
				UISpriteSetMgr.instance:setSeason166Sprite(talentSlotItem.imageLight, "season166_talentree_pointl" .. tostring(talentConfig.sortIndex))

				for i = 1, 3 do
					gohelper.setActive(talentSlotItem["effect" .. i], talentConfig.sortIndex == i)
				end
			end
		end
	end
end

function Season166_2_6HeroGroupFightView:setFightTalentParam()
	local var_34_0 = self.baseSpotTalentId

	if not self.baseSpotTalentId then
		var_34_0 = self.newTalentId

		if not self.newTalentId then
			local talentId = Season166Model.getPrefsTalent()

			if not talentId then
				return
			end

			gohelper.setActive(self._btntalentInfo.gameObject, talentId and talentId > 0)

			local talentMO = Season166Model.instance:getTalentInfo(self.actId, talentId)

			if talentMO then
				if not talentMO.skillIds then
					local talentSkillIds = {}

					if talentMO then
						if not talentMO.level then
							local talentLevel = 1

							Season166Model.instance:setFightTalentParam(talentId, talentSkillIds, talentLevel)
						end
					end
				end
			end
		end
	end
end

function Season166_2_6HeroGroupFightView:refreshTalentReddot()
	RedDotController.instance:addRedDot(self._gotalentReddot, RedDotEnum.DotNode.Season166TalentEnter, nil, self.checkTalentReddotShow, self)
end

function Season166_2_6HeroGroupFightView:checkTalentReddotShow(redDotIcon)
	redDotIcon:defaultRefreshDot()

	local var_36_0 = self.baseSpotTalentId

	if not self.baseSpotTalentId then
		var_36_0 = self.newTalentId

		if not self.newTalentId then
			local talentId = Season166Model.getPrefsTalent()

			if not talentId and not redDotIcon.show then
				redDotIcon.show = Season166Model.instance:checkAllHasNewTalent(self.actId)

				redDotIcon:showRedDot(RedDotEnum.Style.Green)

				return
			end

			redDotIcon.show = Season166Model.instance:checkHasNewTalent(talentId)

			if redDotIcon.show then
				redDotIcon:showRedDot(RedDotEnum.Style.Green)
			end
		end
	end
end

function Season166_2_6HeroGroupFightView:checkOneActivityIsEnd()
	local endTime, offsetSecond = Season166Controller.instance:getSeasonEnterCloseTimeStamp(self.actId)

	if endTime == 0 or offsetSecond <= 0 then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)
	end
end

function Season166_2_6HeroGroupFightView:onClose()
	if self._dragEffectLoader then
		self._dragEffectLoader:dispose()

		self._dragEffectLoader = nil
	end
end

function Season166_2_6HeroGroupFightView:onDestroyView()
	Season166HeroGroupController.instance:onCloseViewCleanData()
	UIBlockMgr.instance:endBlock(Season166_2_6HeroGroupFightView.UIBlock_SeasonFight)
end

return Season166_2_6HeroGroupFightView
