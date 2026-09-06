-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownRankView.lua

module("logic.extensions.showdown.view.ShowDownRankView", package.seeall)

local ShowDownRankView = class("ShowDownRankView", ViewComponent)

function ShowDownRankView:ctor()
	ShowDownRankView.super.ctor(self)
end

function ShowDownRankView:unbindEvents()
	ShowDownRankView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ShowDownRankView:bindEvents()
	ShowDownRankView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function ShowDownRankView:buildUI()
	ShowDownRankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._empty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._tip = self:getGo("right/myRank/tip")
	self._txtTip = self:getTxt("right/myRank/tip/txt")

	local cellGo = self:getGo("right/rankCell")
	local tableviewGo = self:getGo("right/rankListView")

	self._tableView = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function ShowDownRankView:onExit()
	ShowDownRankView.super.onExit(self)
	self._tableView:dispose()
end

function ShowDownRankView:onEnter()
	ShowDownRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._qualType = params[2]
	self._activityType = ShowDownController.instance:getActivityType()

	ShowDownController.instance:sendPM_ShowDownQualify_GetQualifyRankReq(self._activityId, self._qualType)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownQualify_GetQualifyRankRes, self._updateRankInfos, self)
	self:_updateRankInfos()

	self._txtTip.text = ""

	if self._qualType == ShowDownEnum.QualType_Normal then
		local startStepId, endStepId = 1, 2
		local startStamp, endStamp = ShowDownController.instance:getStepTimeStamp(self._activityId, startStepId, endStepId)
		local endTime = GameUtil.formatTimeStamp("%m月%d日%H:%M", endStamp)
		local formatStr = ShowDownConfig.instance:getCommonValue(self._activityId, "rankShowTips")

		self._txtTip.text = string.format(formatStr, endTime)
	elseif self._qualType == ShowDownEnum.QualType_Fun then
		self._txtTip.text = ShowDownConfig.instance:getCommonValue(self._activityId, "rankShowTipsInFunc")
	end
end

function ShowDownRankView:_updateRankInfos(msg)
	local infos = {}
	local myRank = -1
	local myScroe = 0

	if msg then
		infos = msg.rankInfo
		myRank = msg.myRank
		myScroe = msg.myScore
	end

	goutil.setActive(self._empty, #infos == 0)
	self._tableView:reloadData(infos)

	self._txtMyRank.text = myRank <= 0 and "未上榜" or myRank
end

function ShowDownRankView:_updateRankCell(view, cellGo, data)
	local cell = self:_clearRankCell(cellGo)

	if data then
		cell.txtRank.text = data.rank

		HeadItemController.instance:setHeadCellByInfo(cell.headIcon, data.headInfo)

		cell.txtName.text = data.headInfo.userName
		cell.txtArea.text = data.headInfo.areaName
		cell.txtScore.text = data.value

		local time = GameUtil.time2date(checknumber(data.time) / 1000)

		cell.txtTime.text = string.format("%d.%02d.%02d  %02d:%02d:%02d", time.year, time.month, time.day, time.hour, time.min, time.sec)
	end
end

function ShowDownRankView:_clearRankCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.txtRank = goutil.findChildTextComponent(cell.go, "txtRank")
	cell.headIcon = goutil.findChild(cell.go, "headIcon")

	HeadItemController.instance:resetHeadCell(cell.headIcon)

	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtArea = goutil.findChildTextComponent(cell.go, "txtArea")
	cell.txtScore = goutil.findChildTextComponent(cell.go, "txtScore")
	cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")

	return cell
end

return ShowDownRankView
