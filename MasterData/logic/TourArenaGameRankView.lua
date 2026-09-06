-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaGameRankView.lua

module("logic.extensions.tourarena.view.TourArenaGameRankView", package.seeall)

local TourArenaGameRankView = class("TourArenaGameRankView", ViewComponent)

function TourArenaGameRankView:buildUI()
	TourArenaGameRankView.super.buildUI(self)

	local tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	local tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")

	self._tabScrollList = ScrollerList.create(tabScrollerview, tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
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
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
end

function TourArenaGameRankView:bindEvents()
	TourArenaGameRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TourArenaGameRankView:unbindEvents()
	TourArenaGameRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TourArenaGameRankView:onEnter()
	TourArenaGameRankView.super.onEnter(self)

	self._activityId = TourArenaController.instance:getActivityIdOfGame()
	self._activityType = TourArenaController.instance:getActivityTypeOfGame()

	local isInTime = TourArenaController.instance:isInActivityTimeOfGame(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._arenaGameMo = TourArenaController.instance:getTourArenaGameMo(self._activityId)
	self._rankCfg = self:_getRankCfg()

	self:_setCurTabIdx(#self._rankCfg > 0 and 1 or 0)
	self.addGEvent(self, GlobalNotify.TourArenaGameRankRes, self._onUpdate, self)
	self:_onUpdate()

	local startStamp, endStamp = 0, 0

	if self._activityId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end

	if self:_getCurTabIdx() > 0 then
		self:_sendInfoReq()
	end
end

function TourArenaGameRankView:onExit()
	TourArenaGameRankView.super.onExit(self)
	self:_onClearTabColUI()
	self:_onClearRankCol()
end

function TourArenaGameRankView:_sendInfoReq()
	TourArenaController.instance:sendPM_TourArenaGameRankReq(self._activityId, self:_getCurRankId())
end

function TourArenaGameRankView:_getRankCfg()
	return TourArenaGameConfig.instance:getTagGameCfg(self._activityId)
end

function TourArenaGameRankView:_getRankIdOfData(data)
	return data.gameId
end

function TourArenaGameRankView:_getmyRank()
	local msg = self._arenaGameMo:_getRankResMsg(self:_getCurRankId())

	return (msg or nil) and msg.myRank
end

function TourArenaGameRankView:_getTabName(data)
	return data.name
end

function TourArenaGameRankView:_getRankInfoList()
	local msg = self._arenaGameMo:_getRankResMsg(self:_getCurRankId())

	return (msg or nil) and msg.rankInfos
end

function TourArenaGameRankView:_getPrizesByRank(rank)
	local prize
	local prizeData = TourArenaGameConfig.instance:getTagRankPrizeDataByRank(self._activityId, rank)

	return (prizeData or nil) and prizeData.prize
end

function TourArenaGameRankView:_onUpdateData()
	self._tabInfoList = {}

	for idx, data in ipairs(self._rankCfg) do
		local info = {}

		info.tabIdx = idx
		info.data = data
		info.rankId = self:_getRankIdOfData(data)
		self._tabInfoList[idx] = info
	end

	if self._curTabIdx == nil or self:_getTabInfo(self._curTabIdx) == nil then
		self:_setCurTabIdx(#self._tabInfoList > 0 and 1 or 0)
	end

	self._myRank = self:_getmyRank()
	self._rankInfoList = self:_getRankInfoList()
end

function TourArenaGameRankView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TourArenaGameRankView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTabColUI()
	self:_onUpdateRankColUI()
end

function TourArenaGameRankView:_onUpdatePlaneUI()
	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"

	GameUtil.SetActive(self._emptyGo, #self._rankInfoList <= 0)
end

function TourArenaGameRankView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabInfoList)
end

function TourArenaGameRankView:_onClearTabColUI()
	self._tabScrollList:dispose()
end

function TourArenaGameRankView:_updateTabCell(view, cell, info, tag)
	local tabIdx = info.tabIdx
	local data = info.data
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = self:_getTabName(data)

	GameUtil.setUIGroupIdx(mainGo, self:_getCurTabIdx() == tabIdx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, info))
end

function TourArenaGameRankView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function TourArenaGameRankView:_onClickTab(info)
	self:_setCurTabIdx(info.tabIdx)
	self:_onUpdate()
	self:_sendInfoReq()
end

function TourArenaGameRankView:_setCurTabIdx(tabIdx)
	self._curTabIdx = tabIdx
end

function TourArenaGameRankView:_getCurTabIdx()
	return self._curTabIdx
end

function TourArenaGameRankView:_getCurRankId()
	local info = self:_getTabInfo(self:_getCurTabIdx())

	return (info or nil) and (info.rankId or 0)
end

function TourArenaGameRankView:_getTabInfo(tabIdx)
	return self._tabInfoList[tabIdx]
end

function TourArenaGameRankView:_onUpdateRankColUI()
	self._rankScrollList:reloadData(self._rankInfoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
end

function TourArenaGameRankView:_onClearRankCol()
	self._rankScrollList:dispose()
end

function TourArenaGameRankView:_updateRankCell(view, cell, info, tag)
	local rank = info.rankInfos.rank
	local headInfo = info.rankInfos.headInfo
	local socre = info.rankInfos.value
	local sumbitTimeSec = info.rankInfos.time
	local province = info.province
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

	local prizes = self:_getPrizesByRank(rank)

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

function TourArenaGameRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function TourArenaGameRankView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function TourArenaGameRankView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return TourArenaGameRankView
