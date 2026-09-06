-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupGroupInfoView.lua

module("logic.extensions.worldcup.view.WorldCupGroupInfoView", package.seeall)

local WorldCupGroupInfoView = class("WorldCupGroupInfoView", ViewComponent)

function WorldCupGroupInfoView:ctor()
	WorldCupGroupInfoView.super.ctor(self)
end

function WorldCupGroupInfoView:unbindEvents()
	WorldCupGroupInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.addClickHandler(self._btnFilter)
	GameUtil.addClickHandler(self._btnFilterClose)
end

function WorldCupGroupInfoView:bindEvents()
	WorldCupGroupInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnFilterClose, self._onClickFilterClose, self)
end

function WorldCupGroupInfoView:buildUI()
	WorldCupGroupInfoView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._teamTablecell = self:getGo("teamTablecell")
	self._groupTablecell = self:getGo("groupTableview/groupTablecell")
	self._groupTableview = self:getGo("groupTableview")
	self._groupTableList = ScrollerList.create(self._groupTableview, self._groupTablecell, GameUtil.handler(self._updateGroupCell, self), GameUtil.handler(self._clearGroupCell, self))
	self._btnFilter = self:getGo("btnFilter")
	self._btnFilterClose = self:getGo("btnFilterClose")
	self._content = self:getGo("content")
	self._filterTablecell = self:getGo("content/filterTableview/filterTablecell")
	self._filterTableview = self:getGo("content/filterTableview")
	self._filerList = ScrollerList.create(self._filterTableview, self._filterTablecell, GameUtil.handler(self._updateFilterCell, self), GameUtil.handler(self._clearFilterCell, self))
end

function WorldCupGroupInfoView:onExit()
	WorldCupGroupInfoView.super.onExit(self)
	self._groupTableList:dispose()
end

function WorldCupGroupInfoView:onEnter()
	WorldCupGroupInfoView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._teamTableDir = {}

	GameUtil.SetActive(self._content, false)
	GameUtil.SetActive(self._btnFilterClose, false)
	self:_refreshView()
end

function WorldCupGroupInfoView:_refreshView()
	local groupMap = {}
	local groupInfo = WorldCupModel.instance:getGroupInfo()

	for teamId, groupName in pairs(groupInfo) do
		groupMap[groupName] = groupMap[groupName] or {}

		local info = WorldCupModel.instance:getGroupMatchInfo(self._activityId, teamId)

		table.insert(groupMap[groupName], {
			index = 0,
			teamId = teamId,
			teamInfo = info,
			rank = info and info.position
		})
	end

	local groupList = {}
	local groupShowList = {}

	for groupName, list in pairs(groupMap) do
		table.sort(list, function(a, b)
			if a.teamInfo and b.teamInfo and a.teamInfo.position ~= b.teamInfo.position then
				return a.teamInfo.position < b.teamInfo.position
			else
				return a.teamId < b.teamId
			end
		end)

		for i, v in ipairs(list) do
			v.index = i
			v.rank = i
		end

		local showGroupInfo = {
			groupName = groupName,
			teamList = list
		}

		table.insert(groupList, showGroupInfo)

		if not self._filterGroupName or self._filterGroupName == groupName then
			table.insert(groupShowList, showGroupInfo)
		end
	end

	table.sort(groupList, function(a, b)
		return a.groupName < b.groupName
	end)
	table.sort(groupShowList, function(a, b)
		return a.groupName < b.groupName
	end)
	self._groupTableList:reloadData(groupShowList)

	local filterList = {}

	table.insert(filterList, 0)

	for i, v in ipairs(groupList) do
		table.insert(filterList, v.groupName)
	end

	self._filerList:reloadData(filterList)
end

function WorldCupGroupInfoView:_updateGroupCell(view, cell, data, tag)
	local go = cell.gameObject
	local teamTableView = goutil.findChild(go, "teamTableview")
	local txtGroupName = goutil.findChildTextComponent(go, "txtName")

	txtGroupName.text = langPara("%s组", data.groupName)

	local teamTableList = self._teamTableDir[go]

	if not teamTableList then
		teamTableList = ScrollerList.create(teamTableView, self._teamTablecell, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))

		teamTableList:dragNotifyParent()

		self._teamTableDir[go] = teamTableList
	end

	teamTableList:reloadData(data.teamList)
end

function WorldCupGroupInfoView:_clearGroupCell(cell)
	local go = cell.gameObject

	if self._teamTableDir[go] then
		self._teamTableDir[go]:dispose()

		self._teamTableDir[go] = nil
	end
end

function WorldCupGroupInfoView:_updateTeamCell(view, cell, data, tag)
	local go = cell.gameObject
	local bg = goutil.findChild(go, "bg")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local txtMatchCount = goutil.findChildTextComponent(go, "txtMatchCount")
	local txtWin = goutil.findChildTextComponent(go, "txtWin")
	local txtDraw = goutil.findChildTextComponent(go, "txtDraw")
	local txtLose = goutil.findChildTextComponent(go, "txtLose")
	local txtGoal = goutil.findChildTextComponent(go, "txtGoal")
	local txtFumble = goutil.findChildTextComponent(go, "txtFumble")
	local txtGoalDifference = goutil.findChildTextComponent(go, "txtGoalDifference")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local icon = goutil.findChild(go, "icon")

	GameUtil.SetActive(bg, data.index % 2 == 1)

	local teamCfg = WorldCupConfig.instance:getTeamCfg(self._activityId, data.teamId)

	txtName.text = WorldCupController.instance:getTeamName(teamCfg)

	uGuiUtil.setSpriteToImage(icon, nil, GameUrl.getShiJieBeiJingCaiIconUrl(teamCfg.res))

	if data.teamInfo then
		txtRank.text = data.rank
		txtMatchCount.text = data.teamInfo.playedGames
		txtWin.text = data.teamInfo.won
		txtDraw.text = data.teamInfo.draw
		txtLose.text = data.teamInfo.lost
		txtGoal.text = data.teamInfo.goalsFor
		txtFumble.text = data.teamInfo.goalsAgainst
		txtGoalDifference.text = data.teamInfo.goalsFor - data.teamInfo.goalsAgainst
		txtScore.text = data.teamInfo.points
	else
		txtRank.text = 1
		txtMatchCount.text = 0
		txtWin.text = 0
		txtDraw.text = 0
		txtLose.text = 0
		txtGoal.text = 0
		txtFumble.text = 0
		txtGoalDifference.text = 0
		txtScore.text = 0
	end
end

function WorldCupGroupInfoView:_clearTeamCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)
end

function WorldCupGroupInfoView:_updateFilterCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txt")
	local txtMarkName = goutil.findChildTextComponent(go, "Mark/txt")
	local markGo = goutil.findChild(go, "Mark")

	if data == 0 then
		GameUtil.SetActive(markGo, self._filterGroupName == nil)

		txtName.text = lang("全部")
		txtMarkName.text = lang("全部")
	else
		GameUtil.SetActive(markGo, self._filterGroupName == data)

		txtName.text = langPara("%s组", data)
		txtMarkName.text = langPara("%s组", data)
	end

	GameUtil.addClickHandler(go, function()
		self:_onClickFilterType(data)
	end)
end

function WorldCupGroupInfoView:_clearFilterCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function WorldCupGroupInfoView:_onClickFilterType(groupName)
	if groupName == 0 then
		self._filterGroupName = nil
	else
		self._filterGroupName = groupName
	end

	self:_refreshView()
end

function WorldCupGroupInfoView:_onClickFilter()
	GameUtil.SetActive(self._btnFilterClose, true)
	GameUtil.SetActive(self._content, true)
end

function WorldCupGroupInfoView:_onClickFilterClose()
	GameUtil.SetActive(self._btnFilterClose, false)
	GameUtil.SetActive(self._content, false)
end

return WorldCupGroupInfoView
