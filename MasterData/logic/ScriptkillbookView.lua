-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillbookView.lua

module("logic.extensions.scriptkill.view.ScriptkillbookView", package.seeall)

local ScriptkillbookView = class("ScriptkillbookView", ViewComponent)

function ScriptkillbookView:unbindEvents()
	ScriptkillbookView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnCollect)
end

function ScriptkillbookView:bindEvents()
	ScriptkillbookView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
	GameUtil.addClickHandler(self._btnCollect, self._onClickCollect, self)

	for i, v in ipairs(self._downGoList) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickDown, self, i))
	end
end

function ScriptkillbookView:buildUI()
	ScriptkillbookView.super.buildUI(self)

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

	for i = 1, 3 do
		local go = self:getGo("down_" .. i)

		table.insert(self._downGoList, go)
	end

	self._txtTop = self:getTxt("top/txt")
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ScriptkillbookView:onExit()
	ScriptkillbookView.super.onExit(self)
	self._scrollList:dispose()
	RedPointController.instance:unregRedPoint(self._recipeRed)
end

function ScriptkillbookView:onEnterFinished()
	ScriptkillbookView.super.onEnterFinished(self)
	ScriptKillController.instance:tryShowTalkView(self._activityId)
end

function ScriptkillbookView:onEnter()
	ScriptkillbookView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = ScriptKillController.instance:getActivityId()
	end

	self._selectIdx = checknumber(params[2])

	if self._selectIdx == 0 then
		self._selectIdx = 1
	end

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

function ScriptkillbookView:_initView()
	local list = ScriptKillConfig.instance:getChapterListById(self._activityId) or {}

	goutil.clearChildren(self._topTapContainer)

	self._topTapList = {}

	for i, v in ipairs(list) do
		local go = goutil.clone(self._btnTopTab, "item_" .. i)

		GameUtil.SetActive(go, true)
		goutil.addChildToParent(go, self._topTapContainer)
		table.insert(self._topTapList, go)

		local txtName = goutil.findChildTextComponent(go, "txtName")

		txtName.text = v.name

		local lock = goutil.findChild(go, "lock")

		GameUtil.SetActive(lock, not ScriptKillModel.instance:checkFinishLast(self._activityId, v.chapterId))
		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickTopTap, self, i))
	end

	self:_onClickTopTap(self._selectIdx)
end

function ScriptkillbookView:_refreshUI()
	local list = ScriptKillModel.instance:getClueIds(self._activityId) or {}

	self._clueIdsMap = {}

	for i, v in ipairs(list) do
		self._clueIdsMap[v] = true
	end

	local list = ScriptKillConfig.instance:getClueCfgListById(self._activityId, self._selectIdx) or {}

	self._scrollList:reloadData(list)

	local cfg = ScriptKillConfig.instance:getChapterCfgById(self._activityId, self._selectIdx) or {}

	self._txtTop.text = cfg.target

	local info = ScriptKillModel.instance:getInfo(self._activityId) or {}

	self._txtPoint.text = checknumber(info.todayActionPoint)
end

function ScriptkillbookView:_onShowFormula(newTalkId)
	self._selectClueIds = {}

	self:_refreshDown()
	ScriptKillController.instance:tryShowTalkView(self._activityId)
end

function ScriptkillbookView:_onClickTopTap(index)
	if not ScriptKillModel.instance:checkFinishLast(self._activityId, index) then
		TipsFacade.instance:openCommonTips("请先完成上一章节")

		return
	end

	self._selectIdx = index

	for i, v in ipairs(self._topTapList) do
		GameUtil.setUIGroupIdx(v, self._selectIdx == i and 1 or 0)
	end

	self:_refreshDown()
	self:_refreshUI()
end

function ScriptkillbookView:_onClickDown(idx)
	table.remove(self._selectClueIds, idx)
	self:_refreshDown()
end

function ScriptkillbookView:_refreshDown()
	for i, v in ipairs(self._downGoList) do
		local txt = goutil.findChildTextComponent(v, "txt")
		local img = goutil.findChild(v, "img")
		local clueId = self._selectClueIds[i]

		if clueId then
			local cfg = ScriptKillConfig.instance:getClueCfgById(self._activityId, clueId) or {}

			txt.text = cfg.name

			GameUtil.SetActive(img, true)
		else
			txt.text = ""

			GameUtil.SetActive(img, false)
		end
	end

	GameUtil.SetGray(self._btnEnter, #self._selectClueIds == 0)
end

function ScriptkillbookView:_onClickEnter()
	if #self._selectClueIds > 0 then
		ScriptKillController.instance:sendGetFormula(self._activityId, self._selectClueIds)
	end
end

function ScriptkillbookView:_onClickCollect()
	UIStateManager.instance:push(ViewName.ScriptkillguessView, self._activityId)
end

function ScriptkillbookView:_onClickTask()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId, self._selectIdx)
end

function ScriptkillbookView:_onClickTip()
	TipsFacade.instance:openRulesView("scriptkillmainview_rule")
end

function ScriptkillbookView:_updateCell(view, cell, data, tag)
	local lock = goutil.findChild(cell, "lock")
	local txt = goutil.findChildTextComponent(cell, "txt")

	GameUtil.SetActive(lock, true)

	txt.text = ""

	if self._clueIdsMap[data.clueId] then
		txt.text = data.name

		GameUtil.SetActive(lock, false)
	end

	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickClue, self, data))
end

function ScriptkillbookView:_clearCell(cell)
	return
end

function ScriptkillbookView:_onClickClue(data)
	if not self._clueIdsMap[data.clueId] then
		TipsFacade.instance:openCommonTips("还没获得此线索")

		return
	end

	ScriptKillController.instance:openPopupWindow(data.name, data.desc, function()
		self:_addAndShowClude(data.clueId)
	end, nil, "填入", "取消")
end

function ScriptkillbookView:_addAndShowClude(clueId)
	if #self._selectClueIds < #self._downGoList and table.indexof(self._selectClueIds, clueId) == false then
		table.insert(self._selectClueIds, clueId)
		self:_refreshDown()
	end
end

return ScriptkillbookView
