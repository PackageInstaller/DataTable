-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/view/CollectingSkinItemProgressRankView.lua

module("logic.extensions.collectingskin.view.CollectingSkinItemProgressRankView", package.seeall)

local CollectingSkinItemProgressRankView = class("CollectingSkinItemProgressRankView", ViewComponent)

function CollectingSkinItemProgressRankView:ctor()
	CollectingSkinItemProgressRankView.super.ctor(self)
end

function CollectingSkinItemProgressRankView:buildUI()
	CollectingSkinItemProgressRankView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrView = goutil.findChild(self.mainGO, "rankCol/rankScrView")
	self._rankScrCell = goutil.findChild(self.mainGO, "rankCol/rankScrCell")
	self._itemScrCell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")
	self._itemScrollerListDic = {}

	GameUtil.SetActive(self._itemScrCell, false)

	self._rankScrollerList = ScrollerList.create(self._rankScrView, self._rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._myPrizeCol = self:getGo("tipsCol/myPrizeCol")
	self._myPrizeScrView = self:getGo("tipsCol/myPrizeCol/itemScrollerview")
	self._myPrizeScrCell = self:getGo("tipsCol/myPrizeCol/itemScrollercell")
	self._myPrizeScrollerList = ScrollerList.create(self._myPrizeScrView, self._myPrizeScrCell, GameUtil.handler(self._updateMyPrizeItemCell, self), GameUtil.handler(self._clearMyPrizeItemCell, self))
end

function CollectingSkinItemProgressRankView:bindEvents()
	CollectingSkinItemProgressRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CollectingSkinItemProgressRankView:unbindEvents()
	CollectingSkinItemProgressRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CollectingSkinItemProgressRankView:onEnter()
	CollectingSkinItemProgressRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._rankInfoList = {}
	self._myRank = -1
	self._myScore = 0

	self.addGEvent(self, GlobalNotify.CollectingSkinItemRankInfo, self._handleRankInfo, self)
	CollectingSkinController.instance:sendPM_CollectingSkinItemRankInfoReq(self._activityId)
	self:_onUpdate()
end

function CollectingSkinItemProgressRankView:onExit()
	CollectingSkinItemProgressRankView.super.onExit(self)
	self:_onClear()
	self._myPrizeScrollerList:dispose()
end

function CollectingSkinItemProgressRankView:_handleRankInfo(msg)
	if msg.activityId ~= self._activityId then
		return
	end

	self._rankInfoList = msg.rankInfoList
	self._myRank = msg.myRank

	self:_onUpdate()
end

function CollectingSkinItemProgressRankView:_onUpdate()
	local myRank = self._myRank

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"

	local infoList = self._rankInfoList

	self._rankScrollerList:reloadData(infoList)
	self._rankScrollerList:MoveCellInView(0, true)
	GameUtil.SetActive(self._emptyGo, #infoList <= 0)

	local prizes = self:_getPrizesByRank(myRank)

	if not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		self._myPrizeScrollerList:reloadData(prizeStrArr)
		GameUtil.SetActive(self._myPrizeCol, true)
	else
		GameUtil.SetActive(self._myPrizeCol, false)
		self._myPrizeScrollerList:dispose()
	end
end

function CollectingSkinItemProgressRankView:_onClear()
	self._rankScrollerList:dispose()
end

function CollectingSkinItemProgressRankView:_getPrizesByRank(rank)
	return nil
end

function CollectingSkinItemProgressRankView:_updateRankCell(view, cell, info, tag)
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
	txtScore.text = info.value

	local date = GameUtil.time2date(info.time / 1000)

	txtTime.text = string.format("%02d.%02d %02d:%02d", date.month, date.day, date.hour, date.min)

	HeadItemController.instance:setHeadCellByInfo(head, info.headInfo, true)

	local prizes = self:_getPrizesByRank(info.rank)
	local prizeStrArr = {}

	if not string.nilorempty(prizes) then
		prizeStrArr = string.split(prizes, "#")
	end

	self._itemScrollerListDic[mainGo] = self._itemScrollerListDic[mainGo] or ScrollerList.create(itemScrollerview, self._itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	local itemScrollList = self._itemScrollerListDic[mainGo]

	itemScrollList:dragNotifyParent()
	itemScrollList:reloadData(prizeStrArr)
end

function CollectingSkinItemProgressRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")

	HeadItemController.instance:resetHeadCell(head)

	local itemScrollList = self._itemScrollerListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollerListDic[mainGo] = nil
	end
end

function CollectingSkinItemProgressRankView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function CollectingSkinItemProgressRankView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function CollectingSkinItemProgressRankView:_updateMyPrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function CollectingSkinItemProgressRankView:_clearMyPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return CollectingSkinItemProgressRankView
