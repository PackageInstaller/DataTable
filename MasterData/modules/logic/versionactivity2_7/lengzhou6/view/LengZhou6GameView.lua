-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/LengZhou6GameView.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6GameView", package.seeall)

local LengZhou6GameView = class("LengZhou6GameView", BaseView)

function LengZhou6GameView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._goRight = gohelper.findChild(self.viewGO, "#go_Right")
	self._simageGrid = gohelper.findChildSingleImage(self.viewGO, "#go_Right/#simage_Grid")
	self._goTimes = gohelper.findChild(self.viewGO, "#go_Right/#go_Times")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Right/#go_Times/#btn_Left")
	self._txtTimes = gohelper.findChildText(self.viewGO, "#go_Right/#go_Times/#txt_Times")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Right/#go_Times/#btn_Right")
	self._goChessBG = gohelper.findChild(self.viewGO, "#go_Right/#go_ChessBG")
	self._gochessBoard = gohelper.findChild(self.viewGO, "#go_Right/#go_ChessBG/#go_chessBoard")
	self._gochess = gohelper.findChild(self.viewGO, "#go_Right/#go_ChessBG/#go_chess")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Right/#go_ChessBG/#go_chess/#btn_click")
	self._goChessEffect = gohelper.findChild(self.viewGO, "#go_Right/#go_ChessEffect")
	self._goLoading = gohelper.findChild(self.viewGO, "#go_Right/#go_Loading")
	self._sliderloading = gohelper.findChildSlider(self.viewGO, "#go_Right/#go_Loading/#slider_loading")
	self._goContinue = gohelper.findChild(self.viewGO, "#go_Right/#go_Continue")
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#go_Right/#go_Continue/#simage_Mask")
	self._btnContinue = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Right/#go_Continue/#btn_Continue")
	self._goMask = gohelper.findChild(self.viewGO, "#go_Right/#go_Mask")
	self._goAssess = gohelper.findChild(self.viewGO, "#go_Right/#go_Assess")
	self._imageAssess = gohelper.findChildImage(self.viewGO, "#go_Right/#go_Assess/#image_Assess")
	self._goAssess2 = gohelper.findChild(self.viewGO, "#go_Right/#go_Assess2")
	self._imageAssess2 = gohelper.findChildImage(self.viewGO, "#go_Right/#go_Assess2/#image_Assess2")
	self._txtNum = gohelper.findChildText(self.viewGO, "#go_Right/#go_Assess2/#txt_Num")
	self._goEnemy = gohelper.findChild(self.viewGO, "Left/#go_Enemy")
	self._txtenemySkillTitle = gohelper.findChildText(self.viewGO, "Left/#go_Enemy/#txt_enemy_SkillTitle")
	self._imageEnemyHeadIcon = gohelper.findChildImage(self.viewGO, "Left/#go_Enemy/Head/#image_Enemy_HeadIcon")
	self._txtEnemyLife = gohelper.findChildText(self.viewGO, "Left/#go_Enemy/Life/#txt_EnemyLife")
	self._goTarget = gohelper.findChild(self.viewGO, "Left/#go_Target")
	self._simageHeadIcon = gohelper.findChildSingleImage(self.viewGO, "Left/#go_Target/go_Head/#simage_HeadIcon")
	self._txtendlessnum = gohelper.findChildText(self.viewGO, "Left/#go_Target/go_Endless/#txt_endless_num")
	self._goSelf = gohelper.findChild(self.viewGO, "Left/#go_Self")
	self._simagePlayerHeadIcon = gohelper.findChildSingleImage(self.viewGO, "Left/#go_Self/Head/#simage_Player_HeadIcon")
	self._txtSelfLife = gohelper.findChildText(self.viewGO, "Left/#go_Self/Life/#txt_SelfLife")
	self._btnskillDescClose = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_Self/#btn_skillDescClose")
	self._goChooseSkillTips = gohelper.findChild(self.viewGO, "Left/#go_Self/#go_ChooseSkillTips")
	self._goUseSkillTips = gohelper.findChild(self.viewGO, "Left/#go_Self/#go_UseSkillTips")
	self._txtSkillDescr = gohelper.findChildText(self.viewGO, "Left/#go_Self/#go_UseSkillTips/image_TipsBG/#txt_SkillDescr")
	self._txtSkillName = gohelper.findChildText(self.viewGO, "Left/#go_Self/#go_UseSkillTips/image_TipsBG/#txt_SkillDescr/#txt_SkillName")
	self._txtRound = gohelper.findChildText(self.viewGO, "Left/#go_Self/#go_UseSkillTips/image_TipsBG/#txt_SkillDescr/#txt_Round")
	self._btnuseSkill = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_Self/#go_UseSkillTips/image_TipsBG/#txt_SkillDescr/Title/#btn_useSkill")
	self._goEnemySkillTips = gohelper.findChild(self.viewGO, "Left/#go_Self/#go_EnemySkillTips")
	self._txtEnemySkillDescr = gohelper.findChildText(self.viewGO, "Left/#go_Self/#go_EnemySkillTips/image_TipsBG/#txt_Enemy_SkillDescr")
	self._txtEnemySkillName = gohelper.findChildText(self.viewGO, "Left/#go_Self/#go_EnemySkillTips/image_TipsBG/#txt_Enemy_SkillDescr/#txt_Enemy_SkillName")
	self._goEnemyBuffTips = gohelper.findChild(self.viewGO, "Left/#go_Self/#go_EnemyBuffTips")
	self._txtEnemyBuffDescr = gohelper.findChildText(self.viewGO, "Left/#go_Self/#go_EnemyBuffTips/image_TipsBG/#txt_Enemy_BuffDescr")
	self._txtEnemyBuffName = gohelper.findChildText(self.viewGO, "Left/#go_Self/#go_EnemyBuffTips/image_TipsBG/#txt_Enemy_BuffDescr/#txt_Enemy_BuffName")
	self._goPlayerBuffTips = gohelper.findChild(self.viewGO, "Left/#go_Self/#go_PlayerBuffTips")
	self._txtPlayerBuffDescr = gohelper.findChildText(self.viewGO, "Left/#go_Self/#go_PlayerBuffTips/image_TipsBG/#txt_Player_BuffDescr")
	self._txtPlayerBuffName = gohelper.findChildText(self.viewGO, "Left/#go_Self/#go_PlayerBuffTips/image_TipsBG/#txt_Player_BuffDescr/#txt_Player_BuffName")
	self._goCombos = gohelper.findChild(self.viewGO, "#go_Combos")
	self._imageComboFire = gohelper.findChildImage(self.viewGO, "#go_Combos/#image_ComboFire")
	self._txtComboNum = gohelper.findChildText(self.viewGO, "#go_Combos/#txt_ComboNum")
	self._txtComboNum1 = gohelper.findChildText(self.viewGO, "#go_Combos/#txt_ComboNum1")
	self._goChangeTips = gohelper.findChild(self.viewGO, "#go_ChangeTips")
	self._goSkillRelease = gohelper.findChild(self.viewGO, "#go_SkillRelease")
	self._gorectMask = gohelper.findChild(self.viewGO, "#go_SkillRelease/#go_rectMask")
	self._txtskillTipDesc = gohelper.findChildText(self.viewGO, "#go_SkillRelease/#txt_skillTipDesc")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LengZhou6GameView:addEvents()
	self._btnskillDescClose:AddClickListener(self._btnskillDescCloseOnClick, self)
	self._btnuseSkill:AddClickListener(self._btnuseSkillOnClick, self)
end

function LengZhou6GameView:removeEvents()
	self._btnskillDescClose:RemoveClickListener()
	self._btnuseSkill:RemoveClickListener()
end

function LengZhou6GameView:_btnskillDescCloseOnClick()
	self:closeSkillTips()
	self:closeChooseSkillTips()
	self:closeBuffTips()
end

function LengZhou6GameView:_btnuseSkillOnClick()
	if self._playerCurSkillCanUse then
		self:releaseSkill()
	end
end

local ZProj_UIEffectsCollection = ZProj.UIEffectsCollection

function LengZhou6GameView:_editableInitView()
	self._goPlayerSkillParent = gohelper.findChild(self.viewGO, "Left/#go_Self/Scroll View/Viewport/Content")
	self._goEnemySkillParent = gohelper.findChild(self.viewGO, "Left/#go_Enemy/Scroll View/Viewport/Content")
	self._goPlayerChooseSkillParent = gohelper.findChild(self.viewGO, "Left/#go_Self/#go_ChooseSkillTips/Scroll View/Viewport/Content")

	local go = gohelper.findChild(self.viewGO, "Left/#go_Self/#go_UseSkillTips/image_TipsBG/#txt_SkillDescr/Title/#btn_useSkill")

	self._imageUseSkillEffectCollection = ZProj_UIEffectsCollection.Get(go)
	self._combosTr = self._goCombos.transform
	self._combosAnim = self._goCombos:GetComponent(typeof(UnityEngine.Animator))
	self._goChooseSkillTipsAnim = self._goChooseSkillTips:GetComponent(typeof(UnityEngine.Animator))
	self._playerDamageGo = gohelper.findChild(self.viewGO, "Left/#go_Self/Life/damage")
	self._playerDamageText = gohelper.findChildText(self.viewGO, "Left/#go_Self/Life/damage/x/txtNum")
	self._enemyDamageGo = gohelper.findChild(self.viewGO, "Left/#go_Enemy/Life/damage")
	self._enemyDamageText = gohelper.findChildText(self.viewGO, "Left/#go_Enemy/Life/damage/x/txtNum")

	gohelper.setActive(self._playerDamageGo, false)
	gohelper.setActive(self._enemyDamageGo, false)

	self._enemyBuffParent = gohelper.findChild(self.viewGO, "Left/#go_Enemy/Life/EnemyBuff")
	self._playerBuffParent = gohelper.findChild(self.viewGO, "Left/#go_Self/Life/PlayerBuff")
	self._playerAni = self._goSelf:GetComponent(gohelper.Type_Animator)
	self._enemyAni = self._goEnemy:GetComponent(gohelper.Type_Animator)
end

function LengZhou6GameView:onUpdateParam()
	return
end

function LengZhou6GameView:onOpen()
	self:initView()
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.UpdateGameInfo, self.updateGameInfo, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.UpdateEliminateDamage, self.updateEliminateDamage, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.UpdateEnemySkill, self.updateEnemySkill, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.UpdatePlayerSkill, self.updatePlayerSkill, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.OnClickSkill, self.onClickSkill, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.FinishReleaseSkill, self.cancelPlayerSkill, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.UseEnemySkill, self.useEnemySkill, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.ShowCombos, self.showCombos, self)
	self.addEventCb(self, LengZhou6EliminateController.instance, LengZhou6Event.ShowEnemyEffect, self.showEnemyEffect, self)
	self.addEventCb(self, LengZhou6GameController.instance, LengZhou6Event.EnemySkillRound, self.enemySkillRound, self)
	self.addEventCb(self, LengZhou6GameController.instance, LengZhou6Event.OnEndlessChangeSelectState, self.endLessModelRefreshView, self)
	self.addEventCb(self, LengZhou6GameController.instance, LengZhou6Event.ShowSelectView, self.showSelectView, self)
	self.addEventCb(self, LengZhou6GameController.instance, LengZhou6Event.PlayerSelectFinish, self._playerSkillSelectFinish, self)
	self.addEventCb(self, LengZhou6GameController.instance, LengZhou6Event.GameReStart, self._gameReStart, self)
	self.addEventCb(self, LengZhou6GameController.instance, LengZhou6Event.RefreshBuffItem, self.refreshBuffItem, self)
	self.addEventCb(self, LengZhou6Controller.instance, LengZhou6Event.OnClickBuff, self.onClickBuff, self)
end

function LengZhou6GameView:initView()
	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_level_open)

	local battleModel = LengZhou6GameModel.instance:getBattleModel()
	local isEndLess = battleModel == LengZhou6Enum.BattleModel.infinite

	self:initHeroAndEnemyIcon()
	self:updateGameInfo()
	self:updateEliminateDamage()
	self:initPlayerSKillView(not isEndLess)
	self:initEnemySKillView()
	self:updatePlayerSkill()
	self:enemySkillRound()
	gohelper.setActive(self._goUseSkillTips, false)
	gohelper.setActive(self._btnskillDescClose.gameObject, false)
	gohelper.setActive(self._goSelected, false)
	gohelper.setActive(self._goTarget, isEndLess)

	if isEndLess then
		self:initSelectView()
	end

	self:closeChooseSkillTips()
	self:endLessModelRefreshView(true)
end

function LengZhou6GameView:initHeroAndEnemyIcon()
	local heroIconName = LengZhou6Config.instance:getEliminateBattleCostStr(24)
	local enemyIconName = LengZhou6Config.instance:getEliminateBattleCostStr(25)

	UISpriteSetMgr.instance:setHisSaBethSprite(self._imageEnemyHeadIcon, enemyIconName)
	self._simagePlayerHeadIcon:LoadImage(ResUrl.getHeadIconSmall(heroIconName))
end

function LengZhou6GameView:updateGameInfo()
	local player = LengZhou6GameModel.instance:getPlayer()
	local enemy = LengZhou6GameModel.instance:getEnemy()

	self._txtEnemyLife.text = enemy:getHp()
	self._txtSelfLife.text = player:getHp()

	gohelper.setActive(self._goCombos, false)

	local model = LengZhou6GameModel.instance:getBattleModel()

	self._txtendlessnum.text = LengZhou6GameModel.instance:getEndLessModelLayer() or LengZhou6Enum.DefaultEndLessBeginRound

	self:refreshBuffItem()
end

function LengZhou6GameView:enemySkillRound(residueCd)
	if residueCd == nil then
		local enemy = LengZhou6GameModel.instance:getEnemy()
		local action = enemy:getAction()

		residueCd = action:calCurResidueCd()
	end

	local needRelease = residueCd <= 1
	local showResidueCd = math.max(residueCd - 1, 0)

	self._txtenemySkillTitle.text = needRelease and luaLang("lengZhou6_enemy_skill_title_2") or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("lengZhou6_enemy_skill_title"), showResidueCd)

	if self._enemySkillList == nil then
		return
	end

	for i = 1, #self._enemySkillList do
		local skillItem = self._enemySkillList[i]

		if skillItem then
			skillItem:showEnemySkillRound(needRelease)
		end
	end
end

function LengZhou6GameView:endLessModelRefreshView(init)
	local battleModel = LengZhou6GameModel.instance:getBattleModel()

	gohelper.setActive(self._goChangeTips, false)

	if battleModel == LengZhou6Enum.BattleModel.infinite then
		local progress = LengZhou6GameModel.instance:getEndLessBattleProgress()

		TaskDispatcher.runDelay(self.showChangeTips, self, (init or nil) and LengZhou6Enum.openViewAniTime)

		local selectIsFinish = progress == LengZhou6Enum.BattleProgress.selectFinish

		if selectIsFinish then
			self:updateGameInfo()
		end

		self:initPlayerSKillView(selectIsFinish)
		self:closeSkillTips()
		self:cancelPlayerSkill()
		self:updateEnemySkill(true)
		self:enemySkillRound()
	end
end

function LengZhou6GameView:showChangeTips()
	TaskDispatcher.cancelTask(self.showChangeTips, self)

	local progress = LengZhou6GameModel.instance:getEndLessBattleProgress()

	gohelper.setActive(self._goChangeTips, progress == LengZhou6Enum.BattleProgress.selectSkill)

	local curEpisodeId = LengZhou6Model.instance:getCurEpisodeId()

	LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.EnterGameLevel, curEpisodeId)
end

function LengZhou6GameView:updateEliminateDamage()
	local enemy = LengZhou6GameModel.instance:getEnemy()
	local damage = enemy:getCurDiff()
	local needDelay = false

	if damage and math.abs(damage) > 0 then
		self:setCombosActive(true)

		self._enemyDamageText.text = "-" .. math.abs(damage)

		gohelper.setActive(self._enemyDamageGo, true)
		self._enemyAni:Play("damage", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_hp)

		needDelay = true
	else
		self:setCombosActive(false)
	end

	local palyer = LengZhou6GameModel.instance:getPlayer()
	local diff = palyer:getCurDiff()

	if diff and math.abs(diff) > 0 then
		self._playerDamageText.text = "+" .. math.abs(diff)

		gohelper.setActive(self._playerDamageGo, true)

		needDelay = true
	end

	if needDelay then
		TaskDispatcher.cancelTask(self._onMoveEnd, self)
		TaskDispatcher.runDelay(self._onMoveEnd, self, EliminateEnum_2_7.UpdateDamageStepTime)
	else
		self:_onMoveEnd()
	end
end

function LengZhou6GameView:_onMoveEnd()
	gohelper.setActive(self._enemyDamageGo, false)
	gohelper.setActive(self._playerDamageGo, false)
	TaskDispatcher.cancelTask(self._onMoveEnd, self)
	self:setCombosActive(false)

	local enemy = LengZhou6GameModel.instance:getEnemy()

	self._txtEnemyLife.text = enemy:getHp()

	local player = LengZhou6GameModel.instance:getPlayer()

	self._txtSelfLife.text = player:getHp()

	self._enemyAni:Play("idle", 0, 0)
end

function LengZhou6GameView:showCombos(value)
	local value = value or 0
	local thresholdValue = LengZhou6Config.instance:getComboThreshold()
	local showFire = thresholdValue <= value

	self._txtComboNum.text = value
	self._txtComboNum1.text = value

	if self._comboActive then
		self._combosAnim:Play("up", 0, 0)
	end

	self:setCombosActive(value > 0)
	gohelper.setActive(self._imageComboFire.gameObject, showFire)
end

function LengZhou6GameView:setCombosActive(active)
	if self._comboActive ~= nil and self._comboActive == active then
		return
	end

	gohelper.setActive(self._goCombos, active)

	self._comboActive = active
end

function LengZhou6GameView:initPlayerSKillView(isSelectFinish)
	if self._playerSkillList == nil then
		self._playerSkillList = self:getUserDataTb_()
	end

	local player = LengZhou6GameModel.instance:getPlayer()
	local activeSkills = player:getActiveSkills()
	local selectIds = LengZhou6GameModel.instance:getSelectSkillIdList()
	local path = self.viewContainer:getSetting().otherRes[1]

	for i = 1, LengZhou6Enum.PlayerSkillMaxCount do
		local skill, skillId

		if isSelectFinish then
			skill = activeSkills[i]
		else
			skillId = selectIds[i]
		end

		local skillItem = self._playerSkillList[i]

		if skillItem == nil then
			local itemGO = self:getResInst(path, self._goPlayerSkillParent)

			skillItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, LengZhou6SkillItem)

			gohelper.setActive(itemGO, true)
			table.insert(self._playerSkillList, skillItem)
		end

		if skillItem ~= nil then
			skillItem:initSkill(skill, i)

			if skill == nil then
				skillItem:initSkillConfigId(skillId)
			end

			skillItem:initCamp(LengZhou6Enum.entityCamp.player)
			skillItem:selectIsFinish(isSelectFinish)
			skillItem:refreshState()
		end
	end
end

function LengZhou6GameView:updatePlayerSkill()
	if self._playerSkillList ~= nil then
		for i = 1, #self._playerSkillList do
			local skillItem = self._playerSkillList[i]

			if skillItem then
				skillItem:updateSkillInfo()
			end
		end
	end
end

function LengZhou6GameView:initEnemySKillView()
	if self._enemySkillList == nil then
		self._enemySkillList = self:getUserDataTb_()
	end

	local enemy = LengZhou6GameModel.instance:getEnemy()
	local activeSkills = enemy:getCurSkillList()
	local path = self.viewContainer:getSetting().otherRes[1]

	for i = 1, 3 do
		local skill = activeSkills and activeSkills[i]
		local skillItem = self._enemySkillList[i]

		if skillItem == nil then
			local itemGO = self:getResInst(path, self._goEnemySkillParent)

			skillItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, LengZhou6SkillItem)

			gohelper.setActive(itemGO, true)
		end

		skillItem:initSkill(skill)
		skillItem:initCamp(LengZhou6Enum.entityCamp.enemy)
		skillItem:refreshState()
		table.insert(self._enemySkillList, skillItem)
	end
end

function LengZhou6GameView:updateEnemySkill(closeAudio)
	local enemy = LengZhou6GameModel.instance:getEnemy()
	local activeSkills = enemy:getCurSkillList()

	for i = 1, 3 do
		if activeSkills then
			if not activeSkills[i] then
				local skill
				local skillItem = self._enemySkillList[i]

				skillItem:initSkill(skill)
				skillItem:refreshState()

				if skill ~= nil and not closeAudio then
					AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_refresh)
				end
			end
		end
	end
end

function LengZhou6GameView:useEnemySkill(skillId)
	for i = 1, #self._enemySkillList do
		local skillItem = self._enemySkillList[i]

		skillItem:useSkill(skillId)
	end
end

function LengZhou6GameView:onClickSkill(skill)
	if skill == nil then
		return
	end

	if skill:getSkillType() == LengZhou6Enum.SkillType.enemyActive then
		self:_showEnemySkillDesc(skill)
	else
		self:_showPlayerSkillDesc(skill)
	end

	gohelper.setActive(self._btnskillDescClose.gameObject, true)
end

function LengZhou6GameView:_showEnemySkillDesc(skill)
	if skill == nil then
		return
	end

	self._txtEnemySkillDescr.text = skill:getSkillDesc()
	self._txtEnemySkillName.text = skill:getConfig().name

	gohelper.setActive(self._goEnemySkillTips, true)
end

function LengZhou6GameView:_showPlayerSkillDesc(skill)
	self._playerCurSkill = skill

	local config = skill:getConfig()

	self._txtSkillDescr.text = config.desc

	local cd = skill:getCd()
	local isActive = config.type == LengZhou6Enum.SkillType.active

	self._txtRound.text = isActive and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("lengZhou6_skill_round"), skill:getConfig().cd) or luaLang("lengZhou6_skill_round_end")
	self._txtSkillName.text = config.name
	self._playerCurSkillCanUse = cd == 0 and isActive

	if self._imageUseSkillEffectCollection ~= nil then
		self._imageUseSkillEffectCollection:SetGray(not self._playerCurSkillCanUse)
	end

	gohelper.setActive(self._btnuseSkill.gameObject, isActive)
	gohelper.setActive(self._goUseSkillTips, true)
end

function LengZhou6GameView:closeSkillTips()
	gohelper.setActive(self._goUseSkillTips, false)
	gohelper.setActive(self._btnskillDescClose.gameObject, false)
	gohelper.setActive(self._goEnemySkillTips, false)
end

function LengZhou6GameView:releaseSkill()
	if self._playerCurSkill ~= nil then
		if self._playerCurSkill:paramIsFull() then
			self._playerCurSkill:execute()

			self._playerCurSkill = nil
		else
			self:initCharacterSkill()
			LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.ReleaseSkill, self._playerCurSkill)
		end
	end

	self:closeSkillTips()
end

function LengZhou6GameView:cancelPlayerSkill()
	self._playerCurSkill = nil

	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.CancelSkill)
	self:hideSkillRelease()
end

function LengZhou6GameView:hideSkillRelease()
	if self._skillReleaseView ~= nil then
		gohelper.setActive(self._goSkillRelease, false)
	end
end

function LengZhou6GameView:initCharacterSkill()
	if self._skillReleaseView == nil then
		self._skillReleaseView = MonoHelper.addNoUpdateLuaComOnceToGo(self._goSkillRelease, LengZhou6EliminatePlayerSkill)
	end

	local tr = self._goChessBG.transform
	local width = recthelper.getWidth(tr)
	local height = recthelper.getHeight(tr)

	self._skillReleaseView:setTargetTrAndHoleSize(tr, width, height, -56, 325)
	self._skillReleaseView:setClickCb(self.cancelPlayerSkill, self)
	gohelper.setActive(self._goSkillRelease, true)
end

function LengZhou6GameView:initSelectView()
	if self._allSelectSkillItemList == nil then
		self._allSelectSkillItemList = self:getUserDataTb_()
	end

	local allSkillIds = LengZhou6Config.instance:getPlayerAllSkillId()
	local path = self.viewContainer:getSetting().otherRes[2]

	for i = 1, #allSkillIds do
		local skillId = allSkillIds[i]
		local skillItem = self._allSelectSkillItemList[i]

		if skillItem == nil then
			local itemGO = self:getResInst(path, self._goPlayerChooseSkillParent, skillId)

			skillItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, LengZhou6PlayerSelectSkillItem)

			table.insert(self._allSelectSkillItemList, skillItem)
			gohelper.setActive(itemGO, true)
		end

		skillItem:initSkill(skillId)
	end
end

function LengZhou6GameView:showSelectView(index)
	if self._allSelectSkillItemList == nil or tabletool.len(self._allSelectSkillItemList) == 0 then
		return
	end

	local allSkillIds = LengZhou6Config.instance:getPlayerAllSkillId()

	for i = 1, #self._allSelectSkillItemList do
		local skillItem = self._allSelectSkillItemList[i]

		skillItem:initSelectIndex(index)
	end

	table.sort(allSkillIds, function(a, b)
		local selectA = LengZhou6GameModel.instance:isSelectSkill(a)
		local selectB = LengZhou6GameModel.instance:isSelectSkill(b)

		if selectA and not selectB then
			return false
		elseif not selectA and selectB then
			return true
		else
			return a < b
		end
	end)

	for i = 1, #allSkillIds do
		local skillId = allSkillIds[i]
		local skillItem = self._allSelectSkillItemList[i]

		skillItem:initSkill(skillId)
	end

	self:setChooseSkillActive(true)
	gohelper.setActive(self._btnskillDescClose.gameObject, true)
end

function LengZhou6GameView:setChooseSkillActive(active)
	if self._lastChooseActive ~= nil and self._lastActive == active then
		return
	end

	if active then
		gohelper.setActive(self._goChooseSkillTips, true)
		self._goChooseSkillTipsAnim:Play("open", 0, 0)

		self._lastChooseActive = active
	else
		self._goChooseSkillTipsAnim:Play("close", 0, 0)
		TaskDispatcher.runDelay(self._setChooseSkillTipsFalse, self, 0.167)
	end
end

function LengZhou6GameView:_setChooseSkillTipsFalse()
	gohelper.setActive(self._goChooseSkillTips, false)

	self._lastChooseActive = false
end

function LengZhou6GameView:_playerSkillSelectFinish(index, skillId)
	self:closeChooseSkillTips()

	if self._playerSkillList ~= nil then
		local skillItem = self._playerSkillList[index]

		if skillItem ~= nil then
			skillItem:initSkillConfigId(skillId)
			skillItem:initCamp(LengZhou6Enum.entityCamp.player)
			skillItem:refreshState()
		end
	end
end

function LengZhou6GameView:closeChooseSkillTips()
	self:setChooseSkillActive(false)
	gohelper.setActive(self._btnskillDescClose.gameObject, false)
end

function LengZhou6GameView:showEnemyEffect(effect)
	if effect == LengZhou6Enum.SkillEffect.DealsDamage then
		local player = LengZhou6GameModel.instance:getPlayer()

		self._playerDamageText.text = player:getCurDiff()

		gohelper.setActive(self._playerDamageGo, true)
		self._playerAni:Play("damage", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_hp)
		TaskDispatcher.cancelTask(self._showPlayerEffectEnd, self)
		TaskDispatcher.runDelay(self._showPlayerEffectEnd, self, LengZhou6Enum.EnemySkillTime)
	end

	if effect == LengZhou6Enum.SkillEffect.Heal then
		local enemy = LengZhou6GameModel.instance:getEnemy()
		local diff = enemy:getCurDiff()

		self._enemyDamageText.text = diff > 0 and string.format("+%s", diff)

		gohelper.setActive(self._enemyDamageGo, true)
		TaskDispatcher.cancelTask(self._showEnemyEffectEnd, self)
		TaskDispatcher.runDelay(self._showEnemyEffectEnd, self, LengZhou6Enum.EnemySkillTime)
	end

	if effect == LengZhou6Enum.BuffEffect.poison then
		local enemy = LengZhou6GameModel.instance:getEnemy()
		local diff = enemy:getCurDiff()

		self._enemyDamageText.text = diff > 0 and string.format("+%s", diff) or diff

		gohelper.setActive(self._enemyDamageGo, true)
		self._enemyAni:Play("damage", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_hp)

		local enemy = LengZhou6GameModel.instance:getEnemy()

		TaskDispatcher.cancelTask(self._showEnemyEffectEnd, self)
		TaskDispatcher.runDelay(self._showEnemyEffectEnd, self, LengZhou6Enum.EnemyBuffEffectShowTime)
	end
end

function LengZhou6GameView:_showPlayerEffectEnd()
	gohelper.setActive(self._playerDamageGo, false)

	local player = LengZhou6GameModel.instance:getPlayer()

	self._txtSelfLife.text = player:getHp()

	self._playerAni:Play("idle", 0, 0)
end

function LengZhou6GameView:_showEnemyEffectEnd()
	gohelper.setActive(self._enemyDamageGo, false)

	local enemy = LengZhou6GameModel.instance:getEnemy()

	self._txtEnemyLife.text = enemy:getHp()

	self._enemyAni:Play("idle", 0, 0)
end

function LengZhou6GameView:refreshBuffItem()
	self:_refreshPlayerBuffItem()
	self:_refreshEnemyBuffItem()
end

function LengZhou6GameView:_refreshPlayerBuffItem()
	if self._playerBuffItems == nil then
		self._playerBuffItems = self:getUserDataTb_()
	end

	local player = LengZhou6GameModel.instance:getPlayer()
	local buffs = player:getBuffs()
	local num = math.max(tabletool.len(buffs), tabletool.len(self._playerBuffItems))

	for i = 1, num do
		local item = self._playerBuffItems[i]
		local buff = buffs[i]

		if item == nil then
			local itemGO = self:getResInst(self.viewContainer:getSetting().otherRes[3], self._playerBuffParent)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, LengZhou6BuffItem)

			table.insert(self._playerBuffItems, item)
		end

		if item ~= nil then
			item:changeParent((buff ~= nil and buff._configId == 1001 or nil) and self._enemyBuffParent)
		end

		if item ~= nil then
			item:updateBuffItem(buff)
		end
	end
end

function LengZhou6GameView:_refreshEnemyBuffItem()
	if self._enemyBuffItems == nil then
		self._enemyBuffItems = self:getUserDataTb_()
	end

	local enemy = LengZhou6GameModel.instance:getEnemy()
	local buffs = enemy:getBuffs()
	local num = math.max(tabletool.len(buffs), tabletool.len(self._enemyBuffItems))

	for i = 1, num do
		local item = self._enemyBuffItems[i]
		local buff = buffs[i]

		if item == nil and buff ~= nil then
			local itemGO = self:getResInst(self.viewContainer:getSetting().otherRes[3], self._enemyBuffParent)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, LengZhou6BuffItem)

			gohelper.setActive(itemGO, true)
			table.insert(self._enemyBuffItems, item)
		end

		if item ~= nil then
			item:updateBuffItem(buff)
		end
	end
end

function LengZhou6GameView:onClickBuff(buffConfigId)
	if buffConfigId == nil then
		return
	end

	local config = LengZhou6Config.instance:getEliminateBattleBuff(buffConfigId)

	if config then
		if buffConfigId == 1001 or buffConfigId == 1002 then
			self._txtEnemyBuffDescr.text = config.desc
			self._txtEnemyBuffName.text = config.name

			gohelper.setActive(self._goEnemyBuffTips, true)
		end

		if buffConfigId == 1003 then
			self._txtPlayerBuffDescr.text = config.desc
			self._txtPlayerBuffName.text = config.name

			gohelper.setActive(self._goPlayerBuffTips, true)
		end

		gohelper.setActive(self._btnskillDescClose.gameObject, true)
	end
end

function LengZhou6GameView:closeBuffTips()
	gohelper.setActive(self._goEnemyBuffTips, false)
	gohelper.setActive(self._goPlayerBuffTips, false)
end

function LengZhou6GameView:onClose()
	TaskDispatcher.cancelTask(self._onMoveEnd, self)
	TaskDispatcher.cancelTask(self.showChangeTips, self)
	TaskDispatcher.cancelTask(self._showEffectEnd, self)
	TaskDispatcher.cancelTask(self._showPlayerEffectEnd, self)
	TaskDispatcher.cancelTask(self._showEnemyEffectEnd, self)
end

function LengZhou6GameView:_gameReStart()
	self:initView()
end

function LengZhou6GameView:onDestroyView()
	return
end

return LengZhou6GameView
