-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/view/FruitNinjaGameRankView.lua

module("logic.extensions.fruitninja.view.FruitNinjaGameRankView", package.seeall)

local FruitNinjaGameRankView = class("FruitNinjaGameRankView", ViewComponent)

function FruitNinjaGameRankView:ctor()
	FruitNinjaGameRankView.super.ctor(self)
end

function FruitNinjaGameRankView:buildUI()
	FruitNinjaGameRankView.super.buildUI(self)

	self._closeBtn = goutil.findChild(self.mainGO, "closeBtn")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._rankScrollerList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._myPrizeCol = self:getGo("tipsCol/myPrizeCol")
	self._myPrizeCol_itemScrollerview = self:getGo("tipsCol/myPrizeCol/itemScrollerview")
	self._myPrizeCol_itemScrollercell = self:getGo("tipsCol/myPrizeCol/itemScrollercell")
	self._myPrizeScrollList = ScrollerList.create(self._myPrizeCol_itemScrollerview, self._myPrizeCol_itemScrollercell, GameUtil.handler(self._updateMyPrizeItemCell, self), GameUtil.handler(self._clearMyPrizeItemCell, self))
end

function FruitNinjaGameRankView:bindEvents()
	FruitNinjaGameRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
end

function FruitNinjaGameRankView:unbindEvents()
	FruitNinjaGameRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function FruitNinjaGameRankView:destroyUI()
	FruitNinjaGameRankView.super.destroyUI(self)
end

function FruitNinjaGameRankView:onEnter()
	FruitNinjaGameRankView.super.onEnter(self)

	self._activityId = FruitNinjaController.instance:getActivityId()
	self._activityType = FruitNinjaController.instance:getActivityType()

	local isInTime = FruitNinjaController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self.addGEvent(self, GlobalNotify.HandlePM_FruitNinjaViewRankRes, self._handlePM_FruitNinjaViewRankRes, self)
	FruitNinjaController.instance:sendPM_FruitNinjaViewRankReq(self._activityId)
end

function FruitNinjaGameRankView:onExit()
	FruitNinjaGameRankView.super.onExit(self)
	self:_onClear()
	self._myPrizeScrollList:dispose()
end

function FruitNinjaGameRankView:_handlePM_FruitNinjaViewRankRes(msg)
	if msg.activityId ~= self._activityId then
		return
	end

	self._rankInfoList = msg.rankInfoList
	self._myRank = msg.myRank
	self._myScore = checknumber(msg.myScore)

	self:_onUpdate()
end

function FruitNinjaGameRankView:_onUpdate()
	local myRank = self:_getMyRank()

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"

	local infoList = self:_getRankInfoList()

	self._rankScrollerList:reloadData(infoList)
	self._rankScrollerList:MoveCellInView(0, true)
	GameUtil.SetActive(self._emptyGo, #infoList <= 0)

	local prizes = self:_getPrizesByRank(myRank)

	if not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		self._myPrizeScrollList:reloadData(prizeStrArr)
		GameUtil.SetActive(self._myPrizeCol, true)
	else
		GameUtil.SetActive(self._myPrizeCol, false)
		self._myPrizeScrollList:dispose()
	end
end

function FruitNinjaGameRankView:_onClear()
	self._rankScrollerList:dispose()
end

function FruitNinjaGameRankView:_getMyRank()
	return self._myRank
end

function FruitNinjaGameRankView:_getRankInfoList()
	return self._rankInfoList
end

function FruitNinjaGameRankView:_getPrizesByRank(rank)
	local prize
	local prizeData = FruitNinjaConfig.instance:getRankData(self._activityId, rank)

	return (prizeData or nil) and prizeData.prize
end

function FruitNinjaGameRankView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	txtRank.text = info.rank

	local isTop3 = checknumber(info.rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(info.rank - 1)
	end

	txtName.text = info.headInfo.userName
	txtArea.text = info.headInfo.areaName
	txtScore.text = info.value

	local date = GameUtil.time2date(info.time / 1000)

	txtTime.text = string.format("%02d.%02d %02d:%02d", date.month, date.day, date.hour, date.min)

	HeadItemController.instance:setHeadCellByInfo(head, info.headInfo, true)

	local prizes = self:_getPrizesByRank(info.rank)
	local prizeStrArr = {}

	if not string.nilorempty(prizes) then
		prizeStrArr = string.split(prizes, "#")
	end

	self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo] or ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	local itemScrollList = self._itemScrollListDic[mainGo]

	itemScrollList:dragNotifyParent()
	itemScrollList:reloadData(prizeStrArr)
end

function FruitNinjaGameRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")

	HeadItemController.instance:resetHeadCell(head)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function FruitNinjaGameRankView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function FruitNinjaGameRankView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function FruitNinjaGameRankView:_updateMyPrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function FruitNinjaGameRankView:_clearMyPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return FruitNinjaGameRankView
