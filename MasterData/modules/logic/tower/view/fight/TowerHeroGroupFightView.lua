-- chunkname: @modules/logic/tower/view/fight/TowerHeroGroupFightView.lua

module("modules.logic.tower.view.fight.TowerHeroGroupFightView", package.seeall)

local TowerHeroGroupFightView = class("TowerHeroGroupFightView", HeroGroupFightView)
local MaxMultiplication = 4

function TowerHeroGroupFightView:_editableInitView()
	MaxMultiplication = CommonConfig.instance:getConstNum(ConstEnum.MaxMultiplication) or MaxMultiplication
	self._multiplication = 1
	self._goherogroupcontain = gohelper.findChild(self.viewGO, "herogroupcontain")
	self._goBtnContain = gohelper.findChild(self.viewGO, "#go_container/btnContain")
	self._btnContainAnim = self._goBtnContain:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gomask, false)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullView, self._onOpenFullView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onModifyHeroGroup, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupName, self._initFightGroupDrop, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onModifySnapshot, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, self._onClickHeroGroupItem, self)
	self.addEventCb(self, FightController.instance, FightEvent.RespBeginFight, self._respBeginFight, self)
	self.addEventCb(self, HelpController.instance, HelpEvent.RefreshHelp, self.isShowHelpBtnIcon, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroup, self._onUseRecommendGroup, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, self._showGuideDragEffect, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnUpdateRecommendLevel, self._refreshTips, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.HeroMoveForward, self._heroMoveForward, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, self.refreshDropTips, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.onDailyRereshCheck, self)

	if BossRushController.instance:isInBossRushFight() then
		gohelper.addUIClickAudio(self._btnstart.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
		gohelper.addUIClickAudio(self._btnstarthard.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
		gohelper.addUIClickAudio(self._btnstartreplay.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
	else
		gohelper.addUIClickAudio(self._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
		gohelper.addUIClickAudio(self._btnstarthard.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
		gohelper.addUIClickAudio(self._btnstartreplay.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	end

	gohelper.addUIClickAudio(self._btnReplay.gameObject, AudioEnum.UI.Play_UI_Player_Interface_Close)

	self._iconGO = self:getResInst(self.viewContainer:getSetting().otherRes[1], self._btncloth.gameObject)

	recthelper.setAnchor(self._iconGO.transform, -100, 1)

	self._tweeningId = 0
	self._replayMode = false
	self._multSpeedItems = {}

	local parent = self._gomultContent.transform

	for i = 1, MaxMultiplication do
		local item = parent:GetChild(i - 1)

		self:_setMultSpeedItem(item.gameObject, MaxMultiplication - i + 1)
	end

	gohelper.setActive(self._gomultispeed, false)
end

function TowerHeroGroupFightView:_enterFight()
	if HeroGroupModel.instance.episodeId then
		self._closeWithEnteringFight = true

		local result = FightController.instance:setFightHeroSingleGroup()

		if result then
			self.viewContainer:dispatchEvent(HeroGroupEvent.BeforeEnterFight)

			local param = {}
			local fightParam = FightModel.instance:getFightParam()

			param.fightParam = fightParam
			param.chapterId = fightParam.chapterId
			param.episodeId = fightParam.episodeId
			param.useRecord = self._replayMode

			if self._replayMode then
				fightParam.isReplay = true
				fightParam.multiplication = self._multiplication
			else
				fightParam.isReplay = false
				fightParam.multiplication = 1
			end

			param.multiplication = fightParam.multiplication

			TowerController.instance:startFight(param)
			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function TowerHeroGroupFightView:_initFightGroupDrop()
	local heroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	if heroGroupType then
		self._dropherogroup.dropDown.enabled = false

		return
	end

	local episodeId = HeroGroupModel.instance.episodeId
	local episdoeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local episodeType = episdoeConfig.type
	local list = {}

	if episodeType == DungeonEnum.EpisodeType.TowerBoss then
		table.insert(list, HeroGroupModel.instance:getCommonGroupName())
	else
		for i = 1, 4 do
			list[i] = HeroGroupModel.instance:getCommonGroupName(i)
		end
	end

	local selectIndex = HeroGroupModel.instance:getHeroGroupSelectIndex()

	self._dropherogroup:ClearOptions()
	self._dropherogroup:AddOptions(list)
	self._dropherogroup:SetValue(selectIndex - 1)
	gohelper.setActive(self._btnmodifyname, false)
end

function TowerHeroGroupFightView:_onClickHeroGroupItem(id)
	local param = TowerModel.instance:getRecordFightParam()

	if param.isHeroGroupLock then
		GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)

		return
	end

	TowerHeroGroupFightView.super._onClickHeroGroupItem(self, id)
end

function TowerHeroGroupFightView:_groupDropValueChanged(value)
	TowerHeroGroupFightView.super._groupDropValueChanged(self, value)
	gohelper.setActive(self._btnmodifyname, false)
end

function TowerHeroGroupFightView:isShowDropHeroGroup()
	return true
end

function TowerHeroGroupFightView:onDailyRereshCheck()
	local param = TowerModel.instance:getRecordFightParam()
	local towerType = param.towerType

	if towerType == TowerEnum.TowerType.Limited then
		local curOpenMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

		if not curOpenMo then
			MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, TowerHeroGroupFightView.yesCallback)
		end
	end
end

function TowerHeroGroupFightView.yesCallback()
	ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)
	NavigateButtonsView.homeClick()
end

return TowerHeroGroupFightView
