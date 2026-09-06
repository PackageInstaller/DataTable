-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/NumberPuzzleGameRankView.lua

module("logic.extensions.numberpuzzlegame.view.NumberPuzzleGameRankView", package.seeall)

local NumberPuzzleGameRankView = class("NumberPuzzleGameRankView", ViewComponent)

function NumberPuzzleGameRankView:ctor()
	NumberPuzzleGameRankView.super.ctor(self)
end

function NumberPuzzleGameRankView:buildUI()
	NumberPuzzleGameRankView.super.buildUI(self)

	self._closeBtn = goutil.findChild(self.mainGO, "closeBtn")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._myPrizeCol = goutil.findChild(self.mainGO, "tipsCol/myPrizeCol")
	self._myPrizeCol_itemScrollerview = goutil.findChild(self.mainGO, "tipsCol/myPrizeCol/itemScrollerview")
	self._myPrizeCol_itemScrollercell = goutil.findChild(self.mainGO, "tipsCol/myPrizeCol/itemScrollercell")
	self._myPrizeScrollList = ScrollerList.create(self._myPrizeCol_itemScrollerview, self._myPrizeCol_itemScrollercell, GameUtil.handler(self._updateMyPrizeItemCell, self), GameUtil.handler(self._clearMyPrizeItemCell, self))
end

function NumberPuzzleGameRankView:bindEvents()
	NumberPuzzleGameRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
end

function NumberPuzzleGameRankView:unbindEvents()
	NumberPuzzleGameRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function NumberPuzzleGameRankView:destroyUI()
	NumberPuzzleGameRankView.super.destroyUI(self)
end

function NumberPuzzleGameRankView:onEnter()
	NumberPuzzleGameRankView.super.onEnter(self)

	self._activityId = NumberPuzzleGameController.instance:getActivityId()
	self._activityType = NumberPuzzleGameController.instance:getActivityType()

	local isInTime = NumberPuzzleGameController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self.addGEvent(self, GlobalNotify.handlePM_2048EndRankRes, self._onUpdate, self)
	NumberPuzzleGameController.instance:sendPM_2048EndRankReq(self._activityId)
end

function NumberPuzzleGameRankView:onExit()
	NumberPuzzleGameRankView.super.onExit(self)
	self:_onClear()
	self._myPrizeScrollList:dispose()
end

function NumberPuzzleGameRankView:_onUpdate()
	local myRank = self:_getMyRank()

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"

	local prizes = self:_getPrizesByRank(myRank)

	if not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		self._myPrizeScrollList:reloadData(prizeStrArr)
		self._myPrizeScrollList:dragNotifyParent()
		GameUtil.SetActive(self._myPrizeCol, true)
	else
		GameUtil.SetActive(self._myPrizeCol, false)
		self._myPrizeScrollList:dispose()
	end

	local infoList = self:_getRankInfoList()

	self._rankScrollList:reloadData(infoList)
	self._rankScrollList:MoveCellInView(0, true)
	GameUtil.SetActive(self._emptyGo, #infoList <= 0)
end

function NumberPuzzleGameRankView:_onClear()
	self._rankScrollList:dispose()
end

function NumberPuzzleGameRankView:_getMyRank()
	return NumberPuzzleGameModel.instance:getMyRank()
end

function NumberPuzzleGameRankView:_getRankInfoList()
	return NumberPuzzleGameModel.instance:getRankInfos()
end

function NumberPuzzleGameRankView:_getPrizesByRank(rank)
	local prize
	local prizeData = NumberPuzzleGameConfig.instance:getNpgRankPrizeDataByRank(self._activityId, rank)

	return (prizeData or nil) and prizeData.prize
end

function NumberPuzzleGameRankView:_updateRankCell(view, cell, info, tag)
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

	HeadItemController.instance:setHeadCellByInfo(head, info.headInfo, true)

	local prizes = self:_getPrizesByRank(info.rank)

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

function NumberPuzzleGameRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")

	HeadItemController.instance:resetHeadCell(head)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function NumberPuzzleGameRankView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function NumberPuzzleGameRankView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function NumberPuzzleGameRankView:_updateMyPrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function NumberPuzzleGameRankView:_clearMyPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return NumberPuzzleGameRankView
