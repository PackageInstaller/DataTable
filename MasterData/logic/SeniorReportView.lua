-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorReportView.lua

module("logic.extensions.seniorarena.view.SeniorReportView", package.seeall)

local SeniorReportView = class("SeniorReportView", TableViewComponent)

function SeniorReportView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function SeniorReportView:unbindEvents()
	SeniorReportView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function SeniorReportView:bindEvents()
	SeniorReportView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function SeniorReportView:buildUI()
	SeniorReportView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._noReport = self:getGo("noReport")
end

function SeniorReportView:onExit()
	SeniorReportView.super.onExit(self)
end

function SeniorReportView:onEnter()
	SeniorReportView.super.onEnter(self)
	self._tableview.gameObject:SetActive(false)

	if not SeniorArenaController.instance:getIsOpen(true) then
		return
	end

	Arena3v3Agent.instance:sendMyArena3v3ChallengeRecordsReq(self._updateUI, self)
	print("xxxenter SeniorReportView")
end

function SeniorReportView:_updateUI(msg)
	if msg then
		self._tableview.gameObject:SetActive(true)

		self._curViewDatas = msg.records or {}

		goutil.setActive(self._noReport, not (#self._curViewDatas > 0))
		table.sort(self._curViewDatas, function(a, b)
			return a.challnegeTime / 1000 > b.challnegeTime / 1000
		end)
		self:reloadData()
	end
end

function SeniorReportView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local imgResult = goutil.findChildComponent(go, "imgResult", typeof(UIImageSpriteChange))
	local left = goutil.findChild(go, "left")
	local right = goutil.findChild(go, "right")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local btnDetail = Framework.ButtonAdapter.GetFrom(go, "btnDetail")
	local btnShare = Framework.ButtonAdapter.GetFrom(go, "btnShare")
	local leftData = SeniorArenaController.instance:getMyPlayerInfo()
	local rightData = data
	local isWin = data.isChallengerWin

	if not data.isChallenger then
		leftData = rightData
		rightData = leftData
		isWin = not isWin
	end

	self:_updatePlayer(left, leftData, data.challengerNewRank)
	self:_updatePlayer(right, rightData, data.beChallengerNewRank)

	local date = GameUtil.time2date(checknumber(data.challnegeTime / 1000))

	txtTime.text = string.format("%02d月%02d日  %02d：%02d", date.month, date.day, date.hour, date.min)

	btnDetail:AddClickListener(function()
		self:_onClickDetail(data, leftData, rightData, txtTime.text)
	end)
	btnShare:AddClickListener(function()
		self:_onClickShare(data)
	end)
	imgResult:SetState(isWin and 0 or 1)
end

function SeniorReportView:_updatePlayer(go, data, rank)
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgState = goutil.findChildComponent(go, "state", typeof(UIImageSpriteChange))
	local pointHead = goutil.findChild(go, "head")

	if data.isMyInfo then
		txtName.text = data.userName

		HeadItemController.instance:setMyHeadCell(pointHead)
	else
		txtName.text = data.opHeadInfo and data.opHeadInfo.userName or "未知"

		HeadItemController.instance:setHeadCellByInfo(pointHead, data.opHeadInfo)
	end

	txtRank.text = rank
end

function SeniorReportView:_onClickDetail(data, leftPlayerInfo, rightPlayerInfo)
	UIStateManager.instance:push(ViewName.SeniorReportDetailView, leftPlayerInfo, rightPlayerInfo, data.recordForm, timeText)
end

function SeniorReportView:_onClickShare(data)
	FloatWordMgr.instance:show("分享功能暂未开启")
end

return SeniorReportView
