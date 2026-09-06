-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupSelectTeamView.lua

module("logic.extensions.worldcup.view.WorldCupSelectTeamView", package.seeall)

local WorldCupSelectTeamView = class("WorldCupSelectTeamView", ViewComponent)

function WorldCupSelectTeamView:ctor()
	WorldCupSelectTeamView.super.ctor(self)
end

function WorldCupSelectTeamView:unbindEvents()
	WorldCupSelectTeamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function WorldCupSelectTeamView:bindEvents()
	WorldCupSelectTeamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function WorldCupSelectTeamView:buildUI()
	WorldCupSelectTeamView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
end

function WorldCupSelectTeamView:onExit()
	WorldCupSelectTeamView.super.onExit(self)

	self._selectMap = {}
end

function WorldCupSelectTeamView:onEnter()
	WorldCupSelectTeamView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._selectRank = checknumber(params[2])
	self._targetMap = params[3]
	self._selectMap = {}

	for k, v in pairs(self._targetMap) do
		self._selectMap[k] = v
	end

	self:calcTeamInfo()
	self:_refreshView()
end

function WorldCupSelectTeamView:calcTeamInfo()
	self._teamInfoList = {}

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

	for i, checkGroupList in ipairs(groupShowList) do
		for j, chcekTeamInfo in ipairs(checkGroupList.teamList) do
			table.insert(self._teamInfoList, {
				groupName = checkGroupList.groupName,
				teamId = chcekTeamInfo.teamId,
				groupRank = chcekTeamInfo.rank
			})
		end
	end
end

function WorldCupSelectTeamView:_refreshView()
	self._tableList:reloadData(self._teamInfoList)
end

function WorldCupSelectTeamView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local txtName = goutil.findChildTextComponent(go, "name/txtName")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imageChangeRank = goutil.findChildComponent(go, "imgRank", ComponentType.UIImageSpriteChange)
	local teamCfg = WorldCupConfig.instance:getTeamCfg(self._activityId, data.teamId)

	uGuiUtil.setSpriteToImage(icon, nil, GameUrl.getShiJieBeiJingCaiIconUrl(teamCfg.res))

	txtName.text = WorldCupController.instance:getTeamName(teamCfg)
	txtRank.text = langPara("%s小组 第%s名", data.groupName, data.groupRank)

	local curRank = 0

	for index, v in pairs(self._selectMap) do
		if v == data.teamId then
			curRank = index
		end
	end

	GameUtil.SetActive(imageChangeRank, curRank > 0)

	if curRank > 0 then
		imageChangeRank:SetState(curRank - 1)
	end

	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickTeam(data.teamId)
	end)
end

function WorldCupSelectTeamView:_clearCell(cell)
	local go = cell
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(go)
end

function WorldCupSelectTeamView:_onClickTeam(teamId)
	local beforeRank = 0

	for index, v in pairs(self._selectMap) do
		if v == teamId then
			beforeRank = index
		end
	end

	if checknumber(beforeRank) > 0 and beforeRank ~= self._selectRank then
		local content = ""

		if beforeRank == 1 then
			content = lang("该球队已选择为冠军，是否替换？")
		elseif beforeRank == 2 then
			content = lang("该球队已选择为亚军，是否替换？")
		elseif beforeRank == 3 then
			content = lang("该球队已选择为季军，是否替换？")
		end

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			self._selectMap[beforeRank] = nil
			self._selectMap[self._selectRank] = teamId

			self:_refreshView()
		end)
	else
		self._selectMap[self._selectRank] = teamId

		self:_refreshView()
	end
end

function WorldCupSelectTeamView:_onClickSure()
	table.clear(self._targetMap)

	for k, v in pairs(self._selectMap) do
		self._targetMap[k] = v
	end

	GlobalDispatcher:dispatch(GlobalNotify.WorldCupTopThreeSelect, self._selectMap)
	self:close()
end

return WorldCupSelectTeamView
