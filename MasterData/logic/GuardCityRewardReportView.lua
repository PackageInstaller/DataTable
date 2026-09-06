-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityRewardReportView.lua

module("logic.extensions.guardcity.view.GuardCityRewardReportView", package.seeall)

local GuardCityRewardReportView = class("GuardCityRewardReportView", ViewComponent)

function GuardCityRewardReportView:ctor()
	GuardCityRewardReportView.super.ctor(self)
end

function GuardCityRewardReportView:buildUI()
	GuardCityRewardReportView.super.buildUI(self)

	self._tableView = self:getGo("reportCol/tableview")
	self._tableCell = self:getGo("reportCol/reportCell")
	self._emptyGo = self:getGo("reportCol/empty")
end

function GuardCityRewardReportView:bindEvents()
	GuardCityRewardReportView.super.buildUI(self)
end

function GuardCityRewardReportView:unbindEvents()
	GuardCityRewardReportView.super.unbindEvents(self)
end

function GuardCityRewardReportView:onEnter()
	GuardCityRewardReportView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityGetReportInfoRes, self._refreshView, self)

	self._tabScroll = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._activityId = self:getFirstParam()
	self._actCfg = GuardCityConfig.instance:getActivityCfg(self._activityId)

	self:_refreshView()
	GuardCityAgent.instance:sendPM_GuardCityGetReportInfoReq(self._activityId)
end

function GuardCityRewardReportView:onExit()
	GuardCityRewardReportView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityGetReportInfoRes, self._refreshView, self)
	self._tabScroll:dispose()
end

function GuardCityRewardReportView:_refreshView()
	local list = GuardCiytModel.instance:getReportInfo()

	self._tabScroll:reloadData(list)
	GameUtil.SetActive(self._emptyGo, #list <= 0)
end

function GuardCityRewardReportView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "head")
	local btn = GameUtil.asBtn(goutil.findChild(go, "btnDetail"))
	local txtMvpName = goutil.findChildTextComponent(go, "txtMvpName")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtDiscover = goutil.findChildTextComponent(go, "desc/txtDiscover")
	local txtMonsterName = goutil.findChildTextComponent(go, "desc/txtName")
	local txtLevel = goutil.findChildTextComponent(go, "level/txtLevel")
	local txtTime = goutil.findChildTextComponent(go, "desc/txtTime")

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self:_onClickDetail(data)
	end)

	txtMvpName.text = data.mvpPlayerInfo.headInfo.userName
	txtName.text = data.defeatPlayer.headInfo.userName

	local time = GameUtil.time2date(checknumber(data.time) / 1000)

	txtTime.text = string.format("%d.%d %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.day)

	local monsterCfg = GuardCityConfig.instance:getMonsterCfg(self._actCfg.masterPlanId, data.creepsMasterId)

	uGuiUtil.setSpriteToImage(imgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(monsterCfg.headIcon))

	txtLevel.text = monsterCfg.star
	txtMonsterName.text = langPara("%s", monsterCfg.name)
	txtDiscover.text = RoleModel.instance:getUserName()
end

function GuardCityRewardReportView:_clearCell(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "head")
	local btn = GameUtil.asBtn(goutil.findChild(go, "btnDetail"))

	uGuiUtil.clearImage(imgIcon)
	btn:RemoveClickListener()
end

function GuardCityRewardReportView:_onClickDetail(reportData)
	UIStateManager.instance:push(ViewName.GuardCityReportDetailView, self._activityId, reportData)
end

function GuardCityRewardReportView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return GuardCityRewardReportView
