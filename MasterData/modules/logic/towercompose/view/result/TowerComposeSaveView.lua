-- chunkname: @modules/logic/towercompose/view/result/TowerComposeSaveView.lua

module("modules.logic.towercompose.view.result.TowerComposeSaveView", package.seeall)

local TowerComposeSaveView = class("TowerComposeSaveView", BaseView)

function TowerComposeSaveView:onInitView()
	self._btncloseFullView = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeFullView")
	self._goteamContent = gohelper.findChild(self.viewGO, "#go_teamContent")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_teamContent/title/#txt_title")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_teamContent/title/#btn_close")
	self._gotips = gohelper.findChild(self.viewGO, "#go_teamContent/#go_tips")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_teamContent/#go_tips/#txt_tips")
	self._goteamItemContent = gohelper.findChild(self.viewGO, "#go_teamContent/#go_teamItemContent")
	self._goteamitem = gohelper.findChild(self.viewGO, "#go_teamContent/#go_teamItemContent/#go_teamitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeSaveView:addEvents()
	self._btncloseFullView:AddClickListener(self._btncloseFullViewOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshLoadState, self.closeThis, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.UpdateRecordReply, self.closeThis, self)
end

function TowerComposeSaveView:removeEvents()
	self._btncloseFullView:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshLoadState, self.closeThis, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.UpdateRecordReply, self.closeThis, self)
end

function TowerComposeSaveView:_btncloseFullViewOnClick()
	self:closeThis()
end

function TowerComposeSaveView:_btncloseOnClick()
	self:closeThis()
end

function TowerComposeSaveView:_onPlaneItemBtnContinueClick(planeItem)
	local curLockPlaneId = planeItem.planeId == 1 and 2 or 1

	GameFacade.showOptionMessageBox(MessageBoxIdDefine.TowerComposeFailRecordFight, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, function()
		TowerComposeRpc.instance:sendTowerComposeReChallengeRequest(self.themeId, planeItem.planeId)
	end, nil, nil, self, nil, nil, luaLang("towercompose_plane" .. planeItem.planeId), luaLang("towercompose_plane" .. planeItem.planeId), luaLang("towercompose_plane" .. curLockPlaneId))
end

function TowerComposeSaveView:_onPlaneItemBtnAgainClick(planeItem)
	local curLockPlaneId = planeItem.planeId == 1 and 2 or 1

	GameFacade.showOptionMessageBox(MessageBoxIdDefine.TowerComposeWinRecordFight, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, function()
		TowerComposeRpc.instance:sendTowerComposeReChallengeRequest(self.themeId, planeItem.planeId)
	end, nil, nil, self, nil, nil, luaLang("towercompose_plane" .. planeItem.planeId), luaLang("towercompose_plane" .. planeItem.planeId), luaLang("towercompose_plane" .. curLockPlaneId))
end

function TowerComposeSaveView:_onSaveBtnClick(teamItem)
	TowerComposeRpc.instance:sendTowerComposeUpdateRecordRequest(self.themeId, true)
end

function TowerComposeSaveView:_editableInitView()
	gohelper.setActive(self._goteamitem, false)

	self.teamItemMap = self:getUserDataTb_()
end

function TowerComposeSaveView:onUpdateParam()
	return
end

function TowerComposeSaveView:onOpen()
	self.operateType = self.viewParam.operateType
	self.themeId = self.viewParam.themeId
	self.modSlotNumMap = TowerComposeConfig.instance:getModSlotNumMap(self.themeId)

	self:refreshUI()
end

function TowerComposeSaveView:refreshUI()
	self.themeMo = TowerComposeModel.instance:getThemeMo(self.themeId)
	self._txttitle.text = self.operateType == TowerComposeEnum.TeamOperateType.Save and luaLang("towercompose_saveRecord") or luaLang("towercompose_loadRecord")

	if self.operateType == TowerComposeEnum.TeamOperateType.Save then
		self._txttips.text = luaLang("towercompose_save_tip")

		self:createAndRefreshTeamItem(TowerComposeEnum.SaveTeamState.Current)
		self:createAndRefreshTeamItem(TowerComposeEnum.SaveTeamState.Record)
	else
		local isAllPlaneSucc = self.themeMo:isAllPlaneSucc(true)

		self._txttips.text = isAllPlaneSucc and luaLang("towercompose_load_repeatFightTip") or luaLang("towercompose_load_continueFightTip")

		self:createAndRefreshTeamItem(TowerComposeEnum.SaveTeamState.Record)
	end
end

function TowerComposeSaveView:createAndRefreshTeamItem(saveTeamState)
	local isCurrent = saveTeamState == TowerComposeEnum.SaveTeamState.Current
	local isSaveState = self.operateType == TowerComposeEnum.TeamOperateType.Save
	local bossSettleMo = TowerComposeModel.instance:getBossSettleInfo()
	local recordInfoData = self.themeMo:getBossRecordInfoData()
	local bossMo = isCurrent and bossSettleMo and bossSettleMo:getRecordData().bossMo or recordInfoData and recordInfoData.bossMo

	if bossMo == nil then
		return
	end

	local teamItem = self.teamItemMap[saveTeamState]

	if not teamItem then
		teamItem = {
			saveTeamState = saveTeamState,
			go = gohelper.clone(self._goteamitem, self._goteamItemContent, "item" .. (isCurrent and "current" or "record"))
		}
		teamItem.goRecordBg = gohelper.findChild(teamItem.go, "bg/go_record")
		teamItem.goCurrentBg = gohelper.findChild(teamItem.go, "bg/go_current")
		teamItem.goAgain = gohelper.findChild(teamItem.go, "bg/go_again")
		teamItem.goFail = gohelper.findChild(teamItem.go, "teamInfo/plane2/fail")
		teamItem.planeInfoMap = {}

		for planeId = 1, 2 do
			local planeGO = gohelper.findChild(teamItem.go, "teamInfo/plane" .. planeId)

			teamItem.planeInfoMap[planeId] = self:createPlaneUI(planeGO)
		end

		teamItem.goSaveBtn = gohelper.findChild(teamItem.go, "teamInfo/go_saveBtn")
		teamItem.goCurRecord = gohelper.findChild(teamItem.go, "teamInfo/go_saveBtn/go_curRecord")
		teamItem.btnCover = gohelper.findChildButtonWithAudio(teamItem.go, "teamInfo/go_saveBtn/btn_cover")
		teamItem.goSucc = gohelper.findChild(teamItem.go, "enemyInfo/go_success")
		teamItem.goFail = gohelper.findChild(teamItem.go, "enemyInfo/go_fail")
		teamItem.simageBoss = gohelper.findChildSingleImage(teamItem.go, "enemyInfo/simage_boss")
		teamItem.imagePlaneLevel = gohelper.findChildImage(teamItem.go, "enemyInfo/image_planeLevel")
		teamItem.txtPlaneLevel = gohelper.findChildText(teamItem.go, "enemyInfo/txt_planeLevel")
		teamItem.txtBossScore = gohelper.findChildText(teamItem.go, "enemyInfo/score/txt_bossScore")

		teamItem.btnCover:AddClickListener(self._onSaveBtnClick, self, teamItem)
	end

	teamItem.bossMo = bossMo
	self.teamItemMap[saveTeamState] = teamItem

	gohelper.setActive(teamItem.goRecordBg, not isCurrent and isSaveState)
	gohelper.setActive(teamItem.goCurrentBg, isCurrent)
	gohelper.setActive(teamItem.goAgain, not isCurrent and not isSaveState)
	gohelper.setActive(teamItem.go, true)

	for planeId = 1, 2 do
		self:refreshPlaneUI(teamItem, planeId)
	end

	self:refreshEnemyInfo(teamItem)
	gohelper.setActive(teamItem.goSaveBtn, self.operateType == TowerComposeEnum.TeamOperateType.Save)
	gohelper.setActive(teamItem.goCurRecord, teamItem.saveTeamState == TowerComposeEnum.SaveTeamState.Current)
	gohelper.setActive(teamItem.btnCover.gameObject, teamItem.saveTeamState == TowerComposeEnum.SaveTeamState.Record)
end

function TowerComposeSaveView:createPlaneUI(planeGO)
	local planeItem = {}

	planeItem.go = planeGO
	planeItem.txtScoreNum = gohelper.findChildText(planeGO, "score/planeScore/txt_scoreNum")
	planeItem.heroItemMap = {}
	planeItem.goHeroContent = gohelper.findChild(planeGO, "go_heroContent")
	planeItem.goheroItem = gohelper.findChild(planeGO, "go_heroContent/go_heroItem")

	gohelper.setActive(planeItem.goheroItem, false)

	planeItem.gosupportNormal = gohelper.findChild(planeGO, "buff/go_support/normal")
	planeItem.gosupportEquip = gohelper.findChild(planeGO, "buff/go_support/equiped")
	planeItem.simageSupport = gohelper.findChildSingleImage(planeGO, "buff/go_support/equiped/simage_support")
	planeItem.goresearchNormal = gohelper.findChild(planeGO, "buff/go_research/normal")
	planeItem.goresearchEquip = gohelper.findChild(planeGO, "buff/go_research/equiped")
	planeItem.imageResearch = gohelper.findChildImage(planeGO, "buff/go_research/equiped/image_research")
	planeItem.bodyModItemMap = {}
	planeItem.wordModItemMap = {}
	planeItem.goBodyModContent = gohelper.findChild(planeGO, "mod/go_bodyModContent")
	planeItem.goBodyModItem = gohelper.findChild(planeGO, "mod/go_bodyModContent/go_bodyModItem")
	planeItem.goWordModContent = gohelper.findChild(planeGO, "mod/go_wordModContent")
	planeItem.goWordModItem = gohelper.findChild(planeGO, "mod/go_wordModContent/go_wordModItem")
	planeItem.txtEnvName = gohelper.findChildText(planeGO, "environment/txt_envName")
	planeItem.imageEnvIcon = gohelper.findChildImage(planeGO, "environment/txt_envName/image_envIcon")

	gohelper.setActive(planeItem.goBodyModItem, false)
	gohelper.setActive(planeItem.goWordModItem, false)

	planeItem.goLoadBtn = gohelper.findChild(planeGO, "go_loadBtn")
	planeItem.goLock = gohelper.findChild(planeGO, "go_loadBtn/go_lock")
	planeItem.btnAgain = gohelper.findChildButtonWithAudio(planeGO, "go_loadBtn/btn_again")
	planeItem.btnContinue = gohelper.findChildButtonWithAudio(planeGO, "go_loadBtn/btn_continue")

	return planeItem
end

function TowerComposeSaveView:refreshPlaneUI(teamItem, planeId)
	local bossMo = teamItem.bossMo
	local planeMo = bossMo:getPlaneMo(planeId)
	local planeItem = teamItem.planeInfoMap[planeId]

	planeItem.txtScoreNum.text = planeMo.curScore
	planeItem.planeId = planeId
	planeItem.saveTeamState = teamItem.saveTeamState

	self:refreshTeamHero(planeItem, planeMo)
	self:refreshModItem(planeItem, planeMo)
	self:refreshRoleBuff(planeItem, planeMo)
	gohelper.setActive(planeItem.goLoadBtn, self.operateType == TowerComposeEnum.TeamOperateType.Load)

	if self.operateType == TowerComposeEnum.TeamOperateType.Load then
		local isAllPlaneSucc, failPlaneId = self.themeMo:isAllPlaneSucc(true)

		gohelper.setActive(planeItem.goLock, not isAllPlaneSucc and planeId ~= failPlaneId)
		gohelper.setActive(planeItem.btnContinue.gameObject, not isAllPlaneSucc and planeId == failPlaneId)
		gohelper.setActive(planeItem.btnAgain.gameObject, isAllPlaneSucc)
		planeItem.btnAgain:AddClickListener(self._onPlaneItemBtnAgainClick, self, planeItem)
		planeItem.btnContinue:AddClickListener(self._onPlaneItemBtnContinueClick, self, planeItem)
	end
end

function TowerComposeSaveView:refreshTeamHero(planeItem, planeMo)
	local teamInfoData = planeMo:getTeamInfoData()

	for pos = 1, 4 do
		local heroItem = planeItem.heroItemMap[pos]

		if heroItem == nil then
			heroItem = {
				go = gohelper.clone(planeItem.goheroItem, planeItem.goHeroContent, "heroItem" .. pos)
			}
			heroItem.simageRole = gohelper.findChildSingleImage(heroItem.go, "simage_role")
			heroItem.goEmpty = gohelper.findChild(heroItem.go, "go_empty")
			planeItem.heroItemMap[pos] = heroItem
		end

		gohelper.setActive(heroItem.go, true)

		if teamInfoData.heros then
			local heroData = teamInfoData.heros[pos]

			if heroData then
				if heroData.heroId == 0 and heroData.trialId > 0 then
					local trialCo = lua_hero_trial.configDict[heroData.trialId][0]
					local skinConfig = SkinConfig.instance:getSkinCo(trialCo.skin)

					heroItem.simageRole:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
				elseif heroData.heroId > 0 then
					local heroMo = HeroModel.instance:getByHeroId(heroData.heroId)
					local skinConfig = SkinConfig.instance:getSkinCo(heroMo.skin)

					heroItem.simageRole:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
				else
					gohelper.setActive(heroItem.simageRole.gameObject, false)
					gohelper.setActive(heroItem.goEmpty, true)
				end
			else
				gohelper.setActive(heroItem.simageRole.gameObject, false)
				gohelper.setActive(heroItem.goEmpty, true)
			end
		end
	end
end

function TowerComposeSaveView:refreshModItem(planeItem, planeMo)
	local bodyModSlotNum = self.modSlotNumMap[TowerComposeEnum.ModType.Body]

	for slot = 1, bodyModSlotNum do
		local modItem = planeItem.bodyModItemMap[slot]

		if not modItem then
			modItem = {
				go = gohelper.clone(planeItem.goBodyModItem, planeItem.goBodyModContent, "modItem" .. slot)
			}
			modItem.imageModBg = gohelper.findChildImage(modItem.go, "image_modBg")
			modItem.imageModIcon = gohelper.findChildImage(modItem.go, "image_modIcon")
			modItem.imageModColorIcon = gohelper.findChildImage(modItem.go, "image_modIcon_01")
			modItem.materialModIcon = UnityEngine.Object.Instantiate(modItem.imageModColorIcon.material)
			modItem.imageModLvColorIcon = gohelper.findChildImage(modItem.go, "image_modIcon_02")
			modItem.materialModLvIcon = UnityEngine.Object.Instantiate(modItem.imageModLvColorIcon.material)
			modItem.imageModColorIcon.material = modItem.materialModIcon
			modItem.imageModLvColorIcon.material = modItem.materialModLvIcon
			modItem.modIconComp = MonoHelper.addNoUpdateLuaComOnceToGo(modItem.go, TowerComposeModIconComp)
			planeItem.bodyModItemMap[slot] = modItem
		end

		gohelper.setActive(modItem.go, true)

		local modId = planeMo:getEquipModId(TowerComposeEnum.ModType.Body, slot)

		gohelper.setActive(modItem.imageModColorIcon.gameObject, modId > 0)
		modItem.modIconComp:refreshMod(modId, modItem.imageModIcon, modItem.imageModColorIcon, modItem.imageModLvColorIcon, modItem.materialModIcon, modItem.materialModLvIcon)
		UISpriteSetMgr.instance:setTower2Sprite(modItem.imageModBg, string.format("tower_new_frame%d_%d", slot, planeMo.planeId == 1 and 3 or 5))
	end

	local wordModSlotNum = self.modSlotNumMap[TowerComposeEnum.ModType.Word]

	for slot = 1, wordModSlotNum do
		local modItem = planeItem.wordModItemMap[slot]

		if not modItem then
			modItem = {
				go = gohelper.clone(planeItem.goWordModItem, planeItem.goWordModContent, "modItem" .. slot)
			}
			modItem.imageModIcon = gohelper.findChildImage(modItem.go, "image_modIcon")
			modItem.imageModColorIcon = gohelper.findChildImage(modItem.go, "image_modIcon_01")
			modItem.materialModIcon = UnityEngine.Object.Instantiate(modItem.imageModColorIcon.material)
			modItem.imageModLvColorIcon = gohelper.findChildImage(modItem.go, "image_modIcon_02")
			modItem.materialModLvIcon = UnityEngine.Object.Instantiate(modItem.imageModLvColorIcon.material)
			modItem.imageModColorIcon.material = modItem.materialModIcon
			modItem.imageModLvColorIcon.material = modItem.materialModLvIcon
			modItem.modIconComp = MonoHelper.addNoUpdateLuaComOnceToGo(modItem.go, TowerComposeModIconComp)
			planeItem.wordModItemMap[slot] = modItem
		end

		gohelper.setActive(modItem.go, true)

		local modId = planeMo:getEquipModId(TowerComposeEnum.ModType.Word, slot)

		gohelper.setActive(modItem.imageModColorIcon.gameObject, modId > 0)
		modItem.modIconComp:refreshMod(modId, modItem.imageModIcon, modItem.imageModColorIcon, modItem.imageModLvColorIcon, modItem.materialModIcon, modItem.materialModLvIcon)
	end

	local envModSlotNum = self.modSlotNumMap[TowerComposeEnum.ModType.Env]
	local modId = planeMo:getEquipModId(TowerComposeEnum.ModType.Env, envModSlotNum)
	local modconfig = TowerComposeConfig.instance:getComposeModConfig(modId)

	UISpriteSetMgr.instance:setTower2Sprite(planeItem.imageEnvIcon, modconfig.icon)

	planeItem.txtEnvName.text = modconfig.name
end

function TowerComposeSaveView:refreshRoleBuff(planeItem, planeMo)
	local teamInfoData = planeMo:getTeamInfoData()

	gohelper.setActive(planeItem.gosupportNormal, not teamInfoData.supportId or teamInfoData.supportId == 0)
	gohelper.setActive(planeItem.gosupportEquip, teamInfoData.supportId and teamInfoData.supportId > 0)
	gohelper.setActive(planeItem.goresearchNormal, not teamInfoData.researchId or teamInfoData.researchId == 0)
	gohelper.setActive(planeItem.goresearchEquip, teamInfoData.researchId and teamInfoData.researchId > 0)

	if teamInfoData.supportId and teamInfoData.supportId > 0 then
		local supportConfig = TowerComposeConfig.instance:getSupportCo(teamInfoData.supportId)
		local heroMo = HeroModel.instance:getByHeroId(supportConfig.heroId)
		local heroConfig = HeroConfig.instance:getHeroCO(supportConfig.heroId)

		if heroMo then
			if not heroMo.skin then
				local skinId = heroConfig.skinId

				skinId = teamInfoData.assistHero and teamInfoData.assistHero.heroId == supportConfig.heroId and teamInfoData.assistHero.skin > 0 and teamInfoData.assistHero.skin or skinId

				local skinConfig = SkinConfig.instance:getSkinCo(skinId)

				planeItem.simageSupport:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
			end
		end
	end

	if teamInfoData.researchId > 0 then
		local researchCo = TowerComposeConfig.instance:getResearchCo(teamInfoData.researchId)

		UISpriteSetMgr.instance:setTower2Sprite(planeItem.imageResearch, researchCo.icon)
	end
end

function TowerComposeSaveView:refreshEnemyInfo(teamItem)
	local isRecord = teamItem.saveTeamState == TowerComposeEnum.SaveTeamState.Record
	local isAllPlaneSucc = self.themeMo:isAllPlaneSucc(isRecord)

	gohelper.setActive(teamItem.goFail, not isAllPlaneSucc)
	gohelper.setActive(teamItem.goSucc, isAllPlaneSucc)

	local themeConfig = TowerComposeConfig.instance:getThemeConfig(self.themeId)
	local bossMonsterGroupId = themeConfig.monsterGroupId
	local bossGroupConfig = lua_monster_group.configDict[bossMonsterGroupId]
	local bossIdList = string.splitToNumber(bossGroupConfig.bossId, "#")
	local bossId = bossIdList[1]
	local monsterCo = lua_monster.configDict[bossId]
	local skinConfig = lua_monster_skin.configDict[monsterCo.skinId]

	teamItem.simageBoss:LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))

	local bossLevel = teamItem.bossMo.level
	local curLayerId = 1

	if self.operateType == TowerComposeEnum.TeamOperateType.Save then
		local fightParam = TowerComposeModel.instance:getRecordFightParam()

		curLayerId = fightParam.layerId
	else
		local themeId, layerId = TowerComposeModel.instance:getCurThemeIdAndLayer()

		curLayerId = layerId
	end

	local towerEpisodeCo = TowerComposeConfig.instance:getEpisodeConfig(self.themeId, curLayerId)
	local bossLvCo = TowerComposeConfig.instance:getBossLevelCo(towerEpisodeCo.episodeId, bossLevel)

	UISpriteSetMgr.instance:setTower2Sprite(teamItem.imagePlaneLevel, "tower_new_level_" .. string.lower(bossLvCo.levelReq))

	teamItem.txtPlaneLevel.text = string.format("Lv.%d", bossLevel)
	teamItem.txtBossScore.text = teamItem.bossMo.curScore
end

function TowerComposeSaveView:onClose()
	return
end

function TowerComposeSaveView:onDestroyView()
	for _, teamItem in pairs(self.teamItemMap) do
		for planeId, planeItem in pairs(teamItem.planeInfoMap) do
			planeItem.simageSupport:UnLoadImage()
			planeItem.btnContinue:RemoveClickListener()
			planeItem.btnAgain:RemoveClickListener()

			for _, heroItem in pairs(planeItem.heroItemMap) do
				heroItem.simageRole:UnLoadImage()
			end
		end

		teamItem.btnCover:RemoveClickListener()
		teamItem.simageBoss:UnLoadImage()
	end
end

return TowerComposeSaveView
