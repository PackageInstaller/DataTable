-- chunkname: @modules/logic/towercompose/view/TowerComposeThemeInfoView.lua

module("modules.logic.towercompose.view.TowerComposeThemeInfoView", package.seeall)

local TowerComposeThemeInfoView = class("TowerComposeThemeInfoView", BaseView)

function TowerComposeThemeInfoView:onInitView()
	self._txtname = gohelper.findChildText(self.viewGO, "Right/Title/#txt_name")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "Right/Title/#txt_TitleEn")
	self._txtepisode = gohelper.findChildText(self.viewGO, "Right/Title/#txt_episode")
	self._btnenemyInfo = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Title/#btn_enemyInfo")
	self._goattrlist = gohelper.findChild(self.viewGO, "Right/layout/#go_attrlist")
	self._gorecommendAttr = gohelper.findChild(self.viewGO, "Right/layout/#go_attrlist/#go_recommendAttr")
	self._goattritem = gohelper.findChild(self.viewGO, "Right/layout/#go_attrlist/#go_recommendAttr/attrlist/#go_attritem")
	self._txtrecommonddes = gohelper.findChildText(self.viewGO, "Right/layout/#go_attrlist/#go_recommendAttr/#txt_recommonddes")
	self._txtrecommendLevel = gohelper.findChildText(self.viewGO, "Right/layout/#go_attrlist/recommendlevel/#txt_recommendLevel")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Right/layout/desc/Viewport/#txt_desc")
	self._goroleBuffList = gohelper.findChild(self.viewGO, "Right/layout/#go_roleBuffList")
	self._gorolebuff = gohelper.findChild(self.viewGO, "Right/layout/#go_roleBuffList/#go_rolebuff")
	self._scrollrolebuff = gohelper.findChildScrollRect(self.viewGO, "Right/layout/#go_roleBuffList/#go_rolebuff/#scroll_rolebuff")
	self._goroleContent = gohelper.findChild(self.viewGO, "Right/layout/#go_roleBuffList/#go_rolebuff/#scroll_rolebuff/viewport/#go_roleContent")
	self._goroleItem = gohelper.findChild(self.viewGO, "Right/layout/#go_roleBuffList/#go_rolebuff/#scroll_rolebuff/viewport/#go_roleContent/#go_roleItem")
	self._goword = gohelper.findChild(self.viewGO, "Right/#go_word")
	self._golock = gohelper.findChild(self.viewGO, "Right/#go_word/#go_lock")
	self._gounlock = gohelper.findChild(self.viewGO, "Right/#go_word/#go_unlock")
	self._gowordList = gohelper.findChild(self.viewGO, "Right/#go_word/#go_wordList")
	self._gowordContent = gohelper.findChild(self.viewGO, "Right/#go_word/#go_wordList/viewport/content")
	self._gowordItem = gohelper.findChild(self.viewGO, "Right/#go_word/#go_wordList/viewport/content/#go_wordItem")
	self._gowordTipContent = gohelper.findChild(self.viewGO, "Right/#go_word/#go_wordTipContent")
	self._gowordTipItem = gohelper.findChild(self.viewGO, "Right/#go_word/#go_wordTipContent/#go_wordTipItem")
	self._btnwordClick = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_word/#btn_wordClick")
	self._gorecord = gohelper.findChild(self.viewGO, "Right/#go_record")
	self._gomaxScore = gohelper.findChild(self.viewGO, "Right/#go_record/#go_maxScore")
	self._txtmaxScore = gohelper.findChildText(self.viewGO, "Right/#go_record/#go_maxScore/#txt_maxScore")
	self._gonorecord = gohelper.findChild(self.viewGO, "Right/#go_record/#go_norecord")
	self._btnfight = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_fight")
	self._gostart = gohelper.findChild(self.viewGO, "Right/#btn_fight/#go_start")
	self._gorestart = gohelper.findChild(self.viewGO, "Right/#btn_fight/#go_restart")
	self._goplaneStart = gohelper.findChild(self.viewGO, "Right/#btn_fight/#go_planeStart")
	self._goplaneRestart = gohelper.findChild(self.viewGO, "Right/#btn_fight/#go_planeRestart")
	self._gofightLock = gohelper.findChild(self.viewGO, "Right/#btn_fight/#go_fightLock")
	self._txtlock = gohelper.findChildText(self.viewGO, "Right/#btn_fight/#go_fightLock/#txt_lock")
	self._goclickMask = gohelper.findChild(self.viewGO, "#go_clickMask")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._goEnter = gohelper.findChild(self.viewGO, "#go_Enter")
	self._simageEnterBG = gohelper.findChildSingleImage(self.viewGO, "#go_Enter/#simage_EnterBG")
	self._simageBottom = gohelper.findChildSingleImage(self.viewGO, "#go_Enter/#simage_Bottom")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeThemeInfoView:addEvents()
	self._btnenemyInfo:AddClickListener(self._btnenemyInfoOnClick, self)
	self._btnwordClick:AddClickListener(self._btnwordClickOnClick, self)
	self._btnfight:AddClickListener(self._btnfightOnClick, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.SelectThemeLayer, self.refreshUI, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.JumpThemeLayer, self.refreshUI, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.ShowUnlockWordAnim, self.playWordUnlockAnim, self)
end

function TowerComposeThemeInfoView:removeEvents()
	self._btnenemyInfo:RemoveClickListener()
	self._btnwordClick:RemoveClickListener()
	self._btnfight:RemoveClickListener()
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.SelectThemeLayer, self.refreshUI, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.JumpThemeLayer, self.refreshUI, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.ShowUnlockWordAnim, self.playWordUnlockAnim, self)
end

function TowerComposeThemeInfoView:_btnenemyInfoOnClick()
	if self.curEpisodeConfig.plane > 0 then
		local planeId = TowerComposeModel.instance:getCurSelectPlaneId()

		EnemyInfoController.instance:openTowerComposeEnemyInfoView(self.dungeonEpisodeCo.battleId, self.curThemeId, planeId, self.curEpisodeConfig.episodeId)
	else
		EnemyInfoController.instance:openEnemyInfoViewByBattleId(self.dungeonEpisodeCo.battleId)
	end
end

function TowerComposeThemeInfoView:_btnwordClickOnClick()
	gohelper.setActive(self._gowordTipContent, true)

	local param = {}

	param.modIdList = self.unlockModIdList
	param.parentGO = self._gowordTipContent
	param.pivot = Vector2(1, 0)

	TowerComposeController.instance:openTowerComposeModDescTipView(param)
end

function TowerComposeThemeInfoView:_btnfightOnClick()
	local param = {}

	param.towerEpisodeConfig = self.curEpisodeConfig

	if self.isEpisodeLock then
		GameFacade.showToast(ToastEnum.TowerComposeEpisodeUnLock, self.curEpisodeConfig.unlock)

		return
	end

	if self.curEpisodeConfig.plane > 0 then
		TowerComposeController.instance:openTowerComposeModEquipView(param)
	else
		TowerComposeController.instance:enterFight(param)
	end
end

function TowerComposeThemeInfoView:_btnRoleBuffItemOnClick()
	local param = {
		themeId = self.curThemeId
	}

	TowerComposeController.instance:openTowerComposeRoleView(param)
end

function TowerComposeThemeInfoView:_editableInitView()
	gohelper.setActive(self._gowordTipContent, true)
	gohelper.setActive(self._goroleItem, false)
	gohelper.setActive(self._gowordItem, false)

	self.roleBuffList = self:getUserDataTb_()
	self.wordItemList = self:getUserDataTb_()
	self._animWord = self._goword:GetComponent(gohelper.Type_Animator)
end

function TowerComposeThemeInfoView:onUpdateParam()
	self:checkJump()
end

function TowerComposeThemeInfoView:onOpen()
	self:refreshUI()
	self:checkJump()
end

function TowerComposeThemeInfoView:refreshUI()
	self.curThemeId, self.curLayerId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	self.passLayerId = TowerComposeModel.instance:getThemePassLayer(self.curThemeId)
	self.curEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(self.curThemeId, self.curLayerId)
	self.dungeonEpisodeCo = DungeonConfig.instance:getEpisodeCO(self.curEpisodeConfig.episodeId)

	local planeLayerIdList = TowerComposeConfig.instance:getThemeAllPlaneLayerIdList(self.curThemeId)
	local showLayerId = self.curLayerId

	for index, planeLayerId in ipairs(planeLayerIdList) do
		if planeLayerId < self.curLayerId then
			showLayerId = self.curLayerId - index
		end
	end

	local isPlaneLayer = tabletool.indexOf(planeLayerIdList, self.curLayerId)

	self._txtepisode.text = isPlaneLayer and "" or "ST - " .. string.format("%02d", showLayerId)
	self._txtname.text = GameUtil.setFirstStrSize(self.dungeonEpisodeCo.name, 90)
	self._txtTitleEn.text = self.dungeonEpisodeCo.name_En
	self._txtdesc.text = self.dungeonEpisodeCo.desc

	gohelper.setActive(self._goattrlist, self.curEpisodeConfig.plane == 0)
	gohelper.setActive(self._goword, self.curEpisodeConfig.plane == 0)
	gohelper.setActive(self._goroleBuffList, self.curEpisodeConfig.plane > 0)
	gohelper.setActive(self._gorecord, self.curEpisodeConfig.plane > 0)

	self.isEpisodeLock = self:checkIsEpisodeLock()

	gohelper.setActive(self._gostart, self.curLayerId > self.passLayerId and self.curEpisodeConfig.plane == 0 and not self.isEpisodeLock)
	gohelper.setActive(self._gorestart, self.curLayerId <= self.passLayerId and self.curEpisodeConfig.plane == 0 and not self.isEpisodeLock)
	gohelper.setActive(self._goplaneStart, self.curLayerId > self.passLayerId and self.curEpisodeConfig.plane > 0 and not self.isEpisodeLock)
	gohelper.setActive(self._goplaneRestart, self.curLayerId <= self.passLayerId and self.curEpisodeConfig.plane > 0 and not self.isEpisodeLock)
	gohelper.setActive(self._gofightLock, self.isEpisodeLock)

	self._txtlock.text = self.isEpisodeLock and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towercompose_episode_unlock"), self.curEpisodeConfig.unlock) or ""

	if self.curEpisodeConfig.plane > 0 then
		self:refreshPlaneInfo()
	else
		self:refreshNormalInfo()
	end
end

function TowerComposeThemeInfoView:checkIsEpisodeLock()
	if string.nilorempty(self.curEpisodeConfig.unlock) then
		return false
	end

	local unlockScore = tonumber(self.curEpisodeConfig.unlock)
	local themeMo = TowerComposeModel.instance:getThemeMo(self.curThemeId)

	return unlockScore > themeMo:getCurBossHighScore()
end

function TowerComposeThemeInfoView:checkJump()
	if self.viewParam and self.viewParam.jumpId and self.viewParam.jumpId == TowerComposeEnum.JumpId.TowerComposeModEquip and self.curEpisodeConfig.plane > 0 then
		self:_btnfightOnClick()
	end
end

function TowerComposeThemeInfoView:refreshNormalInfo()
	self:refreshRecommend()
	self:refreshWord()
end

function TowerComposeThemeInfoView:refreshRecommend()
	local recommendLevel = FightHelper.getBattleRecommendLevel(self.dungeonEpisodeCo.battleId)

	self._txtrecommendLevel.text = recommendLevel >= 0 and HeroConfig.instance:getLevelDisplayVariant(recommendLevel) or ""

	local recommended, counter = TowerController.instance:getRecommendList(self.dungeonEpisodeCo.battleId)

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, gohelper.findChild(self._gorecommendAttr.gameObject, "attrlist"), self._goattritem)

	self._txtrecommonddes.text = #recommended == 0 and luaLang("new_common_none") or ""
end

function TowerComposeThemeInfoView:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function TowerComposeThemeInfoView:refreshWord()
	gohelper.setActive(self._golock, self.curLayerId > self.passLayerId)
	gohelper.setActive(self._gounlock, self.curLayerId <= self.passLayerId)

	self.unlockModIdList = string.splitToNumber(self.curEpisodeConfig.unlockModIds, "|") or {}

	gohelper.setActive(self._goword, self.curEpisodeConfig.plane == 0 and #self.unlockModIdList > 0)

	for index, modId in ipairs(self.unlockModIdList) do
		local wordItem = self.wordItemList[index]

		if not wordItem then
			wordItem = {
				go = gohelper.clone(self._gowordItem, self._gowordContent, "wordItem" .. index)
			}
			wordItem.imageIcon = gohelper.findChildImage(wordItem.go, "image_icon")
			wordItem.imageModColorIcon = gohelper.findChildImage(wordItem.go, "image_icon_01")
			wordItem.materialModIcon = UnityEngine.Object.Instantiate(wordItem.imageModColorIcon.material)
			wordItem.imageModLvColorIcon = gohelper.findChildImage(wordItem.go, "image_icon_02")
			wordItem.materialModLvIcon = UnityEngine.Object.Instantiate(wordItem.imageModLvColorIcon.material)
			wordItem.imageModColorIcon.material = wordItem.materialModIcon
			wordItem.imageModLvColorIcon.material = wordItem.materialModLvIcon
			wordItem.modIconComp = MonoHelper.addNoUpdateLuaComOnceToGo(wordItem.go, TowerComposeModIconComp)
			self.wordItemList[index] = wordItem
		end

		wordItem.modIconComp:refreshMod(modId, wordItem.imageIcon, wordItem.imageModColorIcon, wordItem.imageModLvColorIcon, wordItem.materialModIcon, wordItem.materialModLvIcon)
		gohelper.setActive(wordItem.go, true)
	end

	for index = #self.unlockModIdList + 1, #self.wordItemList do
		gohelper.setActive(self.wordItemList[index].go, false)
	end
end

function TowerComposeThemeInfoView:refreshPlaneInfo()
	self:buildShowHeroCoData()
	self:refreshRoleBuff()
	self:refreshRecord()
end

function TowerComposeThemeInfoView:buildShowHeroCoData()
	local supportHeroCoList = TowerComposeConfig.instance:getAllSupportCoList(self.curThemeId)
	local extraHeroCoList = TowerComposeConfig.instance:getAllExtraCoList(self.curThemeId)
	local trialHeroList = TowerComposeConfig.instance:getThemeTrialHeroList(self.curThemeId)

	self.trialHeroCoDataList = TowerHeroTrialListModel.instance:getTrialHeroCoDataList(trialHeroList)
	self.showHeroCoMap = self:getUserDataTb_()
	self.showHeroCoList = self:getUserDataTb_()

	for index, supprotCo in ipairs(supportHeroCoList) do
		local heroCoData = self.showHeroCoMap[supprotCo.heroId]

		if not heroCoData then
			heroCoData = {}
			self.showHeroCoMap[supprotCo.heroId] = heroCoData
		end

		heroCoData.index = index
		heroCoData.isSupport = true
		heroCoData.heroId = supprotCo.heroId
		heroCoData.heroMo = HeroModel.instance:getByHeroId(heroCoData.heroId)
		heroCoData.isExit = heroCoData.heroMo ~= nil or heroCoData.TrialHeroMo ~= nil
		heroCoData.config = supprotCo
	end

	for index, extratCo in ipairs(extraHeroCoList) do
		local heroCoData = self.showHeroCoMap[extratCo.id]

		if not heroCoData then
			heroCoData = {}
			self.showHeroCoMap[extratCo.id] = heroCoData
		end

		heroCoData.index = #supportHeroCoList + index
		heroCoData.isExtra = true
		heroCoData.heroId = extratCo.id
		heroCoData.heroMo = HeroModel.instance:getByHeroId(heroCoData.heroId)
		heroCoData.isExit = heroCoData.heroMo ~= nil
		heroCoData.config = extratCo
	end

	for heroId, heroCoData in pairs(self.showHeroCoMap) do
		table.insert(self.showHeroCoList, heroCoData)
	end

	table.sort(self.showHeroCoList, TowerComposeThemeInfoView.sortShowHeroCoList)
end

function TowerComposeThemeInfoView:buildTrialHeroMo(heroId)
	for _, trialCoData in ipairs(self.trialHeroCoDataList) do
		if trialCoData.trialConfig.heroId == heroId then
			local trialHeroMo = HeroMo.New()

			trialHeroMo:initFromTrial(trialCoData.trialConfig.id)

			return trialHeroMo
		end
	end
end

function TowerComposeThemeInfoView.sortShowHeroCoList(heroDataA, heroDataB)
	if heroDataA.isExit == heroDataB.isExit and heroDataA.isExit then
		return heroDataA.index < heroDataB.index
	elseif heroDataA.isExit ~= heroDataB.isExit then
		return heroDataA.isExit
	elseif heroDataA.isExit == heroDataB.isExit and heroDataA.isExit then
		return heroDataA.index < heroDataB.index
	end

	return heroDataA.index < heroDataB.index
end

function TowerComposeThemeInfoView:refreshRoleBuff()
	for index, heroCoData in ipairs(self.showHeroCoList) do
		local roleBuffItem = self.roleBuffList[index]

		if not roleBuffItem then
			roleBuffItem = {
				index = index,
				heroCoData = heroCoData,
				go = gohelper.clone(self._goroleItem, self._goroleContent, "roleBuffItem" .. index)
			}
			roleBuffItem.simageRoleIcon = gohelper.findChildSingleImage(roleBuffItem.go, "rolemask/simage_roleIcon")
			roleBuffItem.btnClick = gohelper.findChildButtonWithAudio(roleBuffItem.go, "btn_click")

			roleBuffItem.btnClick:AddClickListener(self._btnRoleBuffItemOnClick, self)

			self.roleBuffList[index] = roleBuffItem
		end

		gohelper.setActive(roleBuffItem.go, true)
		ZProj.UGUIHelper.SetGrayscale(roleBuffItem.simageRoleIcon.gameObject, not roleBuffItem.heroCoData.isExit)

		local skinId = 0

		if roleBuffItem.heroCoData.heroMo then
			skinId = roleBuffItem.heroCoData.heroMo.skin
		else
			local characterCo = lua_character.configDict[roleBuffItem.heroCoData.heroId]

			if not characterCo then
				logError("该角色id异常:" .. roleBuffItem.heroCoData.heroId)

				return
			end

			skinId = characterCo.skinId
		end

		if skinId > 0 then
			local skinConfig = SkinConfig.instance:getSkinCo(skinId)

			roleBuffItem.simageRoleIcon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
		else
			logError("该角色皮肤id异常:" .. roleBuffItem.heroCoData.heroId)
		end
	end

	for index = #self.showHeroCoList + 1, #self.roleBuffList do
		gohelper.setActive(self.roleBuffList[index].go, false)
	end

	self._scrollrolebuff.horizontalNormalizedPosition = 0

	TaskDispatcher.runDelay(self.refreshRoleContent, self, 0.01)
end

function TowerComposeThemeInfoView:refreshRoleContent()
	gohelper.setActive(self._goroleContent, false)
	gohelper.setActive(self._goroleContent, true)
end

function TowerComposeThemeInfoView:refreshRecord()
	local themeMo = TowerComposeModel.instance:getThemeMo(self.curThemeId)
	local highScore = themeMo:getCurBossHighScore()

	gohelper.setActive(self._gomaxScore, self.curLayerId <= self.passLayerId or self.curEpisodeConfig.plane == 2)
	gohelper.setActive(self._gonorecord, self.curLayerId > self.passLayerId and self.curEpisodeConfig.plane < 2)

	self._txtmaxScore.text = highScore
end

function TowerComposeThemeInfoView:playWordUnlockAnim()
	if self.unlockModIdList and #self.unlockModIdList > 0 then
		self._animWord:Play("switch", 0, 0)
		self._animWord:Update(0)
	end
end

function TowerComposeThemeInfoView:onClose()
	TaskDispatcher.cancelTask(self.refreshRoleContent, self)
end

function TowerComposeThemeInfoView:onDestroyView()
	for index, roleBuffItem in ipairs(self.roleBuffList) do
		roleBuffItem.simageRoleIcon:UnLoadImage()
		roleBuffItem.btnClick:RemoveClickListener()
	end
end

return TowerComposeThemeInfoView
