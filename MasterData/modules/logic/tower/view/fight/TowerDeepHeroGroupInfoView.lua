-- chunkname: @modules/logic/tower/view/fight/TowerDeepHeroGroupInfoView.lua

module("modules.logic.tower.view.fight.TowerDeepHeroGroupInfoView", package.seeall)

local TowerDeepHeroGroupInfoView = class("TowerDeepHeroGroupInfoView", BaseView)

function TowerDeepHeroGroupInfoView:onInitView()
	self._simagedeepBg = gohelper.findChildSingleImage(self.viewGO, "#simage_deepBg")
	self._imagedeepRare = gohelper.findChildImage(self.viewGO, "#go_container/#scroll_info/infocontain/#go_depth/#image_deepRare")
	self._txtdepth = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/#go_depth/#txt_depth")
	self._gopower = gohelper.findChild(self.viewGO, "#go_righttop/#go_power")
	self._goroundContent = gohelper.findChild(self.viewGO, "#go_righttop/go_restRound/#go_roundContent")
	self._goroundItem = gohelper.findChild(self.viewGO, "#go_righttop/go_restRound/#go_roundContent/#go_roundItem")
	self._btnsave = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#btn_save")
	self._btnload = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#btn_load")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerDeepHeroGroupInfoView:addEvents()
	self._btnsave:AddClickListener(self._btnSaveOnClick, self)
	self._btnload:AddClickListener(self._btnLoadOnClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnLoadTeamSuccess, self.refreshUI, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self.playDeepInfoAnim, self)
end

function TowerDeepHeroGroupInfoView:removeEvents()
	self._btnsave:RemoveClickListener()
	self._btnload:RemoveClickListener()
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnLoadTeamSuccess, self.refreshUI, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self.playDeepInfoAnim, self)
end

function TowerDeepHeroGroupInfoView:_btnSaveOnClick()
	local param = {}

	param.teamOperateType = TowerDeepEnum.TeamOperateType.Save

	TowerController.instance:openTowerDeepTeamSaveView(param)
end

function TowerDeepHeroGroupInfoView:_btnLoadOnClick()
	local param = {}

	param.teamOperateType = TowerDeepEnum.TeamOperateType.Load

	TowerController.instance:openTowerDeepTeamSaveView(param)
end

function TowerDeepHeroGroupInfoView:_editableInitView()
	self._goassistBoss = gohelper.findChild(self.viewGO, "herogroupcontain/assistBoss")
	self._goassistBossEmpty = gohelper.findChild(self.viewGO, "herogroupcontain/assistBossEmpty")
	self._animAssistBoss = self._goassistBoss:GetComponent(gohelper.Type_Animator)
	self._animAssistBossEmpty = self._goassistBossEmpty:GetComponent(gohelper.Type_Animation)
	self._goassistBossClick = gohelper.findChild(self.viewGO, "herogroupcontain/assistBoss/boss/click")
	self.teamRoundNum = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.HeroGroupTeamNum)
	self.roundItemMap = self:getUserDataTb_()

	gohelper.setActive(self._goroundItem, false)
	gohelper.setActive(self._goassistBossClick, false)

	self.isDropAssistBoss = false
end

function TowerDeepHeroGroupInfoView:onUpdateParam()
	return
end

function TowerDeepHeroGroupInfoView:onOpen()
	self:refreshUI()
	self:refreshBoss()
end

function TowerDeepHeroGroupInfoView:onOpenFinish()
	TaskDispatcher.runDelay(self.playDeepInfoAnim, self, 0.5)
end

function TowerDeepHeroGroupInfoView:refreshUI()
	gohelper.setActive(self._gopower, false)

	self.curDeepHigh = TowerPermanentDeepModel.instance:getCurDeepHigh()

	local deepRare = TowerPermanentDeepModel.instance:getDeepRare(self.curDeepHigh)

	self._simagedeepBg:LoadImage(ResUrl.getFightImage(string.format("tower/fight_tower_mask_%s.png", deepRare)))
	UISpriteSetMgr.instance:setFightTowerSprite(self._imagedeepRare, "fight_tower_numbg_" .. deepRare)

	self._txtdepth.text = string.format("%sm", self.curDeepHigh)
	self.isFightFailNotEnd = TowerPermanentDeepModel.instance:getIsFightFailNotEndState()

	self:createAndRefreshRound()
end

function TowerDeepHeroGroupInfoView:createAndRefreshRound()
	self.curTeamWaveNum = TowerPermanentDeepModel.instance:getCurDeepGroupWave()

	for index = 1, self.teamRoundNum do
		local roundItem = self.roundItemMap[index]

		if not roundItem then
			roundItem = {
				go = gohelper.clone(self._goroundItem, self._goroundContent, "roundItem" .. index)
			}
			roundItem.fail = gohelper.findChild(roundItem.go, "fail")
			roundItem.normal = gohelper.findChild(roundItem.go, "normal")
			roundItem.hideAnim = roundItem.normal:GetComponent(gohelper.Type_Animator)
			roundItem.current = gohelper.findChild(roundItem.go, "current")
			self.roundItemMap[index] = roundItem
		end

		gohelper.setActive(roundItem.go, true)
		gohelper.setActive(roundItem.fail, index < self.curTeamWaveNum)
		gohelper.setActive(roundItem.normal, self.isFightFailNotEnd and index >= self.curTeamWaveNum - 1 or index >= self.curTeamWaveNum)
		gohelper.setActive(roundItem.current, index == self.curTeamWaveNum)
		roundItem.hideAnim:Play("idle", 0, 0)
		roundItem.hideAnim:Update(0)
	end

	gohelper.setActive(self._btnsave.gameObject, self.curTeamWaveNum > 1)
end

function TowerDeepHeroGroupInfoView:refreshBoss()
	self.curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	self.bossId = self.curGroupMO:getAssistBossId()

	gohelper.setActive(self._goassistBoss, self.bossId > 0)
	gohelper.setActive(self._goassistBossEmpty, self.bossId == 0)
end

function TowerDeepHeroGroupInfoView:playDeepInfoAnim()
	self.curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	self.bossId = self.curGroupMO:getAssistBossId()

	if self.bossId > 0 then
		self._animAssistBoss:Play("out", 0, 0)
		self._animAssistBoss:Update(0)
		gohelper.setActive(self._goassistBoss, not self.isDropAssistBoss)
		TaskDispatcher.runDelay(self.showAssistBossEmpty, self, 0.167)
	else
		TowerController.instance:dispatchEvent(TowerEvent.OnShowAssistBossEmpty)
	end

	if self.isFightFailNotEnd then
		local roundItemIndex = Mathf.Max(self.curTeamWaveNum - 1, 1)
		local roundItem = self.roundItemMap[roundItemIndex]

		roundItem.hideAnim:Play("close", 0, 0)
		roundItem.hideAnim:Update(0)
		TowerPermanentDeepModel.instance:setIsFightFailNotEndState(false)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_passion_get)
	end
end

function TowerDeepHeroGroupInfoView:showAssistBossEmpty()
	TaskDispatcher.cancelTask(self.showAssistBossEmpty, self)
	gohelper.setActive(self._goassistBossEmpty, true)
	gohelper.setActive(self._goassistBoss, false)
	self._animAssistBossEmpty:Play()
	TowerController.instance:dispatchEvent(TowerEvent.OnShowAssistBossEmpty)

	self.isDropAssistBoss = true
end

function TowerDeepHeroGroupInfoView:removeAssistBoss()
	self.curGroupMO:setAssistBossId(0)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
end

function TowerDeepHeroGroupInfoView:onDestroyView()
	self._simagedeepBg:UnLoadImage()
	TaskDispatcher.cancelTask(self.playDeepInfoAnim, self)
	TaskDispatcher.cancelTask(self.showAssistBossEmpty, self)
	self:removeAssistBoss()
	TowerPermanentDeepModel.instance:setIsFightFailNotEndState(false)
end

return TowerDeepHeroGroupInfoView
