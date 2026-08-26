-- chunkname: @modules/logic/abyss/view/AbyssHeroGroupFightView.lua

module("modules.logic.abyss.view.AbyssHeroGroupFightView", package.seeall)

local AbyssHeroGroupFightView = class("AbyssHeroGroupFightView", HeroGroupFightView)
local MaxMultiplication = 4

function AbyssHeroGroupFightView:_editableInitView()
	self._txtclothname = gohelper.findChildTextMesh(self.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName")
	self._txtclothnameen = gohelper.findChildTextMesh(self.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName/#txt_clothNameEn")
	MaxMultiplication = CommonConfig.instance:getConstNum(ConstEnum.MaxMultiplication) or MaxMultiplication
	self._multiplication = 1
	self._goherogroupcontain = gohelper.findChild(self.viewGO, "herogroupcontain")
	self._imagebufficon = gohelper.findChildImage(self.viewGO, "herogroupcontain/hero/bg5/#img_icon")
	self._goAddBuff = gohelper.findChild(self.viewGO, "herogroupcontain/hero/bg5/#go_jiahao")
	self._btnbuff = gohelper.findChildButton(self.viewGO, "herogroupcontain/hero/bg5/#btn_click")
	self._goBtnContain = gohelper.findChild(self.viewGO, "#go_container/btnContain")
	self._btnContainAnim = self._goBtnContain:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gomask, false)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullView, self._onOpenFullView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onModifyHeroGroup, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnUpdateStageInfo, self.refreshBuff, self)
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
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.onDailyRefreshCheck, self)

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
	gohelper.setActive(self._dropherogroup, false)
	gohelper.setActive(self._btnmodifyname, false)
end

function AbyssHeroGroupFightView:addEvents()
	AbyssHeroGroupFightView.super.addEvents(self)

	if self._btnbuff then
		self._btnbuff:AddClickListener(self._btnbuffOnClick, self)
	end
end

function AbyssHeroGroupFightView:removeEvents()
	AbyssHeroGroupFightView.super.removeEvents(self)

	if self._btnbuff then
		self._btnbuff:RemoveClickListener()
	end
end

function AbyssHeroGroupFightView:onOpen()
	AbyssHeroGroupFightView.super.onOpen(self)
	self:refreshBuff()
end

function AbyssHeroGroupFightView:_refreshBtns(isCostPower)
	AbyssHeroGroupFightView.super.onClose(self)
end

function AbyssHeroGroupFightView:_enterFight()
	if HeroGroupModel.instance.episodeId then
		local stageInfo = AbyssModel.instance:getCurStageMo()

		if stageInfo.skillId == nil or stageInfo.skillId == 0 then
			GameFacade.showToast(ToastEnum.V3a9_Abyss_Skill_Tips)

			return
		end

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
			param.activityId = AbyssModel.instance:getCurActId()
			param.stageId = AbyssModel.instance:getCurStageId()

			AbyssController.instance:enterFight(param)
			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function AbyssHeroGroupFightView:_onClickHeroGroupItem(id)
	local infoMo = AbyssModel.instance:getCurStageMo()

	if infoMo:isChallenged() then
		GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)

		return
	end

	AbyssHeroGroupFightView.super._onClickHeroGroupItem(self, id)
end

function AbyssHeroGroupFightView:_onModifyHeroGroup()
	AbyssHeroGroupFightView.super._onModifyHeroGroup(self)
	gohelper.setActive(self._dropherogroup, false)
end

function AbyssHeroGroupFightView:isShowDropHeroGroup()
	return false
end

function AbyssHeroGroupFightView:_initFightGroupDrop()
	gohelper.setActive(self._dropherogroup, false)
end

function AbyssHeroGroupFightView:_checkDropArrow()
	gohelper.setActive(self._dropherogroup, false)
end

function AbyssHeroGroupFightView:refreshBuff()
	if not self._imagebufficon then
		return
	end

	local stageMo = AbyssModel.instance:getCurStageMo()

	if not stageMo then
		gohelper.setActive(self._imagebufficon.gameObject, false)
		gohelper.setActive(self._goAddBuff.gameObject, true)

		return
	end

	if not stageMo.skillId then
		local skillId = 0
		local isEmpty = not skillId or skillId == 0

		gohelper.setActive(self._goAddBuff.gameObject, isEmpty)
		gohelper.setActive(self._imagebufficon.gameObject, not isEmpty)

		if isEmpty then
			return
		end

		local skillConfig = AbyssConfig.instance:getSkillConfig(skillId)

		if skillConfig and not string.nilorempty(skillConfig.icon) then
			UISpriteSetMgr.instance:setAbyssSprite(self._imagebufficon, "jdsh_" .. skillConfig.icon)
		end
	end
end

function AbyssHeroGroupFightView:_btnbuffOnClick()
	local stageId = AbyssModel.instance:getCurStageId()
	local actId = AbyssModel.instance:getCurActId()
	local stageInfo = AbyssModel.instance:getStageInfoMo(actId, stageId)

	if not stageInfo then
		return
	end

	AbyssController.instance:openBuffSelectView(stageId)
end

function AbyssHeroGroupFightView:_groupDropValueChanged(value)
	local heroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	if heroGroupType ~= HeroGroupPresetEnum.HeroGroupType.Abyss then
		return
	end

	local stageId = AbyssModel.instance:getCurStageId()

	if not stageId then
		return
	end

	AbyssHeroGroupFightView.super._groupDropValueChanged(self, value)
	gohelper.setActive(self._btnmodifyname, false)
end

function AbyssHeroGroupFightView:isShowDropHeroGroup()
	local curStageMo = AbyssModel.instance:getCurStageMo()

	return not curStageMo:isChallenged()
end

function AbyssHeroGroupFightView:onDailyRefreshCheck()
	local param = TowerModel.instance:getRecordFightParam()
	local towerType = param.towerType

	if towerType == TowerEnum.TowerType.Limited then
		local curOpenMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

		if not curOpenMo then
			MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, TowerHeroGroupFightView.yesCallback)
		end
	end
end

function AbyssHeroGroupFightView.yesCallback()
	ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)
	NavigateButtonsView.homeClick()
end

return AbyssHeroGroupFightView
