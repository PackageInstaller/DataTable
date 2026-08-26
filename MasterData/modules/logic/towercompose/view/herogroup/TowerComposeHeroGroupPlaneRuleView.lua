-- chunkname: @modules/logic/towercompose/view/herogroup/TowerComposeHeroGroupPlaneRuleView.lua

module("modules.logic.towercompose.view.herogroup.TowerComposeHeroGroupPlaneRuleView", package.seeall)

local TowerComposeHeroGroupPlaneRuleView = class("TowerComposeHeroGroupPlaneRuleView", BaseView)

function TowerComposeHeroGroupPlaneRuleView:onInitView()
	self._scrollplaneInfo = gohelper.findChildScrollRect(self.viewGO, "#go_container/#scroll_planeInfo")
	self._goplane1 = gohelper.findChild(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane1")
	self._gomodPlane1 = gohelper.findChild(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane1/targetList/#go_modPlane1")
	self._gobodyMod1 = gohelper.findChild(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane1/targetList/#go_modPlane1/layout/#go_bodyMod1")
	self._gobodyModItem1 = gohelper.findChild(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane1/targetList/#go_modPlane1/layout/#go_bodyMod1/#go_bodyModItem1")
	self._gowordMod1 = gohelper.findChild(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane1/targetList/#go_modPlane1/layout/#go_wordMod1")
	self._gowordModItem1 = gohelper.findChild(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane1/targetList/#go_modPlane1/layout/#go_wordMod1/#go_wordModItem1")
	self._btnenvironment1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane1/targetList/#go_modPlane1/layout/#btn_environment1")
	self._txtenv1 = gohelper.findChildText(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane1/targetList/#go_modPlane1/layout/#btn_environment1/#txt_env1")
	self._txtplaneScore1 = gohelper.findChildText(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane1/targetList/#go_modPlane1/layout/score1/#txt_planeScore1")
	self._imageenvIcon1 = gohelper.findChildImage(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane1/targetList/#go_modPlane1/layout/#btn_environment1/#txt_env1/#image_envIcon1")
	self._goempty1 = gohelper.findChild(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane1/targetList/#go_empty1")
	self._goplane2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane2")
	self._gomodPlane2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane2/targetList/#go_modPlane2")
	self._gobodyMod2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane2/targetList/#go_modPlane2/layout/#go_bodyMod2")
	self._gobodyModItem2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane2/targetList/#go_modPlane2/layout/#go_bodyMod2/#go_bodyModItem2")
	self._gowordMod2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane2/targetList/#go_modPlane2/layout/#go_wordMod2")
	self._gowordModItem2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane2/targetList/#go_modPlane2/layout/#go_wordMod2/#go_wordModItem2")
	self._btnenvironment2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane2/targetList/#go_modPlane2/layout/#btn_environment2")
	self._txtenv2 = gohelper.findChildText(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane2/targetList/#go_modPlane2/layout/#btn_environment2/#txt_env2")
	self._txtplaneScore2 = gohelper.findChildText(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane2/targetList/#go_modPlane2/layout/score2/#txt_planeScore2")
	self._imageenvIcon2 = gohelper.findChildImage(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane2/targetList/#go_modPlane2/layout/#btn_environment2/#txt_env2/#image_envIcon2")
	self._goempty2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane2/targetList/#go_empty2")
	self._btnplaneEnemy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/towercomposeEnemy/enemytitle/txten/#btn_planeEnemy")
	self._goenemyLock = gohelper.findChild(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/towercomposeEnemy/enemytitle/txten/#go_enemyLock")
	self._imageplaneLevel = gohelper.findChildImage(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/towercomposeEnemy/enemyInfo/#image_planeLevel")
	self._simageboss = gohelper.findChildSingleImage(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/towercomposeEnemy/enemyInfo/boss/#simage_boss")
	self._txtplaneLevel = gohelper.findChildText(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/towercomposeEnemy/enemyInfo/#txt_planeLevel")
	self._btnplaneExtraTips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/towercomposeEnemy/#btn_planeExtraTips")
	self._goextraTips = gohelper.findChild(self.viewGO, "#go_container/#go_extraTips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeHeroGroupPlaneRuleView:addEvents()
	self._btnplaneEnemy:AddClickListener(self._btnplaneEnemyOnClick, self)
	self._btnplaneExtraTips:AddClickListener(self._btnplaneExtraTipsOnClick, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshHeroGroupPointBase, self.refreshPlane, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshLoadState, self.refreshBossInfo, self)
end

function TowerComposeHeroGroupPlaneRuleView:removeEvents()
	self._btnBodyModPlane1:RemoveClickListener()
	self._btnWordModPlane1:RemoveClickListener()
	self._btnBodyModPlane2:RemoveClickListener()
	self._btnWordModPlane2:RemoveClickListener()
	self._btnenvironment1:RemoveClickListener()
	self._btnenvironment2:RemoveClickListener()
	self._btnplaneEnemy:RemoveClickListener()
	self._btnplaneExtraTips:RemoveClickListener()
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshHeroGroupPointBase, self.refreshPlane, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshLoadState, self.refreshBossInfo, self)
end

function TowerComposeHeroGroupPlaneRuleView:_btnplaneEnemyOnClick()
	local planeId = TowerComposeModel.instance:getCurFightPlaneId()

	EnemyInfoController.instance:openTowerComposeEnemyInfoView(self.dungeonEpisodeCo.battleId, self.themeId, planeId, self.towerEpisodeConfig.episodeId)
end

function TowerComposeHeroGroupPlaneRuleView:_btnBodyModPlaneOnClick(planeMo)
	local param = {}

	param.themeId = self.themeId
	param.planeId = planeMo.planeId
	param.modType = TowerComposeEnum.ModType.Body
	param.offsetPos = {
		-550,
		planeMo.planeId == 1 and 120 or -120
	}

	TowerComposeController.instance:openTowerComposeModTipView(param)
end

function TowerComposeHeroGroupPlaneRuleView:_btnWordModPlaneOnClick(planeMo)
	local param = {}

	param.themeId = self.themeId
	param.planeId = planeMo.planeId
	param.modType = TowerComposeEnum.ModType.Word
	param.offsetPos = {
		-550,
		planeMo.planeId == 1 and 120 or -120
	}

	TowerComposeController.instance:openTowerComposeModTipView(param)
end

function TowerComposeHeroGroupPlaneRuleView:_btnEnvironmentOnClick(planeMo)
	local param = {}

	param.themeId = self.themeId
	param.planeId = planeMo.planeId
	param.modType = TowerComposeEnum.ModType.Env
	param.offsetPos = {
		-550,
		planeMo.planeId == 1 and 120 or -120
	}

	TowerComposeController.instance:openTowerComposeModTipView(param)
end

function TowerComposeHeroGroupPlaneRuleView:_btnplaneExtraTipsOnClick()
	local param = {}

	param.posGO = self._goextraTips

	TowerComposeController.instance:openTowerComposeExtraTips(param)
end

function TowerComposeHeroGroupPlaneRuleView:_editableInitView()
	self.bodyModItemList = self:getUserDataTb_()
	self.wordModItemList = self:getUserDataTb_()
	self._btnBodyModPlane1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane1/targetList/#go_modPlane1/layout/#go_bodyMod1")
	self._btnWordModPlane1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane1/targetList/#go_modPlane1/layout/#go_wordMod1")
	self._btnBodyModPlane2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane2/targetList/#go_modPlane2/layout/#go_bodyMod2")
	self._btnWordModPlane2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_planeInfo/planeInfocontain/#go_plane2/targetList/#go_modPlane2/layout/#go_wordMod2")
end

function TowerComposeHeroGroupPlaneRuleView:onUpdateParam()
	return
end

function TowerComposeHeroGroupPlaneRuleView:onOpen()
	self.recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	self.themeId = self.recordFightParam.themeId
	self.layerId = self.recordFightParam.layerId
	self.themeMo = TowerComposeModel.instance:getThemeMo(self.themeId)
	self.themeConfig = TowerComposeConfig.instance:getThemeConfig(self.themeId)
	self.towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(self.themeId, self.layerId)
	self.dungeonEpisodeCo = DungeonConfig.instance:getEpisodeCO(self.towerEpisodeConfig.episodeId)

	self:refreshPlane()
	self:refreshBossInfo()
end

function TowerComposeHeroGroupPlaneRuleView:refreshPlane()
	self:refreshPlane1()
	self:refreshPlane2()
end

function TowerComposeHeroGroupPlaneRuleView:refreshPlane1()
	self.plane1Mo = self.themeMo:getPlaneMo(1)

	gohelper.setActive(self._goplane1, self.plane1Mo)

	if not self.plane1Mo or self.towerEpisodeConfig.plane == 0 then
		return
	end

	self:refreshPlaneInfoUI(self.plane1Mo)
end

function TowerComposeHeroGroupPlaneRuleView:refreshPlane2()
	self.plane2Mo = self.themeMo:getPlaneMo(2)

	gohelper.setActive(self._goplane2, self.plane2Mo)

	if not self.plane2Mo or self.towerEpisodeConfig.plane == 0 then
		return
	end

	self:refreshPlaneInfoUI(self.plane2Mo)
end

function TowerComposeHeroGroupPlaneRuleView:refreshPlaneInfoUI(planeMo)
	local planeId = planeMo.planeId
	local planeGO = self["_gomodPlane" .. planeId]
	local emptyGO = self["_goempty" .. planeId]
	local bodyModInfoList = planeMo:getHaveModInfoList(TowerComposeEnum.ModType.Body)
	local wordModInfoList = planeMo:getHaveModInfoList(TowerComposeEnum.ModType.Word)
	local envModInfoList = planeMo:getHaveModInfoList(TowerComposeEnum.ModType.Env)

	gohelper.setActive(planeGO, #bodyModInfoList > 0 or #wordModInfoList > 0 or #envModInfoList > 0)
	gohelper.setActive(emptyGO, #bodyModInfoList == 0 and #wordModInfoList == 0 and #envModInfoList == 0)
	gohelper.setActive(self["_btnenvironment" .. planeId], #envModInfoList > 0)
	gohelper.setActive(self["_gobodyModItem" .. planeId], false)
	gohelper.setActive(self["_gowordModItem" .. planeId], false)
	self:createAndRefreshBodyModItem(bodyModInfoList, planeId, self["_gobodyMod" .. planeId], self["_gobodyModItem" .. planeId])
	self:createAndRefreshWordModItem(wordModInfoList, planeId, self["_gowordMod" .. planeId], self["_gowordModItem" .. planeId])

	if #envModInfoList > 0 then
		local envModConfig = TowerComposeConfig.instance:getComposeModConfig(envModInfoList[1].modId)

		self["_txtenv" .. planeId].text = envModConfig.name

		UISpriteSetMgr.instance:setTower2Sprite(self["_imageenvIcon" .. planeId], envModConfig.icon)
	end

	self["_btnBodyModPlane" .. planeId]:AddClickListener(self._btnBodyModPlaneOnClick, self, planeMo)
	self["_btnWordModPlane" .. planeId]:AddClickListener(self._btnWordModPlaneOnClick, self, planeMo)
	self["_btnenvironment" .. planeId]:AddClickListener(self._btnEnvironmentOnClick, self, planeMo)

	local pointRoundCoList = TowerComposeConfig.instance:getPointRoundCoList()
	local maxRoundPointAdd = pointRoundCoList[#pointRoundCoList].bossPointAdd
	local totalPointBase = TowerComposeModel.instance:calModPointBaseScore(self.themeId, planeId)
	local addExtraPointBase = 0
	local extraHeroCoList = TowerComposeHeroGroupModel.instance:getPlaneRealExtraCoList(self.themeId, planeId)

	for _, extraCo in ipairs(extraHeroCoList) do
		addExtraPointBase = addExtraPointBase + extraCo.bossPointBase
	end

	self["_txtplaneScore" .. planeId].text = planeMo.isLock and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towercompose_recordScore"), planeMo.curScore) or GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towercompose_pointlevel"), totalPointBase + addExtraPointBase, Mathf.Floor((totalPointBase + addExtraPointBase) * (1 + maxRoundPointAdd / 1000)))
end

function TowerComposeHeroGroupPlaneRuleView:createAndRefreshBodyModItem(bodyModInfoList, planeId, contentGO, itemGO)
	local bodyModList = self.bodyModItemList[planeId]

	if not bodyModList then
		bodyModList = {}
		self.bodyModItemList[planeId] = bodyModList
	end

	for index, modInfo in ipairs(bodyModInfoList) do
		local modItem = bodyModList[index]

		if not modItem then
			modItem = {
				go = gohelper.clone(itemGO, contentGO, "bodyModItem" .. index)
			}
			modItem.modBg = gohelper.findChildImage(modItem.go, "image_modBg")
			modItem.modIcon = gohelper.findChildImage(modItem.go, "image_modIcon")
			modItem.imageModColorIcon = gohelper.findChildImage(modItem.go, "image_modIcon_01")
			modItem.materialModIcon = UnityEngine.Object.Instantiate(modItem.imageModColorIcon.material)
			modItem.imageModLvColorIcon = gohelper.findChildImage(modItem.go, "image_modIcon_02")
			modItem.materialModLvIcon = UnityEngine.Object.Instantiate(modItem.imageModLvColorIcon.material)
			modItem.imageModColorIcon.material = modItem.materialModIcon
			modItem.imageModLvColorIcon.material = modItem.materialModLvIcon
			modItem.modIconComp = MonoHelper.addNoUpdateLuaComOnceToGo(modItem.go, TowerComposeModIconComp)
			bodyModList[index] = modItem
		end

		gohelper.setActive(modItem.go, true)

		local slotId = modInfo.slot
		local modId = modInfo.modId

		UISpriteSetMgr.instance:setTower2Sprite(modItem.modBg, string.format("tower_new_frame%d_3", slotId))
		modItem.modIconComp:refreshMod(modId, modItem.modIcon, modItem.imageModColorIcon, modItem.imageModLvColorIcon, modItem.materialModIcon, modItem.materialModLvIcon)
	end

	for index = #bodyModInfoList + 1, #bodyModList do
		gohelper.setActive(bodyModList[index].go, false)
	end
end

function TowerComposeHeroGroupPlaneRuleView:createAndRefreshWordModItem(wordModInfoList, planeId, contentGO, itemGO)
	local wordModList = self.wordModItemList[planeId]

	if not wordModList then
		wordModList = {}
		self.wordModItemList[planeId] = wordModList
	end

	for index, modInfo in ipairs(wordModInfoList) do
		local modItem = wordModList[index]

		if not modItem then
			modItem = {
				go = gohelper.clone(itemGO, contentGO, "wordModItem" .. index)
			}
			modItem.modIcon = gohelper.findChildImage(modItem.go, "image_modIcon")
			modItem.imageModColorIcon = gohelper.findChildImage(modItem.go, "image_modIcon_01")
			modItem.materialModIcon = UnityEngine.Object.Instantiate(modItem.imageModColorIcon.material)
			modItem.imageModLvColorIcon = gohelper.findChildImage(modItem.go, "image_modIcon_02")
			modItem.materialModLvIcon = UnityEngine.Object.Instantiate(modItem.imageModLvColorIcon.material)
			modItem.imageModColorIcon.material = modItem.materialModIcon
			modItem.imageModLvColorIcon.material = modItem.materialModLvIcon
			modItem.modIconComp = MonoHelper.addNoUpdateLuaComOnceToGo(modItem.go, TowerComposeModIconComp)
			wordModList[index] = modItem
		end

		gohelper.setActive(modItem.go, true)

		local modId = modInfo.modId

		modItem.modIconComp:refreshMod(modId, modItem.modIcon, modItem.imageModColorIcon, modItem.imageModLvColorIcon, modItem.materialModIcon, modItem.materialModLvIcon)
	end

	for index = #wordModInfoList + 1, #wordModList do
		gohelper.setActive(wordModList[index].go, false)
	end
end

function TowerComposeHeroGroupPlaneRuleView:refreshBossInfo()
	if self.towerEpisodeConfig.plane == 0 then
		return
	end

	local bossMonsterGroupId = self.themeConfig.monsterGroupId
	local monsterIdList = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[bossMonsterGroupId].monster, "#")
	local monsterConfig = lua_monster.configDict[monsterIdList[1]]
	local bossLevel = TowerComposeModel.instance:getThemePlaneLevel(self.themeId)

	self._txtplaneLevel.text = string.format("Lv.%d", bossLevel)

	local bossLvCo = TowerComposeConfig.instance:getBossLevelCo(self.towerEpisodeConfig.episodeId, bossLevel)

	UISpriteSetMgr.instance:setTower2Sprite(self._imageplaneLevel, "tower_new_level_" .. string.lower(bossLvCo.levelReq))

	local skinConfig = FightConfig.instance:getSkinCO(monsterConfig.skinId)

	self._simageboss:LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))

	local curBossMo = self.themeMo:getCurBossMo()

	gohelper.setActive(self._goenemyLock, curBossMo.lock)
end

function TowerComposeHeroGroupPlaneRuleView:onClose()
	return
end

function TowerComposeHeroGroupPlaneRuleView:onDestroyView()
	self._simageboss:UnLoadImage()
end

return TowerComposeHeroGroupPlaneRuleView
