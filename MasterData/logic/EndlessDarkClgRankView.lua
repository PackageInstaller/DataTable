-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessdark/view/EndlessDarkClgRankView.lua

module("logic.extensions.endlessdark.view.EndlessDarkClgRankView", package.seeall)

local EndlessDarkClgRankView = class("EndlessDarkClgRankView", ViewComponent)

function EndlessDarkClgRankView:buildUI()
	EndlessDarkClgRankView.super.buildUI(self)

	self._filedView = goutil.findChild(self.mainGO, "rankCol/titleCol/filedView")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")

	GameUtil.SetActive(self._itemScrollercell, false)

	self._btnClose = self:getGo("btnClose")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._txtWaveNum = self:getTxt("tipsCol/txtWaveNum")
	self._txtTip = self:getTxt("tipsCol/tip/txtTip")
end

function EndlessDarkClgRankView:bindEvents()
	EndlessDarkClgRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function EndlessDarkClgRankView:unbindEvents()
	EndlessDarkClgRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function EndlessDarkClgRankView:onEnter()
	EndlessDarkClgRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_EndlessDarkClgViewRankRes, self._handlePM_EndlessDarkClgViewRankRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._myRank = 0
	self._rankInfoList = {}
	self._scrollDic = {}

	EndlessDarkClgController.instance:sendPM_EndlessDarkClgViewRankReq(self._activityId)
end

function EndlessDarkClgRankView:onExit()
	EndlessDarkClgRankView.super.onExit(self)
	self._rankScrollList:dispose()
end

function EndlessDarkClgRankView:_handlePM_EndlessDarkClgViewRankRes(msg)
	self._rankMsg = msg
	self._myRank = self._rankMsg.myRank
	self._myWaveId = self._rankMsg.myWaveId
	self._rankInfoList = self._rankMsg.rankInfoList

	self:_onUpdate()
end

function EndlessDarkClgRankView:_onUpdate()
	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"
	self._txtWaveNum.text = self._myWaveId

	GameUtil.SetActive(self._emptyGo, #self._rankInfoList <= 0)
	self._rankScrollList:reloadData(self._rankInfoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
end

function EndlessDarkClgRankView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local headInfo = info.headInfo
	local tagNum = info.value
	local sumbitTimeSec = info.time
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local txtAreaName = goutil.findChildTextComponent(mainGo, "txtAreaName")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local rewardScroll = self._scrollDic[cell]

	if rewardScroll == nil then
		local tableviewReward = goutil.findChild(mainGo, "tableviewReward")
		local tablecell = goutil.findChild(mainGo, "tableviewReward/tablecell")

		rewardScroll = ScrollerList.create(tableviewReward, tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	end

	txtRank.text = rank

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	if txtName then
		txtName.text = headInfo.userName
	end

	txtAreaName.text = headInfo.areaName
	txtScore.text = tagNum

	if txtTime then
		local timeStr = ""
		local timeSec = checknumber(sumbitTimeSec)

		if timeSec > 0 then
			local timeDate = os.date("*t", timeSec / 1000)

			timeStr = string.format("%d %02d.%02d\n%02d:%02d:%02d", timeDate.year, timeDate.month, timeDate.day, timeDate.hour, timeDate.min, timeDate.sec)
		end

		txtTime.text = timeStr
	end

	HeadItemController.instance:setHeadCellByInfo(imgIcon, headInfo, true)

	local rewardList = EndlessDarkClgController.instance:getRewardList(self._activityId, rank)

	rewardScroll:reloadData(rewardList)
end

function EndlessDarkClgRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)

	local rewardScroll = self._scrollDic[cell]

	if rewardScroll then
		rewardScroll:dispose()

		self._scrollDic[cell] = nil
	end
end

function EndlessDarkClgRankView:_updateCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function EndlessDarkClgRankView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local btnGet = goutil.findChild(cell, "btnGet")

	if self._scrollDic[cell] then
		self._scrollDic[cell]:dispose()
	end

	MaterialMgr.resetAll(cell)
end

return EndlessDarkClgRankView
