-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/view/VersionActivity2_8BossStoryEnterView.lua

module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossStoryEnterView", package.seeall)

local VersionActivity2_8BossStoryEnterView = class("VersionActivity2_8BossStoryEnterView", BaseView)

function VersionActivity2_8BossStoryEnterView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagedecbg = gohelper.findChildSingleImage(self.viewGO, "#simage_decbg")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "#simage_langtxt")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task")
	self._goreddot = gohelper.findChild(self.viewGO, "#btn_task/#go_reddot")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_start")
	self._btncontinue = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_continue")
	self._goprogress = gohelper.findChild(self.viewGO, "#go_progress")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._btnmap = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_map")
	self._gosnow = gohelper.findChild(self.viewGO, "#go_snow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_8BossStoryEnterView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btncontinue:AddClickListener(self._btncontinueOnClick, self)
	self._btnmap:AddClickListener(self._btnmapOnClick, self)
end

function VersionActivity2_8BossStoryEnterView:removeEvents()
	self._btnreset:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btncontinue:RemoveClickListener()
	self._btnmap:RemoveClickListener()
end

function VersionActivity2_8BossStoryEnterView:_btnmapOnClick()
	return
end

function VersionActivity2_8BossStoryEnterView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.BossStoryTip2, MsgBoxEnum.BoxType.Yes_No, function()
		VersionActivity2_8BossRpc.instance:sendBossFightResetChapterRequest(DungeonEnum.ChapterId.BossStory, self._onResetHandler, self)
	end, nil, nil)
end

function VersionActivity2_8BossStoryEnterView:_onResetHandler(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:_updateStars()
end

function VersionActivity2_8BossStoryEnterView:_btntaskOnClick()
	VersionActivity2_8DungeonController.instance:openTaskView()
end

function VersionActivity2_8BossStoryEnterView:_btnstartOnClick()
	self:_enterFight()
end

function VersionActivity2_8BossStoryEnterView:_btncontinueOnClick()
	self:_enterFight()
end

function VersionActivity2_8BossStoryEnterView:_enterFight()
	if not self._episodeId then
		logError("VersionActivity2_8BossStoryEnterView:_enterFight episodeId is nil")

		return
	end

	if self:_checkAfterStoryFinish() then
		return
	end

	if self._episodeId == VersionActivity2_8BossEnum.StoryBossSecondEpisode and not GuideController.instance:isForbidGuides() and not GuideModel.instance:isGuideFinish(VersionActivity2_8BossEnum.StoryBossSecondEpisodeGuideId) then
		StoryController.instance:playStory(VersionActivity2_8BossEnum.StoryBoss_EpisodeStoryId, nil, self._startEnterFight, self)

		return
	end

	self:_startEnterFight()
end

function VersionActivity2_8BossStoryEnterView:_checkAfterStoryFinish()
	if not DungeonModel.instance:hasPassLevel(self._episodeId) then
		return false
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	if episodeConfig.afterStory > 0 and not StoryModel.instance:isStoryFinished(episodeConfig.afterStory) then
		local param = {}

		param.mark = true
		param.episodeId = self._episodeId

		StoryController.instance:playStory(episodeConfig.afterStory, param, function()
			self:closeThis()
			VersionActivity2_8DungeonBossController.instance:forceFinishElement()
		end)

		return true
	end

	return false
end

function VersionActivity2_8BossStoryEnterView:_startEnterFight()
	VersionActivity2_8BossModel.instance:enterBossStoryFight(self._episodeId)

	local config = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	DungeonFightController.instance:enterFight(config.chapterId, self._episodeId)
end

function VersionActivity2_8BossStoryEnterView:_editableInitView()
	gohelper.setActive(self._btncontinue, false)
	gohelper.setActive(self._btnstart, false)
	gohelper.setActive(self._btntask, false)
	gohelper.setActive(self._btnreset, false)
end

function VersionActivity2_8BossStoryEnterView:onUpdateParam()
	return
end

function VersionActivity2_8BossStoryEnterView:onRefreshActivityState()
	local isNormal = false

	gohelper.setActive(self._btntask, isNormal)
end

function VersionActivity2_8BossStoryEnterView:onOpen()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self:onRefreshActivityState()
	gohelper.setActive(self._btnstart, true)
	self:_initStars()
	self:_updateStars()
end

function VersionActivity2_8BossStoryEnterView:_initStars()
	if self._lightList then
		return
	end

	local transform = self._goprogress.transform
	local childCount = transform.childCount

	self._lightList = self:getUserDataTb_()

	for i = 0, childCount - 1 do
		local child = transform:GetChild(i)
		local light = child:GetChild(0)
		local go = light.gameObject

		gohelper.setActive(go, false)
		table.insert(self._lightList, go)
	end
end

function VersionActivity2_8BossStoryEnterView:_updateStars()
	local list = DungeonConfig.instance:getChapterEpisodeCOList(DungeonEnum.ChapterId.BossStory)

	self._episodeId = nil

	local num = 0

	for i, v in ipairs(list) do
		local pass = DungeonModel.instance:hasPassLevelAndStory(v.id)

		if not pass and not self._episodeId then
			self._episodeId = v.id
		end

		local starGo = self._lightList[i]

		gohelper.setActive(starGo, pass)

		if pass then
			num = num + 1
		end
	end

	gohelper.setActive(self._btnreset, num > 0)
end

function VersionActivity2_8BossStoryEnterView:onClose()
	return
end

function VersionActivity2_8BossStoryEnterView:onDestroyView()
	return
end

return VersionActivity2_8BossStoryEnterView
