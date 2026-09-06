-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterhopeclg/view/SummonMasterHopeClgDailyRankView.lua

module("logic.extensions.tourarena.view.SummonMasterHopeClgDailyRankView", package.seeall)

local SummonMasterHopeClgDailyRankView = class("SummonMasterHopeClgDailyRankView", ViewComponent)

function SummonMasterHopeClgDailyRankView:buildUI()
	SummonMasterHopeClgDailyRankView.super.buildUI(self)

	self._filedView = goutil.findChild(self.mainGO, "rankCol/titleCol/filedView")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._txtTip = self:getTxt("tipsCol/txtTip")
end

function SummonMasterHopeClgDailyRankView:bindEvents()
	SummonMasterHopeClgDailyRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SummonMasterHopeClgDailyRankView:unbindEvents()
	SummonMasterHopeClgDailyRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SummonMasterHopeClgDailyRankView:onEnter()
	SummonMasterHopeClgDailyRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._score = params[3]

	local isInTime = SummonMasterHopeClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("不在活动时间内")
		self:close()

		return
	end

	self._myRank = 0
	self._rankInfoList = {}

	self.addGEvent(self, GlobalNotify.PM_SummonMasterHopeClgGetDailyRankRes, self._handlePM_SummonMasterHopeClgGetDailyRankRes, self)
	SummonMasterHopeClgController.instance:sendPM_SummonMasterHopeClgGetDailyRankReq(self._activityId)
end

function SummonMasterHopeClgDailyRankView:onExit()
	SummonMasterHopeClgDailyRankView.super.onExit(self)
	self._rankScrollList:dispose()
end

function SummonMasterHopeClgDailyRankView:_handlePM_SummonMasterHopeClgGetDailyRankRes(msg)
	self._rankMsg = msg
	self._myRank = self._rankMsg.myRank
	self._rankInfoList = self._rankMsg.rankInfos

	self:_onUpdate()
end

function SummonMasterHopeClgDailyRankView:_onUpdate()
	local str = ""

	if self._myRank > 0 then
		str = self._myRank
	else
		str = "未上榜"
		self._txtTip.text = self._score == "" and "" or "上榜需要" .. self._score .. "积分"
	end

	self._txtMyRank.text = str

	GameUtil.SetActive(self._emptyGo, #self._rankInfoList <= 0)
	self._rankScrollList:reloadData(self._rankInfoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
end

function SummonMasterHopeClgDailyRankView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local headInfo = info.headInfo
	local tagNum = info.value
	local sumbitTimeSec = info.time
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtTagNum = goutil.findChildTextComponent(mainGo, "txtTagNum")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)

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

	if txtTime then
		local timeStr = ""
		local timeSec = checknumber(sumbitTimeSec)

		if timeSec > 0 then
			local timeDate = os.date("*t", timeSec / 1000)

			timeStr = string.format("%d %02d.%02d\n%02d:%02d:%02d", timeDate.year, timeDate.month, timeDate.day, timeDate.hour, timeDate.min, timeDate.sec)
		end

		txtTime.text = timeStr
	end

	if txtTagNum then
		txtTagNum.text = tagNum
	end

	HeadItemController.instance:setHeadCellByInfo(imgIcon, headInfo, true)
end

function SummonMasterHopeClgDailyRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

return SummonMasterHopeClgDailyRankView
