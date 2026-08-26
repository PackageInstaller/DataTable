-- chunkname: @modules/logic/towercompose/view/TowerComposeHeroGroupSupportItem.lua

module("modules.logic.towercompose.view.TowerComposeHeroGroupSupportItem", package.seeall)

local TowerComposeHeroGroupSupportItem = class("TowerComposeHeroGroupSupportItem", LuaCompBase)

function TowerComposeHeroGroupSupportItem:initData(param)
	self.param = param
	self.heroCoData = self.param.heroCoData
	self.supportConfig = self.heroCoData.config
	self.heroId = self.heroCoData.config.heroId
	self.themeId = self.heroCoData.config.themeId
end

function TowerComposeHeroGroupSupportItem:init(go)
	self:__onInit()

	self.go = go
	self.goSelect1 = gohelper.findChild(self.go, "go_Selected1")
	self.goSelect2 = gohelper.findChild(self.go, "go_Selected2")
	self.goIsIn1 = gohelper.findChild(self.go, "go_isIn1")
	self.goIsIn2 = gohelper.findChild(self.go, "go_isIn2")
	self.imageRare = gohelper.findChildImage(self.go, "role/rare")
	self.simageHeroIcon = gohelper.findChildSingleImage(self.go, "role/heroicon")
	self.imageCareer = gohelper.findChildImage(self.go, "role/career")
	self.txtLevel = gohelper.findChildText(self.go, "role/txt_level")
	self.goExskill = gohelper.findChild(self.go, "role/go_exskill")
	self.imageExskill = gohelper.findChildImage(self.go, "role/go_exskill/image_exskill")
	self.rankList = {}

	for rankLv = 1, 3 do
		self.rankList[rankLv] = gohelper.findChild(self.go, "role/Rank/rank" .. rankLv)
	end

	self.goRank = gohelper.findChild(self.go, "role/Rank")
	self.txtName = gohelper.findChildText(self.go, "txtLayout/txt_name")
	self.txtActive = gohelper.findChildText(self.go, "txtLayout/txt_active")
	self.txtDesc = gohelper.findChildText(self.go, "txtLayout/txt_desc")

	SkillHelper.addHyperLinkClick(self.txtDesc, self._onHyperLinkClick, self)

	self.goMask = gohelper.findChild(self.go, "go_mask")
	self.btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_click")
	self.btnAssist = gohelper.findChildButtonWithAudio(self.go, "btn_assist")
	self.goAssistNormal = gohelper.findChild(self.go, "btn_assist/go_assistNormal")
	self.goAssistCancel = gohelper.findChild(self.go, "btn_assist/go_assistCancel")
	self.goAssistInTeam = gohelper.findChild(self.go, "btn_assist/go_assistInTeam")
	self.goAssistCD = gohelper.findChild(self.go, "btn_assist/go_assistCD")
	self.imageAssistCD = gohelper.findChildImage(self.go, "btn_assist/go_assistCD/icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeHeroGroupSupportItem:addEventListeners()
	self.btnClick:AddClickListener(self._onSupportItemClick, self)
	self.btnAssist:AddClickListener(self._onAssistItemClick, self)
end

function TowerComposeHeroGroupSupportItem:removeEventListeners()
	self.btnClick:RemoveClickListener()
	self.btnAssist:RemoveClickListener()
end

function TowerComposeHeroGroupSupportItem:_onSupportItemClick()
	if not self.heroMo and not self.assistHeroMo then
		GameFacade.showToast(ToastEnum.TowerComposeNotHaveHero)

		return
	end

	if self.isHeroInTeams then
		GameFacade.showToast(ToastEnum.TowerComposeHeroInTeams)

		return
	end

	local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(self.themeId, self.curPlaneId)
	local themeMo = TowerComposeModel.instance:getThemeMo(self.themeId)
	local planeMo = themeMo:getPlaneMo(self.curPlaneId)

	if isPlaneLock and planeMo.hasFight then
		GameFacade.showToast(ToastEnum.TowerComposeRecordRoleLock)

		return
	end

	if not self.isNormalEpisode and self.inPlaneId == 0 or self.inPlaneId == -1 then
		local inPlaneAssistData = TowerComposeHeroGroupModel.instance:getThemePlaneAssistData(self.themeId, self.curPlaneId)

		if inPlaneAssistData and next(inPlaneAssistData) and inPlaneAssistData.heroId > 0 then
			TowerComposeHeroGroupModel.instance:setThemePlaneAssistData(self.themeId, self.curPlaneId, nil)
		end

		TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Support, self.supportConfig.id)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.HeroGroupSelectBuff)
	elseif self.curPlaneId == self.inPlaneId then
		TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Support, 0)

		local inPlaneAssistData = TowerComposeHeroGroupModel.instance:getThemePlaneAssistData(self.themeId, self.curPlaneId)

		if inPlaneAssistData and next(inPlaneAssistData) and inPlaneAssistData.heroId > 0 then
			TowerComposeHeroGroupModel.instance:setThemePlaneAssistData(self.themeId, self.curPlaneId, nil)
			GameFacade.showToast(ToastEnum.TowerComposeCancelAssist)
		end

		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.HeroGroupSelectBuff)
	elseif self.curPlaneId ~= self.inPlaneId then
		local isInPlaneLock = TowerComposeModel.instance:checkPlaneLock(self.themeId, self.inPlaneId)
		local inPlaneMo = themeMo:getPlaneMo(self.inPlaneId)

		if isInPlaneLock and inPlaneMo.hasFight then
			GameFacade.showToast(ToastEnum.TowerComposeRecordRoleLock)

			return
		end

		GameFacade.showOptionMessageBox(MessageBoxIdDefine.TowerComposeReplaceMod, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self.replaceTipCallBack, nil, nil, self)
	end
end

function TowerComposeHeroGroupSupportItem:replaceTipCallBack()
	TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.inPlaneId, TowerComposeEnum.TeamBuffType.Support, 0)
	TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Support, self.supportConfig.id)

	local inPlaneAssistData = TowerComposeHeroGroupModel.instance:getThemePlaneAssistData(self.themeId, self.inPlaneId)
	local curPlaneAssistData = TowerComposeHeroGroupModel.instance:getThemePlaneAssistData(self.themeId, self.curPlaneId)

	if inPlaneAssistData and next(inPlaneAssistData) and inPlaneAssistData.heroId > 0 then
		if curPlaneAssistData and next(curPlaneAssistData) and curPlaneAssistData.heroId > 0 then
			TowerComposeHeroGroupModel.instance:setThemePlaneAssistType(self.themeId, curPlaneAssistData.heroId, nil)
		end

		TowerComposeHeroGroupModel.instance:setThemePlaneAssistData(self.themeId, self.curPlaneId, inPlaneAssistData)
		TowerComposeHeroGroupModel.instance:setThemePlaneAssistData(self.themeId, self.inPlaneId, nil)
	elseif curPlaneAssistData and next(curPlaneAssistData) and curPlaneAssistData.heroId > 0 and (not inPlaneAssistData or not next(inPlaneAssistData) or inPlaneAssistData.heroId == 0) then
		TowerComposeHeroGroupModel.instance:setThemePlaneAssistType(self.themeId, curPlaneAssistData.heroId, nil)
		TowerComposeHeroGroupModel.instance:setThemePlaneAssistData(self.themeId, self.curPlaneId, nil)
	end

	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.HeroGroupSelectBuff)
end

function TowerComposeHeroGroupSupportItem:_onAssistItemClick()
	local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(self.themeId, self.curPlaneId)
	local themeMo = TowerComposeModel.instance:getThemeMo(self.themeId)
	local planeMo = themeMo:getPlaneMo(self.curPlaneId)
	local isHeroInSupport, supportHeroInPlaneId = TowerComposeHeroGroupModel.instance:checkEquipedSupportHero(self.heroId)

	if self.isHeroInTeams and self.assistHeroId ~= self.heroId then
		GameFacade.showToast(ToastEnum.TowerComposeAssistInTeam)

		return
	elseif not self.isHeroInTeams and isHeroInSupport and supportHeroInPlaneId ~= self.curPlaneId then
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.SelectPlaneSupportSlot, supportHeroInPlaneId)
		GameFacade.showToast(ToastEnum.TowerComposeChangePlane, luaLang("towercompose_plane" .. supportHeroInPlaneId))
	elseif not self.isHeroInTeams and self.assistHeroId == self.heroId then
		if self.assistHeroInPlane ~= self.curPlaneId then
			TowerComposeController.instance:dispatchEvent(TowerComposeEvent.SelectPlaneSupportSlot, self.assistHeroInPlane)
			GameFacade.showToast(ToastEnum.TowerComposeChangePlane, luaLang("towercompose_plane" .. (self.assistHeroInPlane or 1)))
		else
			if isPlaneLock and planeMo.hasFight then
				GameFacade.showToast(ToastEnum.TowerComposeRecordRoleLock)

				return
			end

			TowerComposeHeroGroupModel.instance:setThemePlaneAssistType(self.themeId, self.heroId, nil)
			TowerComposeHeroGroupModel.instance:setThemePlaneAssistData(self.themeId, self.curPlaneId, nil)
			GameFacade.showToast(ToastEnum.TowerComposeCancelAssist)
			TowerComposeController.instance:dispatchEvent(TowerComposeEvent.RefreshAssistState)
		end
	elseif self.isInCD then
		GameFacade.showToast(ToastEnum.Season123RefreshAssistInCD)
	else
		if isPlaneLock and planeMo.hasFight then
			GameFacade.showToast(ToastEnum.TowerComposeRecordRoleLock)

			return
		end

		local planeAssistData = TowerComposeHeroGroupModel.instance:getThemePlaneAssistData(self.themeId, self.curPlaneId)

		if planeAssistData and next(planeAssistData) and planeAssistData.heroId > 0 then
			TowerComposeHeroGroupModel.instance:setThemePlaneAssistType(self.themeId, planeAssistData.heroId, nil)
			GameFacade.showToast(ToastEnum.TowerComposeCancelAssist)
		end

		TowerComposeHeroGroupModel.instance:setThemePlaneAssistData(self.themeId, self.curPlaneId, nil)

		local assistType = TowerComposeHeroGroupModel.instance:getNotUsedAssistType(self.themeId)

		DungeonRpc.instance:sendRefreshAssistRequest(assistType, nil, nil, tostring(self.heroId))
	end
end

function TowerComposeHeroGroupSupportItem:_editableInitView()
	local fightParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = fightParam.themeId
	local layerId = fightParam.layerId

	self.towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)
	self.isNormalEpisode = self.towerEpisodeConfig.plane == 0
	self.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self.txtDesc.gameObject, FixTmpBreakLine)

	TaskDispatcher.cancelTask(self.refreshCD, self)
	TaskDispatcher.runRepeat(self.refreshCD, self, 0.01)
end

function TowerComposeHeroGroupSupportItem:refreshUI()
	gohelper.setActive(self.itemGO, true)

	self.inPlaneId = TowerComposeHeroGroupModel.instance:checkBuffInPlane(self.themeId, TowerComposeEnum.TeamBuffType.Support, self.supportConfig.id, self.isNormalEpisode)
	self.curPlaneId, self.curBuffType = TowerComposeHeroGroupModel.instance:getCurSelectPlaneIdAndType()

	gohelper.setActive(self.goSelect1, (self.inPlaneId ~= 1 or self.curPlaneId ~= 1 or nil) and self.isNormalEpisode and self.inPlaneId == 0)
	gohelper.setActive(self.goSelect2, self.inPlaneId == 2 and self.curPlaneId == 2)
	gohelper.setActive(self.goIsIn1, (self.inPlaneId ~= 1 or nil) and self.isNormalEpisode and self.inPlaneId == 0)
	gohelper.setActive(self.goIsIn2, self.inPlaneId == 2)

	self.heroMo = HeroModel.instance:getByHeroId(self.heroId)

	local heroConfig = HeroConfig.instance:getHeroCO(self.heroId)

	self.isHeroInTeams = TowerComposeHeroGroupModel.instance:checkHeroIsInTeam(self.heroId)

	self:refreshAssist()

	self.txtName.text = self.heroMo and (self.isHeroInTeams and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towercompose_inTeams"), heroConfig.name) or heroConfig.name) or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towercompose_notHave"), heroConfig.name)

	local activeDesc = self.supportConfig.activeType == TowerComposeEnum.ActiveType.Active and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towercompose_activeEffect"), self.supportConfig.coldTime) or luaLang("towercompose_passiveEffect")
	local heroTag = luaLang("towercompose_heroTag" .. self.supportConfig.heroTag) or ""

	self.txtActive.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towercompose_activeEffectDesc"), heroTag, activeDesc)

	local replaceDesc = SkillHelper.buildDesc(self.supportConfig.desc)

	if not self.assistHeroMo then
		local curHeroMo = self.heroMo

		self.txtDesc.text = TowerComposeModel.instance:replaceLevelSkillDesc(replaceDesc, (curHeroMo or nil) and (curHeroMo.exSkillLevel or 0))

		self.descFixTmpBreakLine:refreshTmpContent(self.txtDesc)
		gohelper.setActive(self.txtLevel, curHeroMo ~= nil)
		gohelper.setActive(self.goExskill, curHeroMo ~= nil)
		gohelper.setActive(self.goMask, curHeroMo == nil and self.assistHeroId ~= self.heroId)

		if curHeroMo then
			self.imageExskill.fillAmount = SummonCustomPickChoiceItem.exSkillFillAmount[curHeroMo.exSkillLevel] or 0

			local showLevel, rank = HeroConfig.instance:getShowLevel(curHeroMo.level)
			local tmpRank = rank - 1

			for index, rankItem in ipairs(self.rankList) do
				gohelper.setActive(rankItem, index == tmpRank)
			end

			gohelper.setActive(self.goRank, tmpRank > 0)

			self.txtLevel.text = string.format("Lv.%s", showLevel)

			local skinId = curHeroMo.skin
			local skinConfig = SkinConfig.instance:getSkinCo(skinId)

			self.simageHeroIcon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
		else
			local skinId = heroConfig.skinId
			local skinConfig = SkinConfig.instance:getSkinCo(skinId)

			self.simageHeroIcon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
			gohelper.setActive(self.goRank, false)
		end

		local rare = heroConfig.rare

		UISpriteSetMgr.instance:setCommonSprite(self.imageRare, "equipbar" .. CharacterEnum.Color[rare])

		local strCareer = tostring(heroConfig.career)

		UISpriteSetMgr.instance:setCommonSprite(self.imageCareer, "lssx_" .. strCareer)
	end
end

function TowerComposeHeroGroupSupportItem:refreshAssist()
	self.assistHeroInPlane = TowerComposeHeroGroupModel.instance:checkAssistInPlane(self.themeId, self.heroId, self.towerEpisodeConfig.plane)

	local saveAssistHeroData = self.assistHeroInPlane > -1 and TowerComposeHeroGroupModel.instance:getThemePlaneAssistData(self.themeId, self.assistHeroInPlane) or nil

	self.assistHeroMo = saveAssistHeroData and saveAssistHeroData.heroId == self.heroId and saveAssistHeroData or nil

	local assistData = self.assistHeroInPlane > -1 and TowerComposeHeroGroupModel.instance:getThemePlaneAssistData(self.themeId, self.assistHeroInPlane) or {}

	self.assistId = assistData.heroUid or 0
	self.assistHeroId = assistData.heroId or 0

	gohelper.setActive(self.goAssistCancel, not self.isHeroInTeams and self.assistHeroId == self.heroId)
	gohelper.setActive(self.goAssistNormal, not self.isHeroInTeams and self.assistHeroId ~= self.heroId)
	gohelper.setActive(self.goAssistInTeam, self.isHeroInTeams and self.assistHeroId ~= self.heroId)
	self:refreshCD()
end

function TowerComposeHeroGroupSupportItem:refreshCD()
	local cdRate = PickAssistController.instance:getRefreshCDRate()

	self.isInCD = cdRate > 0
	self.imageAssistCD.fillAmount = cdRate

	gohelper.setActive(self.goAssistCD, self.isInCD)
end

function TowerComposeHeroGroupSupportItem:_onHyperLinkClick(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipView(tonumber(effId), clickPosition)
end

function TowerComposeHeroGroupSupportItem:onDestroy()
	TaskDispatcher.cancelTask(self.refreshCD, self)
end

return TowerComposeHeroGroupSupportItem
