-- chunkname: @modules/logic/versionactivity2_5/challenge/view/herogroup/Act183HeroGroupFightView.lua

module("modules.logic.versionactivity2_5.challenge.view.herogroup.Act183HeroGroupFightView", package.seeall)

local Act183HeroGroupFightView = class("Act183HeroGroupFightView", HeroGroupFightView)

function Act183HeroGroupFightView:onInitView()
	Act183HeroGroupFightView.super.onInitView(self)

	self._gochallenge = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege")
	self._gobaserulecontainer = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/basictxt")
	self._gobaserules = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/basictxt/Iconlist")
	self._gobaseruleItem = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/basictxt/Iconlist/#go_item")
	self._goescapecontainer = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/escapetxt")
	self._goescaperules = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/escapetxt/Iconlist")
	self._goescaperuleitem = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/escapetxt/Iconlist/#go_item")
	self._btnchallengetip = gohelper.findChildButton(self.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/title/#btn_info")
	self._gochallengetips = gohelper.findChild(self.viewGO, "#go_container/#go_challengetips")
	self._btnclosechallengetips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_challengetips/#btn_closechallengetips")
	self._gochallengetipscontent = gohelper.findChild(self.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content")
	self._gochallengetiptitle = gohelper.findChild(self.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content/#go_tipitem/title")
	self._gochallengetipitem = gohelper.findChild(self.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content/#go_tipitem")
	self._gochallengedescitem = gohelper.findChild(self.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content/#go_tipitem/#txt_desc")
	self._goleadertips = gohelper.findChild(self.viewGO, "#go_righttop/#go_LeaderTips")
	self._txtleadertips = gohelper.findChildText(self.viewGO, "#go_righttop/#go_LeaderTips/txt_LeaderTips")

	SkillHelper.addHyperLinkClick(self._txtleadertips.gameObject)
end

function Act183HeroGroupFightView:addEvents()
	Act183HeroGroupFightView.super.addEvents(self)
end

function Act183HeroGroupFightView:removeEvents()
	Act183HeroGroupFightView.super.removeEvents(self)
end

function Act183HeroGroupFightView:_btnclothOnClock()
	local isUseLimit = Act183Helper.isOnlyCanUseLimitPlayerCloth(self._episodeId)

	if isUseLimit then
		GameFacade.showToast(ToastEnum.Act183OnlyOnePlayerCloth)

		return
	end

	Act183HeroGroupFightView.super._btnclothOnClock(self)
end

function Act183HeroGroupFightView:_editableInitView()
	self._activityId = Act183Model.instance:getActivityId()
	self._episodeId = HeroGroupModel.instance.episodeId

	self:checkAct183HeroList()
	Act183HeroGroupFightView.super._editableInitView(self)
end

function Act183HeroGroupFightView:_checkEquipClothSkill()
	local isUseLimit = self:setLimitPlayerCloth()

	if isUseLimit then
		return
	end

	Act183HeroGroupFightView.super._checkEquipClothSkill(self)
end

function Act183HeroGroupFightView:setLimitPlayerCloth()
	local isUseLimit = Act183Helper.isOnlyCanUseLimitPlayerCloth(self._episodeId)

	if isUseLimit then
		local clothId = Act183Helper.getLimitUsePlayerCloth()
		local hasCloth = PlayerClothModel.instance:hasCloth(clothId)

		HeroGroupModel.instance:replaceCloth(hasCloth and clothId or 0)
		HeroGroupModel.instance:saveCurGroupData()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	end

	return isUseLimit
end

function Act183HeroGroupFightView:_refreshBtns(isCostPower)
	Act183HeroGroupFightView.super._refreshBtns(self, isCostPower)
	gohelper.setActive(self._dropherogroup, false)
	TaskDispatcher.cancelTask(self._checkDropArrow, self)
end

function Act183HeroGroupFightView:checkAct183HeroList()
	local roleNum = Act183Helper.getEpisodeBattleNum(self._episodeId)
	local episodeCo = Act183Config.instance:getEpisodeCo(self._episodeId)
	local groupId = episodeCo and episodeCo.groupId
	local groupEpisodeMo = Act183Model.instance:getGroupEpisodeMo(groupId)
	local groupMO = HeroGroupModel.instance:getCurGroupMO()

	groupMO:checkAct183HeroList(roleNum, groupEpisodeMo)
	HeroSingleGroupModel.instance:setMaxHeroCount(roleNum)
	HeroSingleGroupModel.instance:setSingleGroup(groupMO, true)

	self._groupEpisodeMo = groupEpisodeMo
	self._episodeMo = Act183Model.instance:getEpisodeMo(groupId, self._episodeId)
end

function Act183HeroGroupFightView:openHeroGroupEditView()
	self._param = self._param or {}
	self._param.activityId = Act183Model.instance:getActivityId()
	self._param.episodeId = HeroGroupModel.instance.episodeId

	ViewMgr.instance:openView(ViewName.Act183HeroGroupEditView, self._param)
end

function Act183HeroGroupFightView:_refreshReplay()
	gohelper.setActive(self._goReplayBtn, false)
	gohelper.setActive(self._gomemorytimes, false)
end

function Act183HeroGroupFightView:onOpen()
	Act183HeroGroupFightView.super.onOpen(self)

	local unlockSupportHeros = Act183Model.instance:getUnlockSupportHeros()
	local canUseSupportHero = Act183Helper.isEpisodeCanUseSupportHero(self._episodeId)

	if canUseSupportHero and unlockSupportHeros then
		for _, supportHeroMo in ipairs(unlockSupportHeros) do
			HeroGroupTrialModel.instance:addAtLast(supportHeroMo)
		end
	end

	self:refreshLeaderTips()
end

function Act183HeroGroupFightView:refreshLeaderTips()
	local hasTeamLeader = Act183Helper.isEpisodeHasTeamLeader(self._episodeId)

	gohelper.setActive(self._goleadertips, hasTeamLeader)

	if not hasTeamLeader then
		return
	end

	local leaderSkillDesc = Act183Config.instance:getLeaderSkillDesc(self._episodeId)

	self._txtleadertips.text = SkillHelper.buildDesc(leaderSkillDesc)
end

function Act183HeroGroupFightView:_refreshPowerShow()
	gohelper.setActive(self._gopowercontent, false)
end

function Act183HeroGroupFightView:onClose()
	Act183HeroGroupFightView.super.onClose(self)
	HeroSingleGroupModel.instance:setMaxHeroCount()

	HeroGroupTrialModel.instance.curBattleId = nil
end

return Act183HeroGroupFightView
