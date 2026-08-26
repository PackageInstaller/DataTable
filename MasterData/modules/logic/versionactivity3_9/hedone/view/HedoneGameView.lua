-- chunkname: @modules/logic/versionactivity3_9/hedone/view/HedoneGameView.lua

module("modules.logic.versionactivity3_9.hedone.view.HedoneGameView", package.seeall)

local HedoneGameView = class("HedoneGameView", BaseView)

function HedoneGameView:onInitView()
	self._gosecondLayer = gohelper.findChild(self.viewGO, "HedoneGameView_SecondLayer")
	self._txttime = gohelper.findChildText(self.viewGO, "view/#go_time/#txt_num")
	self._gotimeEff = gohelper.findChild(self.viewGO, "view/#go_time/UIEff_Time")
	self._txtkillnum = gohelper.findChildText(self.viewGO, "view/#go_kill/#txt_killnum")
	self._gokillNumEff = gohelper.findChild(self.viewGO, "view/#go_kill/UIEff_Kill")
	self._killNumAnim = self._gokillNumEff:GetComponent(typeof(UnityEngine.Animation))

	local goplayerInfo = gohelper.findChild(self.viewGO, "view/#go_playerinfo")

	self._playerHitAnim = goplayerInfo:GetComponent(typeof(UnityEngine.Animation))
	self._imagehpfg = gohelper.findChildImage(self.viewGO, "view/#go_playerinfo/#go_hp/#image_hpfg")
	self._txthpnum = gohelper.findChildText(self.viewGO, "view/#go_playerinfo/#go_hp/#txt_hpnum")
	self._imageexpup = gohelper.findChildImage(self.viewGO, "view/#go_playerinfo/#go_exp/#image_expup")
	self._imageexpfg = gohelper.findChildImage(self.viewGO, "view/#go_playerinfo/#go_exp/#image_expfg")
	self._goexpEff = gohelper.findChild(self.viewGO, "view/#go_playerinfo/#go_exp/#image_expfg/UIEff_expup")
	self._expAnim = self._goexpEff:GetComponent(typeof(UnityEngine.Animation))
	self._txtexpnum = gohelper.findChildText(self.viewGO, "view/#go_playerinfo/#go_exp/#txt_hpnum")
	self._txtlevel = gohelper.findChildText(self.viewGO, "view/#go_playerinfo/layout/#go_levelbg/#txt_level")
	self._goupEff = gohelper.findChild(self.viewGO, "view/#go_playerinfo/head/UIEff_PlayerUpgrade")
	self._upAnim = self._goupEff:GetComponent(typeof(UnityEngine.Animation))
	self._goskilllayout = gohelper.findChild(self.viewGO, "view/#go_playerinfo/skilllayout")
	self._goskillitem = gohelper.findChild(self.viewGO, "view/#go_playerinfo/skilllayout/#go_skillitem")
	self._godamages = gohelper.findChild(self.viewGO, "view/#go_damages")
	self._godamageItem = gohelper.findChild(self.viewGO, "view/#go_damages/#go_damageItem")
	self._goskillget = gohelper.findChild(self.viewGO, "view/#go_skillget")
	self._skillGetAnimator = self._goskillget:GetComponent(gohelper.Type_Animator)
	self._goskillgetlayout = gohelper.findChild(self.viewGO, "view/#go_skillget/layout")
	self._goskillgetitem = gohelper.findChild(self.viewGO, "view/#go_skillget/layout/#go_getitem")
	self._gobossenter = gohelper.findChild(self.viewGO, "view/#go_bossenter")
	self._goskilldetail = gohelper.findChild(self.viewGO, "view/#go_skilldetail")
	self._btnCloseSkillDetail = gohelper.findChildButtonWithAudio(self.viewGO, "view/#go_skilldetail/#btn_closeskill")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HedoneGameView:addEvents()
	self._btnCloseSkillDetail:AddClickListener(self._onBtnCloseSkillDetailClick, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.OnSecondRefresh, self._onSecondRefresh, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.OnEntityAttributeChange, self._onEntityAttributeChange, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.OnPlayerExpChange, self._onPlayerExpChange, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.OnEntityTakeDamage, self._onEntityTakeDamage, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.OnGameReset, self._onGameReset, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.OnStartNewMonsterWave, self._onStartNewMonsterWave, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.RefreshGameView, self._onRefreshGameView, self)
	self.addEventCb(self, HedoneSkillMgr.instance, HedoneEvent.RefreshSkillCDProgress, self._onRefreshSkillCDProgress, self)
	self.addEventCb(self, HedoneSkillMgr.instance, HedoneEvent.OnPlayerAddSkill, self._onPlayerAddSkill, self)
end

function HedoneGameView:removeEvents()
	self._btnCloseSkillDetail:RemoveClickListener()
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.OnSecondRefresh, self._onSecondRefresh, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.OnEntityAttributeChange, self._onEntityAttributeChange, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.OnPlayerExpChange, self._onPlayerExpChange, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.OnEntityTakeDamage, self._onEntityTakeDamage, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.OnGameReset, self._onGameReset, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.OnStartNewMonsterWave, self._onStartNewMonsterWave, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.RefreshGameView, self._onRefreshGameView, self)
	self.removeEventCb(self, HedoneSkillMgr.instance, HedoneEvent.RefreshSkillCDProgress, self._onRefreshSkillCDProgress, self)
	self.removeEventCb(self, HedoneSkillMgr.instance, HedoneEvent.OnPlayerAddSkill, self._onPlayerAddSkill, self)
end

function HedoneGameView:_onBtnSkillClick(index)
	local playerMO = HedoneGameModel.instance:getPlayerMO()

	if self._skillItemList then
		local skillItem = self._skillItemList[index]
		local skillUid = skillItem and skillItem.skillUid
		local skill = playerMO:getSkill(skillUid)

		if not skill then
			return
		end

		local skillType = skill:getSkillType()
		local skillIdList = playerMO:getSkillIdList(skillType)

		self._skillDetailList:setData(skillIdList)
		gohelper.setActive(self._goskilldetail, true)
	end
end

function HedoneGameView:_onBtnCloseSkillDetailClick()
	gohelper.setActive(self._goskilldetail, false)
end

local GetSkillBlockKey = "HedoneGameView_GetSkillBlock"

function HedoneGameView:_onBtnGetSkillClick(index)
	if self._skillGetItemList then
		local item = self._skillGetItemList[index]
		local skillId = item and item.skillId

		if not skillId then
			return
		end

		UIBlockMgr.instance:startBlock(GetSkillBlockKey)
		HedoneSkillMgr.instance:playerAddSkill(skillId)

		local newSkillIdList = {}

		for i, tItem in ipairs(self._skillGetItemList) do
			if i ~= index then
				tItem.animatorPlayer:Play(UIAnimationName.Close)
			end

			local tSkillId = tItem.skillId

			if tSkillId then
				newSkillIdList[i] = tSkillId
			end
		end

		HedoneStatHelper.sendPickSkillInfo(skillId, newSkillIdList)
		item.animatorPlayer:Play("confirm", self._onPlayGetSkillAnimFinish, self)

		if self._getNewSkillCount <= 0 then
			self._skillGetAnimator:Play(UIAnimationName.Close)
		end

		AudioMgr.instance:trigger(AudioEnum3_9.Hedone.play_ui_dungeon3_2_choose_1)
	end
end

function HedoneGameView:_onPlayGetSkillAnimFinish()
	UIBlockMgr.instance:endBlock(GetSkillBlockKey)

	self._waitSelectNewSkill = false

	local newSkillIdList = self:tryGetNewSkillIdList()

	if newSkillIdList and #newSkillIdList > 0 then
		self:showGetSkillPanel(newSkillIdList)
		self._skillGetAnimator:Play(UIAnimationName.Open)
	else
		gohelper.setActive(self._goskillget, false)
		HedoneGameController.instance:resumeGame(HedoneGameEnum.StopSource.SkillPanel)
	end
end

function HedoneGameView:_onSecondRefresh()
	self:refreshTime()
	self:refreshDamageStateItem()
end

function HedoneGameView:_onEntityAttributeChange(uid, attrId)
	if uid ~= HedoneGameEnum.Const.PlayerUid then
		return
	end

	if attrId == HedoneGameEnum.Attribute.Hp or attrId == HedoneGameEnum.Attribute.HpCap then
		self:refreshHpBar()
	elseif attrId == HedoneGameEnum.Attribute.GlobalSkillCD or attrId == HedoneGameEnum.Attribute.SkillCD then
		self:_onRefreshSkillCDProgress()
	end
end

function HedoneGameView:_onPlayerExpChange(getNewSkillCount)
	self:refreshExpBar()
	self._expAnim:Rewind()
	self._expAnim:Play()

	local isNewLv = self:refreshLevel()

	if isNewLv then
		self._upAnim:Play()
	end

	if not getNewSkillCount or getNewSkillCount <= 0 then
		return
	end

	self._getNewSkillCount = self._getNewSkillCount + getNewSkillCount

	local newSkillIdList = self:tryGetNewSkillIdList()

	if newSkillIdList and #newSkillIdList > 0 then
		self:showGetSkillPanel(newSkillIdList)
		self._skillGetAnimator:Play(UIAnimationName.Open)
	end
end

function HedoneGameView:_onEntityTakeDamage(uid, damage, isCrit, isAlive)
	if uid == HedoneGameEnum.Const.PlayerUid then
		self._playerHitAnim:Play()
		self._playerFloatComp:showFloat(damage)
	elseif not isAlive then
		self:refreshKillNum()
		self._killNumAnim:Rewind()
		self._killNumAnim:Play()
	end
end

function HedoneGameView:_onGameReset()
	self._getNewSkillCount = 0
	self._waitSelectNewSkill = false

	gohelper.setActive(self._goskillget, false)
	gohelper.setActive(self._gobossenter, false)
	self._playerFloatComp:recycleAllFloatItem()
	self:refresh()
end

function HedoneGameView:_onStartNewMonsterWave()
	return
end

function HedoneGameView:_onRefreshGameView()
	self:refresh()
end

function HedoneGameView:_onRefreshSkillCDProgress()
	if not self._skillItemList then
		return
	end

	local playerMO = HedoneGameModel.instance:getPlayerMO()
	local isAlive = playerMO and playerMO:getIsAlive()

	if not isAlive then
		return
	end

	for _, skillItem in ipairs(self._skillItemList) do
		local skillUid = skillItem.skillUid
		local skill = playerMO:getSkill(skillUid)

		if skill then
			skillItem.imagemask.fillAmount = skill:getCDProgress()
		end
	end
end

function HedoneGameView:_onPlayerAddSkill()
	self:refreshSkillItem()
	self:refreshDamageStateItem()
end

function HedoneGameView:_editableInitView()
	local goSkillDetailList = gohelper.findChild(self.viewGO, "view/#go_skilldetail/node/skillList")
	local scrollParam = SimpleListParam.New()

	scrollParam.cellClass = HedoneSkillDetailItem
	self._skillDetailList = GameFacade.createSimpleListComp(goSkillDetailList, scrollParam, nil, self.viewContainer)

	self:_onBtnCloseSkillDetailClick()

	self._cachedDisplayLv = nil

	local goFloats = gohelper.findChild(self.viewGO, "view/#go_playerFloats")

	self._playerFloatComp = MonoHelper.addNoUpdateLuaComOnceToGo(goFloats, HedoneGameFloatComp)
	self._getNewSkillCount = 0

	self:_initCDSkillItem()
end

function HedoneGameView:_initCDSkillItem()
	self._skillItemList = {}

	local cdSkillCount = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.CDSkillCount, false, true)

	gohelper.CreateNumObjList(self._goskilllayout, self._goskillitem, cdSkillCount, self._onCreateSkillItem, self)
end

function HedoneGameView:_onCreateSkillItem(obj, index)
	local skillItem = self:getUserDataTb_()

	skillItem.go = obj
	skillItem.index = index
	skillItem.numLv = 0
	skillItem.goempty = gohelper.findChild(skillItem.go, "#go_empty")
	skillItem.goskill = gohelper.findChild(skillItem.go, "#go_skill")
	skillItem.imageskillicon = gohelper.findChildImage(skillItem.go, "#go_skill/#image_skillicon")
	skillItem.imagemask = gohelper.findChildImage(skillItem.go, "#go_skill/#image_mask")
	skillItem.txtlevel = gohelper.findChildText(skillItem.go, "#go_skill/levelbg/#txt_level")
	skillItem.golevelEff = gohelper.findChild(skillItem.go, "UIEff_SkillUpgrade")
	skillItem.btnclick = gohelper.findChildButtonWithAudio(skillItem.go, "#btn_click")

	skillItem.btnclick:AddClickListener(self._onBtnSkillClick, self, index)

	local txtcount = gohelper.findChildText(skillItem.go, "#go_skill/#txt_count")

	gohelper.setActive(txtcount, false)

	self._skillItemList[index] = skillItem
end

function HedoneGameView:onUpdateParam()
	return
end

function HedoneGameView:onOpen()
	local uiLayerGO = ViewMgr.instance:getUILayer("POPUP_SECOND")
	local goEffectLayer = gohelper.findChild(self.viewGO, "HedoneGameView_SecondLayer/#go_node/#go_effectLayer")
	local effectCanvas = goEffectLayer:GetComponent("Canvas")
	local uiCanvas = uiLayerGO:GetComponent("Canvas")

	effectCanvas.overrideSorting = true
	effectCanvas.sortingOrder = uiCanvas.sortingOrder + 1

	self:refresh()
end

function HedoneGameView:onOpenFinish()
	local uiLayerGO = ViewMgr.instance:getUILayer("POPUP_SECOND")

	gohelper.addChild(uiLayerGO, self._gosecondLayer)
	HedoneGameController.instance:startGame()

	local gameId = HedoneGameModel.instance:getGameId()

	HedoneGameController.instance:dispatchEvent(HedoneEvent.GuideOpenGameView, gameId)
end

function HedoneGameView:tryGetNewSkillIdList()
	local result

	if not self._waitSelectNewSkill and self._getNewSkillCount > 0 then
		result = HedoneSkillMgr.instance:getNewSkillList()
		self._getNewSkillCount = self._getNewSkillCount - 1
	end

	return result
end

function HedoneGameView:showGetSkillPanel(newSkillIdList)
	self._waitSelectNewSkill = true
	self._curMaxSkillRare = nil

	HedoneGameController.instance:stopGame(HedoneGameEnum.StopSource.SkillPanel)
	self:_clearSkillGetItem()
	gohelper.CreateObjList(self, self._onCreateSkillGetItem, newSkillIdList, self._goskillgetlayout, self._goskillgetitem)
	gohelper.setActive(self._goskillget, true)
	gohelper.setActive(self._gotimeEff, false)
	self:_onBtnCloseSkillDetailClick()

	self._skillAudioDict = self._skillAudioDict or {
		AudioEnum3_9.Hedone.play_ui_heduonie3_9_blessing1,
		AudioEnum3_9.Hedone.play_ui_heduonie3_9_blessing2,
		AudioEnum3_9.Hedone.play_ui_heduonie3_9_blessing3
	}

	if self._curMaxSkillRare and self._skillAudioDict[self._curMaxSkillRare] then
		AudioMgr.instance:trigger(self._skillAudioDict[self._curMaxSkillRare])
	end

	local gameId = HedoneGameModel.instance:getGameId()

	HedoneGameController.instance:dispatchEvent(HedoneEvent.GuideOpenSkillGet, gameId)
end

function HedoneGameView:_clearSkillGetItem()
	if self._skillGetItemList then
		for _, skillGetItem in ipairs(self._skillGetItemList) do
			skillGetItem.skillId = nil

			skillGetItem.btnclick:RemoveClickListener()
			skillGetItem.simagequality:UnLoadImage()
		end
	end

	self._skillGetItemList = {}
end

function HedoneGameView:_onCreateSkillGetItem(obj, data, index)
	local item = self:getUserDataTb_()

	item.go = obj
	item.skillId = data
	item.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(item.go)
	item.simagequality = gohelper.findChildSingleImage(obj, "#simage_quality")

	local rare = HedoneConfig.instance:getHedoneSkillRare(item.skillId) or 1
	local qualityPath = ResUrl.getV3a9HedoneSingleBg("v3a9_hedone_skillbg_" .. rare)

	item.simagequality:LoadImage(qualityPath)

	local imageskillicon = gohelper.findChildImage(obj, "#image_skillicon")
	local icon = HedoneConfig.instance:getHedoneSkillIcon(item.skillId)

	UISpriteSetMgr.instance:setV3a9HedoneSprite(imageskillicon, icon)

	local imagequalityline = gohelper.findChildImage(obj, "#image_qualityline")

	UISpriteSetMgr.instance:setV3a9HedoneSprite(imagequalityline, "v3a9_hedone_skillnamebg_" .. rare)

	local gonew = gohelper.findChild(obj, "#image_skillicon/#go_new")
	local gameId = HedoneGameModel.instance:getGameId()
	local unlockGameId = HedoneConfig.instance:getHedoneSkillUnlockGameId(item.skillId)
	local key = HedoneGameEnum.Const.NewSkillPrefsKey .. item.skillId
	local newVal = HedoneGameEnum.Const.NewSkillPrefsVal
	local isFirstShow = GameUtil.playerPrefsGetNumberByUserId(key, newVal) == newVal

	gohelper.setActive(gonew, gameId == unlockGameId and isFirstShow)

	if isFirstShow then
		GameUtil.playerPrefsSetNumberByUserId(key, HedoneGameEnum.Const.OldSkillPrefsVal)
	end

	local goTags = gohelper.findChild(obj, "#go_tags")
	local tagItem = gohelper.findChild(obj, "#go_tags/#go_tagItem")
	local tagList = HedoneConfig.instance:getHedoneSkillTagList(item.skillId)
	local tagDataList = {}
	local skillCD = HedoneConfig.instance:getHedoneSkillCd(item.skillId)
	local isCDSkill = skillCD and skillCD > 0

	for i, tag in ipairs(tagList) do
		local tagData = {}

		tagData.tag = tag
		tagData.isCDSkill = isCDSkill
		tagDataList[i] = tagData
	end

	gohelper.CreateObjList(self, self._onCreateSkillTagItem, tagDataList, goTags, tagItem)

	local txtskillname = gohelper.findChildText(obj, "#image_qualityline/#txt_skillname")

	txtskillname.text = HedoneConfig.instance:getHedoneSkillName(item.skillId)

	local txtdesc = gohelper.findChildText(obj, "scroll_desc/viewport/#txt_desc")

	txtdesc.text = HedoneConfig.instance:getHedoneSkillDesc(item.skillId)
	item.btnclick = gohelper.findChildButtonWithAudio(obj, "#btn_click")

	item.btnclick:AddClickListener(self._onBtnGetSkillClick, self, index)
	item.animatorPlayer:Play(UIAnimationName.Open)

	self._skillGetItemList[index] = item

	if rare and (not self._curMaxSkillRare or rare > self._curMaxSkillRare) then
		self._curMaxSkillRare = rare
	end
end

function HedoneGameView:_onCreateSkillTagItem(obj, data, index)
	local tagBg = obj:GetComponent(gohelper.Type_Image)

	UISpriteSetMgr.instance:setV3a9HedoneSprite(tagBg, (data.isCDSkill or nil) and "v3a9_hedone_tag_2")

	local txt = gohelper.findChildText(obj, "#txt_tag")

	txt.text = data.tag
end

function HedoneGameView:refresh()
	self:refreshTime()
	self:refreshHpBar()
	self:refreshExpBar()
	self:refreshLevel()
	self:refreshKillNum()
	self:refreshSkillItem()
	self:refreshDamageStateItem()
end

function HedoneGameView:refreshTime()
	local strTime = ""
	local isShowTimeStress = false
	local gameTime = HedoneGameModel.instance:getGameTime()
	local gameId = HedoneGameModel.instance:getGameId()
	local targetTime = HedoneConfig.instance:getHedoneGameTargetTime(gameId)

	if targetTime > 0 then
		local remainTime = targetTime - gameTime

		isShowTimeStress = remainTime <= HedoneGameEnum.Const.StressTime
		strTime = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v3a9_hedon_game_time2"), gameTime, targetTime)
	else
		strTime = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v3a9_hedon_game_time1"), gameTime)
	end

	self._txttime.text = strTime

	gohelper.setActive(self._gotimeEff, isShowTimeStress and not self._waitSelectNewSkill)
end

function HedoneGameView:refreshHpBar()
	local hp = 0
	local hpCap = 0
	local playerMO = HedoneGameModel.instance:getPlayerMO()

	if playerMO then
		hp = playerMO:getAttrValue(HedoneGameEnum.Attribute.Hp)
		hpCap = playerMO:getAttrValue(HedoneGameEnum.Attribute.HpCap)
	end

	if hpCap > 0 then
		self._imagehpfg.fillAmount = hp / hpCap or 0
	end

	self._txthpnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v2a5_challenge_mainview_finished"), hp, hpCap)
end

function HedoneGameView:refreshExpBar()
	local needExp = 0
	local curExp = 0
	local playerMO = HedoneGameModel.instance:getPlayerMO()

	if playerMO then
		needExp = playerMO:getLevelUpNeedExp()
		curExp = playerMO:getCurExp()
	end

	if needExp > 0 then
		if not (curExp / needExp) then
			local percent = 0

			self._imageexpup.fillAmount = percent
			self._imageexpfg.fillAmount = percent
			self._txtexpnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v2a5_challenge_mainview_finished"), curExp, needExp)
		end
	end
end

function HedoneGameView:refreshLevel()
	local playerMO = HedoneGameModel.instance:getPlayerMO()
	local lv = playerMO and playerMO:getCurLv() or 0

	if self._cachedDisplayLv and lv == self._cachedDisplayLv then
		return false
	end

	self._cachedDisplayLv = lv

	local langLvPrefix = luaLang("towercompose_modLevel")

	self._txtlevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(langLvPrefix, lv)

	return true
end

function HedoneGameView:refreshKillNum()
	self._txtkillnum.text = HedoneGameModel.instance:getMonsterKillCount()
end

function HedoneGameView:refreshSkillItem()
	local playerMO = HedoneGameModel.instance:getPlayerMO()
	local cdSkillUidList = playerMO and playerMO:getCDSkillUidList()

	if not cdSkillUidList then
		return
	end

	if not self._skillItemList then
		return
	end

	for index, skillItem in ipairs(self._skillItemList) do
		local skillUid = cdSkillUidList[index]
		local skill = playerMO:getSkill(skillUid)

		if skill then
			skillItem.skillUid = skillUid

			local skillId = skill:getId()
			local skillType = skill:getSkillType()
			local skillIdList = playerMO:getSkillIdList(skillType)

			if not skillItem.numLv then
				local oldLv = 0

				if skillIdList then
					local newLv = math.max(1, #skillIdList or 1)

					gohelper.setActive(skillItem.golevelEff, false)

					if oldLv < newLv then
						gohelper.setActive(skillItem.golevelEff, true)
					end

					skillItem.txtlevel.text = GameUtil.getRomanNums2(newLv)
					skillItem.numLv = newLv

					local icon = HedoneConfig.instance:getHedoneSkillIcon(skillId)

					UISpriteSetMgr.instance:setV3a9HedoneSprite(skillItem.imageskillicon, icon)

					skillItem.imagemask.fillAmount = skill:getCDProgress()
				end
			end
		end

		gohelper.setActive(skillItem.goempty, not skill)
		gohelper.setActive(skillItem.goskill, skill)
	end
end

function HedoneGameView:refreshDamageStateItem()
	local damageDataList = HedoneGameModel.instance:getCDSkillRecordDamageDataList()

	if not self._damageStateItemList or #self._damageStateItemList ~= #damageDataList then
		self._damageStateItemList = {}

		gohelper.CreateObjList(self, self._onCreateDamageStateItem, damageDataList, self._godamages, self._godamageItem)
	end

	self:_refreshDamageStateItemData(damageDataList)
end

function HedoneGameView:_onCreateDamageStateItem(obj, data, index)
	local item = self:getUserDataTb_()

	item.skillId = nil
	item.numLv = 0
	item.txtdlevel = gohelper.findChildText(obj, "#txt_level")
	item.imageskillicon = gohelper.findChildImage(obj, "#image_skillicon")
	item.txtdamage = gohelper.findChildText(obj, "#txt_damage")
	item.imagedamagefg = gohelper.findChildImage(obj, "#go_damagebar/#image_damagefg")
	self._damageStateItemList[index] = item
end

function HedoneGameView:_refreshDamageStateItemData(damageDataList)
	local itemList = self._damageStateItemList

	if not itemList then
		return
	end

	local playerMO = HedoneGameModel.instance:getPlayerMO()
	local dataCount = #damageDataList

	for index = 1, dataCount do
		local data = damageDataList[index]
		local item = itemList[index]

		if data and item then
			local skillId = data.skillId
			local skillType = HedoneConfig.instance:getHedoneSkillType(skillId)
			local skillIdList = playerMO and playerMO:getSkillIdList(skillType)

			if skillIdList then
				local skillLv = math.max(1, #skillIdList or 1)

				if item.skillId ~= skillId or item.numLv ~= skillLv then
					item.skillId = skillId
					item.numLv = skillLv
					item.txtdlevel.text = GameUtil.getRomanNums2(skillLv)

					local icon = HedoneConfig.instance:getHedoneSkillIcon(skillId)

					UISpriteSetMgr.instance:setV3a9HedoneSprite(item.imageskillicon, icon)
				end

				item.txtdamage.text = data.damage
				item.imagedamagefg.fillAmount = data.percent
			end
		end
	end
end

function HedoneGameView:onClose()
	gohelper.addChild(self.viewGO, self._gosecondLayer)

	if self._skillItemList then
		for _, skillItem in ipairs(self._skillItemList) do
			skillItem.skillUid = nil

			skillItem.btnclick:RemoveClickListener()
		end
	end

	self._skillItemList = nil
	self._damageStateItemList = nil

	self:_clearSkillGetItem()
	HedoneGameController.instance:exitGame()
end

function HedoneGameView:onDestroyView()
	return
end

return HedoneGameView
