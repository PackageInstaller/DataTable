-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterScriptKillBookView.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterScriptKillBookView", package.seeall)

local DreamTeamChapterScriptKillBookView = class("DreamTeamChapterScriptKillBookView", ScriptkillbookView)

function DreamTeamChapterScriptKillBookView:buildUI()
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnEnter = self:getGo("btnEnter")
	self._btnTask = self:getGo("btnTask")
	self._recipeRed = self:getGo("btnTask/recipeRed")
	self._btnCollect = self:getGo("btnCollect")
	self._txtPoint = self:getTxt("txtPoint/txt")
	self._topTapContainer = self:getGo("topTapContainer")
	self._btnTopTab = self:getGo("btnTopTab")

	GameUtil.SetActive(self._btnTopTab, false)

	self._downGoList = {}

	for i = 1, 2 do
		local go = self:getGo("down_" .. i)

		table.insert(self._downGoList, go)
	end

	self._txtTop = self:getTxt("top/txt")
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DreamTeamChapterScriptKillBookView:onEnter()
	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = ScriptKillController.instance:getActivityId()
	end

	self._selectIdx = checknumber(params[2])

	if self._selectIdx == 0 then
		self._selectIdx = 1
	end

	self._endStoryId = checknumber(params[3])
	self._selectClueIds = {}

	self.addGEvent(self, GlobalNotify.ScriptKillInfoUpdate, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.ScriptKillGetFormula, self._onShowFormula, self)
	ScriptKillController.instance:sendGetInfo(self._activityId)
	self:_initView()

	local taskRedId = EventTaskSummaryController.instance:getCurRedIdByActivityId(self._activityId)

	if taskRedId > 0 then
		RedPointController.instance:regRedPoint(self._recipeRed, taskRedId)
	end
end

function DreamTeamChapterScriptKillBookView:_refreshUI()
	local clueInfoList = ScriptKillModel.instance:getClueIds(self._activityId) or {}
	local cfgs = ScriptKillConfig.instance:getClueCfgListById(self._activityId, 1)

	self._clueIdsMap = {}

	for i, v in ipairs(clueInfoList) do
		self._clueIdsMap[v] = true
	end

	local list = ScriptKillConfig.instance:getClueCfgListById(self._activityId, self._selectIdx) or {}

	self._scrollList:reloadData(list)

	local cfg = ScriptKillConfig.instance:getChapterCfgById(self._activityId, self._selectIdx) or {}

	self._txtTop.text = cfg.target

	local info = ScriptKillModel.instance:getInfo(self._activityId) or {}

	self._txtPoint.text = checknumber(info.todayActionPoint)

	if cfgs and #cfgs == #clueInfoList and checknumber(self._endStoryId) > 0 then
		local key = string.format("DreamTeamChapterScriptKillBookView_%s", self._activityId)

		local function firstCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._endStoryId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end
end

return DreamTeamChapterScriptKillBookView
