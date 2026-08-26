-- chunkname: @modules/logic/tower/view/permanenttower/TowerPermanentInfoView.lua

module("modules.logic.tower.view.permanenttower.TowerPermanentInfoView", package.seeall)

local TowerPermanentInfoView = class("TowerPermanentInfoView", BaseView)

function TowerPermanentInfoView:onInitView()
	self._txtepisode = gohelper.findChildText(self.viewGO, "right/Title/#txt_episode")
	self._txtname = gohelper.findChildText(self.viewGO, "right/Title/#txt_name")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "right/Title/txt_TitleEn")
	self._btnenemyInfo = gohelper.findChildButtonWithAudio(self.viewGO, "right/Title/#btn_enemyInfo")
	self._gorecommendAttr = gohelper.findChild(self.viewGO, "right/#go_recommendAttr")
	self._goattritem = gohelper.findChild(self.viewGO, "right/#go_recommendAttr/attrlist/#go_attritem")
	self._txtrecommonddes = gohelper.findChildText(self.viewGO, "right/#go_recommendAttr/#txt_recommonddes")
	self._txtrecommendLevel = gohelper.findChildText(self.viewGO, "right/recommendlevel/#txt_recommendLevel")
	self._txtdesc = gohelper.findChildText(self.viewGO, "right/desc/Viewport/#txt_desc")
	self._gocurherogroup = gohelper.findChild(self.viewGO, "right/#go_curherogroup")
	self._goherogroupItem = gohelper.findChild(self.viewGO, "right/#go_curherogroup/#go_herogroupItem")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_reset")
	self._golock = gohelper.findChild(self.viewGO, "right/#btn_fight/#go_lock")
	self._gostart = gohelper.findChild(self.viewGO, "right/#btn_fight/#go_start")
	self._gorestart = gohelper.findChild(self.viewGO, "right/#btn_fight/#go_restart")
	self._gostartElite = gohelper.findChild(self.viewGO, "right/#btn_fight/#go_startelite")
	self._gorestartElite = gohelper.findChild(self.viewGO, "right/#btn_fight/#go_restartelite")
	self._btnlock = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_fight/#go_lock")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_fight/#go_start")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_fight/#go_restart")
	self._btnstartElite = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_fight/#go_startelite")
	self._btnrestartElite = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_fight/#go_restartelite")
	self._gomopup = gohelper.findChild(self.viewGO, "#go_mopup")
	self._btnticket = gohelper.findChildButtonWithAudio(self.viewGO, "#go_mopup/ticket/#btn_ticket")
	self._imageticket = gohelper.findChildImage(self.viewGO, "#go_mopup/ticket/#btn_ticket/#image_ticket")
	self._txtticketNum = gohelper.findChildText(self.viewGO, "#go_mopup/ticket/#btn_ticket/#txt_ticketNum")
	self._btnmopup = gohelper.findChildButtonWithAudio(self.viewGO, "#go_mopup/#btn_mopup")
	self._goMopUpReddot = gohelper.findChild(self.viewGO, "#go_mopup/#btn_mopup/#go_mopupReddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerPermanentInfoView:addEvents()
	self._btnenemyInfo:AddClickListener(self._btnenemyInfoOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnlock:AddClickListener(self._btnfightOnClick, self)
	self._btnstart:AddClickListener(self._btnfightOnClick, self)
	self._btnrestart:AddClickListener(self._btnfightOnClick, self)
	self._btnstartElite:AddClickListener(self._btnfightOnClick, self)
	self._btnrestartElite:AddClickListener(self._btnfightOnClick, self)
	self._btnticket:AddClickListener(self._btnticketOnClick, self)
	self._btnmopup:AddClickListener(self._btnmopupOnClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.SelectPermanentEpisode, self.refreshUI, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnTowerResetSubEpisode, self.refreshUI, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerMopUp, self.refreshTicket, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.refreshTicket, self)
end

function TowerPermanentInfoView:removeEvents()
	self._btnenemyInfo:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnlock:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnstartElite:RemoveClickListener()
	self._btnrestartElite:RemoveClickListener()
	self._btnticket:RemoveClickListener()
	self._btnmopup:RemoveClickListener()
	self.removeEventCb(self, TowerController.instance, TowerEvent.SelectPermanentEpisode, self.refreshUI, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnTowerResetSubEpisode, self.refreshUI, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerMopUp, self.refreshTicket, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.refreshTicket, self)
end

function TowerPermanentInfoView:_btnenemyInfoOnClick()
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(self.episodeCo.battleId)
end

function TowerPermanentInfoView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.TowerResetPermanentEpisode, MsgBoxEnum.BoxType.Yes_No, self.sendTowerResetSubEpisodeRequest, nil, nil, self)
end

function TowerPermanentInfoView:sendTowerResetSubEpisodeRequest()
	TowerRpc.instance:sendTowerResetSubEpisodeRequest(TowerEnum.TowerType.Normal, TowerEnum.PermanentTowerId, self.layerConfig.layerId, self.curSelectEpisodeId)
end

function TowerPermanentInfoView:_btnfightOnClick()
	if not self.layerConfig then
		return
	end

	local isLayerUnlock = TowerPermanentModel.instance:checkLayerUnlock(self.layerConfig)

	if not isLayerUnlock then
		return
	end

	local param = {}

	param.towerType = TowerEnum.TowerType.Normal
	param.towerId = TowerEnum.PermanentTowerId
	param.layerId = self.layerConfig.layerId
	param.episodeId = self.curSelectEpisodeId

	TowerController.instance:enterFight(param)
end

function TowerPermanentInfoView:_btnticketOnClick()
	local ticketId = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon)
end

function TowerPermanentInfoView:_btnmopupOnClick()
	TowerController.instance:openTowerMopUpView()
end

function TowerPermanentInfoView:_editableInitView()
	self.simageHeroGroupTab = self:getUserDataTb_()
	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animEventWrap:AddEventListener("switchright", self.refreshUI, self)
end

function TowerPermanentInfoView:onUpdateParam()
	return
end

function TowerPermanentInfoView:onOpen()
	RedDotController.instance:addRedDot(self._goMopUpReddot, RedDotEnum.DotNode.TowerMopUp)
	self:refreshUI()
	self:refreshTicket()
end

function TowerPermanentInfoView:refreshUI()
	self.permanentTowerMo = TowerModel.instance:getCurPermanentMo()
	self.isDeepLayerUnlock = TowerPermanentDeepModel.instance:checkDeepLayerUnlock()
	self.isEnterDeepGuideFinish = TowerPermanentDeepModel.instance:checkEnterDeepLayerGuideFinish()
	self.isInDeepLayer = TowerPermanentDeepModel.instance:getIsInDeepLayerState()
	self.canShowDeep = self.isDeepLayerUnlock and self.isEnterDeepGuideFinish and self.isInDeepLayer

	if self.canShowDeep then
		return
	end

	self.curSelectEpisodeId = TowerPermanentModel.instance:getCurSelectEpisodeId()

	local realSelectStage, realSelectLayerIndex = TowerPermanentModel.instance:getRealSelectStage()

	self.layerConfig = TowerConfig.instance:getPermanentEpisodeLayerCo(realSelectStage, realSelectLayerIndex)
	self.episodeCo = lua_episode.configDict[self.curSelectEpisodeId]

	DungeonModel.instance:SetSendChapterEpisodeId(self.episodeCo.chapterId, self.episodeCo.id)

	self.isElite = self.layerConfig.isElite == 1
	self._txtepisode.text = "ST - " .. realSelectLayerIndex
	self._txtname.text = GameUtil.setFirstStrSize(self.episodeCo.name, 90)
	self._txtTitleEn.text = self.episodeCo.name_En
	self._txtdesc.text = self.episodeCo.desc

	local isEpisodeFinish, subEpisodeMo = TowerPermanentModel.instance:checkLayerSubEpisodeFinish(self.layerConfig.layerId, self.curSelectEpisodeId)
	local isPassLayer = self.layerConfig.layerId <= self.permanentTowerMo.passLayerId
	local isLayerUnlock = TowerPermanentModel.instance:checkLayerUnlock(self.layerConfig)

	gohelper.setActive(self._golock, not isLayerUnlock)
	gohelper.setActive(self._gorestart, isPassLayer and isLayerUnlock and not self.isElite)
	gohelper.setActive(self._gostart, not isPassLayer and isLayerUnlock and not self.isElite)
	gohelper.setActive(self._gorestartElite, isEpisodeFinish and isLayerUnlock and self.isElite)
	gohelper.setActive(self._gostartElite, not isEpisodeFinish and isLayerUnlock and self.isElite)
	gohelper.setActive(self._gocurherogroup, isEpisodeFinish and subEpisodeMo and #subEpisodeMo.heroIds > 0)
	gohelper.setActive(self._btnreset.gameObject, isEpisodeFinish and subEpisodeMo and #subEpisodeMo.heroIds > 0)

	if subEpisodeMo then
		local heroGroupDataList = {}
		local assistBossId = subEpisodeMo.assistBossId

		if assistBossId > 0 then
			table.insert(heroGroupDataList, {
				isAssistBoss = true,
				id = assistBossId
			})
		end

		for index, heroId in ipairs(subEpisodeMo.heroIds) do
			table.insert(heroGroupDataList, {
				id = heroId
			})
		end

		gohelper.CreateObjList(self, self.showHeroGroupItem, heroGroupDataList, self._gocurherogroup, self._goherogroupItem)
	end

	local fightParam = FightModel.instance:getFightParam()

	if fightParam then
		fightParam:setEpisodeId(self.episodeCo.id)
	end

	self:refreshRecommend()
end

function TowerPermanentInfoView:showHeroGroupItem(obj, data, index)
	local goHeroItem = gohelper.findChild(obj, "go_herogItem")
	local goBossItem = gohelper.findChild(obj, "go_bossItem")
	local simageHeroIcon = gohelper.findChildSingleImage(goHeroItem, "simage_hero")
	local simageBossIcon = gohelper.findChildSingleImage(goBossItem, "simage_enemy")
	local simageIconList = {
		simageHeroIcon,
		simageBossIcon
	}

	gohelper.setActive(goHeroItem, not data.isAssistBoss)
	gohelper.setActive(goBossItem, data.isAssistBoss)

	if data.isAssistBoss then
		local assistBossConfig = TowerConfig.instance:getAssistBossConfig(data.id)
		local skinConfig = FightConfig.instance:getSkinCO(assistBossConfig.skinId)

		simageBossIcon:LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))
	else
		local heroMO = HeroModel.instance:getByHeroId(data.id)
		local skinConfig = {}

		if not heroMO then
			local heroCo = HeroConfig.instance:getHeroCO(data.id)

			skinConfig = SkinConfig.instance:getSkinCo(heroCo.skinId)
		else
			skinConfig = FightConfig.instance:getSkinCO(heroMO.skin)
		end

		simageHeroIcon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.retangleIcon))
	end

	self.simageHeroGroupTab[index] = simageIconList
end

function TowerPermanentInfoView:refreshRecommend()
	local recommendLevel = FightHelper.getBattleRecommendLevel(self.episodeCo.battleId)

	self._txtrecommendLevel.text = recommendLevel >= 0 and HeroConfig.instance:getLevelDisplayVariant(recommendLevel) or ""

	local recommended, counter = TowerController.instance:getRecommendList(self.episodeCo.battleId)

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, gohelper.findChild(self._gorecommendAttr.gameObject, "attrlist"), self._goattritem)

	self._txtrecommonddes.text = #recommended == 0 and luaLang("new_common_none") or ""
end

function TowerPermanentInfoView:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function TowerPermanentInfoView:refreshTicket()
	local mopUpOpenLayerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)
	local isOpenMopUp = self.permanentTowerMo.passLayerId >= tonumber(mopUpOpenLayerNum)

	gohelper.setActive(self._gomopup, isOpenMopUp)

	if not isOpenMopUp then
		return
	end

	local curMopUpTimes = TowerModel.instance:getMopUpTimes()
	local maxMopUpTimes = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)

	self._txtticketNum.text = string.format("%s/%s", curMopUpTimes, maxMopUpTimes)

	local ticketId = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageticket, ticketId .. "_1", true)
end

function TowerPermanentInfoView:onClose()
	return
end

function TowerPermanentInfoView:onDestroyView()
	for _, simageHeroGroupList in pairs(self.simageHeroGroupTab) do
		for index, simageHeroGroup in pairs(simageHeroGroupList) do
			simageHeroGroup:UnLoadImage()
		end
	end

	self._animEventWrap:RemoveAllEventListener()
end

return TowerPermanentInfoView
