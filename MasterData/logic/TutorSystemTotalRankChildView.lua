-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/tutorsystem/TutorSystemTotalRankChildView.lua

module("logic.extensions.commontabrank.view.tutorsystem.TutorSystemTotalRankChildView", package.seeall)

local TutorSystemTotalRankChildView = class("TutorSystemTotalRankChildView", ViewComponent)

function TutorSystemTotalRankChildView:buildUI()
	TutorSystemTotalRankChildView.super.buildUI(self)

	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._txtMyValue = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyValue")
end

function TutorSystemTotalRankChildView:bindEvents()
	TutorSystemTotalRankChildView.super.bindEvents(self)
end

function TutorSystemTotalRankChildView:unbindEvents()
	TutorSystemTotalRankChildView.super.unbindEvents(self)
end

function TutorSystemTotalRankChildView:onEnter()
	TutorSystemTotalRankChildView.super.onEnter(self)

	self._rankList = {}
	self._myRank = 0

	self.addGEvent(self, GlobalNotify.HandlePM_TutorTeacherRankInfoRes, self._handleMsgRes, self)
	TutorSystemController.instance:sendPM_TutorTeacherRankInfoReq()
end

function TutorSystemTotalRankChildView:onExit()
	TutorSystemTotalRankChildView.super.onExit(self)
	self._rankScrollList:dispose()
end

function TutorSystemTotalRankChildView:_handleMsgRes(msg)
	self._rankList = msg.rankInfos
	self._myRank = msg.myRank
	self._myValue = msg.finishTutorNum

	self:_onUpdate()
end

function TutorSystemTotalRankChildView:_onUpdate()
	GameUtil.SetActive(self._emptyGo, #self._rankList <= 0)
	self._rankScrollList:reloadData(self._rankList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)

	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"
	self._txtMyValue.text = self._myValue
end

function TutorSystemTotalRankChildView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local headInfo = info.headInfo
	local value = info.value
	local mainGo = cell.gameObject
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtValue = goutil.findChildTextComponent(mainGo, "txtValue")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtRank.text = rank
	txtName.text = headInfo.userName
	txtValue.text = value
	txtArea.text = headInfo.areaName

	HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, true)
end

function TutorSystemTotalRankChildView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)
end

return TutorSystemTotalRankChildView
