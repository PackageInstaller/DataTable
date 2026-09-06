-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaFightWeeklyRankChildView.lua

module("logic.extensions.tourarena.view.TourArenaFightWeeklyRankChildView", package.seeall)

local TourArenaFightWeeklyRankChildView = class("TourArenaFightWeeklyRankChildView", ViewComponent)

function TourArenaFightWeeklyRankChildView:buildUI()
	TourArenaFightWeeklyRankChildView.super.buildUI(self)

	local rankScrView = self:getGo("rankCol/rankScrView")
	local rankScrCell = self:getGo("rankCol/rankScrCell")

	self._itemScrCell = self:getGo("rankCol/itemScrCell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._txtFieldArea = self:getTxt("rankCol/titleCol/txtFieldArea")
	self._rankScrollList = ScrollerList.create(rankScrView, rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollerListDic = {}

	GameUtil.SetActive(self._itemScrCell, false)

	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._txtMyValue = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyValue")
end

function TourArenaFightWeeklyRankChildView:bindEvents()
	TourArenaFightWeeklyRankChildView.super.bindEvents(self)
end

function TourArenaFightWeeklyRankChildView:unbindEvents()
	TourArenaFightWeeklyRankChildView.super.unbindEvents(self)
end

function TourArenaFightWeeklyRankChildView:onEnter()
	TourArenaFightWeeklyRankChildView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._zoneId = checknumber(params[2])
	self._actData = TourArenaFightConfig.instance:getTafActData(self._activityId)

	if self._actData then
		self._mainViewRankZoneId = self._actData.mainViewRankZoneId or 0
	end

	self._rankList = {}
	self._myRank = 0
	self._myValue = 0

	self.addGEvent(self, GlobalNotify.TourArenaFightTotalRankRes, self._handleMsgRes, self)
	TourArenaController.instance:sendPM_TourArenaFightTotalRankReq(self._activityId, self._zoneId)
end

function TourArenaFightWeeklyRankChildView:onExit()
	TourArenaFightWeeklyRankChildView.super.onExit(self)
	self._rankScrollList:dispose()
end

function TourArenaFightWeeklyRankChildView:_handleMsgRes(msg)
	if msg.zoneId ~= self._zoneId then
		return
	end

	self._rankList = msg.rankInfos
	self._myRank = msg.myRank

	self:_onUpdate()
end

function TourArenaFightWeeklyRankChildView:_getPrizesByRank(rank)
	local data = TourArenaFightConfig.instance:getTafRankDataByRank(self._activityId, self._zoneId, rank)

	return data and data.prize
end

function TourArenaFightWeeklyRankChildView:_onUpdate()
	GameUtil.SetActive(self._emptyGo, #self._rankList <= 0)
	self._rankScrollList:reloadData(self._rankList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)

	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"
	self._txtFieldArea.text = self._mainViewRankZoneId == 0 and "所属地区" or self._mainViewRankZoneId == 1 and "区服" or "区服"
end

function TourArenaFightWeeklyRankChildView:_updateRankCell(view, cell, info, tag)
	local rank = info.rankInfos.rank
	local headInfo = info.rankInfos.headInfo
	local value = info.rankInfos.value
	local time = info.rankInfos.time
	local province = info.province
	local mainGo = cell.gameObject
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtValue = goutil.findChildTextComponent(mainGo, "txtValue")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")
	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtRank.text = rank
	txtName.text = headInfo.userName
	txtValue.text = value

	if txtArea then
		txtArea.text = province
		txtArea.text = self._mainViewRankZoneId == 0 and province or self._mainViewRankZoneId == 1 and headInfo.areaName or headInfo.areaName
	end

	HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, true)

	local date = GameUtil.time2date(time / 1000)

	txtTime.text = string.format("%02d.%02d.%02d\n%02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)

	local prizes = self:_getPrizesByRank(rank)

	if itemScrollerview and self._itemScrCell and not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		if not self._itemScrollerListDic[mainGo] then
			local itemScrollerList = ScrollerList.create(itemScrollerview, self._itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollerListDic[mainGo] = self._itemScrollerListDic[mainGo]

			self._itemScrollerListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollerListDic[mainGo]:dragNotifyParent()
		end
	end
end

function TourArenaFightWeeklyRankChildView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)

	local itemScrollerList = self._itemScrollerListDic[mainGo]

	if itemScrollerList then
		itemScrollerList:dispose()

		self._itemScrollerListDic[mainGo] = nil
	end
end

function TourArenaFightWeeklyRankChildView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function TourArenaFightWeeklyRankChildView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return TourArenaFightWeeklyRankChildView
