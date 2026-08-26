-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/Act183DungeonView_Detail.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.Act183DungeonView_Detail", package.seeall)

local Act183DungeonView_Detail = class("Act183DungeonView_Detail", BaseView)
local DelaySwitchEpisodeInfo = 0.1

function Act183DungeonView_Detail:onInitView()
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._gonormaltype = gohelper.findChild(self.viewGO, "root/left/mode/#go_normaltype")
	self._goselectnormal = gohelper.findChild(self.viewGO, "root/left/mode/#go_normaltype/#go_selectnormal")
	self._gounselectnormal = gohelper.findChild(self.viewGO, "root/left/mode/#go_normaltype/#go_unselectnormal")
	self._gohardtype = gohelper.findChild(self.viewGO, "root/left/mode/#go_hardtype")
	self._goselecthard = gohelper.findChild(self.viewGO, "root/left/mode/#go_hardtype/#go_selecthard")
	self._gounselecthard = gohelper.findChild(self.viewGO, "root/left/mode/#go_hardtype/#go_unselecthard")
	self._btnclicknormal = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/mode/#go_normaltype/#btn_clicknormal")
	self._btnclickhard = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/mode/#go_hardtype/#btn_clickhard")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#btn_task")
	self._goepisodecontainer = gohelper.findChild(self.viewGO, "root/middle/#go_episodecontainer")
	self._gonormalepisode = gohelper.findChild(self.viewGO, "root/middle/#go_episodecontainer/#go_normalepisode")
	self._gobossepisode = gohelper.findChild(self.viewGO, "root/middle/#go_episodecontainer/#go_bossepisode")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "root/top/bar/#btn_reset")
	self._godetail = gohelper.findChild(self.viewGO, "root/right/#go_detail")
	self._btnclosedetail = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_closedetail")
	self._gonormal = gohelper.findChild(self.viewGO, "root/right/#go_detail/#go_normal")
	self._gohard = gohelper.findChild(self.viewGO, "root/right/#go_detail/#go_hard")
	self._scrolldetail = gohelper.findChildScrollRect(self.viewGO, "root/right/#go_detail/#scroll_detail")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/right/#go_detail/title/#txt_title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/top/#txt_desc")
	self._godone = gohelper.findChild(self.viewGO, "root/right/#go_detail/title/#go_done")
	self._goconditions = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions")
	self._imageconditionstar = gohelper.findChildImage(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions/top/title/#image_conditionstar")
	self._goconditiondescs = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions/#go_conditiondescs")
	self._txtconditionitem = gohelper.findChildText(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions/#go_conditiondescs/#txt_conditionitem")
	self._gobaserulecontainer = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer")
	self._gobadgerules = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_badgerules")
	self._gobadgeruleitem = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_badgerules/#go_badgeruleitem")
	self._gobaserules = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_baserules")
	self._gobaseruleitem = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_baserules/#go_baseruleitem")
	self._goescaperulecontainer = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_escaperulecontainer")
	self._goescaperules = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_escaperulecontainer/#go_escaperules")
	self._goescaperuleitem = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_escaperulecontainer/#go_escaperules/#go_escaperuleitem")
	self._gorewardcontainer = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_rewardcontainer")
	self._gorewards = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_rewardcontainer/#go_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_rewardcontainer/#go_rewards/#go_rewarditem")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#go_detail/#btn_start")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#go_detail/#btn_restart")
	self._btnbadge = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#go_detail/#btn_badge")
	self._golock = gohelper.findChild(self.viewGO, "root/right/#go_detail/#go_lock")
	self._txtusebadgenum = gohelper.findChildText(self.viewGO, "root/right/#go_detail/#btn_badge/#txt_usebadgenum")
	self._gobadgedetail = gohelper.findChild(self.viewGO, "root/right/#go_detail/#go_badgedetail")
	self._btnclosebadge = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#go_detail/#go_badgedetail/#btn_closebadge")
	self._btnresetbadge = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#go_detail/#go_badgedetail/#go_badges/#btn_resetbadge")
	self._gobadgeitem = gohelper.findChild(self.viewGO, "root/right/#go_detail/#go_badgedetail/#go_badges/#go_badgeitem")
	self._btnrepress = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#go_detail/#btn_repress")
	self._gosetrepresshero = gohelper.findChild(self.viewGO, "root/right/#go_detail/#btn_repress/#go_setrepresshero")
	self._simagerepressheroicon = gohelper.findChildSingleImage(self.viewGO, "root/right/#go_detail/#btn_repress/#go_setrepresshero/#simage_repressheroicon")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "root/right/#go_detail/#btn_repress/#go_setrepresshero/#image_Career")
	self._gorepressresult = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult")
	self._gohasrepress = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_hasrepress")
	self._gounrepress = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_unrepress")
	self._gorepressrules = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_repressrules")
	self._gorepressruleitem = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_repressrules/#go_repressruleitem")
	self._gorepressheropos = gohelper.findChild(self.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_hasrepress/#go_repressheropos")
	self._btnresetepisode = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#go_detail/#btn_resetepisode")
	self._gonotresetepisode = gohelper.findChild(self.viewGO, "root/right/#go_detail/#go_notresetepisode")
	self._btninfo = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#go_detail/title/#btn_Info")
	self._goleadertips = gohelper.findChild(self.viewGO, "root/right/#go_detail/#go_LeaderTips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183DungeonView_Detail:addEvents()
	self._btnclosedetail:AddClickListener(self._btnclosedetailOnClick, self)
end

function Act183DungeonView_Detail:removeEvents()
	self._btnclosedetail:RemoveClickListener()
end

function Act183DungeonView_Detail:_btnclosedetailOnClick()
	self:setDetailVisible(false)
	Act183Controller.instance:dispatchEvent(Act183Event.OnClickEpisode)
end

function Act183DungeonView_Detail:_editableInitView()
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnClickEpisode, self._onClickEpisode, self)
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnUpdateRepressInfo, self._onUpdateRepressInfo, self)
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnUpdateGroupInfo, self._onUpdateGroupInfo, self)

	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._compMgr = MonoHelper.addLuaComOnceToGo(self._godetail, Act183DungeonCompMgr)

	self._compMgr:addComp(self._godetail, Act183DungeonDescComp, true)
	self._compMgr:addComp(self._goconditions, Act183DungeonConditionComp, true)
	self._compMgr:addComp(self._gobaserulecontainer, Act183DungeonBaseAndBadgeRuleComp, true)
	self._compMgr:addComp(self._gorewardcontainer, Act183DungeonRewardRuleComp, true)
	self._compMgr:addComp(self._goescaperulecontainer, Act183DungeonEscapeRuleComp, true)
	self._compMgr:addComp(self._gorepressresult, Act183DungeonRepressResultComp, true)
	self._compMgr:addComp(self._btnstart.gameObject, Act183DungeonStartBtnComp, true)
	self._compMgr:addComp(self._gobadgedetail, Act183DungeonSelectBadgeComp, true)
	self._compMgr:addComp(self._btnrepress.gameObject, Act183DungeonRepressBtnComp, false)
	self._compMgr:addComp(self._btnrestart.gameObject, Act183DungeonRestartBtnComp, false)
	self._compMgr:addComp(self._btnresetepisode.gameObject, Act183DungeonResetBtnComp, false)
	self._compMgr:addComp(self._gonotresetepisode, Act183DungeonNotResetBtnComp, false)
	self._compMgr:addComp(self._golock, Act183DungeonLockBtnComp, false)
	self._compMgr:addComp(self._btnbadge.gameObject, Act183DungeonBadgeBtnComp, false)
	self._compMgr:addComp(self._goleadertips, Act183DungeonTeamLeaderTipsComp, false)
	self:setDetailVisible(false)
end

function Act183DungeonView_Detail:_onClickEpisode(episodeId)
	if not episodeId then
		return
	end

	if self._expand and self._episodeId ~= episodeId then
		self._animator:Play("rightswitch", 0, 0)
	end

	self._nextEpisodeMo = Act183Model.instance:getEpisodeMoById(episodeId)

	if not self._nextEpisodeMo then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("Act183DungeonView_Detail_SwitchEpisode")
	TaskDispatcher.cancelTask(self.switchEpisodeDetail, self)
	TaskDispatcher.runDelay(self.switchEpisodeDetail, self, DelaySwitchEpisodeInfo)
end

function Act183DungeonView_Detail:switchEpisodeDetail()
	self:refreshEpisodeDetail(self._nextEpisodeMo)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("Act183DungeonView_Detail_SwitchEpisode")
end

function Act183DungeonView_Detail:_onUpdateRepressInfo(episodeId, episodeMo)
	if not self._expand or self._episodeId ~= episodeId then
		return
	end

	self:refreshEpisodeDetail(episodeMo)
end

function Act183DungeonView_Detail:_onUpdateGroupInfo()
	if not self._expand or not self._episodeId then
		return
	end

	local newEpisodeMo = Act183Model.instance:getEpisodeMoById(self._episodeId)

	self:refreshEpisodeDetail(newEpisodeMo)
end

function Act183DungeonView_Detail:refreshEpisodeDetail(episodeMo)
	local isExpand = episodeMo ~= nil

	self:setDetailVisible(isExpand)

	if not isExpand then
		return
	end

	self._episodeId = episodeMo:getEpisodeId()

	self._compMgr:onUpdateMO(episodeMo)
end

function Act183DungeonView_Detail:setDetailVisible(isVisible)
	if self._expand and not isVisible then
		self._animator:Play("rightclose", 0, 0)
	elseif not self._expand and isVisible then
		self._animator:Play("rightopen", 0, 0)
	end

	self._expand = isVisible

	gohelper.setActive(self._godetail, self._expand)
	gohelper.setActive(self._btnclosedetail.gameObject, self._expand)

	if not isVisible then
		self._episodeId = nil
	end
end

function Act183DungeonView_Detail:onClose()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("Act183DungeonView_Detail_SwitchEpisode")
	TaskDispatcher.cancelTask(self.switchEpisodeDetail, self)
end

function Act183DungeonView_Detail:onDestroyView()
	return
end

return Act183DungeonView_Detail
