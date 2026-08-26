-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_ResultView.lua

module("modules.logic.bossrush.view.V1a4_BossRush_ResultView", package.seeall)

local V1a4_BossRush_ResultView = class("V1a4_BossRush_ResultView", BaseView)

function V1a4_BossRush_ResultView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Title/#simage_Title")
	self._btnRank = gohelper.findChildButtonWithAudio(self.viewGO, "Title/#btn_Rank")
	self._simagePlayerHead = gohelper.findChildSingleImage(self.viewGO, "Player/PlayerHead/#simage_PlayerHead")
	self._txtPlayerName = gohelper.findChildText(self.viewGO, "Player/#txt_PlayerName")
	self._txtTime = gohelper.findChildText(self.viewGO, "Player/#txt_Time")
	self._goAssessScore = gohelper.findChild(self.viewGO, "Right/#go_AssessScore")
	self._goGroup = gohelper.findChild(self.viewGO, "Right/#go_Group")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a4_BossRush_ResultView:addEvents()
	self._btnRank:AddClickListener(self._btnRankOnClick, self)
end

function V1a4_BossRush_ResultView:removeEvents()
	self._btnRank:RemoveClickListener()
end

function V1a4_BossRush_ResultView:_btnRankOnClick()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function V1a4_BossRush_ResultView:_editableInitView()
	self._bossBgList = self:getUserDataTb_()

	for i = 1, 3 do
		self._bossBgList[i] = gohelper.findChild(self.viewGO, "boss_topbg" .. i)
	end

	self:_initAssessScore()
	self:_initHeroGroup()

	self._click = gohelper.getClick(self.viewGO)

	self._click:AddClickListener(self.closeThis, self)
	NavigateMgr.instance:addEscape(ViewName.V1a4_BossRush_ResultView, self.closeThis, self)
end

function V1a4_BossRush_ResultView:_initAssessScore()
	local itemClass = V1a4_BossRush_Assess_Score
	local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_result_assess, self._goAssessScore, itemClass.__name)

	self._assessScore = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

	self._assessScore:setActiveDesc(false)
	self._assessIcon:initData(self, false)
end

function V1a4_BossRush_ResultView:_initHeroGroup()
	local itemClass = V1a4_BossRush_HeroGroup
	local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_herogroup, self._goGroup, itemClass.__cname)

	self._heroGroup = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass, self.viewContainer)
end

function V1a4_BossRush_ResultView:onUpdateParam()
	return
end

function V1a4_BossRush_ResultView:onOpen()
	self._curStage, self._curLayer = BossRushModel.instance:getBattleStageAndLayer()

	local playerInfo = PlayerModel.instance:getPlayinfo()
	local portrait = playerInfo.portrait

	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simagePlayerHead)

	self._liveHeadIcon:setLiveHead(portrait)

	self._txtTime.text = TimeUtil.getServerDateToString()
	self._txtPlayerName.text = playerInfo.name

	self:_refresh()
end

function V1a4_BossRush_ResultView:onOpenFinish()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
end

function V1a4_BossRush_ResultView:onClose()
	self._click:RemoveClickListener()
	FightController.onResultViewClose()
end

function V1a4_BossRush_ResultView:onDestroyView()
	self._simageFullBG:UnLoadImage()
	self._simageTitle:UnLoadImage()
	self._simagePlayerHead:UnLoadImage()
	GameUtil.onDestroyViewMember(self, "_heroGroup")
	GameUtil.onDestroyViewMember(self, "_assessScore")
end

function V1a4_BossRush_ResultView:_refresh()
	local stage = self._curStage

	if not stage then
		return
	end

	local bgIndex = stage == 1 and 1 or stage == 2 and 3 or 2

	for i, v in ipairs(self._bossBgList) do
		gohelper.setActive(v, bgIndex == i)
	end

	self._simageFullBG:LoadImage(BossRushConfig.instance:getResultViewFullBgSImage(stage))
	self._simageTitle:LoadImage(BossRushConfig.instance:getResultViewNameSImage(stage))
	self._assessScore:setData_ResultView(stage, BossRushModel.instance:getFightScore())
	self._assessScore:setActiveNewRecord(BossRushModel.instance:checkIsNewHighestPointRecord(stage))
	self._heroGroup:setDataByCurFightParam()
end

return V1a4_BossRush_ResultView
