-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateLevelView.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelView", package.seeall)

local EliminateLevelView = class("EliminateLevelView", BaseView)

function EliminateLevelView:onInitView()
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gocameraMain = gohelper.findChild(self.viewGO, "#go_cameraMain")
	self._simageteamchessMaskBG2 = gohelper.findChildSingleImage(self.viewGO, "#go_cameraMain/#simage_teamchessMaskBG2")
	self._simageeliminatechessMaskBG = gohelper.findChildSingleImage(self.viewGO, "#go_cameraMain/#simage_eliminatechessMaskBG")
	self._simageeliminatechessMaskBG2 = gohelper.findChildSingleImage(self.viewGO, "#go_cameraMain/#simage_eliminatechessMaskBG2")
	self._simageteamchessMaskBG = gohelper.findChildSingleImage(self.viewGO, "#go_cameraMain/#simage_teamchessMaskBG")
	self._goModeBGDec = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Title/#go_ModeBGDec")
	self._txtTurns = gohelper.findChildText(self.viewGO, "#go_cameraMain/Middle/Title/#txt_Turns")
	self._goPoint = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Title/Point/#go_Point")
	self._goPointLight = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Title/Point/#go_PointLight")
	self._goEliminate = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Title/Eliminate/#go_Eliminate")
	self._goEliminateLight = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Title/Eliminate/#go_EliminateLight")
	self._goteamchess = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/#go_teamchess")
	self._goPointViewList = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/#go_eliminatechess/Right/#go_PointViewList")
	self._goeliminatechess = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/#go_eliminatechess")
	self._btnTaskcancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cameraMain/Left/Task/#btn_Task_cancel")
	self._goTaskPanel = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel")
	self._imageTaskBG = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel/#image_TaskBG")
	self._goItem = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel/#image_TaskBG/#go_Item")
	self._txtTaskTarget = gohelper.findChildText(self.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel/#image_TaskBG/#go_Item/#txt_TaskTarget")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cameraMain/Left/Task/#btn_Task")
	self._imageRoleBG = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Left/Role/#image_RoleBG")
	self._imageRoleBG2 = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Left/Role/#image_RoleBG2")
	self._imageRoleHPFG = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Left/Role/Role/#image_RoleHPFG")
	self._imageRolehpfgeff1 = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Left/Role/Role/#image_RoleHPFG/#image_Rolehpfg_eff1")
	self._simageRole = gohelper.findChildSingleImage(self.viewGO, "#go_cameraMain/Left/Role/Role/image/#simage_Role")
	self._txtRoleHP = gohelper.findChildText(self.viewGO, "#go_cameraMain/Left/Role/Role/image_RoleHPNumBG/#txt_RoleHP")
	self._gorolePointDamage = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Role/Role/#go_rolePointDamage")
	self._goRoleSkillPoint1 = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1")
	self._goRoleSkill = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill")
	self._goRoleSkillBG = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillBG")
	self._goRoleSkillBGDisable = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillBGDisable")
	self._imageRoleSkill = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/image/#image_RoleSkill")
	self._goRolevxbreak = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/image/#go_Role_vx_break")
	self._imageRoleSkillFG = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#image_RoleSkillFG")
	self._imageRoleSkillfgeff1 = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#image_RoleSkillFG/#image_RoleSkillfg_eff1")
	self._goRoleSkillFull = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillFull")
	self._goRoleSkillLoop = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillFull/#go_RoleSkill_Loop")
	self._goRoleSkillClickEffect = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillClick_Effect")
	self._txtRoleCostNum = gohelper.findChildText(self.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/image_SkillEnergyBG/#txt_RoleCostNum")
	self._goRoleSkillClick = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillClick")
	self._goRoleSkillPoint2 = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint2")
	self._goRolevxdamage = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Role/#go_Role_vx_damage")
	self._imageEnemyBG = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Right/Enemy/#image_EnemyBG")
	self._imageEnemyBG2 = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Right/Enemy/#image_EnemyBG2")
	self._goenemyPointDamage = gohelper.findChild(self.viewGO, "#go_cameraMain/Right/Enemy/Enemy/#go_enemyPointDamage")
	self._imageEnemyHPFG = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Right/Enemy/Enemy/#image_EnemyHPFG")
	self._imageEnemyhpfgeff2 = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Right/Enemy/Enemy/#image_EnemyHPFG/#image_Enemyhpfg_eff2")
	self._simageEnemy = gohelper.findChildSingleImage(self.viewGO, "#go_cameraMain/Right/Enemy/Enemy/image/#simage_Enemy")
	self._goenemyvxbreak = gohelper.findChild(self.viewGO, "#go_cameraMain/Right/Enemy/Enemy/image/#go_enemy_vx_break")
	self._txtEnemyHP = gohelper.findChildText(self.viewGO, "#go_cameraMain/Right/Enemy/Enemy/image_EnemyHPNumBG/#txt_EnemyHP")
	self._goEnemySkillPoint1 = gohelper.findChild(self.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1")
	self._goEnemySkill = gohelper.findChild(self.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill")
	self._goEnemySkillBG = gohelper.findChild(self.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/#go_EnemySkillBG")
	self._goEnemySkillBGDisable = gohelper.findChild(self.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/#go_EnemySkillBGDisable")
	self._imageEnemySkill = gohelper.findChildSingleImage(self.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/image/#image_EnemySkill")
	self._imageenemySkillFG = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/#image_enemySkillFG")
	self._imageEnemyskillfgeff2 = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/#image_enemySkillFG/#image_Enemyskillfg_eff2")
	self._goEnemySkillFull = gohelper.findChild(self.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/#go_EnemySkillFull")
	self._txtEnemyCostNum = gohelper.findChildText(self.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint1/#go_EnemySkill/image_SkillEnergyBG/#txt_EnemyCostNum")
	self._goEnemySkillPoint2 = gohelper.findChild(self.viewGO, "#go_cameraMain/Right/Enemy/#go_EnemySkillPoint2")
	self._goEnemyvxdamage = gohelper.findChild(self.viewGO, "#go_cameraMain/Right/Enemy/#go_Enemy_vx_damage")
	self._btnPointViewBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cameraMain/Right/#btn_PointViewBtn")
	self._txtPointView = gohelper.findChildText(self.viewGO, "#go_cameraMain/Right/#btn_PointViewBtn/#txt_PointView")
	self._goskillViewPoint = gohelper.findChild(self.viewGO, "#go_cameraMain/#go_skillViewPoint")
	self._goRolePoint = gohelper.findChild(self.viewGO, "#go_cameraMain/#go_skillViewPoint/#go_Role_Point")
	self._goEnemyPoint = gohelper.findChild(self.viewGO, "#go_cameraMain/#go_skillViewPoint/#go_Enemy_Point")
	self._goenemyInfo = gohelper.findChild(self.viewGO, "#go_cameraMain/#go_enemyInfo")
	self._goEnemyChessPoint = gohelper.findChild(self.viewGO, "#go_cameraMain/#go_enemyInfo/#go_EnemyChessPoint")
	self._goSkillRelease = gohelper.findChild(self.viewGO, "#go_cameraMain/#go_SkillRelease")
	self._gorectMask = gohelper.findChild(self.viewGO, "#go_cameraMain/#go_SkillRelease/#go_rectMask")
	self._txtskillTipDesc = gohelper.findChildText(self.viewGO, "#go_cameraMain/#go_SkillRelease/#txt_skillTipDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateLevelView:addEvents()
	self._btnTaskcancel:AddClickListener(self._btnTaskcancelOnClick, self)
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
	self._btnPointViewBtn:AddClickListener(self._btnPointViewBtnOnClick, self)
end

function EliminateLevelView:removeEvents()
	self._btnTaskcancel:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnPointViewBtn:RemoveClickListener()
end

local SLFramework_UGUI_UILongPressListener = SLFramework.UGUI.UILongPressListener
local SLFramework_UGUI_UIClickListener = SLFramework.UGUI.UIClickListener
local tweenHelper = ZProj.TweenHelper
local ZProj_UIEffectsCollection = ZProj.UIEffectsCollection

function EliminateLevelView:_btnTaskcancelOnClick()
	self:changeShowTaskPanelState(true)
end

function EliminateLevelView:_btnTaskOnClick()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_switch)
	self:changeShowTaskPanelState(true)
end

function EliminateLevelView:changeShowTaskPanelState(needControlBtn)
	self._isShowTaskPanel = not self._isShowTaskPanel

	if not self._isShowTaskPanel then
		self._taskAni:Play("close")
		TaskDispatcher.runDelay(self.setTaskViewActive, self, 0.27)
	else
		self:setTaskViewActive()
	end

	if needControlBtn then
		gohelper.setActive(self._btnTaskcancel, self._isShowTaskPanel)
	end
end

function EliminateLevelView:setTaskViewActive()
	gohelper.setActive(self._goTaskPanel, self._isShowTaskPanel)
end

function EliminateLevelView:_btnPointViewBtnOnClick()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)
	self:setTeamChessViewWatchState()
end

function EliminateLevelView:_editableInitView()
	self.roleGo = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Role/Role")
	self.enemyGo = gohelper.findChild(self.viewGO, "#go_cameraMain/Right/Enemy/Enemy")
	self._goRoleSkillClickEffect = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Role/#go_RoleSkillPoint1/#go_RoleSkill/#go_RoleSkillClick_Effect")
	self._imageRole = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Left/Role/Role/image/#simage_Role")
	self._imageEnemy = gohelper.findChildImage(self.viewGO, "#go_cameraMain/Right/Enemy/Enemy/image/#simage_Enemy")
	self._effectAck = gohelper.findChild(self.viewGO, "#go_cameraMain/#eff_attack")
	self._effectToPlayer = gohelper.findChild(self.viewGO, "#go_cameraMain/#eff_attack/1")
	self._effectToEnemy = gohelper.findChild(self.viewGO, "#go_cameraMain/#eff_attack/2")
	self.roleSkillLongPress = SLFramework_UGUI_UILongPressListener.Get(self._goRoleSkillClick)

	self.roleSkillLongPress:AddClickListener(self._roleSkillLongPressClick, self)
	self.roleSkillLongPress:AddLongPressListener(self._roleSkillLongPress, self)
	self.roleSkillLongPress:SetLongPressTime({
		0.5,
		9999
	})

	self.enemyInfoMaskClick = SLFramework_UGUI_UIClickListener.Get(self._goenemyInfo)

	self.enemyInfoMaskClick:AddClickListener(self.hideEnemyInfoView, self)

	self.pointViewListClick = SLFramework_UGUI_UIClickListener.Get(self._goPointViewList)

	self.pointViewListClick:AddClickListener(self._pointViewListClick, self)

	self.roleClick = SLFramework_UGUI_UIClickListener.Get(self._simageRole.gameObject)

	self.roleClick:AddClickListener(self.onRoleClick, self)

	self.enemySkillClick = SLFramework_UGUI_UILongPressListener.Get(self._goEnemySkill)

	self.enemySkillClick:AddLongPressListener(self.showEnemySkillView, self)
	self.enemySkillClick:SetLongPressTime({
		0.5,
		9999
	})

	self._ani = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._taskAni = self._goTaskPanel:GetComponent(typeof(UnityEngine.Animator))
	self._teamChessViewAni = self._goteamchess:GetComponent(typeof(UnityEngine.Animator))
	self._eliminateChessViewAni = self._goeliminatechess:GetComponent(typeof(UnityEngine.Animator))
	self._eliminateLightAni = self._goEliminateLight:GetComponent(typeof(UnityEngine.Animator))
	self._pointLightAni = self._goPointLight:GetComponent(typeof(UnityEngine.Animator))
	self._roleSkillUIEffect = ZProj_UIEffectsCollection.Get(self._goRoleSkill)
	self._roleGoUIEffect = ZProj_UIEffectsCollection.Get(self.roleGo)
	self._enemyGoUIEffect = ZProj_UIEffectsCollection.Get(self.enemyGo)
	self._eliminatechessMaskCanvasGroup = self._simageeliminatechessMaskBG.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._eliminatechessMaskCanvasGroup2 = self._simageeliminatechessMaskBG2.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._teamchessMaskCanvasGroup = self._simageteamchessMaskBG.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._teamchessMaskCanvasGroup2 = self._simageteamchessMaskBG2.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(self._goRoleSkillClickEffect, false)
	gohelper.setActive(self._effectAck, false)
	EliminateLevelController.instance:BgSwitch(EliminateEnum.AudioFightStep.FightNormal)
end

function EliminateLevelView:_roleSkillLongPressClick()
	if not EliminateLevelModel.instance:mainCharacterSkillIsUnLock() then
		GameFacade.showToast(ToastEnum.EliminateMainSkillLocked)

		return
	end

	if not EliminateLevelModel.instance:canReleaseSkill() then
		GameFacade.showToast(ToastEnum.EliminateSkillEnergyNotEnough)

		return
	end

	self:skillRelease()
end

function EliminateLevelView:hideRoleSkillClickEffect()
	gohelper.setActive(self._goRoleSkillClickEffect, false)
end

function EliminateLevelView:_roleSkillLongPress()
	self:showSkillView()
end

function EliminateLevelView:onRoleClick()
	EliminateLevelController.instance:clickMainCharacter()
end

function EliminateLevelView:onUpdateParam()
	return
end

function EliminateLevelView:setParent(parent, canvas)
	self._gocameraMain.transform:SetParent(parent.transform)
	EliminateTeamChessModel.instance:setViewCanvas(canvas)

	local mainTr = self._gocameraMain.transform

	transformhelper.setLocalScale(mainTr, 0.009259259, 0.009259259, 0.009259259)
	transformhelper.setLocalPos(mainTr, 0, 0, 0)
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.EliminateRoundStateChangeGoActive)
end

function EliminateLevelView:onOpen()
	self.showWatchView = false
	self._canUseSkill = true

	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.TeamChessWarInfoUpdate, self.updateInfo, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChange, self.updateViewState, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.MainCharacterHpChange, self.mainCharacterHpChange, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.LevelConditionChange, self.updateTaskInfo, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.MainCharacterPowerChange, self.mainCharacterPowerChange, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.WarChessCharacterSkillSuccess, self.onSkillRelease, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.CharacterHpDamageFlyEffectPlayFinish, self.mainCharacterHpChangeFlyFinish, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.TeamChessSelectEffectBegin, self.initTeamChessSkill, self)
	self.addEventCb(self, EliminateLevelController.instance, EliminateChessEvent.TeamChessSelectEffectEnd, self.onTeamChessSkillRelease, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.TeamChessOnFlowStart, self.teamChessOnFlowStart, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.TeamChessOnFlowEnd, self.teamChessOnFlowEnd, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.EnemyForecastChessIdUpdate, self.updateEnemyForecastChess, self)
	self.addEventCb(self, EliminateChessController.instance, EliminateChessEvent.PerformBegin, self.eliminateOnPerformBegin, self)
	self.addEventCb(self, EliminateChessController.instance, EliminateChessEvent.PerformEnd, self.eliminateOnPerformEnd, self)
	self.addEventCb(self, EliminateChessController.instance, EliminateChessEvent.Match3ChessBeginViewClose, self.match3ChessBeginViewClose, self)
	EliminateLevelController.instance:changeRoundType(EliminateEnum.RoundType.TeamChess)
	self:hideEnemyInfoView()
	self:initInfo()
	self:initTask()
	self:refreshInfo()
	self:loadAndSetMaskSprite()
end

function EliminateLevelView:onClose()
	return
end

function EliminateLevelView:updateInfo()
	return
end

local ZProj_UIEffectsCollection = ZProj.UIEffectsCollection

function EliminateLevelView:initTask()
	self._isShowTaskPanel = false

	gohelper.setActive(self._goTaskPanel, self._isShowTaskPanel)
	gohelper.setActive(self._btnTaskcancel, self._isShowTaskPanel)

	local config = EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig()

	self._taskItem = self:getUserDataTb_()

	local chessWar = EliminateTeamChessModel.instance:getCurTeamChessWar()

	if not string.nilorempty(config.winCondition) then
		local item = gohelper.clone(self._goItem, self._imageTaskBG.gameObject, "taskItem")
		local itemEffectCollection = ZProj_UIEffectsCollection.Get(item)
		local txtTaskTarget = gohelper.findChildText(item, "#txt_TaskTarget")

		txtTaskTarget.text = EliminateLevelModel.instance.formatString(config.winConditionDesc)

		itemEffectCollection:SetGray(not chessWar:winConditionIsFinish())
		gohelper.setActive(item, true)

		self._taskItem[1] = itemEffectCollection
	end

	if not string.nilorempty(config.extraWinCondition) then
		local item = gohelper.clone(self._goItem, self._imageTaskBG.gameObject, "taskItem")
		local itemEffectCollection = ZProj_UIEffectsCollection.Get(item)
		local txtTaskTarget = gohelper.findChildText(item, "#txt_TaskTarget")

		txtTaskTarget.text = EliminateLevelModel.instance.formatString(config.extraWinConditionDesc)

		itemEffectCollection:SetGray(not chessWar:extraWinConditionIsFinish())
		gohelper.setActive(item, true)

		self._taskItem[2] = itemEffectCollection
	end
end

function EliminateLevelView:initInfo()
	local myInfo = EliminateTeamChessModel.instance:getCurTeamMyInfo()

	if myInfo then
		local characterConfig = EliminateConfig.instance:getTeamChessCharacterConfig(myInfo.id)

		if characterConfig.resPic then
			self._simageRole:LoadImage(ResUrl.getHeadIconSmall(characterConfig.resPic))
		end

		local skillData = EliminateConfig.instance:getMainCharacterSkillConfig(characterConfig.activeSkillIds)

		if skillData then
			if not skillData.icon then
				local icon = ""

				if not string.nilorempty(icon) then
					UISpriteSetMgr.instance:setV2a2EliminateSprite(self._imageRoleSkill, icon, false)
				end
			end
		end
	end

	local enemyInfo = EliminateTeamChessModel.instance:getCurTeamEnemyInfo()

	if enemyInfo then
		local enemyConfig = EliminateConfig.instance:getTeamChessEnemyConfig(enemyInfo.id)

		if enemyConfig.headImg then
			self._simageEnemy:LoadImage(ResUrl.getHeadIconSmall(enemyConfig.headImg))
		end
	end
end

function EliminateLevelView:refreshInfo()
	self:refreshHpInfo()
	self:refreshSkillPowerInfo()
	self:updateEnemyForecastChess()
	gohelper.setActive(self._goRoleSkill, EliminateLevelModel.instance:mainCharacterSkillIsUnLock())
end

function EliminateLevelView:refreshHpInfo(teamType, gear)
	local myInfo = EliminateTeamChessModel.instance:getCurTeamMyInfo()

	if myInfo then
		local characterConfig = EliminateConfig.instance:getTeamChessCharacterConfig(myInfo.id)

		self._txtRoleHP.text = myInfo.hp

		tweenHelper.DOFillAmount(self._imageRoleHPFG, myInfo.hp / characterConfig.hp, EliminateTeamChessEnum.hpChangeTime, nil, nil, nil, EaseType.OutQuart)
		tweenHelper.DOFillAmount(self._imageRolehpfgeff1, myInfo.hp / characterConfig.hp, EliminateTeamChessEnum.hpChangeTime, nil, nil, nil, EaseType.OutQuart)
		self._roleGoUIEffect:SetGray(myInfo.hp <= 0)
		self:setImageGray(self._imageRole, myInfo.hp <= 0)
	end

	local enemyInfo = EliminateTeamChessModel.instance:getCurTeamEnemyInfo()

	if enemyInfo then
		local enemyConfig = EliminateConfig.instance:getTeamChessEnemyConfig(enemyInfo.id)

		self._txtEnemyHP.text = enemyInfo.hp

		if enemyConfig then
			if not enemyConfig.hp then
				local hp = 1

				tweenHelper.DOFillAmount(self._imageEnemyHPFG, enemyInfo.hp / hp, EliminateTeamChessEnum.hpChangeTime, nil, nil, nil, EaseType.OutQuart)
				tweenHelper.DOFillAmount(self._imageEnemyhpfgeff2, enemyInfo.hp / hp, EliminateTeamChessEnum.hpChangeTime, nil, nil, nil, EaseType.OutQuart)
				self._enemyGoUIEffect:SetGray(enemyInfo.hp <= 0)
				self:setImageGray(self._imageEnemy, enemyInfo.hp <= 0)
			end
		end
	end

	if teamType ~= nil then
		gohelper.setActive(self._goenemyvxbreak, false)
		gohelper.setActive(self._goEnemyvxdamage, false)
		gohelper.setActive(self._goRolevxbreak, false)
		gohelper.setActive(self._goRolevxdamage, false)

		if teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
			local haveHp = myInfo.hp > 0

			gohelper.setActive(self._goRolevxdamage, true)
			gohelper.setActive(self._goRolevxbreak, not haveHp)
		end

		if teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
			local haveHp = enemyInfo.hp > 0

			gohelper.setActive(self._goEnemyvxdamage, true)
			gohelper.setActive(self._goenemyvxbreak, not haveHp)
		end

		if enemyInfo.hp <= 0 or myInfo.hp <= 0 then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_zhuzhanzhe_death)
		else
			gear = gear or 1

			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess["play_ui_youyu_attack_" .. gear])
		end
	end
end

function EliminateLevelView:refreshSkillPowerInfo()
	local myInfo = EliminateTeamChessModel.instance:getCurTeamMyInfo()

	if myInfo then
		local characterConfig = EliminateConfig.instance:getTeamChessCharacterConfig(myInfo.id)
		local skillConfig = EliminateConfig.instance:getMainCharacterSkillConfig(characterConfig.activeSkillIds)
		local skillCostPower = skillConfig.cost

		self._txtRoleCostNum.text = skillCostPower <= myInfo.power and GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("eliminate_skill_power_content1"), myInfo.power, skillCostPower) or GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("eliminate_skill_power_content2"), myInfo.power, skillCostPower)

		tweenHelper.DOFillAmount(self._imageRoleSkillFG, myInfo.power / skillCostPower, EliminateTeamChessEnum.powerChangeTime, nil, nil, nil, EaseType.OutQuart)
		tweenHelper.DOFillAmount(self._imageRoleSkillfgeff1, myInfo.power / skillCostPower, EliminateTeamChessEnum.powerChangeTime, nil, nil, nil, EaseType.OutQuart)
		self:updateRoleSkillGray(true)
	end
end

function EliminateLevelView:updateTaskInfo()
	local chessWar = EliminateTeamChessModel.instance:getCurTeamChessWar()

	if self._taskItem[1] then
		local itemEffectCollection = self._taskItem[1]

		itemEffectCollection:SetGray(not chessWar:winConditionIsFinish())
	end

	if self._taskItem[2] then
		local itemEffectCollection = self._taskItem[2]

		itemEffectCollection:SetGray(not chessWar:extraWinConditionIsFinish())
	end

	self:match3ChessBeginViewClose(true)
end

function EliminateLevelView:mainCharacterHpChange(teamType, diffValue)
	if diffValue < 0 and math.abs(diffValue) > 0 then
		local x1, y1, _ = transformhelper.getPos(self._simageRole.transform)
		local x2, y2, _ = transformhelper.getPos(self._simageEnemy.transform)

		if teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
			EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.PlayCharacterDamageFlyEffect, teamType, diffValue, x2, y2, x1, y1)
		end

		if teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
			EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.PlayCharacterDamageFlyEffect, teamType, diffValue, x1, y1, x2, y2)
		end
	else
		self:refreshHpInfo()
	end
end

function EliminateLevelView:mainCharacterHpChangeFlyFinish(teamType, diffValue, gear)
	if teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		local x, y, _ = transformhelper.getPos(self._gorolePointDamage.transform)

		EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.PlayDamageEffect, diffValue, x, y, EliminateTeamChessEnum.HpDamageType.Character)
	end

	if teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		local x, y, _ = transformhelper.getPos(self._goenemyPointDamage.transform)

		EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.PlayDamageEffect, diffValue, x, y, EliminateTeamChessEnum.HpDamageType.Character)
	end

	gohelper.setActive(self._effectToEnemy, teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy)
	gohelper.setActive(self._effectToPlayer, teamType == EliminateTeamChessEnum.TeamChessTeamType.player)
	gohelper.setActive(self._effectAck, false)
	gohelper.setActive(self._effectAck, true)
	self:refreshHpInfo(teamType, gear)
end

function EliminateLevelView:updateEnemyForecastChess()
	gohelper.setActive(self._goEnemySkill, false)

	local forecastChess = EliminateTeamChessModel.instance:getEnemyForecastChess()

	if forecastChess then
		local forecastData = forecastChess[1]
		local config = EliminateConfig.instance:getSoldierChessConfig(forecastData.chessId)
		local round = forecastData.round
		local curRound = EliminateLevelModel.instance:getRoundNumber()

		if config then
			if not config.resPic then
				local icon = ""

				if not string.nilorempty(icon) then
					SurvivalUnitIconHelper.instance:setNpcIcon(self._imageEnemySkill, icon)
					gohelper.setActive(self._goEnemySkill, true)
				end

				local residueRound = round - curRound

				self._txtEnemyCostNum.text = residueRound

				local fillAmount = 1

				if residueRound > 0 then
					fillAmount = 1 / (residueRound + 1)
				else
					AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_skill_release)
				end

				tweenHelper.DOFillAmount(self._imageenemySkillFG, fillAmount, EliminateTeamChessEnum.teamChessForecastUpdateStep, nil, nil, nil, EaseType.OutQuart)
				tweenHelper.DOFillAmount(self._imageEnemyskillfgeff2, fillAmount, EliminateTeamChessEnum.teamChessForecastUpdateStep, self.hpChangeEnd, self, nil, EaseType.OutQuart)
				gohelper.setActive(self._goEnemySkillFull, residueRound == 0)
			end
		end
	end
end

function EliminateLevelView:hpChangeEnd()
	gohelper.setActive(self._effectAck, false)
end

function EliminateLevelView:mainCharacterPowerChange(teamType, diffValue)
	self:refreshSkillPowerInfo()
end

function EliminateLevelView:updateViewState(isSwitch)
	if self.showWatchView then
		self:setTeamChessViewWatchState()
	end

	local roundType = EliminateLevelModel.instance:getCurRoundType()

	self._isTeamChess = roundType == EliminateEnum.RoundType.TeamChess
	self._isMatch3Chess = roundType == EliminateEnum.RoundType.Match3Chess
	self._isSwitch = isSwitch

	if isSwitch then
		if self._isTeamChess and self._eliminateChessViewAni then
			self._eliminateChessViewAni:Play("close")
		end

		if self._isMatch3Chess and self._teamChessViewAni then
			self._teamChessViewAni:Play("close")
		end

		self._ani:Play("fightin")
		TaskDispatcher.runDelay(self.refreshViewActive, self, 0.67)
	else
		self:refreshViewActive()
	end

	local config = EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig()
	local isSpecialLevel = config and config.chessScene == "scenes/v2a2_m_s12_xdwf/scenes_prefab/v2a2_m_s12_xdwf_jd_p.prefab"

	self._teamchessMaskCanvasGroup2.alpha = self._isTeamChess and isSpecialLevel and 1 or 0
	self._eliminatechessMaskCanvasGroup2.alpha = self._isMatch3Chess and isSpecialLevel and 1 or 0
	self._eliminatechessMaskCanvasGroup.alpha = self._isMatch3Chess and 1 or 0
	self._teamchessMaskCanvasGroup.alpha = self._isTeamChess and 1 or 0

	self._goEnemySkill.transform:SetParent((self._isMatch3Chess or nil) and (self._goEnemySkillPoint1.transform or self._goEnemySkillPoint2.transform))
	self._goRoleSkill.transform:SetParent((self._isMatch3Chess or nil) and (self._goRoleSkillPoint1.transform or self._goRoleSkillPoint2.transform))
	transformhelper.setLocalPos(self._goEnemySkill.transform, 0, 0, 0)
	transformhelper.setLocalPos(self._goRoleSkill.transform, 0, 0, 0)
	gohelper.setActive(self._imageEnemyBG2.gameObject, self._isTeamChess)
	gohelper.setActive(self._imageRoleBG2.gameObject, self._isTeamChess)
	gohelper.setActive(self._imageEnemyBG.gameObject, self._isMatch3Chess)
	gohelper.setActive(self._imageRoleBG.gameObject, self._isMatch3Chess)

	self._txtTurns.text = EliminateLevelModel.instance:getRoundNumber()
	self._txtPointView.text = luaLang("eliminate_watch_teamchess")

	self:refreshInfo()
	self:onSkillReleaseCancel(true)

	self._canUseSkill = self._isMatch3Chess
end

function EliminateLevelView:refreshViewActive()
	self:setTeamChessViewActive(self._isTeamChess)
	self:setEliminateViewActive(self._isMatch3Chess)

	if self._isSwitch then
		self._ani:Play("fightout")
	end

	TaskDispatcher.runDelay(self.refreshLightAni, self, 0.33)

	self._isShowTaskPanel = self._isTeamChess

	self:setTaskViewActive()
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.EliminateRoundStateChangeEnd)
	self:updateRoleSkillGray(false)
end

function EliminateLevelView:refreshLightAni()
	if self._isTeamChess and self._eliminateLightAni then
		self._eliminateLightAni:Play("open")
	end

	if self._isMatch3Chess and self._pointLightAni then
		self._pointLightAni:Play("open")
	end
end

function EliminateLevelView:setTeamChessViewActive(isTeamChess)
	gohelper.setActive(self._goteamchess, isTeamChess)
	gohelper.setActiveCanvasGroup(self._goEliminateLight, isTeamChess)
	gohelper.setActiveCanvasGroup(self._goPoint, isTeamChess)
end

function EliminateLevelView:setEliminateViewActive(isMatch3Chess)
	gohelper.setActive(self._goeliminatechess, isMatch3Chess)
	gohelper.setActiveCanvasGroup(self._goEliminate, isMatch3Chess)
	gohelper.setActiveCanvasGroup(self._goPointLight, isMatch3Chess)
	gohelper.setActive(self._btnPointViewBtn, isMatch3Chess)
end

function EliminateLevelView:setTeamChessViewWatchState()
	self.showWatchView = not self.showWatchView

	gohelper.setActive(self._goRoleSkill, not self.showWatchView)
	self:updateTeamChessViewWatchState(self.showWatchView)
	EliminateLevelModel.instance:setIsWatchTeamChess(self.showWatchView)
	self:updateRoleSkillGray(false)
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessViewWatchView, self.showWatchView)
end

function EliminateLevelView:updateTeamChessViewWatchState(state)
	gohelper.setActive(self._goteamchess, state)
	gohelper.setActive(self._goeliminatechess, not state)

	self._txtPointView.text = state and luaLang("eliminate_return_match3") or luaLang("eliminate_watch_teamchess")
end

function EliminateLevelView:showSkillView()
	local myInfo = EliminateTeamChessModel.instance:getCurTeamMyInfo()

	if myInfo == nil then
		return
	end

	local characterConfig = EliminateConfig.instance:getTeamChessCharacterConfig(myInfo.id)
	local param = {
		point = self._goRolePoint,
		showType = EliminateLevelEnum.skillShowType.skill,
		skillId = characterConfig.activeSkillIds
	}

	ViewMgr.instance:openView(ViewName.EliminateCharacterSkillTipView, param)
end

function EliminateLevelView:showEnemySkillView()
	local forecastChess = EliminateTeamChessModel.instance:getEnemyForecastChess()

	if forecastChess == nil then
		return
	end

	local param = {
		forecastChess = forecastChess,
		point = self._goEnemyPoint,
		showType = EliminateLevelEnum.skillShowType.forecast
	}

	ViewMgr.instance:openView(ViewName.EliminateCharacterSkillTipView, param)
end

function EliminateLevelView:_pointViewListClick()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)
	self:setTeamChessViewWatchState()
end

function EliminateLevelView:match3ChessBeginViewClose(needShow)
	local roundType = EliminateLevelModel.instance:getCurRoundType()
	local round = EliminateLevelModel.instance:getRoundNumber()
	local delayTime = EliminateEnum.levelTargetTipShowTime

	if roundType == EliminateEnum.RoundType.TeamChess then
		delayTime = EliminateEnum.levelTargetTipShowTimeInTeamChess
		needShow = true
	elseif round == 1 then
		delayTime = EliminateEnum.levelTargetTipShowTime
		needShow = true
	else
		delayTime = EliminateEnum.levelTargetTipShowTimeInTeamChess
	end

	if needShow ~= nil and needShow then
		self:changeShowTaskPanelState()
		TaskDispatcher.runDelay(self.changeShowTaskPanelState, self, delayTime)
	end
end

function EliminateLevelView:initCharacterSkill()
	if self._skillReleaseView == nil then
		self._skillReleaseView = MonoHelper.addNoUpdateLuaComOnceToGo(self._goSkillRelease, EliminateMainCharacterSkill)

		self._skillReleaseView:setCanvas(EliminateTeamChessModel.instance:getViewCanvas())
	end

	local wight, height = EliminateChessItemController.instance:getMaxWidthAndHeight()

	self._skillReleaseView:setTargetTrAndHoleSize(self._goeliminatechess.transform, wight, height, -30, 15)
	self._skillReleaseView:setCanvas(EliminateTeamChessModel.instance:getViewCanvas())
	self._skillReleaseView:setClickCb(self.onSkillReleaseCancel, self)
end

function EliminateLevelView:onSkillRelease()
	local curRound = EliminateLevelModel.instance:getCurRoundType()
	local selectSkillData = EliminateLevelController.instance:getCurSelectSkill()
	local effectRound = selectSkillData:getEffectRound()

	if curRound == effectRound and curRound == EliminateEnum.RoundType.Match3Chess then
		EliminateTeamChessModel.instance:updateMainCharacterPower(EliminateTeamChessEnum.TeamChessTeamType.player, -selectSkillData:getCost())
	end

	if isTypeOf(selectSkillData, CharacterSkillAddDiamondMO) then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_skill_release)
	end

	EliminateLevelController.instance:cancelSkillRelease()
	self:hideSkillRelease()
	self:refreshSkillPowerInfo()
end

function EliminateLevelView:onSkillReleaseCancel(dispatch)
	EliminateLevelController.instance:cancelSkillRelease()
	self:hideSkillRelease()

	if dispatch == nil then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.WarChessCharacterSkillCancel, true)
	end
end

function EliminateLevelView:skillRelease()
	local myInfo = EliminateTeamChessModel.instance:getCurTeamMyInfo()

	if myInfo == nil then
		return
	end

	local characterConfig = EliminateConfig.instance:getTeamChessCharacterConfig(myInfo.id)
	local skillConfig = EliminateConfig.instance:getMainCharacterSkillConfig(characterConfig.activeSkillIds)

	if skillConfig == nil then
		return
	end

	local skillMo = EliminateLevelController.instance:setCurSelectSkill(skillConfig.id, skillConfig.effect)

	if skillMo:getEffectRound() == EliminateEnum.RoundType.TeamChess then
		local roundStepState = EliminateTeamChessModel.instance:getCurTeamRoundStepState()

		if roundStepState == EliminateTeamChessEnum.TeamChessRoundType.settlement then
			return
		end
	elseif not self._canUseSkill then
		return
	end

	if not EliminateLevelController.instance:canReleaseByRound() then
		EliminateLevelController.instance:cancelSkillRelease()

		return
	end

	if EliminateLevelController.instance:canRelease() then
		gohelper.setActive(self._goRoleSkillClickEffect, true)
		TaskDispatcher.runDelay(self.hideRoleSkillClickEffect, self, 2)
		EliminateLevelController.instance:releaseSkill()

		return
	end

	gohelper.setActive(self._goSkillRelease, true)
	self:initCharacterSkill()
	self._skillReleaseView:refreshSkillData()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_skill_release)
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.WarChessCharacterSkillViewOpen)
end

function EliminateLevelView:hideSkillRelease()
	gohelper.setActive(self._goSkillRelease, false)
end

function EliminateLevelView:initTeamChessSkill(wight, height)
	if self._skillReleaseView == nil then
		self._skillReleaseView = MonoHelper.addNoUpdateLuaComOnceToGo(self._goSkillRelease, EliminateMainCharacterSkill)

		self._skillReleaseView:setCanvas(EliminateTeamChessModel.instance:getViewCanvas())
	end

	self._skillReleaseView:setTargetTrAndHoleSize(self._goteamchess.transform, wight + 200, height, 20)
	self._skillReleaseView:setClickCb(self.onTeamChessSkillReleaseCancel, self)
	self._skillReleaseView:refreshTeamChessSkillData()
	gohelper.setActive(self._goSkillRelease, true)
	EliminateTeamChessModel.instance:setTeamChessSkillState(true)
end

function EliminateLevelView:onTeamChessSkillRelease()
	self:hideSkillRelease()
	EliminateTeamChessModel.instance:setTeamChessSkillState(false)
end

function EliminateLevelView:onTeamChessSkillReleaseCancel()
	self:hideSkillRelease()
	EliminateTeamChessModel.instance:setTeamChessSkillState(false)
	EliminateTeamChessController.instance:clearReleasePlaceSkill()
end

function EliminateLevelView:teamChessOnFlowEnd()
	EliminateLevelController.instance:checkMainSkill()
	EliminateLevelController.instance:checkPlayerSoliderCount()
end

function EliminateLevelView:eliminateOnPerformBegin()
	self._canUseSkill = false
end

function EliminateLevelView:eliminateOnPerformEnd()
	self:refreshSkillPowerInfo()

	self._canUseSkill = true
end

function EliminateLevelView:teamChessOnFlowStart()
	self:updateRoleSkillGray(false)
end

function EliminateLevelView:updateRoleSkillGray(playerAudio)
	if not EliminateLevelModel.instance:mainCharacterSkillIsUnLock() then
		return
	end

	local myInfo = EliminateTeamChessModel.instance:getCurTeamMyInfo()
	local isGray = false
	local skillMo

	if myInfo then
		local characterConfig = EliminateConfig.instance:getTeamChessCharacterConfig(myInfo.id)
		local skillConfig = EliminateConfig.instance:getMainCharacterSkillConfig(characterConfig.activeSkillIds)

		skillMo = EliminateLevelController.instance:getTempSkillMo(skillConfig.id, skillConfig.effect)
		isGray = not EliminateLevelController.instance:canReleaseByRound(skillMo) or self.showWatchView

		local roundType = EliminateLevelModel.instance:getCurRoundType()

		if skillMo:getEffectRound() == EliminateEnum.RoundType.TeamChess and roundType == EliminateEnum.RoundType.TeamChess then
			local roundStepState = EliminateTeamChessModel.instance:getCurTeamRoundStepState()
			local isSettle = roundStepState == EliminateTeamChessEnum.TeamChessRoundType.settlement

			isGray = isGray or isSettle
		end

		local fullIsActive = not isGray and myInfo.power >= skillConfig.cost

		if fullIsActive and playerAudio and not gohelper.isNil(self._goRoleSkillFull) and not self._goRoleSkillFull.activeInHierarchy then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_skill_release)
		end

		gohelper.setActive(self._goRoleSkillFull, fullIsActive)
		self._roleSkillUIEffect:SetGray(isGray)
		self:setImageGray(self._imageRoleSkill, isGray)
	end
end

function EliminateLevelView:setImageGray(image, isGray)
	if self.grayMat == nil then
		local grayPath = self.viewContainer:getSetting().otherRes[9]

		self.grayMat = self.viewContainer._abLoader:getAssetItem(grayPath):GetResource()
	end

	if self.normalMat == nil then
		local normalPath = self.viewContainer:getSetting().otherRes[10]

		self.normalMat = self.viewContainer._abLoader:getAssetItem(normalPath):GetResource()
	end

	image.material = isGray and self.grayMat or self.normalMat
end

function EliminateLevelView:loadAndSetMaskSprite()
	local maskHot = self._gorectMask:GetComponent(typeof(ZProj.RectMaskHole))
	local maskSpritePath = self.viewContainer:getSetting().otherRes[11]
	local texture = self.viewContainer._abLoader:getAssetItem(maskSpritePath):GetResource()

	if not gohelper.isNil(texture) and not gohelper.isNil(maskHot) then
		maskHot.sprite = UnityEngine.Sprite.Create(texture, UnityEngine.Rect.New(0, 0, texture.width, texture.height), Vector2.zero)
	end
end

function EliminateLevelView:hideEnemyInfoView()
	return
end

function EliminateLevelView:onDestroyView()
	if self.roleSkillLongPress then
		self.roleSkillLongPress:RemoveClickListener()
		self.roleSkillLongPress:RemoveLongPressListener()

		self.roleSkillLongPress = nil
	end

	if self.enemyInfoMaskClick then
		self.enemyInfoMaskClick:RemoveClickListener()

		self.enemyInfoMaskClick = nil
	end

	if self.pointViewListClick then
		self.pointViewListClick:RemoveClickListener()

		self.pointViewListClick = nil
	end

	if self.roleClick then
		self.roleClick:RemoveClickListener()

		self.roleClick = nil
	end

	if self.enemySkillClick then
		self.enemySkillClick:RemoveLongPressListener()

		self.enemySkillClick = nil
	end

	if self._skillDetailsView then
		self._skillDetailsView:onDestroy()

		self._skillDetailsView = nil
	end

	if self._skillReleaseView then
		self._skillReleaseView:onDestroy()

		self._skillReleaseView = nil
	end

	TaskDispatcher.cancelTask(self.setTaskViewActive, self)
	TaskDispatcher.cancelTask(self.changeShowTaskPanelState, self)
	TaskDispatcher.cancelTask(self.hideRoleSkillClickEffect, self)
	TaskDispatcher.cancelTask(self.refreshLightAni, self)
	TaskDispatcher.cancelTask(self.refreshViewActive, self)

	self._ani = nil
	self._taskAni = nil
	self._teamChessViewAni = nil
	self._eliminateChessViewAni = nil
	self._eliminateLightAni = nil
	self._pointLightAni = nil
	self.grayMat = nil
	self.normalMat = nil
end

function EliminateLevelView:setOverrideClose()
	return
end

return EliminateLevelView
