-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyHeroGroupView.lua

module("modules.logic.sp01.odyssey.view.OdysseyHeroGroupView", package.seeall)

local OdysseyHeroGroupView = class("OdysseyHeroGroupView", BaseView)

function OdysseyHeroGroupView:onInitView()
	self._btnclosemult = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closemult")
	self._btnenemy = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_enemy")
	self._btntalent = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_talent")
	self._gotalentLocked = gohelper.findChild(self.viewGO, "#btn_talent/locked")
	self._gotalentUnlock = gohelper.findChild(self.viewGO, "#btn_talent/unlock")
	self._gotalentReddot = gohelper.findChild(self.viewGO, "#btn_talent/unlock/#go_talentReddot")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._gotopbtns = gohelper.findChild(self.viewGO, "#go_container/#go_topbtns")
	self._btnRestraintInfo = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_topbtns/#btn_RestraintInfo")
	self._btnchangename = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/#btn_changename")
	self._btncloth = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/btnCloth")
	self._txtclothName = gohelper.findChildText(self.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName")
	self._txtclothNameEn = gohelper.findChildText(self.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName/#txt_clothNameEn")
	self._scrollSuit = gohelper.findChildScrollRect(self.viewGO, "#scroll_Suit")
	self._gosuit = gohelper.findChild(self.viewGO, "#scroll_Suit/Viewport/Content/#go_suit")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#scroll_Suit/Viewport/Content/#go_suit/#btn_click")
	self._btnunpowerstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/btnUnPowerStart")
	self._btnrecommend = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_topbtns/btn_recommend")
	self._dropherogroup = gohelper.findChildDropdown(self.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup")
	self._simagefullBg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_fullbg")

	self._dropherogroup:AddOnValueChanged(self._groupDropValueChanged, self)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyHeroGroupView:addEvents()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onModifyHeroGroup, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, self.onClickHeroGroupItem, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnStartDungeonExtraParams, self.onEnterFightSetParams, self)
	self.addEventCb(self, OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, self._onModifyHeroGroup, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.OnRefreshReddot, self.refreshReddot, self)
	self.addEventCb(self, FightController.instance, FightEvent.RespBeginFight, self._respBeginFight, self)
	self._btnclosemult:AddClickListener(self._btnclosemultOnClick, self)
	self._btnenemy:AddClickListener(self._btnenemyOnClick, self)
	self._btntalent:AddClickListener(self._btntalentOnClick, self)
	self._btnRestraintInfo:AddClickListener(self._btnRestraintInfoOnClick, self)
	self._btnchangename:AddClickListener(self._btnchangenameOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnunpowerstart:AddClickListener(self._btnunpowerstartOnClick, self)
	self._btnrecommend:AddClickListener(self._btnrecommendOnClick, self)
	self._btncloth:AddClickListener(self._btnclothOnClock, self)
end

function OdysseyHeroGroupView:removeEvents()
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, self.onClickHeroGroupItem, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onModifyHeroGroup, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnStartDungeonExtraParams, self.onEnterFightSetParams, self)
	self.removeEventCb(self, OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, self._onModifyHeroGroup, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.OnRefreshReddot, self.refreshReddot, self)
	self.removeEventCb(self, FightController.instance, FightEvent.RespBeginFight, self._respBeginFight, self)
	self._btnclosemult:RemoveClickListener()
	self._btnenemy:RemoveClickListener()
	self._btntalent:RemoveClickListener()
	self._btnRestraintInfo:RemoveClickListener()
	self._btnchangename:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self._btnunpowerstart:RemoveClickListener()
	self._btnrecommend:RemoveClickListener()
	self._btncloth:RemoveClickListener()
end

function OdysseyHeroGroupView:_btnclosemultOnClick()
	return
end

function OdysseyHeroGroupView:_btnenemyOnClick()
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(HeroGroupModel.instance.battleId)
end

function OdysseyHeroGroupView:_btntalentOnClick()
	local isUnlock = OdysseyTalentModel.instance:isTalentUnlock()

	if isUnlock == false then
		return
	end

	OdysseyController.instance:openTalentTreeView()
end

function OdysseyHeroGroupView:_btnRestraintInfoOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function OdysseyHeroGroupView:_btnchangenameOnClick()
	return
end

function OdysseyHeroGroupView:_btnclickOnClick()
	return
end

function OdysseyHeroGroupView:_btnunpowerstartOnClick()
	if self._heroGroupType == OdysseyEnum.HeroGroupType.Prepare then
		logError("编队模式不能进入战斗")

		return
	end

	if HeroGroupModel.instance.episodeId then
		local result = OdysseyDungeonController.instance:setFightHeroGroup()

		if result then
			local fightParam = FightModel.instance:getFightParam()

			fightParam.isReplay = false
			fightParam.multiplication = 1

			DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, 1)
			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function OdysseyHeroGroupView:_btnrecommendOnClick()
	return
end

function OdysseyHeroGroupView:_btnclothOnClock()
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

function OdysseyHeroGroupView:_respBeginFight()
	gohelper.setActive(self._gomask, true)
end

function OdysseyHeroGroupView:onClickHeroGroupItem(id)
	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local equips = heroGroupMO:getPosEquips(id - 1).equipUid
	local param = {}

	param.fight_param = FightParam.New()
	param.singleGroupMOId = id
	param.originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(id)
	param.equips = equips

	ViewMgr.instance:openView(ViewName.OdysseyHeroGroupEditView, param)
end

function OdysseyHeroGroupView:_editableInitView()
	self._gomask = gohelper.findChild(self.viewGO, "#go_container2/#go_mask")
	self._goherogroupcontain = gohelper.findChild(self.viewGO, "herogroupcontain")
	self._iconGO = self:getResInst(self.viewContainer:getSetting().otherRes[1], self._btncloth.gameObject)

	recthelper.setAnchor(self._iconGO.transform, -100, 1)
	gohelper.setActive(self._gomask, false)
end

function OdysseyHeroGroupView:onUpdateParam()
	return
end

function OdysseyHeroGroupView:onOpen()
	local viewParam = self.viewParam
	local heroGroupType

	if viewParam == nil then
		heroGroupType = OdysseyEnum.HeroGroupType.Fight
		self._episodeId = HeroGroupModel.instance.episodeId
		self.episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)
		self._chapterConfig = DungeonConfig.instance:getChapterCO(self.episodeConfig.chapterId)
		heroGroupType = OdysseyEnum.HeroGroupType.Fight
	else
		heroGroupType = viewParam.heroGroupType ~= nil and viewParam.heroGroupType or OdysseyEnum.HeroGroupType.Prepare
	end

	self._heroGroupType = heroGroupType

	HeroGroupModel.instance:setHeroGroupType(heroGroupType)

	local groupHeroMo = HeroGroupModel.instance:getCurGroupMO()

	HeroGroupTrialModel.instance:setTrialByOdysseyGroupMo(groupHeroMo)
	self:initState()
	self:_initFightGroupDrop()
	self:_refreshCloth()
	self:_refreshTalentState()
	self:refreshReddot()
	OdysseyStatHelper.instance:initViewStartTime()
	NavigateMgr.instance:addEscape(self.viewName, self._onEscapeBtnClick, self)
end

function OdysseyHeroGroupView:initState()
	local isFight = self._heroGroupType == OdysseyEnum.HeroGroupType.Fight

	gohelper.setActive(self._btnenemy, isFight)
	gohelper.setActive(self._btnrecommend, false)
	gohelper.setActive(self._btnunpowerstart, isFight)
	gohelper.setActive(self._btnRestraintInfo, false)
	gohelper.setActive(self._simagefullBg, not isFight)
end

function OdysseyHeroGroupView:_refreshTalentState()
	local isUnlock = OdysseyTalentModel.instance:isTalentUnlock()

	gohelper.setActive(self._btntalent.gameObject, isUnlock)
	gohelper.setActive(self._gotalentLocked, not isUnlock)
	gohelper.setActive(self._gotalentUnlock, isUnlock)
end

function OdysseyHeroGroupView:_refreshCloth()
	local clothShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local cloth_id = curGroupMO.clothId

	cloth_id = PlayerClothModel.instance:getSpEpisodeClothID() or cloth_id

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

	gohelper.setActive(self._btncloth.gameObject, OdysseyHeroGroupView.showCloth())
end

function OdysseyHeroGroupView._getEpisodeConfigAndBattleConfig()
	local episodeCO = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local battleCO

	return episodeCO, HeroGroupModel.instance.battleId and HeroGroupModel.instance.battleId > 0 and lua_battle.configDict[HeroGroupModel.instance.battleId] or DungeonConfig.instance:getBattleCo(HeroGroupModel.instance.episodeId)
end

function OdysseyHeroGroupView.showCloth()
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	local clothShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)

	if not clothShow then
		return false
	end

	local episodeCO, battleCO = OdysseyHeroGroupView._getEpisodeConfigAndBattleConfig()

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

function OdysseyHeroGroupView:_checkEquipClothSkill()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(curGroupMO.clothId) then
		return
	end

	local list = PlayerClothModel.instance:getList()

	for _, clothMO in ipairs(list) do
		if PlayerClothModel.instance:hasCloth(clothMO.id) then
			HeroGroupModel.instance:replaceCloth(clothMO.id)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
			HeroGroupModel.instance:saveCurGroupData()

			break
		end
	end
end

function OdysseyHeroGroupView:_onEscapeBtnClick()
	if not self._gomask.gameObject.activeInHierarchy then
		self.viewContainer:_closeCallback()
	end
end

function OdysseyHeroGroupView:_initFightGroupDrop()
	local list = {}

	for i = 1, 4 do
		list[i] = OdysseyHeroGroupModel.instance:getCommonGroupName(i)
	end

	local selectIndex = OdysseyHeroGroupModel.instance:getCurIndex()

	gohelper.setActive(self._btnchangename, false)
	self._dropherogroup:ClearOptions()
	self._dropherogroup:AddOptions(list)
	self._dropherogroup:SetValue(selectIndex - 1)
end

function OdysseyHeroGroupView:_groupDropValueChanged(value)
	local selectIndex = value + 1

	if OdysseyHeroGroupModel.instance:canSwitchHeroGroupSelectIndex(selectIndex) then
		OdysseyHeroGroupController.instance:switchHeroGroup(selectIndex, self.onSwitchHeroGroup, self)
	end
end

function OdysseyHeroGroupView:onSwitchHeroGroup()
	GameFacade.showToast(self._changeToastId or ToastEnum.SeasonGroupChanged)
	HeroGroupModel.instance:setHeroGroupSelectIndex()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	gohelper.setActive(self._goherogroupcontain, false)
	gohelper.setActive(self._goherogroupcontain, true)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupSelectIndex)
end

function OdysseyHeroGroupView:_onModifyHeroGroup()
	self:_refreshCloth()
end

function OdysseyHeroGroupView:onEnterFightSetParams(req, episodeConfig)
	if episodeConfig and episodeConfig.type == DungeonEnum.EpisodeType.Odyssey then
		req.params = tostring(OdysseyDungeonModel.instance:getCurInElementId())
	end
end

function OdysseyHeroGroupView:refreshReddot()
	local isHasNotUseTalentPoint = OdysseyTalentModel.instance:checkHasNotUsedTalentPoint()

	gohelper.setActive(self._gotalentReddot, isHasNotUseTalentPoint)
end

function OdysseyHeroGroupView:onClose()
	self._dropherogroup:RemoveOnValueChanged()
	OdysseyStatHelper.instance:sendOdysseyViewStayTime("OdysseyHeroGroupView")
	HeroSingleGroupModel.instance:setMaxHeroCount()
	HeroGroupTrialModel.instance:clear()
end

function OdysseyHeroGroupView:onDestroyView()
	return
end

return OdysseyHeroGroupView
