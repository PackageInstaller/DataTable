-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventClueCombineView.lua

module("logic.extensions.jieshenevent.view.JieShenEventClueCombineView", package.seeall)

local JieShenEventClueCombineView = class("JieShenEventClueCombineView", ViewComponent)

function JieShenEventClueCombineView:unbindEvents()
	JieShenEventClueCombineView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnEnter)
end

function JieShenEventClueCombineView:bindEvents()
	JieShenEventClueCombineView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)

	for i, v in ipairs(self._downGoList) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickDown, self, i))
	end
end

function JieShenEventClueCombineView:buildUI()
	JieShenEventClueCombineView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnEnter = self:getGo("btnEnter")
	self._txtPoint = self:getTxt("txtPoint/txt")

	GameUtil.SetActive(self._btnTopTab, false)

	self._tabTableview = self:getGo("tabTableview")
	self._tabTableCell = self:getGo("tabTableCell")
	self._tabScrollList = ScrollerList.create(self._tabTableview, self._tabTableCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._downGoList = {}

	for i = 1, 2 do
		local go = self:getGo("down_" .. i)

		table.insert(self._downGoList, go)
	end

	self._txtTop = self:getTxt("top/txt")
	self._clueTableView = self:getGo("clueTableview")
	self._clueTableCell = self:getGo("clueTableCell")
	self._scrollList = ScrollerList.create(self._clueTableView, self._clueTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function JieShenEventClueCombineView:onExit()
	JieShenEventClueCombineView.super.onExit(self)
	self._scrollList:dispose()
end

function JieShenEventClueCombineView:onEnterFinished()
	JieShenEventClueCombineView.super.onEnterFinished(self)
end

function JieShenEventClueCombineView:onEnter()
	JieShenEventClueCombineView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.JieShenEvnetComfirmClue, self._onComfirmClue, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._selectIdx = checknumber(params[2])

	if self._selectIdx == 0 then
		self._selectIdx = 1
	end

	self._selectClueIds = {}

	self.addGEvent(self, GlobalNotify.PM_JieShenEvnetComboClueRes, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.PM_JieShenEvnetComboClueRes, self._onShowFormula, self)
	self:_initView()
end

function JieShenEventClueCombineView:_initView()
	self:_refreshUI()
	self:_onClickTopTap(self._selectIdx)
end

function JieShenEventClueCombineView:_refreshUI()
	local tabCfgs = JieShenEventConfig.instance:getClueTabCfgs(self._activityId)

	self._tabScrollList:reloadData(tabCfgs)

	local list = JieShenEventModel.instance:getGainClueList(self._activityId)

	self._clueIdsMap = {}

	for i, v in ipairs(list) do
		self._clueIdsMap[v] = true
	end

	local clues = JieShenEventConfig.instance:getClueCfgsByTab(self._activityId, self._selectIdx) or {}

	self._scrollList:reloadData(clues)
end

function JieShenEventClueCombineView:_onShowFormula(status)
	self._selectClueIds = {}

	self:_refreshDown()
end

function JieShenEventClueCombineView:_onClickTopTap(index)
	self._selectIdx = index

	self:_refreshDown()
	self:_refreshUI()
end

function JieShenEventClueCombineView:_onClickDown(idx)
	table.remove(self._selectClueIds, idx)
	self:_refreshDown()
end

function JieShenEventClueCombineView:_refreshDown()
	for i, v in ipairs(self._downGoList) do
		local txt = goutil.findChildTextComponent(v, "txt")
		local img = goutil.findChild(v, "img")
		local clueId = self._selectClueIds[i]

		if clueId then
			local cfg = JieShenEventConfig.instance:getClueCfg(self._activityId, clueId) or {}

			txt.text = cfg.name

			GameUtil.SetActive(img, true)
		else
			txt.text = ""

			GameUtil.SetActive(img, false)
		end
	end

	GameUtil.SetGray(self._btnEnter, #self._selectClueIds == 0)
end

function JieShenEventClueCombineView:_checkCombo(selectClueIds)
	local targetClueId = 0
	local comboMap

	for i, clueId in ipairs(selectClueIds) do
		local selectCombineList = JieShenEventConfig.instance:getClueComboInfo(self._activityId, clueId)

		if not selectCombineList then
			return 0
		end

		if not comboMap then
			comboMap = {}

			for comboId, v in pairs(selectCombineList) do
				comboMap[comboId] = true
			end
		else
			local newComboMap = {}
			local hasCombine = false

			for comboId, v in pairs(selectCombineList) do
				if comboMap[comboId] == true then
					newComboMap[comboId] = true
					hasCombine = true
				end
			end

			if not hasCombine then
				return 0
			else
				comboMap = newComboMap
			end
		end
	end

	for clueId, v in pairs(comboMap) do
		local clueCfg = JieShenEventConfig.instance:getClueCfg(self._activityId, clueId)

		if clueCfg.clueIds and #clueCfg.clueIds == #selectClueIds then
			targetClueId = clueId
		end
	end

	return targetClueId
end

function JieShenEventClueCombineView:_onClickEnter()
	if #self._selectClueIds > 0 then
		local targetClueId = self:_checkCombo(self._selectClueIds)

		if targetClueId == 0 then
			FloatWordMgr.instance:show(lang("没有可关联的新线索"))
		elseif JieShenEventModel.instance:isGainClue(self._activityId, targetClueId) then
			FloatWordMgr.instance:show(lang("该线索已探明"))
		else
			JieShenEventAgent.instance:sendPM_JieShenEvnetComboClueReq(self._activityId, targetClueId)
		end
	end
end

function JieShenEventClueCombineView:_onClickTip()
	TipsFacade.instance:openRulesView("jie_shen_event_rule")
end

function JieShenEventClueCombineView:_updateCell(view, cell, data, tag)
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

function JieShenEventClueCombineView:_clearCell(cell)
	return
end

function JieShenEventClueCombineView:_updateTabCell(view, cell, data, tag)
	local go = cell.gameObject
	local uiChangeGroup = go:GetComponent(ComponentType.UIChangeGroup)
	local txtName = goutil.findChildTextComponent(go, "txtName")

	if data.tabId == self._selectIdx then
		uiChangeGroup:SetState(1)
	else
		uiChangeGroup:SetState(0)
	end

	txtName.text = data.title

	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, GameUtil.handler(self._onClickTopTap, self, data.tabId))
end

function JieShenEventClueCombineView:_clearTabCell(cell)
	GameUtil.rmClickHandler(go)
end

function JieShenEventClueCombineView:_onClickClue(data)
	if not self._clueIdsMap[data.clueId] then
		TipsFacade.instance:openCommonTips("还没获得此线索")

		return
	end

	UIStateManager.instance:push(ViewName.JieShenEventClueImportView, self._activityId, data.clueId)
end

function JieShenEventClueCombineView:_onComfirmClue(clueId)
	if #self._selectClueIds < #self._downGoList then
		if table.indexof(self._selectClueIds, clueId) == false then
			table.insert(self._selectClueIds, clueId)
			self:_refreshDown()
		end
	else
		TipsFacade.instance:openCommonTips("无法填入")
	end
end

return JieShenEventClueCombineView
