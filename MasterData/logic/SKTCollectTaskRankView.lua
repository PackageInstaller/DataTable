-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/collection/SKTCollectTaskRankView.lua

module("logic.extensions.saintknighttask.view.collection.SKTCollectTaskRankView", package.seeall)

local SKTCollectTaskRankView = class("SKTCollectTaskRankView", ViewComponent)

function SKTCollectTaskRankView:ctor()
	SKTCollectTaskRankView.super.ctor(self)
end

function SKTCollectTaskRankView:buildUI()
	SKTCollectTaskRankView.super.buildUI(self)

	self._closeBtn = goutil.findChild(self.mainGO, "closeBtn")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function SKTCollectTaskRankView:bindEvents()
	SKTCollectTaskRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
end

function SKTCollectTaskRankView:unbindEvents()
	SKTCollectTaskRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function SKTCollectTaskRankView:destroyUI()
	SKTCollectTaskRankView.super.destroyUI(self)
end

function SKTCollectTaskRankView:onEnter()
	SKTCollectTaskRankView.super.onEnter(self)

	self._activityId = SaintKnightTaskController.instance:getActivityId()

	local isInTime = SaintKnightTaskController.instance:isInActivityTimeAsSkt(self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._rankId = 0

	if self._rankId <= 0 then
		FloatWordMgr.instance:show("缺失排行榜id")
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.SKTaskCollectionTasksGetRankInfoRes, self._onUpdateUI, self)
	SaintKnightTaskController.instance:sendCollectionTasksGetRankInfoReq(self._activityId, self._rankId)
end

function SKTCollectTaskRankView:onExit()
	SKTCollectTaskRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SKTaskCollectionTasksGetRankInfoRes, self._onUpdateUI, self)
	self:_onClearRankCol()
end

function SKTCollectTaskRankView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateRankColUI()
end

function SKTCollectTaskRankView:_onUpdatePlaneUI()
	local myRank = SaintKnightTaskModel.instance:getMyRankInCollection(self._rankId)

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"
end

function SKTCollectTaskRankView:_onUpdateRankColUI()
	local infoList = SaintKnightTaskModel.instance:getCollectionTasksRankInfoList(self._rankId)

	self._rankScrollList:reloadData(infoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
	GameUtil.SetActive(self._emptyGo, #infoList <= 0)
end

function SKTCollectTaskRankView:_onClearRankCol()
	self._rankScrollList:dispose()
end

function SKTCollectTaskRankView:_updateRankCell(view, cell, info, tag)
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

function SKTCollectTaskRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local btnIcon = goutil.findChild(mainGo, "btnIcon")

	uGuiUtil.clearImage(imgIcon)
	GameUtil.rmClickHandler(btnIcon)
end

return SKTCollectTaskRankView
