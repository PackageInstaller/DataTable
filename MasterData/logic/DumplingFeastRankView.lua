-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/view/DumplingFeastRankView.lua

module("logic.extensions.dumplingfeast.view.DumplingFeastRankView", package.seeall)

local DumplingFeastRankView = class("DumplingFeastRankView", ViewComponent)

function DumplingFeastRankView:ctor()
	DumplingFeastRankView.super.ctor(self)
end

function DumplingFeastRankView:buildUI()
	DumplingFeastRankView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtMyRank = self:getTxt("tipsCol/txtMyRank")
	self._emptyGo = self:getGo("rankCol/emptyGo")
	self._rankScrView = self:getGo("rankCol/rankScrView")
	self._rankScrCell = self:getGo("rankCol/rankScrCell")
	self._itemScrCell = self:getGo("rankCol/itemScrCell")
	self._itemScrollerListDic = {}

	GameUtil.SetActive(self._itemScrCell, false)

	self._rankScrollerList = ScrollerList.create(self._rankScrView, self._rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._myPrizeCol = self:getGo("tipsCol/myPrizeCol")
	self._myPrizeScrView = self:getGo("tipsCol/myPrizeCol/itemScrView")
	self._myPrizeScrCell = self:getGo("tipsCol/myPrizeCol/itemScrCell")
	self._myPrizeScrollerList = ScrollerList.create(self._myPrizeScrView, self._myPrizeScrCell, GameUtil.handler(self._updateMyPrizeItemCell, self), GameUtil.handler(self._clearMyPrizeItemCell, self))
end

function DumplingFeastRankView:bindEvents()
	DumplingFeastRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DumplingFeastRankView:unbindEvents()
	DumplingFeastRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DumplingFeastRankView:onEnter()
	DumplingFeastRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._rankInfoList = {}
	self._myRank = -1
	self._myDamage = 0

	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastRankViewRes, self._handleRankMsg, self)
	DumplingFeastController.instance:sendPM_DumplingFeastRankViewReq(self._activityId)
	self:_onUpdate()
end

function DumplingFeastRankView:onExit()
	DumplingFeastRankView.super.onExit(self)
	self:_onClear()
	self._myPrizeScrollerList:dispose()
end

function DumplingFeastRankView:_handleRankMsg(msg)
	if msg.activityId ~= self._activityId then
		return
	end

	self._rankInfoList = msg.infoList
	self._myRank = msg.myRank
	self._myDamage = checknumber(msg.myDamage)

	self:_onUpdate()
end

function DumplingFeastRankView:_onUpdate()
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
	end
end

function DumplingFeastRankView:_onClear()
	self._rankScrollerList:dispose()
end

function DumplingFeastRankView:_getPrizesByRank(rank)
	local prize
	local data = DumplingFeastConfig.instance:getRankPrizeData(self._activityId, rank)

	return (data or nil) and data.prize
end

function DumplingFeastRankView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")

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

	self._itemScrollerListDic[mainGo] = self._itemScrollerListDic[mainGo] or ScrollerList.create(itemScrView, self._itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	local itemScrollList = self._itemScrollerListDic[mainGo]

	itemScrollList:dragNotifyParent()
	itemScrollList:reloadData(prizeStrArr)
end

function DumplingFeastRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")

	HeadItemController.instance:resetHeadCell(head)

	local itemScrollList = self._itemScrollerListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollerListDic[mainGo] = nil
	end
end

function DumplingFeastRankView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item)
end

function DumplingFeastRankView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function DumplingFeastRankView:_updateMyPrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function DumplingFeastRankView:_clearMyPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return DumplingFeastRankView
