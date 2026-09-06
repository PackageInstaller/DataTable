-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatetrial/view/UltimateTrialRankChildScoreView.lua

module("logic.extensions.ultimatetrial.view.UltimateTrialRankChildScoreView", package.seeall)

local UltimateTrialRankChildScoreView = class("UltimateTrialRankChildScoreView", ViewComponent)

function UltimateTrialRankChildScoreView:buildUI()
	UltimateTrialRankChildScoreView.super.buildUI(self)

	self._rankScrollerview = self:getGo("rankCol/rankScrollerview")
	self._rankScrollercell = self:getGo("rankCol/rankScrollercell")
	self._emptyGo = self:getGo("rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollercell = self:getGo("rankCol/itemScrollercell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._txtMyRank = self:getTxt("tipsCol/txtMyRank")
	self._txtMyValue = self:getTxt("tipsCol/txtMyValue")
	self._txtMyTitle = self:getTxt("tipsCol/txtMyTitle")
	self._txtRuleDesc = self:getTxt("tipsCol/txtRuleDesc")
	self._txtFieldValue = self:getTxt("rankCol/titleCol/txtFieldValue")
	self._myPrizeCol = self:getGo("tipsCol/myPrizeCol")
	self._myPrizeCol_itemScrollerview = self:getGo("tipsCol/myPrizeCol/itemScrollerview")
	self._myPrizeCol_itemScrollercell = self:getGo("tipsCol/myPrizeCol/itemScrollercell")
	self._myPrizeScrollList = ScrollerList.create(self._myPrizeCol_itemScrollerview, self._myPrizeCol_itemScrollercell, GameUtil.handler(self._updateMyPrizeItemCell, self), GameUtil.handler(self._clearMyPrizeItemCell, self))

	GameUtil.SetActive(self._myPrizeCol, false)
end

function UltimateTrialRankChildScoreView:bindEvents()
	UltimateTrialRankChildScoreView.super.bindEvents(self)
end

function UltimateTrialRankChildScoreView:unbindEvents()
	UltimateTrialRankChildScoreView.super.unbindEvents(self)
end

function UltimateTrialRankChildScoreView:onEnter()
	UltimateTrialRankChildScoreView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._clgActId = checknumber(params[1])
	self._activityId = UltimateTrialController.instance:getActivityId()

	local isInTime = UltimateTrialController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._rankList = {}
	self._myRank = 0
	self._myValue = 0
	self._clgData = UltimateTrialConfig.instance:getChallengeData(self._activityId, self._clgActId)
	self._txtFieldValue.text = self._clgData.scoreTitle
	self._txtMyTitle.text = "我的" .. self._clgData.scoreTitle
	self._txtRuleDesc.text = self._clgData.scoreRuleDesc

	self.addGEvent(self, GlobalNotify.HandlePM_UltimateTrialGetScoreRankViewRes, self._handleMsgRes, self)
	UltimateTrialController.instance:sendPM_UltimateTrialGetScoreRankViewReq(self._activityId, self._clgActId)
end

function UltimateTrialRankChildScoreView:onExit()
	UltimateTrialRankChildScoreView.super.onExit(self)
	self._rankScrollList:dispose()
	self._myPrizeScrollList:dispose()
end

function UltimateTrialRankChildScoreView:_handleMsgRes(msg)
	if msg.activityId ~= self._activityId or msg.clgActId ~= self._clgActId then
		return
	end

	self._rankList = msg.recordList
	self._myRank = msg.myRank
	self._myValue = msg.myScore

	self:_onUpdate()
end

function UltimateTrialRankChildScoreView:_getPrizesByRank(rank)
	local data = UltimateTrialConfig.instance:getScoreRankPrizeData(self._activityId, self._clgActId, rank)

	return data and data.prize
end

function UltimateTrialRankChildScoreView:_onUpdate()
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
		self._myPrizeScrollList:dispose()
	end

	GameUtil.SetActive(self._emptyGo, #self._rankList <= 0)
	self._rankScrollList:reloadData(self._rankList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
end

function UltimateTrialRankChildScoreView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local headInfo = info.headInfo
	local value = info.value
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
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
	txtValue.text = value

	HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, true)

	local prizes = self:_getPrizesByRank(rank)

	if itemScrollerview and self._itemScrollercell and not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:setCenterMode(true)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
		end
	end
end

function UltimateTrialRankChildScoreView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function UltimateTrialRankChildScoreView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function UltimateTrialRankChildScoreView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function UltimateTrialRankChildScoreView:_updateMyPrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function UltimateTrialRankChildScoreView:_clearMyPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return UltimateTrialRankChildScoreView
