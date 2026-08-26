-- chunkname: @modules/logic/towercompose/view/herogroup/TowerComposeHeroGroupView.lua

module("modules.logic.towercompose.view.herogroup.TowerComposeHeroGroupView", package.seeall)

local TowerComposeHeroGroupView = class("TowerComposeHeroGroupView", BaseView)

function TowerComposeHeroGroupView:onInitView()
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "#go_container/#scroll_info")
	self._scrollplaneInfo = gohelper.findChildScrollRect(self.viewGO, "#go_container/#scroll_planeInfo")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/btnStart")
	self._gonormalPlane = gohelper.findChild(self.viewGO, "#go_herogroupcontain/#go_normalPlane")
	self._gostarList = gohelper.findChild(self.viewGO, "#go_heroitem/heroitemani/hero/vertical/#go_starList")
	self._gorecommended = gohelper.findChild(self.viewGO, "#go_heroitem/heroitemani/hero/#go_recommended")
	self._gocounter = gohelper.findChild(self.viewGO, "#go_heroitem/heroitemani/hero/#go_counter")
	self._txttrialtag = gohelper.findChildText(self.viewGO, "#go_heroitem/heroitemani/tags/trialtag/#txt_trial_tag")
	self._gomojing = gohelper.findChild(self.viewGO, "#go_heroitem/heroitemani/#go_mojing")
	self._txt = gohelper.findChildText(self.viewGO, "#go_heroitem/heroitemani/#go_mojing/#txt")
	self._gocontainer2 = gohelper.findChild(self.viewGO, "#go_container2")
	self._gomask = gohelper.findChild(self.viewGO, "#go_container2/#go_mask")
	self._gotrialTips = gohelper.findChild(self.viewGO, "#go_container/trialContainer/#go_trialTips")
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/trialContainer/#go_trialTips/#btn_tips")
	self._gotipsbg = gohelper.findChild(self.viewGO, "#go_container/trialContainer/#go_trialTips/#go_tipsbg")
	self._gotipsitem = gohelper.findChild(self.viewGO, "#go_container/trialContainer/#go_trialTips/#go_tipsbg/#go_tipsitem")
	self._btncloth = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/#btnCloth")
	self._goPlane1 = gohelper.findChild(self.viewGO, "#go_herogroupcontain2/go_team1/#go_plane1")
	self._goPlaneLock1 = gohelper.findChild(self.viewGO, "#go_herogroupcontain2/go_team1/#go_planeLock1")
	self._goPlane2 = gohelper.findChild(self.viewGO, "#go_herogroupcontain2/go_team2/#go_plane2")
	self._goPlaneLock2 = gohelper.findChild(self.viewGO, "#go_herogroupcontain2/go_team2/#go_planeLock2")
	self._btncloth1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_herogroupcontain2/go_team1/#btn_cloth1")
	self._btncloth2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_herogroupcontain2/go_team2/#btn_cloth2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeHeroGroupView:addEvents()
	self._btntips:AddClickListener(self._btntipsOnClick, self)
	self._btnStart:AddClickListener(self._btnStartOnClick, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, self._onClickHeroGroupItem, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.HeroGroupSelectBuff, self.refreshPlaneBuffSlot, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self.refreshPlaneBuffSlot, self)
	self.addEventCb(self, FightController.instance, FightEvent.RespBeginFight, self._respBeginFight, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.TowerComposeSelectCloth, self.refreshPlayerClothSlot, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onDeleteEquip, self.onEquipChange, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.LoadRecordReply, self.loadRecordReply, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshLoadState, self.refreshUI, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshAssistState, self.refreshPlaneBuffSlot, self)
end

function TowerComposeHeroGroupView:removeEvents()
	self._btntips:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, self._onClickHeroGroupItem, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.HeroGroupSelectBuff, self.refreshPlaneBuffSlot, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self.refreshPlaneBuffSlot, self)
	self.removeEventCb(self, FightController.instance, FightEvent.RespBeginFight, self._respBeginFight, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.TowerComposeSelectCloth, self.refreshPlayerClothSlot, self)
	self.removeEventCb(self, EquipController.instance, EquipEvent.onDeleteEquip, self.onEquipChange, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.LoadRecordReply, self.loadRecordReply, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshLoadState, self.refreshUI, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshAssistState, self.refreshPlaneBuffSlot, self)
end

function TowerComposeHeroGroupView:_btntipsOnClick()
	gohelper.setActive(self._gotipsbg, not self._gotipsbg.activeSelf)

	self._clickTrialFrame = UnityEngine.Time.frameCount
end

function TowerComposeHeroGroupView:_onEscapeBtnClick()
	if not self._gomask.gameObject.activeInHierarchy then
		self.viewContainer:_closeCallback()
	end
end

function TowerComposeHeroGroupView:_btnStartOnClick()
	if self.episodeId then
		local isEmpty, planeId = self:checkPlaneHeroGroupEmpty()

		if isEmpty then
			local episodeConfig = DungeonConfig.instance:getEpisodeCO(self.towerEpisodeConfig.episodeId)
			local planeName = luaLang("towercompose_plane" .. planeId) or ""

			GameFacade.showToast(ToastEnum.TowerComposeHeroGroupEmpty, episodeConfig.name, planeName)

			return
		end

		TowerComposeController.instance:startDungeonRequest()
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function TowerComposeHeroGroupView:_btnclothOnClock(playerClothItem)
	local clothUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill)

	if clothUnlock or PlayerClothModel.instance:getSpEpisodeClothID() then
		local param = {}

		param.planeId = playerClothItem.planeId
		param.useCallback = self.refreshPlayerClothSlot
		param.useCallbackObj = self
		param.towerEpisodeConfig = self.towerEpisodeConfig

		ViewMgr.instance:openView(ViewName.TowerComposePlayerClothView, param)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function TowerComposeHeroGroupView:_respBeginFight()
	gohelper.setActive(self._gomask, true)
end

function TowerComposeHeroGroupView:_editableInitView()
	gohelper.setActive(self._gocontainer2, true)
	gohelper.setActive(self._gomask, false)

	self.planeSlotItemMap = self:getUserDataTb_()
	self.playerClothItemMap = self:getUserDataTb_()
	self._playerClothIconGO = self:getResInst(self.viewContainer:getSetting().otherRes[1], self._btncloth.gameObject)

	recthelper.setAnchor(self._playerClothIconGO.transform, -100, 1)

	for planeId = 1, 2 do
		self["_playerClothIconGO" .. planeId] = self:getResInst(self.viewContainer:getSetting().otherRes[1], self["_btncloth" .. planeId].gameObject)

		recthelper.setAnchor(self["_playerClothIconGO" .. planeId].transform, -100, 1)
	end
end

function TowerComposeHeroGroupView:onUpdateParam()
	return
end

function TowerComposeHeroGroupView:onOpen()
	self.recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	self.themeId = self.recordFightParam.themeId
	self.layerId = self.recordFightParam.layerId
	self.towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(self.themeId, self.layerId)
	self.dungeonEpisodeCo = DungeonConfig.instance:getEpisodeCO(self.towerEpisodeConfig.episodeId)
	self.episodeId = self.towerEpisodeConfig.episodeId
	self.battleId = self.dungeonEpisodeCo.battleId

	NavigateMgr.instance:addEscape(self.viewName, self._onEscapeBtnClick, self)
	gohelper.setActive(self._scrollinfo.gameObject, self.towerEpisodeConfig.plane == 0)
	gohelper.setActive(self._scrollplaneInfo.gameObject, self.towerEpisodeConfig.plane > 0)

	if self._gotrialTips.activeSelf then
		gohelper.setActive(self._gotipsbg, true)
	end

	HeroGroupTrialModel.instance:setTrialByBattleId(self.battleId)
	TowerComposeHeroGroupModel.instance:replaceLockPlaneBuffItem()
	self:checkAndDropAssist()
	self:refreshUI()
end

function TowerComposeHeroGroupView:checkAndDropAssist()
	if self.towerEpisodeConfig.plane > 0 then
		for planeId = 1, self.towerEpisodeConfig.plane do
			TowerComposeHeroGroupModel.instance:checkAndDropAssistHero(self.themeId, planeId)
		end
	else
		TowerComposeHeroGroupModel.instance:checkAndDropAssistHero(self.themeId, self.towerEpisodeConfig.plane)
	end
end

function TowerComposeHeroGroupView:refreshUI()
	self:_setTrialNumTips()
	self:refreshPlaneLock()
	self:refreshPlaneBuffSlot()
	self:refreshPlayerClothSlot()
end

function TowerComposeHeroGroupView:_setTrialNumTips()
	local _, battleCO = self:_getEpisodeConfigAndBattleConfig()
	local tips = {}
	local limitNum = HeroGroupTrialModel.instance:getLimitNum() or 0

	if limitNum > 0 then
		tips[1] = limitNum >= 4 and luaLang("herogroup_trial_tip") or formatLuaLang("herogroup_trial_limit_tip", limitNum)
	end

	if battleCO and not string.nilorempty(battleCO.trialEquips) then
		table.insert(tips, luaLang("herogroup_trial_equip_tip"))
	end

	gohelper.setActive(self._goTrialTips, #tips > 0)

	if #tips > 0 then
		gohelper.CreateObjList(self, self._setTrialTipsTxt, tips, self._gotipsbg, self._gotipsitem)
	end
end

function TowerComposeHeroGroupView:_getEpisodeConfigAndBattleConfig()
	local episodeCO = DungeonConfig.instance:getEpisodeCO(self.episodeId)
	local battleCO

	return episodeCO, self.battleId and self.battleId > 0 and lua_battle.configDict[self.battleId] or DungeonConfig.instance:getBattleCo(self.episodeId)
end

function TowerComposeHeroGroupView:_setTrialTipsTxt(obj, data, index)
	gohelper.findChildTextMesh(obj, "desc").text = data
end

function TowerComposeHeroGroupView:_onClickHeroGroupItem(id)
	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local equips = heroGroupMO:getPosEquips(id - 1).equipUid

	self._param = {}
	self._param.singleGroupMOId = id
	self._param.originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(id)
	self._param.equips = equips

	ViewMgr.instance:openView(ViewName.TowerComposeHeroGroupEditView, self._param)
end

function TowerComposeHeroGroupView:_onSupportSlotClick(planeSlotItem)
	local planeId = planeSlotItem.planeId

	TowerComposeHeroGroupModel.instance:setCurSelectPlaneIdAndType(planeId, TowerComposeEnum.TeamBuffType.Support)
	TowerComposeController.instance:openTowerComposeHeroGroupBuffView()
end

function TowerComposeHeroGroupView:_onResearchSlotClick(planeSlotItem)
	local planeId = planeSlotItem.planeId

	TowerComposeHeroGroupModel.instance:setCurSelectPlaneIdAndType(planeId, TowerComposeEnum.TeamBuffType.Research)
	TowerComposeController.instance:openTowerComposeHeroGroupBuffView()
end

function TowerComposeHeroGroupView:refreshPlaneBuffSlot()
	if self.towerEpisodeConfig.plane == 0 or self.towerEpisodeConfig.plane == 1 then
		local planeId = self.towerEpisodeConfig.plane
		local planeSlotItem = self.planeSlotItemMap[planeId]

		if not planeSlotItem then
			planeSlotItem = self:buildPlaneSlot(self._gonormalPlane)
			planeSlotItem.planeId = planeId
			self.planeSlotItemMap[planeId] = planeSlotItem
		end

		self:refreshPlaneSlotUI(planeSlotItem)
	elseif self.towerEpisodeConfig.plane == 2 then
		for planeId = 1, 2 do
			local planeSlotItem = self.planeSlotItemMap[planeId]

			if not planeSlotItem then
				planeSlotItem = self:buildPlaneSlot(self["_goPlane" .. planeId])
				planeSlotItem.planeId = planeId
				self.planeSlotItemMap[planeId] = planeSlotItem
			end

			self:refreshPlaneSlotUI(planeSlotItem)
		end
	end
end

function TowerComposeHeroGroupView:buildPlaneSlot(planeGO)
	local planeSlotItem = {}

	planeSlotItem.go = planeGO
	planeSlotItem.goSupport = gohelper.findChild(planeGO, "go_support")
	planeSlotItem.goSupportNormal = gohelper.findChild(planeSlotItem.goSupport, "normal")
	planeSlotItem.goSupportAdd = gohelper.findChild(planeSlotItem.goSupport, "normal/bg2")
	planeSlotItem.goSupportSelect = gohelper.findChild(planeSlotItem.goSupport, "selected")
	planeSlotItem.goSupportEquip = gohelper.findChild(planeSlotItem.goSupport, "equiped")
	planeSlotItem.goSupportLock = gohelper.findChild(planeSlotItem.goSupport, "go_lock")
	planeSlotItem.simageSupport = gohelper.findChildSingleImage(planeSlotItem.goSupport, "equiped/simage_support")
	planeSlotItem.imageCareer = gohelper.findChildImage(planeSlotItem.goSupport, "equiped/image_career")
	planeSlotItem.goAssist = gohelper.findChild(planeSlotItem.goSupport, "go_assist")
	planeSlotItem.btnSupport = gohelper.findChildButtonWithAudio(planeSlotItem.goSupport, "btn_support")
	planeSlotItem.goResearch = gohelper.findChild(planeGO, "go_research")
	planeSlotItem.goResearchNormal = gohelper.findChild(planeSlotItem.goResearch, "normal")
	planeSlotItem.goResearchAdd = gohelper.findChild(planeSlotItem.goResearch, "normal/bg2")
	planeSlotItem.goResearchSelect = gohelper.findChild(planeSlotItem.goResearch, "selected")
	planeSlotItem.goResearchEquip = gohelper.findChild(planeSlotItem.goResearch, "equiped")
	planeSlotItem.goResearchLock = gohelper.findChild(planeSlotItem.goResearch, "go_lock")
	planeSlotItem.imageResearch = gohelper.findChildImage(planeSlotItem.goResearch, "equiped/image_research")
	planeSlotItem.btnResearch = gohelper.findChildButtonWithAudio(planeSlotItem.goResearch, "btn_research")

	planeSlotItem.btnSupport:AddClickListener(self._onSupportSlotClick, self, planeSlotItem)
	planeSlotItem.btnResearch:AddClickListener(self._onResearchSlotClick, self, planeSlotItem)

	return planeSlotItem
end

function TowerComposeHeroGroupView:refreshPlaneSlotUI(planeSlotItem)
	planeSlotItem.supportBuffId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(self.themeId, planeSlotItem.planeId, TowerComposeEnum.TeamBuffType.Support)
	planeSlotItem.researchBuffId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(self.themeId, planeSlotItem.planeId, TowerComposeEnum.TeamBuffType.Research)

	local isPlaneLayerUnlock = TowerComposeModel.instance:checkHasPlaneLayerUnlock(self.themeId)
	local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(self.themeId, planeSlotItem.planeId)
	local themeMo = TowerComposeModel.instance:getThemeMo(self.themeId)
	local planeMo = themeMo:getPlaneMo(planeSlotItem.planeId)
	local assistData = TowerComposeHeroGroupModel.instance:getThemePlaneAssistData(self.themeId, planeSlotItem.planeId)

	if not assistData.heroUid then
		local assistHeroId, assistId = assistData.heroId or 0, 0

		gohelper.setActive(planeSlotItem.goResearch, isPlaneLayerUnlock)
		gohelper.setActive(planeSlotItem.goSupportSelect, false)
		gohelper.setActive(planeSlotItem.goSupportAdd, planeSlotItem.supportBuffId == 0 and (not isPlaneLock or not planeMo.hasFight))
		gohelper.setActive(planeSlotItem.goSupportLock, isPlaneLock and planeMo.hasFight)
		gohelper.setActive(planeSlotItem.goSupportEquip, planeSlotItem.supportBuffId > 0)
		gohelper.setActive(planeSlotItem.goSupportNormal, planeSlotItem.supportBuffId == 0)
		gohelper.setActive(planeSlotItem.goResearchSelect, false)
		gohelper.setActive(planeSlotItem.goResearchAdd, planeSlotItem.researchBuffId == 0 and (not isPlaneLock or not planeMo.hasFight))
		gohelper.setActive(planeSlotItem.goResearchLock, isPlaneLock and planeMo.hasFight)
		gohelper.setActive(planeSlotItem.goResearchEquip, planeSlotItem.researchBuffId > 0)
		gohelper.setActive(planeSlotItem.goResearchNormal, planeSlotItem.researchBuffId == 0)

		if planeSlotItem.supportBuffId > 0 then
			local supportConfig = TowerComposeConfig.instance:getSupportCo(planeSlotItem.supportBuffId)
			local heroMo = HeroModel.instance:getByHeroId(supportConfig.heroId)
			local heroConfig = HeroConfig.instance:getHeroCO(supportConfig.heroId)

			if heroMo then
				if not heroMo.skin then
					local skinId = heroConfig.skinId

					skinId = assistData and assistData.heroId == supportConfig.heroId and assistData.skin > 0 and assistData.skin or skinId

					local skinConfig = SkinConfig.instance:getSkinCo(skinId)

					planeSlotItem.simageSupport:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
					UISpriteSetMgr.instance:setCommonSprite(planeSlotItem.imageCareer, "lssx_" .. tostring(heroConfig.career))
					gohelper.setActive(planeSlotItem.goAssist, supportConfig.heroId == assistHeroId)
				end
			end
		else
			TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, planeSlotItem.planeId, TowerComposeEnum.TeamBuffType.Support, 0)
			gohelper.setActive(planeSlotItem.goAssist, false)
		end

		if planeSlotItem.researchBuffId > 0 then
			local researchCo = TowerComposeConfig.instance:getResearchCo(planeSlotItem.researchBuffId)

			UISpriteSetMgr.instance:setTower2Sprite(planeSlotItem.imageResearch, researchCo.icon)
		else
			TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, planeSlotItem.planeId, TowerComposeEnum.TeamBuffType.Research, 0)
		end
	end
end

function TowerComposeHeroGroupView:refreshPlayerClothSlot()
	gohelper.setActive(self._btncloth.gameObject, self.towerEpisodeConfig.plane < 2 and HeroGroupFightView.showCloth())
	gohelper.setActive(self._btncloth1.gameObject, self.towerEpisodeConfig.plane == 2 and HeroGroupFightView.showCloth())
	gohelper.setActive(self._btncloth2.gameObject, self.towerEpisodeConfig.plane == 2 and HeroGroupFightView.showCloth())

	if self.towerEpisodeConfig.plane == 0 or self.towerEpisodeConfig.plane == 1 then
		local planeId = self.towerEpisodeConfig.plane
		local playerClothItem = self.playerClothItemMap[planeId]

		if not playerClothItem then
			playerClothItem = self:buildPlayerClothSlot(self._btncloth)
			playerClothItem.planeId = planeId
			playerClothItem.clothIconGO = self._playerClothIconGO
			self.playerClothItemMap[planeId] = playerClothItem
		end

		self:refreshPlayerClothUI(playerClothItem)
	elseif self.towerEpisodeConfig.plane == 2 then
		for planeId = 1, 2 do
			local playerClothItem = self.playerClothItemMap[planeId]

			if not playerClothItem then
				playerClothItem = self:buildPlayerClothSlot(self["_btncloth" .. planeId])
				playerClothItem.planeId = planeId
				playerClothItem.clothIconGO = self["_playerClothIconGO" .. planeId]
				self.playerClothItemMap[planeId] = playerClothItem
			end

			self:refreshPlayerClothUI(playerClothItem)
		end
	end
end

function TowerComposeHeroGroupView:buildPlayerClothSlot(btnCloth)
	local playerClothItem = {}

	playerClothItem.go = btnCloth.gameObject
	playerClothItem._btncloth = btnCloth
	playerClothItem._txtclothName = gohelper.findChildText(playerClothItem.go, "txt_clothName")
	playerClothItem._txtclothNameEn = gohelper.findChildText(playerClothItem.go, "txt_clothName/txt_clothNameEn")
	playerClothItem._goclothLock = gohelper.findChild(playerClothItem.go, "go_lock")

	playerClothItem._btncloth:AddClickListener(self._btnclothOnClock, self, playerClothItem)

	return playerClothItem
end

function TowerComposeHeroGroupView:refreshPlayerClothUI(playerClothItem)
	playerClothItem.clothId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(self.themeId, playerClothItem.planeId, TowerComposeEnum.TeamBuffType.Cloth)
	playerClothItem.clothId = PlayerClothModel.instance:getSpEpisodeClothID() or playerClothItem.clothId

	self:checkEquipClothSkill(playerClothItem)

	local clothMO = PlayerClothModel.instance:getById(playerClothItem.clothId)

	gohelper.setActive(playerClothItem._txtclothName.gameObject, clothMO)

	local themeMo = TowerComposeModel.instance:getThemeMo(self.themeId)
	local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(self.themeId, playerClothItem.planeId)
	local planeMo = themeMo:getPlaneMo(playerClothItem.planeId)

	gohelper.setActive(playerClothItem._goclothLock, isPlaneLock and planeMo.hasFight)

	if clothMO then
		local clothConfig = lua_cloth.configDict[clothMO.clothId]

		playerClothItem._txtclothName.text = clothConfig.name
		playerClothItem._txtclothNameEn.text = clothConfig.enname
	end

	for _, clothCO in ipairs(lua_cloth.configList) do
		local icon = gohelper.findChild(playerClothItem.clothIconGO, tostring(clothCO.id))

		if not gohelper.isNil(icon) then
			gohelper.setActive(icon, clothCO.id == playerClothItem.clothId)
		end
	end
end

function TowerComposeHeroGroupView:checkEquipClothSkill(playerClothItem)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	if playerClothItem.clothId and playerClothItem.clothId > 0 and PlayerClothModel.instance:getById(playerClothItem.clothId) then
		return
	end

	local list = PlayerClothModel.instance:getList()

	for _, clothMO in ipairs(list) do
		if PlayerClothModel.instance:hasCloth(clothMO.id) then
			HeroGroupModel.instance:replaceCloth(clothMO.id)
			TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, playerClothItem.planeId, TowerComposeEnum.TeamBuffType.Cloth, clothMO.id)
			TowerComposeHeroGroupModel.instance:saveThemePlaneBuffData()

			playerClothItem.clothId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(self.themeId, playerClothItem.planeId, TowerComposeEnum.TeamBuffType.Cloth)

			break
		end
	end
end

function TowerComposeHeroGroupView:checkPlaneHeroGroupEmpty()
	if self.towerEpisodeConfig.plane == 2 then
		local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

		for planeId = 1, self.towerEpisodeConfig.plane do
			local startIndex = planeId < 2 and 1 or 5
			local endIndex = planeId < 2 and 4 or 8
			local isHasHero = false

			for index = startIndex, endIndex do
				local heroId = curGroupMO:getHeroByIndex(index)

				if heroId ~= "0" then
					isHasHero = true

					break
				end
			end

			if isHasHero == false then
				return true, planeId
			end
		end
	end

	return false
end

function TowerComposeHeroGroupView:refreshPlaneLock()
	if self.towerEpisodeConfig.plane == 2 then
		local themeMo = TowerComposeModel.instance:getThemeMo(self.themeId)

		for planeId = 1, self.towerEpisodeConfig.plane do
			local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(self.themeId, planeId)
			local planeMo = themeMo:getPlaneMo(planeId)

			gohelper.setActive(self["_goPlaneLock" .. planeId], isPlaneLock and planeMo.hasFight)
		end
	else
		gohelper.setActive(self._goPlaneLock1, false)
		gohelper.setActive(self._goPlaneLock2, false)
	end
end

function TowerComposeHeroGroupView:onEquipChange()
	local themeMo = TowerComposeModel.instance:getThemeMo(self.themeId)
	local curBossMo = themeMo:getCurBossMo()

	if curBossMo.lock then
		TowerComposeRpc.instance:sendTowerComposeLoadRecordRequest(self.themeId)
	end
end

function TowerComposeHeroGroupView:loadRecordReply()
	local themeMo = TowerComposeModel.instance:getThemeMo(self.themeId)
	local bossRecordInfoData = themeMo:getBossRecordInfoData()

	if not bossRecordInfoData then
		GameFacade.showToast(ToastEnum.TowerComposeRecordExpired)
		TowerComposeRpc.instance:sendTowerComposeCancelReChallengeRequest(self.themeId)
	end
end

function TowerComposeHeroGroupView:onClose()
	return
end

function TowerComposeHeroGroupView:onDestroyView()
	for _, planeSlotItem in pairs(self.planeSlotItemMap) do
		planeSlotItem.btnSupport:RemoveClickListener()
		planeSlotItem.btnResearch:RemoveClickListener()
		planeSlotItem.simageSupport:UnLoadImage()
	end

	for _, playerClothItem in pairs(self.playerClothItemMap) do
		playerClothItem._btncloth:RemoveClickListener()
	end
end

return TowerComposeHeroGroupView
