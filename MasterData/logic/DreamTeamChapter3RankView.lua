-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapter3RankView.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapter3RankView", package.seeall)

local DreamTeamChapter3RankView = class("DreamTeamChapter3RankView", ViewComponent)

function DreamTeamChapter3RankView:buildUI()
	DreamTeamChapter3RankView.super.buildUI(self)

	self._filedView = goutil.findChild(self.mainGO, "rankCol/titleCol/filedView")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")

	GameUtil.SetActive(self._itemScrollercell, false)

	self._btnClose = self:getGo("btnClose")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._txtMaxScore = self:getTxt("tipsCol/txtMaxScore")
	self._txtTip = self:getTxt("tipsCol/tip/txtTip")
end

function DreamTeamChapter3RankView:bindEvents()
	DreamTeamChapter3RankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DreamTeamChapter3RankView:unbindEvents()
	DreamTeamChapter3RankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DreamTeamChapter3RankView:onEnter()
	DreamTeamChapter3RankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DreamTeamChapterRankViewRes, self._handlePM_DreamTeamChapterRankViewRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._myRank = 0
	self._rankInfoList = {}
	self._rewardMap = {}

	DreamTeamChapterController.instance:sendPM_DreamTeamChapterRankViewReq(self._activityId)
end

function DreamTeamChapter3RankView:onExit()
	DreamTeamChapter3RankView.super.onExit(self)
	self._rankScrollList:dispose()
end

function DreamTeamChapter3RankView:_handlePM_DreamTeamChapterRankViewRes(msg)
	self._rankMsg = msg
	self._myRank = self._rankMsg.myRank
	self._rankInfoList = self._rankMsg.rankInfoList

	self:_onUpdate()
end

function DreamTeamChapter3RankView:_onUpdate()
	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"

	GameUtil.SetActive(self._emptyGo, #self._rankInfoList <= 0)
	self._rankScrollList:reloadData(self._rankInfoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
end

function DreamTeamChapter3RankView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local headInfo = info.headInfo
	local tagNum = info.value
	local sumbitTimeSec = info.time
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local txtAreaName = goutil.findChildTextComponent(mainGo, "txtAreaName")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local tableviewReward = goutil.findChild(mainGo, "tableviewReward")
	local tablecellReward = goutil.findChild(mainGo, "tableviewReward/tablecell")

	self._rewardMap[cell] = self._rewardMap[cell] or ScrollerList.create(tableviewReward, tablecellReward, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local scroll = self._rewardMap[cell]
	local rankCfg = DreamTeamChapterConfig.instance:getRankPrizeCfgByRank(self._activityId, rank) or {}

	if not rankCfg.prize then
		local prize = ""
		local prizeList = string.split(prize, "#")

		scroll:reloadData(prizeList)

		txtRank.text = rank

		local isTop3 = checknumber(rank) <= 3

		imgRank.gameObject:SetActive(isTop3)
		txtRank.gameObject:SetActive(not isTop3)

		if isTop3 then
			imgRank:SetState(rank - 1)
		end

		if txtName then
			txtName.text = headInfo.userName
		end

		txtAreaName.text = headInfo.areaName
		txtScore.text = tagNum

		if txtTime then
			local timeStr = ""
			local timeSec = checknumber(sumbitTimeSec)

			if timeSec > 0 then
				local timeDate = os.date("*t", timeSec / 1000)

				timeStr = string.format("%d %02d.%02d\n%02d:%02d:%02d", timeDate.year, timeDate.month, timeDate.day, timeDate.hour, timeDate.min, timeDate.sec)
			end

			txtTime.text = timeStr
		end

		HeadItemController.instance:setHeadCellByInfo(imgIcon, headInfo, true)
	end
end

function DreamTeamChapter3RankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local scroll = self._rewardMap[cell]

	if scroll then
		scroll:dispose()
	end

	HeadItemController.instance:resetHeadCell(imgIcon)
end

function DreamTeamChapter3RankView:_updateCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function DreamTeamChapter3RankView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(cell)
end

return DreamTeamChapter3RankView
