-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/goddesscompetition/GoddessCompetitionRedPackChildRankView.lua

module("logic.extensions.commontabrank.view.goddesscompetition.GoddessCompetitionRedPackChildRankView", package.seeall)

local GoddessCompetitionRedPackChildRankView = class("GoddessCompetitionRedPackChildRankView", ViewComponent)

function GoddessCompetitionRedPackChildRankView:buildUI()
	GoddessCompetitionRedPackChildRankView.super.buildUI(self)

	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._txtMyValue = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyValue")
	self._myPrizeCol = goutil.findChild(self.mainGO, "tipsCol/myPrizeCol")
	self._myPrizeCol_itemScrollerview = goutil.findChild(self.mainGO, "tipsCol/myPrizeCol/itemScrollerview")
	self._myPrizeCol_itemScrollercell = goutil.findChild(self.mainGO, "tipsCol/myPrizeCol/itemScrollercell")
	self._myPrizeScrollList = ScrollerList.create(self._myPrizeCol_itemScrollerview, self._myPrizeCol_itemScrollercell, GameUtil.handler(self._updateMyPrizeItemCell, self), GameUtil.handler(self._clearMyPrizeItemCell, self))

	GameUtil.SetActive(self._myPrizeCol, false)
end

function GoddessCompetitionRedPackChildRankView:bindEvents()
	GoddessCompetitionRedPackChildRankView.super.bindEvents(self)
end

function GoddessCompetitionRedPackChildRankView:unbindEvents()
	GoddessCompetitionRedPackChildRankView.super.unbindEvents(self)
end

function GoddessCompetitionRedPackChildRankView:onEnter()
	GoddessCompetitionRedPackChildRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._rankList = {}
	self._myRank = 0
	self._myValue = 0

	self.addGEvent(self, GlobalNotify.GoddessCompetitionRankViewRes, self._handleMsgRes, self)
	GoddessCompetitionAgent.instance:sendPM_GoddessCompetitionRedPackRankViewReq(self._activityId)
end

function GoddessCompetitionRedPackChildRankView:onExit()
	GoddessCompetitionRedPackChildRankView.super.onExit(self)
	self._rankScrollList:dispose()
	self._myPrizeScrollList:dispose()
end

function GoddessCompetitionRedPackChildRankView:_handleMsgRes()
	local rankList, myRank, myValue = GoddessCompetitionModel.instance:getRankInfo()

	self._rankList = rankList or {}
	self._myRank = checknumber(myRank)
	self._myValue = checknumber(myValue)

	self:_onUpdate()
end

function GoddessCompetitionRedPackChildRankView:_getPrizesByRank(rank)
	local data = GoddessCompetitionConfig.instance:getRedPackRankDataByRank(self._activityId, rank)

	return data and data.prize
end

function GoddessCompetitionRedPackChildRankView:_onUpdate()
	GameUtil.SetActive(self._emptyGo, #self._rankList <= 0)
	self._rankScrollList:reloadData(self._rankList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)

	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"
	self._txtMyValue.text = tostring(self._myValue)

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
end

function GoddessCompetitionRedPackChildRankView:_updateRankCell(view, cell, info, tag)
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

	HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, true)

	local date = GameUtil.time2date(time / 1000)

	txtTime.text = string.format("%02d.%02d.%02d\n%02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)

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

function GoddessCompetitionRedPackChildRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function GoddessCompetitionRedPackChildRankView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function GoddessCompetitionRedPackChildRankView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function GoddessCompetitionRedPackChildRankView:_updateMyPrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function GoddessCompetitionRedPackChildRankView:_clearMyPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return GoddessCompetitionRedPackChildRankView
