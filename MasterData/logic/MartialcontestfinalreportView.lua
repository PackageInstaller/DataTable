-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalreportView.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalreportView", package.seeall)

local MartialcontestfinalreportView = class("MartialcontestfinalreportView", ViewComponent)

function MartialcontestfinalreportView:ctor()
	MartialcontestfinalreportView.super.ctor(self)
end

function MartialcontestfinalreportView:unbindEvents()
	MartialcontestfinalreportView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	self._btnFliter:RemoveClickListener()
	self._customInput:RemoveListener()
end

function MartialcontestfinalreportView:bindEvents()
	MartialcontestfinalreportView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	self._btnFliter:AddClickListener(self._onClickbtnFliter, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function MartialcontestfinalreportView:buildUI()
	MartialcontestfinalreportView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getGo("btnClose")
	self._goEmpty = self:getGo("noReport")
	self._fliterpanelGo = self:getGo("fliterpanel")
	self._cellconGo = self:getGo("fliterpanel/bg")
	self._txtFilterName = self:getTxt("btnFliter/text")
	self._customInput = UICustomInput.Get(self._cellconGo)

	goutil.setActive(self._fliterpanelGo, false)

	self._btnFliter = self:getBtn("btnFliter")
	self._filterType = -1
	self._tableviewGoFilter = self:getGo("fliterpanel/bg/tableview")
	self._tablecellGoFilter = self:getGo("fliterpanel/bg/tablecell")
	self._scrollerListFilter = ScrollerList.create(self._tableviewGoFilter, self._tablecellGoFilter, GameUtil.handler(self._updateFilterCell, self), GameUtil.handler(self._clearFilterCell, self))
	self._tabtableviewGo = self:getGo("tabtableview")
	self._tabtablecellGo = self:getGo("tabtablecell")
	self._scrollerListTab = ScrollerList.create(self._tabtableviewGo, self._tabtablecellGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function MartialcontestfinalreportView:onExit()
	MartialcontestfinalreportView.super.onExit(self)
	self:_setFilterPanelOpen(false)
	self._scrollerListFilter:dispose()
	self._tableList:dispose()
	self._scrollerListTab:dispose()
end

function MartialcontestfinalreportView:onEnter()
	MartialcontestfinalreportView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.MCFinalsInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._filterType = -1
	self._selectRoundId = 0

	self:_setFilterPanelOpen(false)
	self:_refreshView()
	MartialContestAgent.instance:sendPM_MCFinalsInfoReq(self._activityId)
end

function MartialcontestfinalreportView:_refreshView()
	local info = MartialContestModel.instance:getFinalsInfo()

	if not info then
		return
	end

	self:_cachePlayerInfos(info)
	self:_createAndRefreshTabData(info)
	self:_refreshFilterName()
end

function MartialcontestfinalreportView:_cachePlayerInfos(info)
	self._userId2PlayerInfo = {}

	for i, v in ipairs(info.allPlayers or {}) do
		self._userId2PlayerInfo[v.headInfo.headInfo.userId] = v
	end
end

function MartialcontestfinalreportView:_createAndRefreshTabData(info)
	self._tabDatas = {}

	local tabDatasMap = {
		[3] = {
			roundId = 3,
			results = {}
		},
		[4] = {
			roundId = 4,
			results = {}
		},
		[5] = {
			roundId = 5,
			results = {}
		}
	}

	for k, v in pairs(tabDatasMap) do
		table.insert(self._tabDatas, v)
	end

	for i, v in ipairs(info.results or {}) do
		local stepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, v.stepId)
		local tabData = tabDatasMap[stepCfg.roundId]

		table.insert(tabData.results, v)
	end

	table.sort(self._tabDatas, function(a, b)
		return a.roundId < b.roundId
	end)
	self._scrollerListTab:reloadData(self._tabDatas)

	if not tabDatasMap[self._selectRoundId] and #self._tabDatas > 0 then
		self._selectRoundId = self._tabDatas[1].roundId
	end

	self:_onClickTabCell(self._selectRoundId)
end

function MartialcontestfinalreportView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgResult = goutil.findChildComponent(go, "imgResult", typeof(UIImageSpriteChange))
	local left = goutil.findChild(go, "left")
	local right = goutil.findChild(go, "right")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local btnDetail = Framework.ButtonAdapter.GetFrom(go, "btnDetail")
	local leftInfo = self._userId2PlayerInfo[data.playerUserIdA]
	local rightInfo = self._userId2PlayerInfo[data.playerUserIdB]

	self:_updatePlayer(left, leftInfo)
	self:_updatePlayer(right, rightInfo)

	local stepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, data.stepId)
	local date = GameUtil.string2date(stepCfg.startTime)

	txtTime.text = string.format("%02d月%02d日  %02d:%02d", date.month, date.day, date.hour, date.min)

	btnDetail:AddClickListener(function()
		self:_onClickDetail(data)
	end)

	local stete = data.isTeamAWin and 0 or 1

	imgResult:SetState(stete)
end

function MartialcontestfinalreportView:_updatePlayer(go, data)
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local pointHead = goutil.findChild(go, "head")
	local headInfo = data.headInfo.headInfo

	txtName.text = headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(pointHead, headInfo)

	txtRank.text = data.headInfo.zdl
end

function MartialcontestfinalreportView:_clearCell(cell)
	local go = cell.gameObject
	local btnDetail = goutil.findChild(go, "btnDetail")
	local leftHeadInfoGo = goutil.findChild(go, "leftHeadInfo")
	local rightHeadInfoGo = goutil.findChild(go, "rightHeadInfo")

	HeadItemController.instance:resetHeadCell(leftHeadInfoGo)
	HeadItemController.instance:resetHeadCell(rightHeadInfoGo)
	GameUtil.rmClickHandler(btnDetail)
end

function MartialcontestfinalreportView:_onClickDetail(data)
	UIStateManager.instance:push(ViewName.MartialcontestfinalreportdetailView, self._activityId, data.stepId, data.groupId)
end

function MartialcontestfinalreportView:_onClickbtnFliter()
	if not self._recordResults or #self._recordResults <= 0 then
		FloatWordMgr.instance:show("暂无挑战记录")

		return
	end

	self:_setFilterPanelOpen(true)
end

function MartialcontestfinalreportView:_onCustomInputCallback(hover)
	if not hover then
		self:_setFilterPanelOpen(false)
	end
end

function MartialcontestfinalreportView:_setFilterPanelOpen(isOpen)
	GameUtil.SetActive(self._fliterpanelGo, isOpen)
end

function MartialcontestfinalreportView:_buildFilterCells()
	self._recordResults = {}

	local recordResultsMap = {}

	for i, v in ipairs(self._tabDatas) do
		if self._selectRoundId == v.roundId then
			for j, result in ipairs(v.results) do
				local resultData = recordResultsMap[result.stepId]

				if not resultData then
					resultData = {
						stepId = result.stepId,
						results = {}
					}
					recordResultsMap[result.stepId] = resultData

					table.insert(self._recordResults, resultData)
				end

				table.insert(resultData.results, result)
			end

			break
		end
	end

	table.sort(self._recordResults, function(a, b)
		return a.stepId > b.stepId
	end)

	self._filterType = -1

	if #self._recordResults > 0 then
		self._filterType = self._recordResults[1].stepId
	end

	self._scrollerListFilter:reloadData(self._recordResults)
end

function MartialcontestfinalreportView:_refreshDataByFilter()
	local resultList = {}

	for i, v in ipairs(self._recordResults or {}) do
		if v.stepId == self._filterType then
			resultList = v.results

			break
		end
	end

	self._tableList:reloadData(resultList)
	GameUtil.SetActive(self._goEmpty, not resultList or #resultList <= 0)
end

function MartialcontestfinalreportView:_refreshFilterName()
	if self._filterType ~= -1 then
		local stepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, self._filterType)

		self._txtFilterName.text = MartialContestController.instance:getFinalRoundDescByRoundId(self._activityId, stepCfg.stepId, stepCfg.roundId)
	else
		self._txtFilterName.text = "暂无"
	end
end

function MartialcontestfinalreportView:_updateFilterCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local btn = GameUtil.asBtn(cell)
	local stepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, data.stepId)

	txtName.text = MartialContestController.instance:getFinalRoundDescByRoundId(self._activityId, data.stepId, stepCfg.roundId)

	btn:AddClickListener(function()
		self:_onClickFilterCell(data.stepId)
	end)
end

function MartialcontestfinalreportView:_onClickFilterCell(stepId)
	self._filterType = stepId

	self:_refreshFilterName()
	self:_setFilterPanelOpen(false)
	self:_refreshDataByFilter()
end

function MartialcontestfinalreportView:_clearFilterCell(cell)
	return
end

function MartialcontestfinalreportView:_updateTabCell(view, cell, data, tag)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txt")
	local change = cell.gameObject:GetComponent(ComponentType.UIChangeGroup)
	local roundId = data.roundId
	local roundCfg = MartialContestConfig.instance:getRoundCfg(self._activityId, roundId)

	if roundCfg.roundType == "FINALS_COMMON" then
		txtDesc.text = "第一场"
	elseif roundCfg.roundType == "FINALS_3V3" then
		txtDesc.text = "第二场"
	elseif roundCfg.roundType == "FINALS_BUFF" then
		txtDesc.text = "第三场"
	end

	change:SetState(self._selectRoundId == data.roundId and 0 or 1)
	btn:AddClickListener(function()
		self:_onClickTabCell(data.roundId)
	end)
end

function MartialcontestfinalreportView:_clearTabCell(cell)
	return
end

function MartialcontestfinalreportView:_onClickTabCell(roundId)
	self._selectRoundId = roundId

	self:_buildFilterCells()
	self:_refreshDataByFilter()
	self:_refreshFilterName()
	self._scrollerListTab:refresh()
end

return MartialcontestfinalreportView
