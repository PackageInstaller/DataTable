-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaFightTotalRankView.lua

module("logic.extensions.tourarena.view.TourArenaFightTotalRankView", package.seeall)

local TourArenaFightTotalRankView = class("TourArenaFightTotalRankView", ViewComponent)

function TourArenaFightTotalRankView:buildUI()
	TourArenaFightTotalRankView.super.buildUI(self)

	local tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	local tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")

	self._tabScrollList = ScrollerList.create(tabScrollerview, tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._filedView = goutil.findChild(self.mainGO, "rankCol/titleCol/filedView")
	self._txtFieldArea = self:getTxt("rankCol/titleCol/filedView/txtFieldArea")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
end

function TourArenaFightTotalRankView:bindEvents()
	TourArenaFightTotalRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TourArenaFightTotalRankView:unbindEvents()
	TourArenaFightTotalRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TourArenaFightTotalRankView:onEnter()
	TourArenaFightTotalRankView.super.onEnter(self)

	self._activityId = TourArenaController.instance:getActivityIdOfFight()
	self._activityType = TourArenaController.instance:getActivityTypeOfFight()

	local isInTime = TourArenaController.instance:isInActivityTimeOfFight(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._arenaFightMo = TourArenaController.instance:getTourArenaFightMo(self._activityId)
	self._actData = TourArenaFightConfig.instance:getTafActData(self._activityId)
	self._termId = self._actData.zoneTermId
	self._zoneId = 0

	if self._actData then
		self._mainViewRankZoneId = self._actData.mainViewRankZoneId or 0
	end

	self._rankCfg = self:_getRankCfg()

	self:_setCurTabIdx(#self._rankCfg > 0 and 1 or 0)
	self.addGEvent(self, GlobalNotify.TourArenaFightTotalRankRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TourArenaZoneInfoRes, self._handleTourArenaZoneInfoRes, self)
	self:_onUpdate()

	local startStamp, endStamp = 0, 0

	if self._activityId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end

	TourArenaController.instance:sendPM_TourArenaZoneInfoReq(self._termId)
end

function TourArenaFightTotalRankView:onExit()
	TourArenaFightTotalRankView.super.onExit(self)
	self:_onClearTabColUI()
	self:_onClearRankCol()
end

function TourArenaFightTotalRankView:_handleTourArenaZoneInfoRes(msg)
	local termId = msg.termId
	local zoneId = checknumber(msg.zoneId)

	if termId ~= self._termId then
		return
	end

	self._zoneId = zoneId

	self:_updateCurTabIdx()

	if self:_getCurTabIdx() > 0 then
		self:_sendInfoReq()
	end
end

function TourArenaFightTotalRankView:_sendInfoReq()
	TourArenaController.instance:sendPM_TourArenaFightTotalRankReq(self._activityId, self:_getCurRankId())
end

function TourArenaFightTotalRankView:_getRankCfg()
	return TourArenaZoneConfig.instance:getTazDataList()
end

function TourArenaFightTotalRankView:_getRankIdOfData(data)
	return data.zoneId
end

function TourArenaFightTotalRankView:_getmyRank()
	local msg = self._arenaFightMo:_getTotalRankResMsg(self:_getCurRankId())

	return (msg or nil) and msg.myRank
end

function TourArenaFightTotalRankView:_getTabName(data)
	return data.name
end

function TourArenaFightTotalRankView:_getRankInfoList()
	local msg = self._arenaFightMo:_getTotalRankResMsg(self:_getCurRankId())

	return (msg or nil) and msg.rankInfos
end

function TourArenaFightTotalRankView:_onUpdateData()
	self._tabInfoList = {}

	for idx, data in ipairs(self._rankCfg) do
		local info = {}

		info.tabIdx = idx
		info.data = data
		info.rankId = self:_getRankIdOfData(data)
		self._tabInfoList[idx] = info
	end

	if self._curTabIdx == nil or self:_getTabInfo(self._curTabIdx) == nil then
		self:_updateCurTabIdx()
	end

	self._myRank = self:_getmyRank()
	self._rankInfoList = self:_getRankInfoList()
end

function TourArenaFightTotalRankView:_updateCurTabIdx()
	local tabIdx = #self._tabInfoList > 0 and 1 or 0

	if self._zoneId > 0 then
		for _, info in ipairs(self._tabInfoList) do
			if info.data.zoneId == self._zoneId then
				tabIdx = info.tabIdx

				break
			end
		end
	end

	self:_setCurTabIdx(tabIdx)
end

function TourArenaFightTotalRankView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TourArenaFightTotalRankView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTabColUI()
	self:_onUpdateRankColUI()
end

function TourArenaFightTotalRankView:_onUpdatePlaneUI()
	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"

	GameUtil.SetActive(self._emptyGo, #self._rankInfoList <= 0)

	self._txtFieldArea.text = self._mainViewRankZoneId == 0 and "所属地区" or self._mainViewRankZoneId == 1 and "区服" or "区服"
end

function TourArenaFightTotalRankView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabInfoList)
end

function TourArenaFightTotalRankView:_onClearTabColUI()
	self._tabScrollList:dispose()
end

function TourArenaFightTotalRankView:_updateTabCell(view, cell, info, tag)
	local tabIdx = info.tabIdx
	local data = info.data
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = self:_getTabName(data)

	GameUtil.setUIGroupIdx(mainGo, self:_getCurTabIdx() == tabIdx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, info))
end

function TourArenaFightTotalRankView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function TourArenaFightTotalRankView:_onClickTab(info)
	self:_setCurTabIdx(info.tabIdx)
	self:_onUpdate()
	self:_sendInfoReq()
end

function TourArenaFightTotalRankView:_setCurTabIdx(tabIdx)
	self._curTabIdx = tabIdx
end

function TourArenaFightTotalRankView:_getCurTabIdx()
	return self._curTabIdx
end

function TourArenaFightTotalRankView:_getCurRankId()
	local info = self:_getTabInfo(self:_getCurTabIdx())

	return (info or nil) and (info.rankId or 0)
end

function TourArenaFightTotalRankView:_getTabInfo(tabIdx)
	return self._tabInfoList[tabIdx]
end

function TourArenaFightTotalRankView:_getPrizesByRank(zoneId, rank)
	local prize
	local prizeData = TourArenaFightConfig.instance:getTafRankDataByRank(self._activityId, zoneId, rank)

	return (prizeData or nil) and prizeData.prize
end

function TourArenaFightTotalRankView:_onUpdateRankColUI()
	self._rankScrollList:reloadData(self._rankInfoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
end

function TourArenaFightTotalRankView:_onClearRankCol()
	self._rankScrollList:dispose()
end

function TourArenaFightTotalRankView:_updateRankCell(view, cell, info, tag)
	local rank = info.rankInfos.rank
	local headInfo = info.rankInfos.headInfo
	local socre = info.rankInfos.value
	local sumbitTimeSec = info.rankInfos.time
	local province = info.province
	local rankId = self:_getCurRankId()
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

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

	if txtArea then
		txtArea.text = province
		txtArea.text = self._mainViewRankZoneId == 0 and province or self._mainViewRankZoneId == 1 and headInfo.areaName or headInfo.areaName
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

	if txtScore then
		txtScore.text = socre
	end

	HeadItemController.instance:setHeadCellByInfo(imgIcon, headInfo, true)

	local prizes = self:_getPrizesByRank(rankId, rank)

	if itemScrollerview and self._itemScrollercell and not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = itemScrollList

			itemScrollList:reloadData(prizeStrArr)
			itemScrollList:dragNotifyParent()
		end
	end
end

function TourArenaFightTotalRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function TourArenaFightTotalRankView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function TourArenaFightTotalRankView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return TourArenaFightTotalRankView
