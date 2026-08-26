-- chunkname: @modules/logic/towercompose/view/TowerComposeHeroGroupBuffView.lua

module("modules.logic.towercompose.view.TowerComposeHeroGroupBuffView", package.seeall)

local TowerComposeHeroGroupBuffView = class("TowerComposeHeroGroupBuffView", BaseView)

function TowerComposeHeroGroupBuffView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosupportView = gohelper.findChild(self.viewGO, "Tips/#go_supportView")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Tips/#go_supportView/#txt_desc")
	self._scrollsupportList = gohelper.findChildScrollRect(self.viewGO, "Tips/#go_supportView/#scroll_supportList")
	self._gosupportContent = gohelper.findChild(self.viewGO, "Tips/#go_supportView/#scroll_supportList/Viewport/#go_supportContent")
	self._gosupportItem = gohelper.findChild(self.viewGO, "Tips/#go_supportView/#scroll_supportList/Viewport/#go_supportContent/#go_supportItem")
	self._goresearchView = gohelper.findChild(self.viewGO, "Tips/#go_researchView")
	self._scrollresearchList = gohelper.findChildScrollRect(self.viewGO, "Tips/#go_researchView/#scroll_researchList")
	self._goresearchContent = gohelper.findChild(self.viewGO, "Tips/#go_researchView/#scroll_researchList/Viewport/#go_researchContent")
	self._goresearchItem = gohelper.findChild(self.viewGO, "Tips/#go_researchView/#scroll_researchList/Viewport/#go_researchContent/#go_researchItem")
	self._goonePlane = gohelper.findChild(self.viewGO, "#go_onePlane")
	self._gotwoPlane = gohelper.findChild(self.viewGO, "#go_twoPlane")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeHeroGroupBuffView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.HeroGroupSelectBuff, self.refreshUI, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshAssistState, self.refreshUI, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRefreshAssistReply, self.onRefreshAssistReply, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.SelectPlaneSupportSlot, self.onSelectPlaneSupportSlot, self)
end

function TowerComposeHeroGroupBuffView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.HeroGroupSelectBuff, self.refreshUI, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshAssistState, self.refreshUI, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnRefreshAssistReply, self.onRefreshAssistReply, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.SelectPlaneSupportSlot, self.onSelectPlaneSupportSlot, self)
end

function TowerComposeHeroGroupBuffView:_btncloseOnClick()
	self:closeThis()
end

function TowerComposeHeroGroupBuffView:_onResearchItemClick(researchItem)
	if not researchItem.unlockState then
		GameFacade.showToast(ToastEnum.TowerComposeNotHave, researchItem.config.name)

		return
	end

	local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(self.themeId, self.curPlaneId)
	local themeMo = TowerComposeModel.instance:getThemeMo(self.themeId)
	local planeMo = themeMo:getPlaneMo(self.curPlaneId)

	if isPlaneLock and planeMo.hasFight then
		GameFacade.showToast(ToastEnum.TowerComposeRecordBuffLock)

		return
	end

	if not self.isNormalEpisode and researchItem.inPlaneId == 0 or researchItem.inPlaneId == -1 then
		TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Research, researchItem.config.id)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.HeroGroupSelectBuff)
	elseif self.curPlaneId == researchItem.inPlaneId then
		TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Research, 0)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.HeroGroupSelectBuff)
	elseif self.curPlaneId ~= researchItem.inPlaneId then
		local isInPlaneLock = TowerComposeModel.instance:checkPlaneLock(self.themeId, researchItem.inPlaneId)
		local inPlaneMo = themeMo:getPlaneMo(researchItem.inPlaneId)

		if isInPlaneLock and inPlaneMo.hasFight then
			GameFacade.showToast(ToastEnum.TowerComposeRecordBuffLock)

			return
		end

		self.curResearchItem = researchItem

		GameFacade.showOptionMessageBox(MessageBoxIdDefine.TowerComposeReplaceMod, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self.replaceTipCallBack, nil, nil, self)
	end
end

function TowerComposeHeroGroupBuffView:replaceTipCallBack()
	TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.curResearchItem.inPlaneId, TowerComposeEnum.TeamBuffType.Research, 0)
	TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Research, self.curResearchItem.config.id)

	self.curResearchItem = nil

	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.HeroGroupSelectBuff)
end

function TowerComposeHeroGroupBuffView:_onSupportSlotClick(planeSlotItem)
	TowerComposeHeroGroupModel.instance:setCurSelectPlaneIdAndType(planeSlotItem.planeId, TowerComposeEnum.TeamBuffType.Support)
	self:refreshUI()
end

function TowerComposeHeroGroupBuffView:_onResearchSlotClick(planeSlotItem)
	TowerComposeHeroGroupModel.instance:setCurSelectPlaneIdAndType(planeSlotItem.planeId, TowerComposeEnum.TeamBuffType.Research)
	self:refreshUI()
end

function TowerComposeHeroGroupBuffView:onSelectPlaneSupportSlot(planeId)
	local planeSlotItem = self.planeSlotItemMap[planeId]

	if planeSlotItem then
		self:_onSupportSlotClick(planeSlotItem)
	end
end

function TowerComposeHeroGroupBuffView:_editableInitView()
	self.supportItemList = self:getUserDataTb_()
	self.researchItemList = self:getUserDataTb_()
	self.planeSlotItemMap = self:getUserDataTb_()
	self._goTwoPlane1 = gohelper.findChild(self.viewGO, "#go_twoPlane/plane1")
	self._goTwoPlane2 = gohelper.findChild(self.viewGO, "#go_twoPlane/plane2")

	gohelper.setActive(self._gosupportItem, false)
	gohelper.setActive(self._goresearchItem, false)
	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function TowerComposeHeroGroupBuffView:onUpdateParam()
	return
end

function TowerComposeHeroGroupBuffView:onOpen()
	self.fightParam = TowerComposeModel.instance:getRecordFightParam()
	self.themeId = self.fightParam.themeId
	self.layerId = self.fightParam.layerId
	self.towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(self.themeId, self.layerId)
	self.isNormalEpisode = self.towerEpisodeConfig.plane == 0
	self.showTwoPlane = self.towerEpisodeConfig.plane > 1
	self.episodeId = self.fightParam.episodeId

	self:refreshUI()
end

function TowerComposeHeroGroupBuffView:refreshUI()
	local supportHeroCoList = TowerComposeConfig.instance:getAllSupportCoList(self.themeId)

	self.heroCoList = self:buildHeroCoList(supportHeroCoList)
	self.curPlaneId, self.curBuffType = TowerComposeHeroGroupModel.instance:getCurSelectPlaneIdAndType()

	gohelper.setActive(self._gosupportView, self.curBuffType == TowerComposeEnum.TeamBuffType.Support)
	gohelper.setActive(self._goresearchView, self.curBuffType == TowerComposeEnum.TeamBuffType.Research)

	if self.curBuffType == TowerComposeEnum.TeamBuffType.Research then
		self:refreshResearchView()
	end

	if self.curBuffType == TowerComposeEnum.TeamBuffType.Support then
		self:refreshSupportView()
	end

	self:refreshPlaneSlot()
end

function TowerComposeHeroGroupBuffView:refreshResearchView()
	self.curAllResearchCoList = TowerComposeConfig.instance:getAllResearchCoList(self.themeId)

	for index, researchCo in ipairs(self.curAllResearchCoList) do
		local researchItem = self.researchItemList[index]

		if not researchItem then
			researchItem = {
				go = gohelper.clone(self._goresearchItem, self._goresearchContent, "researchItem" .. researchCo.id)
			}
			researchItem.goSelect1 = gohelper.findChild(researchItem.go, "go_Selected1")
			researchItem.goSelect2 = gohelper.findChild(researchItem.go, "go_Selected2")
			researchItem.goIsIn1 = gohelper.findChild(researchItem.go, "go_isIn1")
			researchItem.goIsIn2 = gohelper.findChild(researchItem.go, "go_isIn2")
			researchItem.imageIcon = gohelper.findChildImage(researchItem.go, "image_Icon")
			researchItem.txtDesc = gohelper.findChildText(researchItem.go, "txtLayout/txt_Desc")
			researchItem.txtName = gohelper.findChildText(researchItem.go, "txtLayout/txt_Name")
			researchItem.goMask = gohelper.findChild(researchItem.go, "go_mask")
			researchItem.btnClick = gohelper.findChildButtonWithAudio(researchItem.go, "btn_click")
			self.researchItemList[index] = researchItem
		end

		gohelper.setActive(researchItem.go, true)
		researchItem.btnClick:AddClickListener(self._onResearchItemClick, self, researchItem)

		researchItem.config = researchCo
		researchItem.unlockState = TowerComposeModel.instance:checkCurThemeResearchUnlock(self.themeId, researchCo.id)

		if researchItem.unlockState then
			researchItem.txtName.text = researchCo.name or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towercompose_notHave"), researchCo.name)
		end

		researchItem.txtDesc.text = SkillHelper.buildDesc(researchCo.desc)

		UISpriteSetMgr.instance:setTower2Sprite(researchItem.imageIcon, researchCo.icon)

		researchItem.inPlaneId = TowerComposeHeroGroupModel.instance:checkBuffInPlane(self.themeId, TowerComposeEnum.TeamBuffType.Research, researchCo.id, self.isNormalEpisode)

		gohelper.setActive(researchItem.goSelect1, (researchItem.inPlaneId ~= 1 or self.curPlaneId ~= 1 or nil) and self.isNormalEpisode and researchItem.inPlaneId == 0)
		gohelper.setActive(researchItem.goSelect2, researchItem.inPlaneId == 2 and self.curPlaneId == 2)
		gohelper.setActive(researchItem.goIsIn1, (researchItem.inPlaneId ~= 1 or nil) and self.isNormalEpisode and researchItem.inPlaneId == 0)
		gohelper.setActive(researchItem.goIsIn2, researchItem.inPlaneId == 2)
		gohelper.setActive(researchItem.goMask, not researchItem.unlockState)
	end

	for index = #self.curAllResearchCoList + 1, #self.researchItemList do
		gohelper.setActive(self.researchItemList[index].go, false)
	end
end

function TowerComposeHeroGroupBuffView:refreshSupportView()
	for index, heroCoData in ipairs(self.heroCoList) do
		local supportItem = self.supportItemList[index]

		if not supportItem then
			supportItem = {
				go = gohelper.clone(self._gosupportItem, self._gosupportContent, "supportItem" .. heroCoData.config.id)
			}
			supportItem.comp = MonoHelper.addNoUpdateLuaComOnceToGo(supportItem.go, TowerComposeHeroGroupSupportItem)
			self.supportItemList[index] = supportItem
		end

		supportItem.comp:initData({
			heroCoData = heroCoData
		})
		gohelper.setActive(supportItem.go, true)
		supportItem.comp:refreshUI()
	end

	for index = #self.heroCoList + 1, #self.supportItemList do
		gohelper.setActive(self.supportItemList[index].go, false)
	end
end

function TowerComposeHeroGroupBuffView:buildHeroCoList(heroCoList)
	local newHeroCoList = {}
	local heroIdMap = {}

	for index, heroCo in ipairs(heroCoList) do
		local coData = heroIdMap[heroCo.heroId]

		if not coData then
			coData = {
				index = index,
				heroMo = HeroModel.instance:getByHeroId(heroCo.heroId),
				heroConfig = HeroConfig.instance:getHeroCO(heroCo.heroId)
			}

			table.insert(newHeroCoList, coData)

			heroIdMap[heroCo.heroId] = coData
		end

		local isAssistHero, assistHeroData = self:checkIsAssitHero(heroCo.themeId, heroCo.heroId)

		if isAssistHero and assistHeroData and next(assistHeroData) then
			coData.config = TowerComposeConfig.instance:getThemeCurLvHeroIdSupportCo(heroCo.themeId, heroCo.heroId, assistHeroData.exSkillLevel or 0)
			coData.canShow = true
			coData.isNormalEpisode = self.isNormalEpisode
		elseif coData.heroMo then
			coData.config = TowerComposeConfig.instance:getThemeCurLvHeroIdSupportCo(heroCo.themeId, heroCo.heroId, coData.heroMo.exSkillLevel or 0)
			coData.canShow = coData.heroMo ~= nil
			coData.isNormalEpisode = self.isNormalEpisode
		end
	end

	table.sort(newHeroCoList, function(a, b)
		local aInPlane = TowerComposeHeroGroupModel.instance:checkBuffInPlane(a.config.themeId, TowerComposeEnum.TeamBuffType.Support, a.config.id, a.isNormalEpisode)
		local bInPlane = TowerComposeHeroGroupModel.instance:checkBuffInPlane(b.config.themeId, TowerComposeEnum.TeamBuffType.Support, b.config.id, b.isNormalEpisode)

		if aInPlane ~= bInPlane then
			return bInPlane < aInPlane
		elseif a.canShow ~= b.canShow then
			return a.canShow
		elseif a.heroConfig.rare ~= b.heroConfig.rare then
			return a.heroConfig.rare > b.heroConfig.rare
		else
			return a.index < b.index
		end
	end)

	return newHeroCoList
end

function TowerComposeHeroGroupBuffView:checkIsAssitHero(themeId, heroId)
	if self.towerEpisodeConfig.plane > 0 then
		for planeId = 1, self.towerEpisodeConfig.plane do
			local assistHeroData = TowerComposeHeroGroupModel.instance:getThemePlaneAssistData(themeId, planeId)

			if assistHeroData and assistHeroData.heroId == heroId then
				return true, assistHeroData
			end
		end
	else
		local assistHeroData = TowerComposeHeroGroupModel.instance:getThemePlaneAssistData(themeId, 0)

		if assistHeroData and assistHeroData.heroId == heroId then
			return true, assistHeroData
		end
	end

	return false
end

function TowerComposeHeroGroupBuffView:refreshPlaneSlot()
	gohelper.setActive(self._goonePlane, not self.showTwoPlane)
	gohelper.setActive(self._gotwoPlane, self.showTwoPlane)

	local totalPlane = self.showTwoPlane and 2 or 1

	for planeId = 1, totalPlane do
		local planeSlotItem = self.planeSlotItemMap[planeId]

		if not planeSlotItem then
			if self.showTwoPlane then
				if planeId == 1 then
					local var_19_0 = self._goTwoPlane1

					if not self._goTwoPlane1 then
						var_19_0 = self._goTwoPlane2

						if not self._goTwoPlane2 then
							local planeGO = self._goonePlane

							planeSlotItem = self:buildPlaneSlot(planeGO)
							self.planeSlotItemMap[planeId] = planeSlotItem
						end
					end
				end
			end
		end

		planeSlotItem.planeId = self.towerEpisodeConfig.plane > 0 and planeId or 0

		self:refreshPlaneSlotUI(planeSlotItem)
	end
end

function TowerComposeHeroGroupBuffView:buildPlaneSlot(planeGO)
	local planeSlotItem = {}

	planeSlotItem.go = planeGO
	planeSlotItem.goSupport = gohelper.findChild(planeGO, "support")
	planeSlotItem.goSupportNormal = gohelper.findChild(planeSlotItem.goSupport, "normal")
	planeSlotItem.goSupportSelect = gohelper.findChild(planeSlotItem.goSupport, "selected")
	planeSlotItem.goSupportAdd = gohelper.findChild(planeSlotItem.goSupport, "selected/bg2")
	planeSlotItem.goSupportEquip = gohelper.findChild(planeSlotItem.goSupport, "equiped")
	planeSlotItem.goSupportLock = gohelper.findChild(planeSlotItem.goSupport, "go_lock")
	planeSlotItem.simageSupport = gohelper.findChildSingleImage(planeSlotItem.goSupport, "equiped/simage_support")
	planeSlotItem.btnSupport = gohelper.findChildButtonWithAudio(planeSlotItem.goSupport, "btn_support")
	planeSlotItem.animSupport = planeSlotItem.goSupport:GetComponent(typeof(UnityEngine.Animator))
	planeSlotItem.goAssist = gohelper.findChild(planeSlotItem.goSupport, "go_assist")
	planeSlotItem.goResearch = gohelper.findChild(planeGO, "research")
	planeSlotItem.goResearchNormal = gohelper.findChild(planeSlotItem.goResearch, "normal")
	planeSlotItem.goResearchSelect = gohelper.findChild(planeSlotItem.goResearch, "selected")
	planeSlotItem.goResearchAdd = gohelper.findChild(planeSlotItem.goResearch, "selected/bg2")
	planeSlotItem.goResearchEquip = gohelper.findChild(planeSlotItem.goResearch, "equiped")
	planeSlotItem.goResearchLock = gohelper.findChild(planeSlotItem.goResearch, "go_lock")
	planeSlotItem.imageResearch = gohelper.findChildImage(planeSlotItem.goResearch, "equiped/image_research")
	planeSlotItem.btnResearch = gohelper.findChildButtonWithAudio(planeSlotItem.goResearch, "btn_research")
	planeSlotItem.animResearch = planeSlotItem.goResearch:GetComponent(typeof(UnityEngine.Animator))

	planeSlotItem.btnSupport:AddClickListener(self._onSupportSlotClick, self, planeSlotItem)
	planeSlotItem.btnResearch:AddClickListener(self._onResearchSlotClick, self, planeSlotItem)

	return planeSlotItem
end

function TowerComposeHeroGroupBuffView:refreshPlaneSlotUI(planeSlotItem)
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
		gohelper.setActive(planeSlotItem.goSupportSelect, self.curBuffType == TowerComposeEnum.TeamBuffType.Support and self.curPlaneId == planeSlotItem.planeId)
		gohelper.setActive(planeSlotItem.goSupportEquip, planeSlotItem.supportBuffId > 0)
		gohelper.setActive(planeSlotItem.goSupportNormal, planeSlotItem.supportBuffId == 0)
		gohelper.setActive(planeSlotItem.goSupportAdd, planeSlotItem.supportBuffId == 0 and (not isPlaneLock or not planeMo.hasFight))
		gohelper.setActive(planeSlotItem.goSupportLock, isPlaneLock and planeMo.hasFight)
		gohelper.setActive(planeSlotItem.goResearchSelect, self.curBuffType == TowerComposeEnum.TeamBuffType.Research and self.curPlaneId == planeSlotItem.planeId)
		gohelper.setActive(planeSlotItem.goResearchEquip, planeSlotItem.researchBuffId > 0)
		gohelper.setActive(planeSlotItem.goResearchNormal, planeSlotItem.researchBuffId == 0)
		gohelper.setActive(planeSlotItem.goResearchAdd, planeSlotItem.researchBuffId == 0 and (not isPlaneLock or not planeMo.hasFight))
		gohelper.setActive(planeSlotItem.goResearchLock, isPlaneLock and planeMo.hasFight)

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
					gohelper.setActive(planeSlotItem.goAssist, supportConfig.heroId == assistHeroId)
				end
			end
		else
			gohelper.setActive(planeSlotItem.goAssist, false)
		end

		if planeSlotItem.researchBuffId > 0 then
			local researchCo = TowerComposeConfig.instance:getResearchCo(planeSlotItem.researchBuffId)

			UISpriteSetMgr.instance:setTower2Sprite(planeSlotItem.imageResearch, researchCo.icon)
		end

		planeSlotItem.lastSupportBuffId = planeSlotItem.lastSupportBuffId or planeSlotItem.supportBuffId or planeSlotItem.lastSupportBuffId
		planeSlotItem.lastResearchBuffId = planeSlotItem.lastResearchBuffId or planeSlotItem.researchBuffId or planeSlotItem.lastResearchBuffId

		if planeSlotItem.lastSupportBuffId ~= planeSlotItem.supportBuffId then
			planeSlotItem.lastSupportBuffId = planeSlotItem.supportBuffId

			if planeSlotItem.supportBuffId > 0 then
				planeSlotItem.animSupport:Play("add", 0, 0)
				planeSlotItem.animSupport:Update(0)
				AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_fight_ly_card_close)
			end
		end

		if planeSlotItem.lastResearchBuffId ~= planeSlotItem.researchBuffId then
			planeSlotItem.lastResearchBuffId = planeSlotItem.researchBuffId

			if planeSlotItem.researchBuffId > 0 then
				planeSlotItem.animResearch:Play("add", 0, 0)
				planeSlotItem.animResearch:Update(0)
				AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_fight_ly_card_close)
			end
		end
	end
end

function TowerComposeHeroGroupBuffView:onRefreshAssistReply(info)
	if info.assistType == PickAssistEnum.Type.TowerCompose1 or info.assistType == PickAssistEnum.Type.TowerCompose2 then
		local assistHeroId = info.ext
		local assistList = DungeonAssistModel.instance:getAssistList(info.assistType)

		PickAssistController.instance:recordAssistRefreshTime()

		if #assistList > 0 then
			PickAssistController.instance:openPickAssistView(info.assistType, info.assistType, nil, self.selectAssistHeroCallBack, self, false, assistHeroId, true)
		else
			GameFacade.showToast(ToastEnum.TowerComposeAssistNotFind)
		end

		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.RefreshAssistState)
	end
end

function TowerComposeHeroGroupBuffView:selectAssistHeroCallBack(pickAssistHeroMO)
	if pickAssistHeroMO then
		local assistType = TowerComposeHeroGroupModel.instance:getNotUsedAssistType(self.themeId)

		TowerComposeHeroGroupModel.instance:setThemePlaneAssistType(self.themeId, pickAssistHeroMO.heroId, assistType)
		TowerComposeHeroGroupModel.instance:setThemePlaneAssistData(self.themeId, self.curPlaneId, pickAssistHeroMO)

		local curSupportCo = TowerComposeConfig.instance:getThemeCurLvHeroIdSupportCo(self.themeId, pickAssistHeroMO.heroId, pickAssistHeroMO.exSkillLevel)

		TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Support, curSupportCo.id)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.RefreshAssistState)

		self._scrollsupportList.verticalNormalizedPosition = 1
	end

	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.SelectAssistCallBack, pickAssistHeroMO)
end

function TowerComposeHeroGroupBuffView:onClose()
	TowerComposeHeroGroupModel.instance:saveThemePlaneBuffData()
end

function TowerComposeHeroGroupBuffView:onDestroyView()
	for _, slotItem in pairs(self.planeSlotItemMap) do
		slotItem.btnSupport:RemoveClickListener()
		slotItem.btnResearch:RemoveClickListener()
		slotItem.simageSupport:UnLoadImage()
	end

	for _, researchItem in ipairs(self.researchItemList) do
		researchItem.btnClick:RemoveClickListener()
	end
end

return TowerComposeHeroGroupBuffView
