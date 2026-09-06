-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupAllMatchView.lua

module("logic.extensions.worldcup.view.WorldCupAllMatchView", package.seeall)

local WorldCupAllMatchView = class("WorldCupAllMatchView", ViewComponent)
local RACE_STATE_WAIT = 0
local RACE_STATE_PLAY = 1
local RACE_STATE_END = 2
local GROUP_STAGE = 1
local CELL_TYPE_TITLE = 1
local CELL_TYPE_MATCH = 2

function WorldCupAllMatchView:ctor()
	WorldCupAllMatchView.super.ctor(self)
end

function WorldCupAllMatchView:unbindEvents()
	WorldCupAllMatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.addClickHandler(self._btnFilter)
	GameUtil.addClickHandler(self._btnFilterClose)
end

function WorldCupAllMatchView:bindEvents()
	WorldCupAllMatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnFilterClose, self._onClickFilterClose, self)
end

function WorldCupAllMatchView:buildUI()
	WorldCupAllMatchView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._matchTableview = self:getGo("matchTableview")
	self._tablecell_1 = self:getGo("matchTableview/tablecell_1")
	self._tablecell_2 = self:getGo("matchTableview/tablecell_2")
	self._matchTableList = ScrollerList.create(self._matchTableview, {
		self._tablecell_1,
		self._tablecell_2
	}, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._matchTableList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._matchTableList:regGetCellSize(GameUtil.handler(self._getCellSize, self))

	self._btnFilter = self:getGo("btnFilter")
	self._btnFilterClose = self:getGo("btnFilterClose")
	self._content = self:getGo("content")
	self._filterTablecell = self:getGo("content/filterTableview/filterTablecell")
	self._filterTableview = self:getGo("content/filterTableview")
	self._filerList = ScrollerList.create(self._filterTableview, self._filterTablecell, GameUtil.handler(self._updateFilterCell, self), GameUtil.handler(self._clearFilterCell, self))
end

function WorldCupAllMatchView:onExit()
	WorldCupAllMatchView.super.onExit(self)
end

function WorldCupAllMatchView:onEnter()
	WorldCupAllMatchView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	GameUtil.SetActive(self._btnFilterClose, false)
	GameUtil.SetActive(self._content, false)
	self:_refreshView()
end

function WorldCupAllMatchView:_refreshView()
	local matchList = WorldCupModel.instance:getMatchList(self._activityId)
	local list = {}

	for i, v in ipairs(matchList) do
		table.insert(list, v)
	end

	list = ArraySort.sortOn(list, {
		"stageId",
		function(info)
			return checknumber(info.startTime)
		end,
		"matchId"
	})
	self._resultList = {}

	local month, day = 0, 0
	local stageId = 0
	local curIndex = 0
	local collectData = {}
	local todayDate = GameUtil.time2date(ServerTime.now())

	for i, v in ipairs(list) do
		if not self._filterStageId or self._filterStageId == v.stageId then
			local startTimeDate = GameUtil.time2date(checknumber(v.startTime) / 1000)

			if month ~= startTimeDate.month or day ~= startTimeDate.day or stageId ~= v.stageId then
				if #collectData > 0 then
					table.insert(self._resultList, {
						type = CELL_TYPE_MATCH,
						info = collectData
					})

					collectData = {}
				end

				month = startTimeDate.month
				day = startTimeDate.day
				stageId = v.stageId

				table.insert(self._resultList, {
					type = CELL_TYPE_TITLE,
					stageId = v.stageId,
					day = startTimeDate.day,
					month = startTimeDate.month
				})

				if month < todayDate.month or todayDate.month == month and day < todayDate.day then
					curIndex = #self._resultList
				end
			end

			table.insert(collectData, v)

			if #collectData >= 2 then
				table.insert(self._resultList, {
					type = CELL_TYPE_MATCH,
					info = collectData
				})

				collectData = {}
			end
		end
	end

	if #collectData > 0 then
		table.insert(self._resultList, {
			type = CELL_TYPE_MATCH,
			info = collectData
		})
	end

	self._matchTableList:reloadData(self._resultList)

	if curIndex > 0 then
		self._matchTableList:MoveCellToBegin(curIndex - 1)
	else
		self._matchTableList:MoveCellToBegin(0)
	end

	local stageCfg = WorldCupConfig.instance:getStageCfgs(self._activityId)
	local filterList = {}

	table.insert(filterList, 0)

	for i, v in ipairs(stageCfg) do
		table.insert(filterList, v.stageId)
	end

	self._filerList:reloadData(filterList)
end

function WorldCupAllMatchView:_updateCell(view, cell, data, tag)
	if data.type == CELL_TYPE_TITLE then
		self:_updateTitleCell(view, cell, data, tag)
	elseif data.type == CELL_TYPE_MATCH then
		self:_updateMatchsCell(view, cell, data, tag)
	end
end

function WorldCupAllMatchView:_updateTitleCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local stageCfg = WorldCupConfig.instance:getStageCfg(self._activityId, data.stageId)

	txtName.text = langPara("%s %s月%s日", stageCfg.name, data.month, data.day)
end

function WorldCupAllMatchView:_updateMatchsCell(view, cell, data, tag)
	local go = cell.gameObject
	local content1 = goutil.findChild(go, "content_1")
	local content2 = goutil.findChild(go, "content_2")

	if data.info[1] then
		GameUtil.SetActive(content1, true)
		self:_updateMatchCell(view, content1, data.info[1], tag)
	else
		GameUtil.SetActive(content1, false)
	end

	if data.info[2] then
		GameUtil.SetActive(content2, true)
		self:_updateMatchCell(view, content2, data.info[2], tag)
	else
		GameUtil.SetActive(content2, false)
	end
end

function WorldCupAllMatchView:_updateMatchCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local iconMainTeam = goutil.findChild(go, "iconMainTeam")
	local txtMainTeamName = goutil.findChildTextComponent(go, "txtMainTeamName")
	local txtMainTeamScore = goutil.findChildTextComponent(go, "txtMainTeamScore")
	local iconAwayTeam = goutil.findChild(go, "iconAwayTeam")
	local txtAwayTeamName = goutil.findChildTextComponent(go, "txtAwayTeamName")
	local txtAwayTeamScore = goutil.findChildTextComponent(go, "txtAwayTeamScore")
	local raceStateChange = goutil.findChildComponent(go, "raceState", ComponentType.UIImageSpriteChange)
	local txtRaceState = goutil.findChildTextComponent(go, "raceState/txtRaceState")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local info = data
	local stageCfg = WorldCupConfig.instance:getStageCfg(self._activityId, info.stageId)

	if info.stageId == GROUP_STAGE then
		local groupNameAttr = string.split(info.groupName, "_")

		txtName.text = langPara("%s组", groupNameAttr[2])
	else
		txtName.text = langPara("%s", stageCfg.name)
	end

	local startTime = checknumber(info.startTime) / 1000

	if startTime <= ServerTime.now() then
		if not RACE_STATE_PLAY then
			local raceState = RACE_STATE_WAIT
			local startDate = GameUtil.time2date(startTime)

			txtTime.text = langPara("%02d-%02d\n%02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min)

			local mainTeamCfg = WorldCupConfig.instance:getTeamCfg(self._activityId, info.homeTeamId)

			if mainTeamCfg then
				uGuiUtil.setSpriteToImage(iconMainTeam, nil, GameUrl.getShiJieBeiJingCaiIconUrl(mainTeamCfg.res))

				txtMainTeamName.text = WorldCupController.instance:getTeamName(mainTeamCfg)

				GameUtil.SetActive(iconMainTeam, true)
			else
				uGuiUtil.clearImage(iconMainTeam)
				GameUtil.SetActive(iconMainTeam, false)

				txtMainTeamName.text = lang("待定")
			end

			local awayTeamCfg = WorldCupConfig.instance:getTeamCfg(self._activityId, info.awayTeamId)

			if awayTeamCfg then
				uGuiUtil.setSpriteToImage(iconAwayTeam, nil, GameUrl.getShiJieBeiJingCaiIconUrl(awayTeamCfg.res))

				txtAwayTeamName.text = WorldCupController.instance:getTeamName(awayTeamCfg)

				GameUtil.SetActive(iconAwayTeam, true)
			else
				GameUtil.SetActive(iconAwayTeam, false)
				uGuiUtil.clearImage(iconAwayTeam)

				txtAwayTeamName.text = lang("待定")
			end

			if info.result then
				raceState = RACE_STATE_END
				txtMainTeamScore.text = info.result.fullTimeHome
				txtAwayTeamScore.text = info.result.fullTimeAway
			else
				txtMainTeamScore.text = 0
				txtAwayTeamScore.text = 0
			end

			txtRaceState.text = raceState == RACE_STATE_PLAY and lang("赛中") or raceState == RACE_STATE_WAIT and lang("未赛") or lang("完赛")

			raceStateChange:SetState(raceState)
		end
	end
end

function WorldCupAllMatchView:_clearCell(cell)
	return
end

function WorldCupAllMatchView:_getTagByIdx(data, idx)
	return data.type
end

function WorldCupAllMatchView:_getCellSize(view, index)
	local data = self._resultList[index + 1]

	if data.type == CELL_TYPE_TITLE then
		return 890, 24
	elseif data.type == CELL_TYPE_MATCH then
		return 890, 122
	else
		return 100, 100
	end
end

function WorldCupAllMatchView:_updateFilterCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txt")
	local txtMarkName = goutil.findChildTextComponent(go, "Mark/txt")
	local markGo = goutil.findChild(go, "Mark")

	if data == 0 then
		GameUtil.SetActive(markGo, self._filterStageId == nil)

		txtName.text = lang("全部")
		txtMarkName.text = lang("全部")
	else
		local stageCfg = WorldCupConfig.instance:getStageCfg(self._activityId, data)

		GameUtil.SetActive(markGo, self._filterStageId == data)

		txtName.text = stageCfg.name
		txtMarkName.text = stageCfg.name
	end

	GameUtil.addClickHandler(go, function()
		self:_onClickFilterType(data)
	end)
end

function WorldCupAllMatchView:_clearFilterCell(cell)
	return
end

function WorldCupAllMatchView:_onClickFilter()
	GameUtil.SetActive(self._btnFilterClose, true)
	GameUtil.SetActive(self._content, true)
end

function WorldCupAllMatchView:_onClickFilterClose()
	GameUtil.SetActive(self._btnFilterClose, false)
	GameUtil.SetActive(self._content, false)
end

function WorldCupAllMatchView:_onClickFilterType(stageId)
	if stageId == 0 then
		self._filterStageId = nil
	else
		self._filterStageId = stageId
	end

	self:_refreshView()
end

return WorldCupAllMatchView
