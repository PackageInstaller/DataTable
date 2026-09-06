-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/tutorsystem/TutorSystemMoonRankChildView.lua

module("logic.extensions.commontabrank.view.tutorsystem.TutorSystemMoonRankChildView", package.seeall)

local TutorSystemMoonRankChildView = class("TutorSystemMoonRankChildView", ViewComponent)

function TutorSystemMoonRankChildView:buildUI()
	TutorSystemMoonRankChildView.super.buildUI(self)

	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._txtMyValue = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyValue")
end

function TutorSystemMoonRankChildView:bindEvents()
	TutorSystemMoonRankChildView.super.bindEvents(self)
end

function TutorSystemMoonRankChildView:unbindEvents()
	TutorSystemMoonRankChildView.super.unbindEvents(self)
end

function TutorSystemMoonRankChildView:onEnter()
	TutorSystemMoonRankChildView.super.onEnter(self)

	self._rankList = {}
	self._myRank = 0

	self.addGEvent(self, GlobalNotify.HandlePM_TutorTeacherMonthlyRankInfoRes, self._handleMsgRes, self)
	TutorSystemController.instance:sendPM_TutorTeacherMonthlyRankInfoReq()
end

function TutorSystemMoonRankChildView:onExit()
	TutorSystemMoonRankChildView.super.onExit(self)
	self._rankScrollList:dispose()
end

function TutorSystemMoonRankChildView:_handleMsgRes(msg)
	self._rankList = msg.rankInfos
	self._myRank = msg.myRank
	self._myValue = msg.finishTutorNum

	self:_onUpdate()
end

function TutorSystemMoonRankChildView:_getPrizesByRank(rank)
	local data = TutorSystemConfig.instance:getRankPrizeDataByRank(rank)

	if data then
		return data.prize
	end
end

function TutorSystemMoonRankChildView:_onUpdate()
	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"
	self._txtMyValue.text = self._myValue

	GameUtil.SetActive(self._emptyGo, #self._rankList <= 0)
	self._rankScrollList:reloadData(self._rankList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
end

function TutorSystemMoonRankChildView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local headInfo = info.headInfo
	local value = info.value
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
	txtValue.text = value

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

function TutorSystemMoonRankChildView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function TutorSystemMoonRankChildView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function TutorSystemMoonRankChildView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function TutorSystemMoonRankChildView:_updateMyPrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function TutorSystemMoonRankChildView:_clearMyPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return TutorSystemMoonRankChildView
