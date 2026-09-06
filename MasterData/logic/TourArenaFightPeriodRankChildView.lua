-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaFightPeriodRankChildView.lua

module("logic.extensions.tourarena.view.TourArenaFightPeriodRankChildView", package.seeall)

local TourArenaFightPeriodRankChildView = class("TourArenaFightPeriodRankChildView", ViewComponent)

function TourArenaFightPeriodRankChildView:buildUI()
	TourArenaFightPeriodRankChildView.super.buildUI(self)

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

function TourArenaFightPeriodRankChildView:bindEvents()
	TourArenaFightPeriodRankChildView.super.bindEvents(self)
end

function TourArenaFightPeriodRankChildView:unbindEvents()
	TourArenaFightPeriodRankChildView.super.unbindEvents(self)
end

function TourArenaFightPeriodRankChildView:onEnter()
	TourArenaFightPeriodRankChildView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._actData = TourArenaFightConfig.instance:getTafActData(self._activityId)
	self._periodId = self._actData.periodId
	self._rankList = {}
	self._myRank = 0
	self._myValue = 0

	self.addGEvent(self, GlobalNotify.TourArenaPeriodRankRes, self._handleMsgRes, self)
	TourArenaController.instance:sendPM_TourArenaPeriodRankReq(self._activityId)
end

function TourArenaFightPeriodRankChildView:onExit()
	TourArenaFightPeriodRankChildView.super.onExit(self)
	self._rankScrollList:dispose()
end

function TourArenaFightPeriodRankChildView:_handleMsgRes(msg)
	self._rankList = msg.infoList
	self._myRank = msg.myRank

	self:_onUpdate()
end

function TourArenaFightPeriodRankChildView:_getPrizesByRank(rank)
	local data = TourArenaFightConfig.instance:getTafPeriodRankDataByRank(self._periodId, rank)

	return data and data.prize
end

function TourArenaFightPeriodRankChildView:_onUpdate()
	GameUtil.SetActive(self._emptyGo, #self._rankList <= 0)
	self._rankScrollList:reloadData(self._rankList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)

	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"
end

function TourArenaFightPeriodRankChildView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local headInfo = info.headInfo
	local value = info.value
	local time = info.time
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
	txtArea.text = headInfo.areaName

	HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, true)

	local date = GameUtil.time2date(time / 1000)

	txtTime.text = string.format("%02d.%02d.%02d\n%02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)

	local prizes = self:_getPrizesByRank(rank)

	if not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		if not self._itemScrollerListDic[mainGo] then
			local itemScrollerList = ScrollerList.create(itemScrollerview, self._itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollerListDic[mainGo] = self._itemScrollerListDic[mainGo]

			self._itemScrollerListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollerListDic[mainGo]:dragNotifyParent()
		end
	end
end

function TourArenaFightPeriodRankChildView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)

	local itemScrollerList = self._itemScrollerListDic[mainGo]

	if itemScrollerList then
		itemScrollerList:dispose()

		self._itemScrollerListDic[mainGo] = nil
	end
end

function TourArenaFightPeriodRankChildView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function TourArenaFightPeriodRankChildView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return TourArenaFightPeriodRankChildView
