-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_HeroGroupFightViewLevel.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_HeroGroupFightViewLevel", package.seeall)

local V3a9_BossRush_HeroGroupFightViewLevel = class("V3a9_BossRush_HeroGroupFightViewLevel", HeroGroupFightViewLevel)

function V3a9_BossRush_HeroGroupFightViewLevel:onInitView()
	self._txtheightscore = gohelper.findChildText(self.viewGO, "container/#scroll_info/infocontain/recordcontain/text/recordbg/text")
	self._gonormalcondition = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition")
	self._txtnormalcondition = gohelper.findChildText(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#txt_normalcondition")
	self._gonormalfinish = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalfinish")
	self._gonormalunfinish = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalunfinish")
	self._goplatinumcondition = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition")
	self._txtplatinumcondition = gohelper.findChildText(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#txt_platinumcondition")
	self._goplatinumfinish = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#go_platinumfinish")
	self._goplatinumunfinish = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#go_platinumunfinish")
	self._goplatinumcondition2 = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2")
	self._txtplatinumcondition2 = gohelper.findChildText(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#txt_platinumcondition")
	self._goplatinumfinish2 = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#go_platinumfinish")
	self._goplatinumunfinish2 = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#go_platinumunfinish")
	self._gohardplatinumcondition = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition")
	self._txthardplatinumcondition = gohelper.findChildText(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition/#txt_hardplatinumcondition")
	self._gohardplatinumfinish = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition/#go_hardplatinumfinish")
	self._gohardplatinumunfinish = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition/#go_hardunfinish")
	self._gohardcondition = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition")
	self._txthardcondition = gohelper.findChildText(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition/#txt_hardcondition")
	self._gohardfinish = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition/#go_hardfinish")
	self._gohardunfinish = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition/#go_hardunfinish")
	self._gohardconditionlock = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_hardconditionlock")
	self._gotargetlist = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList")
	self._btnenemy = gohelper.findChildButtonWithAudio(self.viewGO, "container/#scroll_info/infocontain/enemycontain/enemytitle/txten/#btn_enemy")
	self._enemylist = gohelper.findChildButtonWithAudio(self.viewGO, "container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam/enemyList")
	self._txtrecommendlevel = gohelper.findChildText(self.viewGO, "container/#scroll_info/infocontain/enemycontain/recommendtxt/#txt_recommendLevel")
	self._goenemyteam = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam")
	self._gocount = gohelper.findChild(self.viewGO, "container/btnContain/#go_cost/#go_count")
	self._gorecommendattr = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/enemycontain/#go_recommendAttr")
	self._goattritem = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/attrlist/#go_attritem")
	self._txtrecommonddes = gohelper.findChildTextMesh(self.viewGO, "container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/#txt_recommonddes")
	self._goadditionrule = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/#go_additionRule")
	self._goplace = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/targetList/#go_place")
	self._gostar3 = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star3")
	self._gostar2 = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star2")
	self._gostar1 = gohelper.findChild(self.viewGO, "container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star1")
	self.btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "herogroupcontain/#go_replayready/Reset")
	self._goreplayready = gohelper.findChild(self.viewGO, "herogroupcontain/#go_replayready")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_HeroGroupFightViewLevel:addEvents()
	self._btnenemy:AddClickListener(self._btnenemyOnClick, self)
	self._enemylist:AddClickListener(self._btnenemyOnClick, self)
	self.btnReset:AddClickListener(self._btnResetOnClick, self)
	self.addEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._refreshUI, self)
end

function V3a9_BossRush_HeroGroupFightViewLevel:removeEvents()
	self._btnenemy:RemoveClickListener()
	self._enemylist:RemoveClickListener()
	self.btnReset:RemoveClickListener()
	self.removeEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._refreshUI, self)
end

function V3a9_BossRush_HeroGroupFightViewLevel:_editableInitView()
	self._monsterGroupItemList = {}

	gohelper.addUIClickAudio(self._btnenemy.gameObject, AudioEnum.UI.play_ui_formation_monstermessage)
end

function V3a9_BossRush_HeroGroupFightViewLevel:onOpen()
	V3a9_BossRush_HeroGroupFightViewLevel.super.onOpen(self)

	local stage, actId = V3a9_BossRushModel.instance:getEnterActStage()

	self._actId = actId
	self._stage = stage

	self:_onRefreshBtnReset()
	self:_refreshHeightScore()
end

function V3a9_BossRush_HeroGroupFightViewLevel:_refreshHeightScore()
	self._stageMo = V3a9_BossRushModel.instance:getStageMo(self._actId, self._stage)
	self._txtheightscore.text = BossRushConfig.instance:getScoreStr(self._stageMo.latestPoint)
end

function V3a9_BossRush_HeroGroupFightViewLevel:_btnResetOnClick()
	V3a9_BossRushController.instance:onResetTeam(self._actId, self._stage, self._resetTeamCallback, self)
end

function V3a9_BossRush_HeroGroupFightViewLevel:_resetTeamCallback()
	self:_onRefreshBtnReset()
	self:_refreshHeightScore()
end

function V3a9_BossRush_HeroGroupFightViewLevel:_onRefreshBtnReset()
	local stageMo = V3a9_BossRushModel.instance:getStageMo(self._actId, self._stage)
	local isChallenge = stageMo:isChallenge()

	gohelper.setActive(self._goreplayready, isChallenge)
end

function V3a9_BossRush_HeroGroupFightViewLevel:onDestroyView()
	return
end

return V3a9_BossRush_HeroGroupFightViewLevel
