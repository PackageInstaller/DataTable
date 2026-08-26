-- chunkname: @modules/logic/tower/view/fight/TowerDeepResultView.lua

module("modules.logic.tower.view.fight.TowerDeepResultView", package.seeall)

local TowerDeepResultView = class("TowerDeepResultView", BaseView)

function TowerDeepResultView:onInitView()
	self._simagedeepRare = gohelper.findChildSingleImage(self.viewGO, "#simage_deepRare")
	self._gobossNormal = gohelper.findChild(self.viewGO, "boss/#go_bossNormal")
	self._gobossEndless = gohelper.findChild(self.viewGO, "boss/#go_bossEndless")
	self._goresultView = gohelper.findChild(self.viewGO, "#go_resultView")
	self._simageplayerHead = gohelper.findChildSingleImage(self.viewGO, "#go_resultView/Left/Player/PlayerHead/#simage_playerHead")
	self._txtplayerName = gohelper.findChildText(self.viewGO, "#go_resultView/Left/Player/#txt_playerName")
	self._txttime = gohelper.findChildText(self.viewGO, "#go_resultView/Left/Player/#txt_time")
	self._txtplayerUid = gohelper.findChildText(self.viewGO, "#go_resultView/Left/Player/#txt_playerUid")
	self._btncloseResult = gohelper.findChildButtonWithAudio(self.viewGO, "#go_resultView/#btn_closeResult")
	self._scrolllist = gohelper.findChildScrollRect(self.viewGO, "#go_resultView/Right/#scroll_list")
	self._goteamContent = gohelper.findChild(self.viewGO, "#go_resultView/Right/#scroll_list/Viewport/#go_teamContent")
	self._goteamItem = gohelper.findChild(self.viewGO, "#go_resultView/Right/#scroll_list/Viewport/#go_teamContent/#go_teamItem")
	self._gobossView = gohelper.findChild(self.viewGO, "#go_bossView")
	self._imagedeepBg = gohelper.findChildImage(self.viewGO, "#go_bossView/Score/#image_deepBg")
	self._txtdepth = gohelper.findChildText(self.viewGO, "#go_bossView/Score/#txt_depth")
	self._gonewRecord = gohelper.findChild(self.viewGO, "#go_bossView/Score/#txt_depth/#go_newRecord")
	self._txtbossDec = gohelper.findChildText(self.viewGO, "#go_bossView/#txt_bossDec")
	self._btncloseBoss = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bossView/#btn_closeBoss")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerDeepResultView:addEvents()
	self._btncloseResult:AddClickListener(self._btncloseResultOnClick, self)
	self._btncloseBoss:AddClickListener(self._btncloseBossOnClick, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function TowerDeepResultView:removeEvents()
	self._btncloseResult:RemoveClickListener()
	self._btncloseBoss:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

TowerDeepResultView.showResultViewTime = 1.267
TowerDeepResultView.showHeroItemAnimTime = 0.06

function TowerDeepResultView:_btncloseResultOnClick()
	self:closeThis()
end

function TowerDeepResultView:_btncloseBossOnClick()
	self:onDepthTweenDone(true)
	TaskDispatcher.cancelTask(self._btncloseBossOnClick, self)

	self.animView.enabled = true

	self.animView:Play("toresult", 0, 0)
	self.animView:Update(0)
	self:showAllTeamItem()
	gohelper.setActive(self._btncloseBoss.gameObject, false)
end

function TowerDeepResultView:_editableInitView()
	self.teamItemMap = self:getUserDataTb_()

	gohelper.setActive(self._goteamItem, false)

	self.animView = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function TowerDeepResultView:onUpdateParam()
	return
end

function TowerDeepResultView:onOpen()
	self.fightResult = TowerPermanentDeepModel.instance:getFightResult()
	self.isSucc = self.fightResult == TowerDeepEnum.FightResult.Succ
	self.isOpenEndless = TowerPermanentDeepModel.instance.isOpenEndless
	self.curDeepGroupMo = TowerPermanentDeepModel.instance:getCurDeepGroupMo()
	self.curDepth = self.curDeepGroupMo.curDeep

	self:refreshUI()
end

function TowerDeepResultView:refreshUI()
	self.deepRare = TowerPermanentDeepModel.instance:getDeepRare(self.curDepth)

	self._simagedeepRare:LoadImage(ResUrl.getFightImage(string.format("tower/fight_tower_mask_%s.png", self.deepRare)))

	self.fightParam = FightModel.instance:getFightParam()
	self.heroEquipMoList = self.fightParam:getHeroEquipAndTrialMoList(true)

	self:refreshBossView()
	self:refreshResultView()
end

function TowerDeepResultView:refreshBossView()
	gohelper.setActive(self._gobossNormal, not self.isOpenEndless and not self.isSucc)
	gohelper.setActive(self._gobossEndless, self.isOpenEndless or self.isSucc)
	UISpriteSetMgr.instance:setFightTowerSprite(self._imagedeepBg, "fight_tower_numbg_" .. self.deepRare)

	self._txtbossDec.text = TowerDeepConfig.instance:getConstConfigLangValue((self.isSucc or nil) and (TowerDeepEnum.ConstId.ResultBossDescSucc or TowerDeepEnum.ConstId.ResultBossDescFail))

	gohelper.setActive(self._gonewRecord, TowerPermanentDeepModel.instance.isNewRecord)

	local waitNamePlateToastList = AchievementToastModel.instance:getWaitNamePlateToastList()

	if not waitNamePlateToastList or #waitNamePlateToastList == 0 then
		self:startShowDepth()
	end
end

function TowerDeepResultView:startShowDepth()
	local defaultHigh = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)

	self.depthTweenId = ZProj.TweenHelper.DOTweenFloat(defaultHigh, self.curDepth, 1.5, self.onDepthFrameCallback, self.onDepthTweenDone, self, nil, EaseType.Linear)
end

function TowerDeepResultView:onDepthFrameCallback(value)
	self._txtdepth.text = string.format("%dM", value)
end

function TowerDeepResultView:onDepthTweenDone(isClick)
	self._txtdepth.text = string.format("%dM", self.curDepth)

	if self.depthTweenId then
		ZProj.TweenHelper.KillById(self.depthTweenId)

		self.depthTweenId = nil
	end

	if not isClick then
		TaskDispatcher.runDelay(self._btncloseBossOnClick, self, TowerDeepResultView.showResultViewTime)
	end
end

function TowerDeepResultView:refreshResultView()
	self:refreshPlayerInfo()
	self:createTeamsItem()
end

function TowerDeepResultView:refreshPlayerInfo()
	local playerInfo = PlayerModel.instance:getPlayinfo()

	self._txtplayerUid.text = string.format("UID:%s", playerInfo.userId)
	self._txtplayerName.text = playerInfo.name
	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simageplayerHead)

	self._liveHeadIcon:setLiveHead(playerInfo.portrait)

	self._txttime.text = os.date("%Y.%m.%d %H:%M:%S", self.curDeepGroupMo.createTime)
end

function TowerDeepResultView:createTeamsItem()
	local curTeamDataList = self.curDeepGroupMo:getTeamDataList()

	for index, teamData in ipairs(curTeamDataList) do
		local teamItem = self.teamItemMap[index]

		if not teamItem then
			teamItem = {
				go = gohelper.clone(self._goteamItem, self._goteamContent, "teamItem" .. index)
			}
			teamItem.teamComp = MonoHelper.addNoUpdateLuaComOnceToGo(teamItem.go, TowerDeepResultTeamItem)
			self.teamItemMap[index] = teamItem
		end

		teamItem.teamComp:refreshUI(index, curTeamDataList)
	end
end

function TowerDeepResultView:showAllTeamItem()
	for index, teamItem in ipairs(self.teamItemMap) do
		teamItem.teamComp:showTeamItem(index * TowerDeepResultView.showHeroItemAnimTime)
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mingdi_boss_clearing)

	self._scrolllist.verticalNormalizedPosition = 1
	self.scrollTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.5, self.setScrollPos, self.setScrollPosDone, self)
end

function TowerDeepResultView:setScrollPos(value)
	self._scrolllist.verticalNormalizedPosition = value
end

function TowerDeepResultView:setScrollPosDone()
	self._scrolllist.verticalNormalizedPosition = 0
end

function TowerDeepResultView:_onCloseViewFinish(viewName)
	if viewName == ViewName.AchievementNamePlateUnlockView then
		self:startShowDepth()
	end
end

function TowerDeepResultView:onClose()
	FightController.onResultViewClose()
	TaskDispatcher.cancelTask(self._btncloseBossOnClick, self)

	if self.depthTweenId then
		ZProj.TweenHelper.KillById(self.depthTweenId)

		self.depthTweenId = nil
	end

	if self.scrollTweenId then
		ZProj.TweenHelper.KillById(self.scrollTweenId)

		self.scrollTweenId = nil
	end
end

function TowerDeepResultView:onDestroyView()
	self._simageplayerHead:UnLoadImage()
end

return TowerDeepResultView
