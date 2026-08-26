-- chunkname: @modules/logic/tower/view/timelimittower/TowerTimeLimitLevelInfoView.lua

module("modules.logic.tower.view.timelimittower.TowerTimeLimitLevelInfoView", package.seeall)

local TowerTimeLimitLevelInfoView = class("TowerTimeLimitLevelInfoView", BaseView)

function TowerTimeLimitLevelInfoView:onInitView()
	self._godetailInfo = gohelper.findChild(self.viewGO, "root/#go_detailInfo")
	self._txtIndex = gohelper.findChildText(self.viewGO, "root/#go_detailInfo/#txt_Index")
	self._txtTitle = gohelper.findChildText(self.viewGO, "root/#go_detailInfo/#txt_Title")
	self._txten = gohelper.findChildText(self.viewGO, "root/#go_detailInfo/#txt_en")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_detailInfo/#btn_detail")
	self._gorecommendAttr = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#go_recommendAttr")
	self._goattritem = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#go_recommendAttr/attrlist/#go_attritem")
	self._txtrecommonddes = gohelper.findChildText(self.viewGO, "root/#go_detailInfo/#go_recommendAttr/#txt_recommonddes")
	self._txtrecommendLevel = gohelper.findChildText(self.viewGO, "root/#go_detailInfo/recommendtxt/#txt_recommendLevel")
	self._goadditionRule = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#go_additionRule")
	self._scrollrules = gohelper.findChildScrollRect(self.viewGO, "root/#go_detailInfo/#go_additionRule/#scroll_rules")
	self._gorules = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#go_additionRule/#scroll_rules/Viewport/#go_rules")
	self._goruletemp = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#go_additionRule/#scroll_rules/Viewport/#go_rules/#go_ruletemp")
	self._godifficulty = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#go_difficulty")
	self._goeasy = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#go_difficulty/#go_easy")
	self._gonormal = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#go_difficulty/#go_normal")
	self._gohard = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#go_difficulty/#go_hard")
	self._btnswitchleft = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_detailInfo/#go_difficulty/#btn_switchleft")
	self._btnswitchright = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_detailInfo/#go_difficulty/#btn_switchright")
	self._txtmultiIndex = gohelper.findChildText(self.viewGO, "root/#go_detailInfo/#go_difficulty/index/#txt_multiIndex")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_detailInfo/#btn_Start")
	self._btnStartAgain = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_detailInfo/#btn_StartAgain")
	self._btnrefresh = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/#btn_refresh")
	self._goruleWindow = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#go_rulewindow")
	self._btncloseRule = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_detailInfo/#go_rulewindow/#go_ruledesc/#btn_closerule")
	self._goruleItem = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#go_rulewindow/#go_ruledesc/bg/#go_ruleDescList/#go_ruleitem")
	self._goruleDescList = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#go_rulewindow/#go_ruledesc/bg/#go_ruleDescList")
	self._goenemy = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/#go_enemy")
	self._simageenemy = gohelper.findChildSingleImage(self.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/#go_enemy/#simage_enemy")
	self._gohero = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/hero")
	self._goheroitem = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/hero/heroItem")
	self._goSwitchEfeect = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#go_difficulty/index/vx_refresh")
	self._goScore = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#go_score")
	self._txtScore = gohelper.findChildText(self.viewGO, "root/#go_detailInfo/#go_score/txt_score")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerTimeLimitLevelInfoView:addEvents()
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._btnswitchleft:AddClickListener(self._btnswitchleftOnClick, self)
	self._btnswitchright:AddClickListener(self._btnswitchrightOnClick, self)
	self._btnStart:AddClickListener(self._btnStartOnClick, self)
	self._btnStartAgain:AddClickListener(self._btnStartAgainOnClick, self)
	self._btnrefresh:AddClickListener(self._btnrefreshOnClick, self)
	self._btncloseRule:AddClickListener(self._btnCloseRuleOnClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnTowerResetSubEpisode, self.refreshUI, self)
end

function TowerTimeLimitLevelInfoView:removeEvents()
	self._btndetail:RemoveClickListener()
	self._btnswitchleft:RemoveClickListener()
	self._btnswitchright:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnStartAgain:RemoveClickListener()
	self._btnrefresh:RemoveClickListener()
	self._btncloseRule:RemoveClickListener()
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnTowerResetSubEpisode, self.refreshUI, self)
end

function TowerTimeLimitLevelInfoView:_btndetailOnClick()
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(self.episodeConfig.battleId)
end

function TowerTimeLimitLevelInfoView:_btnadditionRuleclickOnClick()
	if self._ruleDataList and #self._ruleDataList > 0 then
		ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
			ruleList = self._ruleDataList
		})
	end
end

function TowerTimeLimitLevelInfoView:_btnswitchleftOnClick()
	if self.difficulty == TowerEnum.Difficulty.Easy then
		return
	end

	self.difficulty = Mathf.Max(self.difficulty - 1, TowerEnum.Difficulty.Easy)

	gohelper.setActive(self._goSwitchEfeect, false)
	gohelper.setActive(self._goSwitchEfeect, true)
	TowerTimeLimitLevelModel.instance:setEntranceDifficulty(self.entranceId, self.difficulty)
	self:refreshUI()
end

function TowerTimeLimitLevelInfoView:_btnswitchrightOnClick()
	if self.difficulty == TowerEnum.Difficulty.Hard then
		return
	end

	self.difficulty = Mathf.Min(self.difficulty + 1, TowerEnum.Difficulty.Hard)

	gohelper.setActive(self._goSwitchEfeect, false)
	gohelper.setActive(self._goSwitchEfeect, true)
	TowerTimeLimitLevelModel.instance:setEntranceDifficulty(self.entranceId, self.difficulty)
	self:refreshUI()
end

function TowerTimeLimitLevelInfoView:_btnStartOnClick()
	TowerTimeLimitLevelModel.instance:saveLastEntranceDifficulty(self.curOpenMo)

	local param = {}

	param.towerType = TowerEnum.TowerType.Limited
	param.towerId = self.seasonId
	param.layerId = self.layerId
	param.difficulty = self.difficulty
	param.episodeId = self.episodeConfig.id

	TowerController.instance:enterFight(param)
end

function TowerTimeLimitLevelInfoView:_btnStartAgainOnClick()
	self:_btnStartOnClick()
end

function TowerTimeLimitLevelInfoView:_btnrefreshOnClick()
	local towerInfoMo = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, self.seasonId)
	local curMaxScore = towerInfoMo:getLayerScore(self.layerId)

	GameFacade.showMessageBox(MessageBoxIdDefine.TowerResetSubEpisode, MsgBoxEnum.BoxType.Yes_No, self.sendDecomposeEquipRequest, nil, nil, self, nil, nil, curMaxScore)
end

function TowerTimeLimitLevelInfoView:sendDecomposeEquipRequest()
	TowerRpc.instance:sendTowerResetSubEpisodeRequest(TowerEnum.TowerType.Limited, self.seasonId, self.layerId, 0, self.refreshUI, self)
end

function TowerTimeLimitLevelInfoView:_btnCloseRuleOnClick()
	gohelper.setActive(self._goruleWindow, false)
end

function TowerTimeLimitLevelInfoView:_editableInitView()
	self.goRoot = gohelper.findChild(self.viewGO, "root")
	self._animEventWrap = self.goRoot:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animEventWrap:AddEventListener("switch", self.refreshUI, self)

	self.ruleItemTab = self:getUserDataTb_()

	gohelper.setActive(self._goruleWindow, false)

	self.difficultyItemTab = {
		self._goeasy,
		self._gonormal,
		self._gohard
	}
	self.heroItemTab = self:getUserDataTb_()
	self.goLightLeftArrow = gohelper.findChild(self._btnswitchleft.gameObject, "light")
	self.goDarkLeftArrow = gohelper.findChild(self._btnswitchleft.gameObject, "dark")
	self.goLightRightArrow = gohelper.findChild(self._btnswitchright.gameObject, "light")
	self.goDarkRightArrow = gohelper.findChild(self._btnswitchright.gameObject, "dark")
end

function TowerTimeLimitLevelInfoView:onUpdateParam()
	return
end

function TowerTimeLimitLevelInfoView:onOpen()
	self.curOpenMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if self.curOpenMo then
		self.seasonId = self.curOpenMo.towerId

		TowerTimeLimitLevelModel.instance:initEntranceDifficulty(self.curOpenMo)
	else
		logError("数据异常，当前没有开启的限时塔")

		return
	end
end

function TowerTimeLimitLevelInfoView:refreshUI()
	self.entranceId = TowerTimeLimitLevelModel.instance.curSelectEntrance

	if self.entranceId == 0 or self.seasonId == 0 then
		return
	end

	self.difficulty = TowerTimeLimitLevelModel.instance:getEntranceDifficulty(self.entranceId)

	local limitedEpisodeCo = TowerConfig.instance:getTowerLimitedTimeCoByDifficulty(self.seasonId, self.entranceId, self.difficulty)
	local episodeId = limitedEpisodeCo.episodeId

	self.episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	self._txtIndex.text = string.format("SP%s", self.entranceId)
	self._txtTitle.text = self.episodeConfig.name
	self._txten.text = self.episodeConfig.name_En

	local multiIndex = TowerTimeLimitLevelModel.instance:getDifficultyMulti(self.difficulty)

	self._txtmultiIndex.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_multiindex"), {
		multiIndex
	})

	self:refreshDifficulty()
	self:refreshRecommend()
	self:refreshAdditionRule()
	self:refreshHeroList()
	self:refreshScore()
end

function TowerTimeLimitLevelInfoView:refreshDifficulty()
	for index = 1, 3 do
		gohelper.setActive(self.difficultyItemTab[index], index == self.difficulty)
	end

	gohelper.setActive(self.goLightLeftArrow, self.difficulty > TowerEnum.Difficulty.Easy)
	gohelper.setActive(self.goDarkLeftArrow, self.difficulty == TowerEnum.Difficulty.Easy)
	gohelper.setActive(self.goLightRightArrow, self.difficulty < TowerEnum.Difficulty.Hard)
	gohelper.setActive(self.goDarkRightArrow, self.difficulty == TowerEnum.Difficulty.Hard)
end

function TowerTimeLimitLevelInfoView:refreshRecommend()
	local recommendLevel = FightHelper.getBattleRecommendLevel(self.episodeConfig.battleId)

	self._txtrecommendLevel.text = recommendLevel >= 0 and HeroConfig.instance:getLevelDisplayVariant(recommendLevel) or ""

	local recommended, counter = TowerController.instance:getRecommendList(self.episodeConfig.battleId)

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, gohelper.findChild(self._gorecommendAttr.gameObject, "attrlist"), self._goattritem)

	self._txtrecommonddes.text = #recommended == 0 and luaLang("new_common_none") or ""

	gohelper.setActive(self._txtrecommonddes, #recommended == 0)
end

function TowerTimeLimitLevelInfoView:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function TowerTimeLimitLevelInfoView:refreshAdditionRule()
	local battleCo = lua_battle.configDict[self.episodeConfig.battleId]

	if battleCo then
		if not battleCo.additionRule then
			local additionRule = ""
			local ruleList = FightStrUtil.instance:getSplitString2Cache(additionRule, true, "|", "#")

			self._ruleDataList = ruleList

			if not ruleList or #ruleList == 0 then
				gohelper.setActive(self._goadditionRule, false)

				return
			end

			gohelper.setActive(self._goadditionRule, true)
			gohelper.CreateObjList(self, self.ruleItemShow, ruleList, self._gorules, self._goruletemp)
		end
	end
end

function TowerTimeLimitLevelInfoView:ruleItemShow(obj, data, index)
	local ruleItem = self.ruleItemTab[index]

	if not ruleItem then
		ruleItem = {}
		self.ruleItemTab[index] = ruleItem
	end

	ruleItem.go = obj
	ruleItem.tagicon = gohelper.findChildImage(ruleItem.go, "image_tagicon")
	ruleItem.simage = gohelper.findChildImage(ruleItem.go, "")
	ruleItem.btnClick = gohelper.findChildButtonWithAudio(ruleItem.go, "btn_additionRuleclick")

	local targetId = data[1]
	local ruleId = data[2]
	local ruleCo = lua_rule.configDict[ruleId]

	UISpriteSetMgr.instance:setCommonSprite(ruleItem.tagicon, "wz_" .. targetId)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(ruleItem.simage, ruleCo.icon)
	ruleItem.btnClick:AddClickListener(self._btnadditionRuleclickOnClick, self)
end

function TowerTimeLimitLevelInfoView:ruleDescWindowShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")
	local tag = gohelper.findChildImage(obj, "tag")
	local desc = gohelper.findChildText(obj, "desc")
	local targetId = data[1]
	local ruleId = data[2]
	local ruleCo = lua_rule.configDict[ruleId]

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(icon, ruleCo.icon)
	UISpriteSetMgr.instance:setCommonSprite(tag, "wz_" .. targetId)
	SkillHelper.addHyperLinkClick(desc)

	local srcDesc = ruleCo.desc
	local descContent = SkillHelper.buildDesc(srcDesc, nil, "#6680bd")
	local side = luaLang("dungeon_add_rule_target_" .. targetId)
	local tagColor = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local color = tagColor[targetId]

	desc.text = string.format("<color=%s>[%s]</color>%s", color, side, descContent)
end

function TowerTimeLimitLevelInfoView:refreshHeroList()
	local towerInfoMo = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, self.seasonId)
	local towerCoList = TowerConfig.instance:getTowerLimitedTimeCoList(self.seasonId, self.entranceId)

	self.layerId = towerCoList[1].layerId

	local subEpisodeMoList = towerInfoMo:getLayerSubEpisodeList(self.layerId)

	if subEpisodeMoList then
		if not subEpisodeMoList[1].assistBossId then
			local assistBossId = 0

			if subEpisodeMoList then
				if not subEpisodeMoList[1].heroIds then
					local heroIdList = {}

					self._simageenemy = gohelper.findChildSingleImage(self.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/#go_enemy/#simage_enemy")

					gohelper.setActive(self._goenemy, assistBossId > 0)

					if assistBossId > 0 then
						local assistBossConfig = TowerConfig.instance:getAssistBossConfig(assistBossId)
						local skinConfig = FightConfig.instance:getSkinCO(assistBossConfig.skinId)

						self._simageenemy:LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))
					end

					gohelper.setActive(self._btnStartAgain, heroIdList and #heroIdList > 0)
					gohelper.setActive(self._btnStart, not heroIdList or #heroIdList == 0)

					if heroIdList and #heroIdList > 0 then
						gohelper.CreateObjList(self, self._onHeroItemShow, heroIdList, self._gohero, self._goheroitem)
					end
				end
			end
		end
	end
end

function TowerTimeLimitLevelInfoView:_onHeroItemShow(obj, data, index)
	local heroItem = self.heroItemTab[index]

	if not heroItem then
		heroItem = {
			simagehero = gohelper.findChildSingleImage(obj, "simage_hero")
		}
		self.heroItemTab[index] = heroItem
	end

	local skinConfig = {}
	local heroMO = HeroModel.instance:getByHeroId(data)

	if not heroMO then
		local heroCo = HeroConfig.instance:getHeroCO(data)

		skinConfig = SkinConfig.instance:getSkinCo(heroCo.skinId)
	else
		skinConfig = FightConfig.instance:getSkinCO(heroMO.skin)
	end

	heroItem.simagehero:LoadImage(ResUrl.getHeadIconSmall(skinConfig.retangleIcon))
end

function TowerTimeLimitLevelInfoView:refreshScore()
	local towerInfoMo = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, self.seasonId)
	local curMaxScore = towerInfoMo:getLayerScore(self.layerId)
	local subEpisodeMoList = towerInfoMo:getLayerSubEpisodeList(self.layerId)

	if subEpisodeMoList then
		if not subEpisodeMoList[1].heroIds then
			local heroIdList = {}

			gohelper.setActive(self._goScore, heroIdList and #heroIdList > 0)

			self._txtScore.text = curMaxScore
		end
	end
end

function TowerTimeLimitLevelInfoView:onClose()
	TowerTimeLimitLevelModel.instance:saveLastEntranceDifficulty(self.curOpenMo)
end

function TowerTimeLimitLevelInfoView:onDestroyView()
	for index, ruleItem in pairs(self.ruleItemTab) do
		ruleItem.btnClick:RemoveClickListener()
	end

	for index, heroItem in pairs(self.heroItemTab) do
		heroItem.simagehero:UnLoadImage()
	end

	self._simageenemy:UnLoadImage()
	self._animEventWrap:RemoveAllEventListener()
end

return TowerTimeLimitLevelInfoView
