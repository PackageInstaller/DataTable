-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilRewardReportView.lua

module("logic.extensions.destroyevil.view.DestroyEvilRewardReportView", package.seeall)

local DestroyEvilRewardReportView = class("DestroyEvilRewardReportView", ViewComponent)

function DestroyEvilRewardReportView:buildUI()
	DestroyEvilRewardReportView.super.buildUI(self)

	self._tableView = self:getGo("reportCol/tableview")
	self._tableCell = self:getGo("reportCol/reportCell")
	self._emptyGo = self:getGo("reportCol/empty")
end

function DestroyEvilRewardReportView:bindEvents()
	DestroyEvilRewardReportView.super.buildUI(self)
end

function DestroyEvilRewardReportView:unbindEvents()
	DestroyEvilRewardReportView.super.unbindEvents(self)
end

function DestroyEvilRewardReportView:onEnter()
	DestroyEvilRewardReportView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DestroyEvilGetReportInfoRes, self._refreshView, self)

	self._tabScroll = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._activityId = self:getFirstParam()
	self._actCfg = DestroyEvilConfig.instance:getActivityCfg(self._activityId)

	self:_refreshView()
	DestroyEvilAgent.instance:sendPM_DestroyEvilGetReportInfoReq(self._activityId)
end

function DestroyEvilRewardReportView:onExit()
	DestroyEvilRewardReportView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DestroyEvilGetReportInfoRes, self._refreshView, self)
	self._tabScroll:dispose()
end

function DestroyEvilRewardReportView:_refreshView()
	local list = DestroyEvilModel.instance:getReportInfo()

	self._tabScroll:reloadData(list)
	GameUtil.SetActive(self._emptyGo, #list <= 0)
end

function DestroyEvilRewardReportView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "head")
	local btn = GameUtil.asBtn(goutil.findChild(go, "btnDetail"))
	local txtMvpName = goutil.findChildTextComponent(go, "txtMvpName")
	local txtName = goutil.findChildTextComponent(go, "desc/txtName")
	local txtDiscover = goutil.findChildTextComponent(go, "desc/txtDiscover")
	local txtMonsterName = goutil.findChildTextComponent(go, "txtName")
	local txtLevel = goutil.findChildTextComponent(go, "lv/txtLv")
	local txtTime = goutil.findChildTextComponent(go, "desc/txtTime")
	local txtStar = goutil.findChildTextComponent(go, "star/txtStar")

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self:_onClickDetail(data)
	end)

	local time = GameUtil.time2date(checknumber(data.time) / 1000)

	txtTime.text = string.format("%d.%d %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.day)

	local cfgMonster = DestroyEvilConfig.instance:getMonsterCfg(self._activityId, data.monsterId)

	txtLevel.text = "Lv." .. cfgMonster.level
	txtStar.text = cfgMonster.star

	local cfgCreeps = DestroyEvilConfig.instance:getCreeps(cfgMonster.creepsMasterId)
	local targetPosId = cfgCreeps[1].posId
	local cfgTarget = cfgCreeps[1]

	for i, v in ipairs(cfgCreeps) do
		if targetPosId > v.posId then
			targetPosId = v.posId
			cfgTarget = v
		end
	end

	MaterialMgr.setIcon(imgIcon, MatType.Pet, cfgTarget.raceId)

	txtMvpName.text = data.mvpPlayerInfo.headInfo.userName
	txtName.text = data.defeatPlayer.headInfo.userName
	txtMonsterName.text = DestroyEvilController.instance:getMonsterName(self._activityId, data.monsterId)
	txtDiscover.text = RoleModel.instance:getUserName()
end

function DestroyEvilRewardReportView:_clearCell(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "head")
	local btn = GameUtil.asBtn(goutil.findChild(go, "btnDetail"))

	uGuiUtil.clearImage(imgIcon)
	btn:RemoveClickListener()
end

function DestroyEvilRewardReportView:_onClickDetail(reportData)
	UIStateManager.instance:push(ViewName.DestroyEvilReportDetailView, self._activityId, reportData)
end

function DestroyEvilRewardReportView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return DestroyEvilRewardReportView
