-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterScriptKillSeachView.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterScriptKillSeachView", package.seeall)

local DreamTeamChapterScriptKillSeachView = class("DreamTeamChapterScriptKillSeachView", ScriptkillseachView)

function DreamTeamChapterScriptKillSeachView:onEnter()
	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = ScriptKillController.instance:getActivityId()
	end

	self._chapterId = checknumber(params[2])

	if self._chapterId == 0 then
		self._chapterId = 1
	end

	self._dreamTeamActId = checknumber(params[3])
	self._selectTabIdx = 1
	self._speaking = false
	self._speakList = {}
	self._effectMap = {}
	self._errorCount = 0

	self:_initView()

	local taskRedId = EventTaskSummaryController.instance:getCurRedIdByActivityId(self._activityId)

	if taskRedId > 0 then
		RedPointController.instance:regRedPoint(self._recipeRed, taskRedId)
	end

	self.addGEvent(self, GlobalNotify.ScriptKillGetCludeId, self._onGetClueId, self)
	self.addGEvent(self, GlobalNotify.ScriptKillInfoUpdate, self._refreshUI, self)
	GameUtil.doCallbackWhenFirst("ScriptkillseachView_" .. self._activityId .. "_" .. self._chapterId, function()
		local cfg = ScriptKillConfig.instance:getChapterCfgById(self._activityId, self._chapterId)

		if cfg and checknumber(cfg.storyId) > 0 then
			StoryController.instance:startStory(checknumber(cfg.storyId))
		end
	end)
end

function DreamTeamChapterScriptKillSeachView:_onClickJump1()
	local dreamTeamCfg = DreamTeamChapterConfig.instance:getActivityCfg(self._dreamTeamActId)

	if dreamTeamCfg then
		if not dreamTeamCfg.chap1EndStoryId then
			local chap1EndStoryId = 0

			UIStateManager.instance:push(ViewName.DreamTeamChapterScriptKillBookView, self._activityId, self._chapterId, chap1EndStoryId)
		end
	end
end

return DreamTeamChapterScriptKillSeachView
