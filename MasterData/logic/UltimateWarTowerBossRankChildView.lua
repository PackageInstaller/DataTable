-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/ultimatewar/UltimateWarTowerBossRankChildView.lua

module("logic.extensions.commontabrank.view.ultimatewar.UltimateWarTowerBossRankChildView", package.seeall)

local UltimateWarTowerBossRankChildView = class("UltimateWarTowerBossRankChildView", ViewComponent)

function UltimateWarTowerBossRankChildView:buildUI()
	UltimateWarTowerBossRankChildView.super.buildUI(self)

	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._txtMyValue = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyValue")
end

function UltimateWarTowerBossRankChildView:bindEvents()
	UltimateWarTowerBossRankChildView.super.bindEvents(self)
end

function UltimateWarTowerBossRankChildView:unbindEvents()
	UltimateWarTowerBossRankChildView.super.unbindEvents(self)
end

function UltimateWarTowerBossRankChildView:onEnter()
	UltimateWarTowerBossRankChildView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._rankType = UltimateWarEnum.RankType_TowerBoss

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._rankList = {}
	self._myRank = 0
	self._myValue = 0

	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarRankViewRes, self._handleMsgRes, self)
	UltimateWarController.instance:sendPM_UltimateWarRankViewReq(self._activityId, self._rankType)
end

function UltimateWarTowerBossRankChildView:onExit()
	UltimateWarTowerBossRankChildView.super.onExit(self)
	self._rankScrollList:dispose()
end

function UltimateWarTowerBossRankChildView:_handleMsgRes(msg)
	if msg.activityId ~= self._activityId or msg.type ~= self._rankType then
		return
	end

	self._rankList = msg.rankList
	self._myRank = msg.myRank
	self._myValue = checknumber(msg.param)

	self:_onUpdate()
end

function UltimateWarTowerBossRankChildView:_onUpdate()
	GameUtil.SetActive(self._emptyGo, #self._rankList <= 0)
	self._rankScrollList:reloadData(self._rankList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)

	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"
	self._txtMyValue.text = self._myValue
end

function UltimateWarTowerBossRankChildView:_updateRankCell(view, cell, info, tag)
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

function UltimateWarTowerBossRankChildView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)
end

return UltimateWarTowerBossRankChildView
