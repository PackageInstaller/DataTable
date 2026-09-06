-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/ultimatewar/UltimateWarTowerFinalBossRankChildView.lua

module("logic.extensions.commontabrank.view.ultimatewar.UltimateWarTowerFinalBossRankChildView", package.seeall)

local UltimateWarTowerFinalBossRankChildView = class("UltimateWarTowerFinalBossRankChildView", ViewComponent)

function UltimateWarTowerFinalBossRankChildView:buildUI()
	UltimateWarTowerFinalBossRankChildView.super.buildUI(self)

	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._txtMyTime = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyTime")
	self._myPrizeCol = goutil.findChild(self.mainGO, "tipsCol/myPrizeCol")
	self._myPrizeCol_itemScrollerview = goutil.findChild(self.mainGO, "tipsCol/myPrizeCol/itemScrollerview")
	self._myPrizeCol_itemScrollercell = goutil.findChild(self.mainGO, "tipsCol/myPrizeCol/itemScrollercell")
	self._myPrizeScrollList = ScrollerList.create(self._myPrizeCol_itemScrollerview, self._myPrizeCol_itemScrollercell, GameUtil.handler(self._updateMyPrizeItemCell, self), GameUtil.handler(self._clearMyPrizeItemCell, self))

	GameUtil.SetActive(self._myPrizeCol, false)
end

function UltimateWarTowerFinalBossRankChildView:bindEvents()
	UltimateWarTowerFinalBossRankChildView.super.bindEvents(self)
end

function UltimateWarTowerFinalBossRankChildView:unbindEvents()
	UltimateWarTowerFinalBossRankChildView.super.unbindEvents(self)
end

function UltimateWarTowerFinalBossRankChildView:onEnter()
	UltimateWarTowerFinalBossRankChildView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._rankType = UltimateWarEnum.RankType_FinalBoss

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._rankList = {}
	self._myRank = 0
	self._myTime = 0

	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarRankViewRes, self._handleMsgRes, self)
	UltimateWarController.instance:sendPM_UltimateWarRankViewReq(self._activityId, self._rankType)
end

function UltimateWarTowerFinalBossRankChildView:onExit()
	UltimateWarTowerFinalBossRankChildView.super.onExit(self)
	self._rankScrollList:dispose()
	self._myPrizeScrollList:dispose()
end

function UltimateWarTowerFinalBossRankChildView:_handleMsgRes(msg)
	if msg.activityId ~= self._activityId or msg.type ~= self._rankType then
		return
	end

	self._rankList = msg.rankList
	self._myRank = msg.myRank
	self._myTime = checknumber(msg.param)

	self:_onUpdate()
end

function UltimateWarTowerFinalBossRankChildView:_getPrizesByRank(rank)
	local data = UltimateWarConfig.instance:getThirdStepBossRankPrizeData(self._activityId, rank)

	if data then
		return data.prize
	end
end

function UltimateWarTowerFinalBossRankChildView:_onUpdate()
	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"
	self._txtMyTime.text = self._myTime > 0 and GameUtil.formatTimeStamp("%Y.%m.%d %H:%M:%S", self._myTime / 1000) or "无"

	local prizes = self:_getPrizesByRank(self._myRank)

	if not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		self._myPrizeScrollList:reloadData(prizeStrArr)
		self._myPrizeScrollList:dragNotifyParent()
		GameUtil.SetActive(self._myPrizeCol, true)
	else
		GameUtil.SetActive(self._myPrizeCol, false)
		self._myPrizeScrollList:dispose()
	end

	GameUtil.SetActive(self._emptyGo, #self._rankList <= 0)
	self._rankScrollList:reloadData(self._rankList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
end

function UltimateWarTowerFinalBossRankChildView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local headInfo = info.headInfo
	local time = info.time
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtValue = goutil.findChildTextComponent(mainGo, "txtValue")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	txtRank.text = rank

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtName.text = headInfo.userName
	txtArea.text = headInfo.areaName

	local date = GameUtil.time2date(time / 1000)

	txtValue.text = string.format("%02d.%02d.%02d\n%02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)

	HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, true)

	local prizes = self:_getPrizesByRank(rank)

	if itemScrollerview and self._itemScrollercell and not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
		end
	end
end

function UltimateWarTowerFinalBossRankChildView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function UltimateWarTowerFinalBossRankChildView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function UltimateWarTowerFinalBossRankChildView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function UltimateWarTowerFinalBossRankChildView:_updateMyPrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function UltimateWarTowerFinalBossRankChildView:_clearMyPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return UltimateWarTowerFinalBossRankChildView
