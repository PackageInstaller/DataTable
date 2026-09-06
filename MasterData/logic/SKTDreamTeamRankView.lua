-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/dream/SKTDreamTeamRankView.lua

module("logic.extensions.saintknighttask.view.dream.SKTDreamTeamRankView", package.seeall)

local SKTDreamTeamRankView = class("SKTDreamTeamRankView", ViewComponent)

function SKTDreamTeamRankView:buildUI()
	SKTDreamTeamRankView.super.buildUI(self)

	local tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	local tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")

	self._tabScrollList = ScrollerList.create(tabScrollerview, tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._filedView = goutil.findChild(self.mainGO, "rankCol/titleCol/filedView")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtTip")
end

function SKTDreamTeamRankView:bindEvents()
	SKTDreamTeamRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SKTDreamTeamRankView:unbindEvents()
	SKTDreamTeamRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SKTDreamTeamRankView:onEnter()
	SKTDreamTeamRankView.super.onEnter(self)

	self._activityId = SaintKnightTaskController.instance:getActivityId()

	local isInTime = SaintKnightTaskController.instance:isInActivityTimeAsSkt(self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._rankCfg = SaintKnightTaskConfig.instance:getSktRankCfg(self._activityId) or {}

	self:_setCurTabIdx(#self._rankCfg > 0 and 1 or 0)
	self.addGEvent(self, GlobalNotify.SKTaskCollectionTasksGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.SKTaskCollectionTasksGetRankInfoRes, self._onUpdate, self)
	self:_onUpdate()

	if self:_getCurTabIdx() > 0 then
		SaintKnightTaskController.instance:sendCollectionTasksGetRankInfoReq(self._activityId, self:_getCurRankId())
	end
end

function SKTDreamTeamRankView:onExit()
	SKTDreamTeamRankView.super.onExit(self)
	self:_onClearTabColUI()
	self:_onClearRankCol()
end

function SKTDreamTeamRankView:_onUpdateData()
	self._tabInfoList = {}

	for idx, data in ipairs(self._rankCfg) do
		local info = {}

		info.tabIdx = data.index
		info.rankId = data.rankId
		info.data = data
		self._tabInfoList[idx] = info
	end

	if self._curTabIdx == nil or self:_getTabInfo(self._curTabIdx) == nil then
		self:_setCurTabIdx(#self._tabInfoList > 0 and 1 or 0)
	end

	self._myRank = SaintKnightTaskModel.instance:getMyRankInCollection(self:_getCurRankId())
	self._rankInfoList = SaintKnightTaskModel.instance:getCollectionTasksRankInfoList(self:_getCurRankId())
end

function SKTDreamTeamRankView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function SKTDreamTeamRankView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTabColUI()
	self:_onUpdateRankColUI()
end

function SKTDreamTeamRankView:_onUpdatePlaneUI()
	local data = SaintKnightTaskConfig.instance:getSktRankData(self._activityId, self:_getCurTabIdx())

	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"

	if data then
		if data then
			self._txtTip.text = data.tips or "榜单每15分钟更新一次"
		end
	end

	GameUtil.SetActive(self._emptyGo, #self._rankInfoList <= 0)
end

function SKTDreamTeamRankView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabInfoList)
end

function SKTDreamTeamRankView:_onClearTabColUI()
	self._tabScrollList:dispose()
end

function SKTDreamTeamRankView:_updateTabCell(view, cell, info, tag)
	local tabIdx = info.tabIdx
	local data = info.data
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.name

	GameUtil.setUIGroupIdx(mainGo, self:_getCurTabIdx() == tabIdx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, info))
end

function SKTDreamTeamRankView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function SKTDreamTeamRankView:_onClickTab(info)
	self:_setCurTabIdx(info.tabIdx)
	self:_onUpdate()
	SaintKnightTaskController.instance:sendCollectionTasksGetRankInfoReq(self._activityId, info.rankId)
end

function SKTDreamTeamRankView:_setCurTabIdx(tabIdx)
	self._curTabIdx = tabIdx
end

function SKTDreamTeamRankView:_getCurTabIdx()
	return self._curTabIdx
end

function SKTDreamTeamRankView:_getCurRankId()
	local info = self:_getTabInfo(self:_getCurTabIdx())

	return (info or nil) and (info.rankId or 0)
end

function SKTDreamTeamRankView:_getTabInfo(tabIdx)
	return self._tabInfoList[tabIdx]
end

function SKTDreamTeamRankView:_onUpdateRankColUI()
	self._rankScrollList:reloadData(self._rankInfoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)

	local data = SaintKnightTaskConfig.instance:getSktRankData(self._activityId, self:_getCurTabIdx())

	if data then
		local str
		local children = GameUtil.getChildren(self._filedView)

		for idx, go in ipairs(children) do
			go:GetComponent(goutil.Type_UIText).text = data.fields[idx] or ""
		end
	end
end

function SKTDreamTeamRankView:_onClearRankCol()
	self._rankScrollList:dispose()
end

function SKTDreamTeamRankView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local btnIcon = goutil.findChild(mainGo, "btnIcon")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)

	txtRank.text = info.rank

	local isTop3 = checknumber(info.rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(info.rank - 1)
	end

	txtName.text = info.headInfo.userName
	txtArea.text = info.areaName

	local timeStr = ""
	local timeSec = checknumber(info.sumbitTimeSec)

	if timeSec > 0 then
		local timeDate = os.date("*t", timeSec / 1000)

		timeStr = string.format("%d %02d.%02d\n%02d:%02d:%02d", timeDate.year, timeDate.month, timeDate.day, timeDate.hour, timeDate.min, timeDate.sec)
	end

	txtTime.text = timeStr

	HeadItemController.instance:setHeadCellByInfo(imgIcon, info.headInfo)

	local function callBack()
		FriendController.instance:showInfoView(info.headInfo.userId, imgIcon)
	end

	GameUtil.addClickHandler(btnIcon, callBack)
end

function SKTDreamTeamRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local btnIcon = goutil.findChild(mainGo, "btnIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)
	GameUtil.rmClickHandler(btnIcon)
end

return SKTDreamTeamRankView
