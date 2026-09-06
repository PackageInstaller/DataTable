-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldChildRankView.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldChildRankView", package.seeall)

local HolyDragonFieldChildRankView = class("HolyDragonFieldChildRankView", ViewComponent)

function HolyDragonFieldChildRankView:buildUI()
	HolyDragonFieldChildRankView.super.buildUI(self)

	self._rankScrollerview = self:getGo("rankCol/rankScrollerview")
	self._rankScrollercell = self:getGo("rankCol/rankScrollercell")
	self._emptyGo = self:getGo("rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollercell = self:getGo("rankCol/itemScrollercell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._txtMyRank = self:getTxt("tipsCol/txtMyRank")
	self._txtMyValue = self:getTxt("tipsCol/txtMyValue")
	self._myPrizeCol = self:getGo("tipsCol/myPrizeCol")
	self._myPrizeColItemScrollerview = self:getGo("tipsCol/myPrizeCol/itemScrollerview")
	self._myPrizeColItemScrollercell = self:getGo("tipsCol/myPrizeCol/itemScrollercell")
	self._myPrizeScrollList = ScrollerList.create(self._myPrizeColItemScrollerview, self._myPrizeColItemScrollercell, GameUtil.handler(self._updateMyPrizeItemCell, self), GameUtil.handler(self._clearMyPrizeItemCell, self))

	GameUtil.SetActive(self._myPrizeCol, false)
end

function HolyDragonFieldChildRankView:bindEvents()
	HolyDragonFieldChildRankView.super.bindEvents(self)
end

function HolyDragonFieldChildRankView:unbindEvents()
	HolyDragonFieldChildRankView.super.unbindEvents(self)
end

function HolyDragonFieldChildRankView:onEnter()
	HolyDragonFieldChildRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._fieldId = checknumber(params[2])
	self._subMo = HolyDragonFieldController.instance:getSubMo(self._activityId)
	self._fieldData = HolyDragonFieldConfig.instance:getFieldData(self._activityId, self._fieldId)
	self._rankList = {}
	self._myRank = 0
	self._myValue = 0

	self.addGEvent(self, GlobalNotify.HolyDragonField_RankRefresh, self._handleRankRefresh, self)
	HolyDragonFieldController.instance:sendPM_HolyDragonFieldRankViewReq(self._activityId, self._fieldId)
end

function HolyDragonFieldChildRankView:onExit()
	HolyDragonFieldChildRankView.super.onExit(self)
	self._rankScrollList:dispose()
	self._myPrizeScrollList:dispose()

	for _, itemScrollList in pairs(self._itemScrollListDic) do
		itemScrollList:dispose()
	end

	table.clear(self._itemScrollListDic)
end

function HolyDragonFieldChildRankView:_handleRankRefresh(activityId, fieldId)
	if activityId ~= self._activityId or fieldId ~= self._fieldId then
		return
	end

	local msg = self._subMo:getRankMsg()

	self._rankList = msg.infoList
	self._myRank = msg.myRank
	self._myValue = msg.myScore

	self:_onUpdate()
end

function HolyDragonFieldChildRankView:_getPrizesByRank(rank)
	rank = checknumber(rank)

	if rank <= 0 then
		return nil
	end

	local data = HolyDragonFieldConfig.instance:getScoreRankPrizeData(self._fieldData.rankPlanId, rank)

	return data and data.prize
end

function HolyDragonFieldChildRankView:_onUpdate()
	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"
	self._txtMyValue.text = self._myValue

	local prizes = self:_getPrizesByRank(self._myRank)

	if not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		self._myPrizeScrollList:reloadData(prizeStrArr)
		self._myPrizeScrollList:dragNotifyParent()
		GameUtil.SetActive(self._myPrizeCol, true)
	else
		GameUtil.SetActive(self._myPrizeCol, false)
		self._myPrizeScrollList:reloadData({})
	end

	GameUtil.SetActive(self._emptyGo, #self._rankList <= 0)
	self._rankScrollList:reloadData(self._rankList)
	self._rankScrollList:MoveCellInView(0, true)
end

function HolyDragonFieldChildRankView:_updateRankCell(view, cell, info, tag)
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
	elseif self._itemScrollListDic[mainGo] then
		self._itemScrollListDic[mainGo]:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function HolyDragonFieldChildRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function HolyDragonFieldChildRankView:_updateItemCell(view, cell, prizeStr, tag)
	MaterialMgr.setCellByCfg(prizeStr, cell.gameObject)
end

function HolyDragonFieldChildRankView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function HolyDragonFieldChildRankView:_updateMyPrizeItemCell(view, cell, prizeStr, tag)
	MaterialMgr.setCellByCfg(prizeStr, cell.gameObject)
end

function HolyDragonFieldChildRankView:_clearMyPrizeItemCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return HolyDragonFieldChildRankView
