-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/collection/SKTCollectTaskView.lua

module("logic.extensions.saintknighttask.view.collection.SKTCollectTaskView", package.seeall)

local SKTCollectTaskView = class("SKTCollectTaskView", ViewComponent)

function SKTCollectTaskView:ctor()
	SKTCollectTaskView.super.ctor(self)
end

function SKTCollectTaskView:buildUI()
	SKTCollectTaskView.super.buildUI(self)

	self._btnRank = goutil.findChild(self.mainGO, "btnRank")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rewardCol = goutil.findChild(self.mainGO, "rewardCol")
	self._btnGet = goutil.findChild(self.mainGO, "rewardCol/btnGet")
	self._btnGetRed = goutil.findChild(self.mainGO, "rewardCol/btnGet/redPoint")
	self._receiveGo = goutil.findChild(self.mainGO, "rewardCol/receiveGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function SKTCollectTaskView:bindEvents()
	SKTCollectTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGet, self._onClickBtnGet, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
end

function SKTCollectTaskView:unbindEvents()
	SKTCollectTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGet)
	GameUtil.rmClickHandler(self._btnRank)
end

function SKTCollectTaskView:destroyUI()
	SKTCollectTaskView.super.destroyUI(self)
end

function SKTCollectTaskView:onEnter()
	SKTCollectTaskView.super.onEnter(self)

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

	GlobalDispatcher:addListener(GlobalNotify.SKTaskCollectionTasksGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.SKTaskCollectionTasksGetRankInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.SKTaskCollectionTasksGainPrizeRes, self._sendInfoReq, self)
	RedPointController.instance:regRedPoint(self._btnGetRed, SaintKnightTaskConfig.instance:getSktCollectionPrizeRed())
	self:_sendInfoReq()
end

function SKTCollectTaskView:onExit()
	SKTCollectTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SKTaskCollectionTasksGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.SKTaskCollectionTasksGetRankInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.SKTaskCollectionTasksGainPrizeRes, self._sendInfoReq, self)
	RedPointController.instance:unregRedPoint(self._btnGetRed)
	self:_onClearRankCol()
end

function SKTCollectTaskView:_sendInfoReq()
	SaintKnightTaskController.instance:sendCollectionTasksGetInfoReq(self._activityId)
	SaintKnightTaskController.instance:sendCollectionTasksGetRankInfoReq(self._activityId, self._rankId)
end

function SKTCollectTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function SKTCollectTaskView:_onUpdateData()
	return
end

function SKTCollectTaskView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateRankColUI()
	self:_onUpdateRewardColUI()
end

function SKTCollectTaskView:_onUpdatePlaneUI()
	return
end

function SKTCollectTaskView:_onUpdateRankColUI()
	local infoList = SaintKnightTaskModel.instance:getCollectionTasksRankInfoList(self._rankId)

	self._rankScrollList:reloadData(infoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
	GameUtil.SetActive(self._emptyGo, #infoList <= 0)
end

function SKTCollectTaskView:_onClearRankCol()
	self._rankScrollList:dispose()
end

function SKTCollectTaskView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
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

	local function callBack()
		FriendController.instance:showInfoView(info.headInfo.userId, imgIcon)
	end

	GameUtil.addClickHandler(btnIcon, callBack)
end

function SKTCollectTaskView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local btnIcon = goutil.findChild(mainGo, "btnIcon")

	GameUtil.rmClickHandler(btnIcon)
end

function SKTCollectTaskView:_onUpdateRewardColUI()
	local isHasGain = SaintKnightTaskModel.instance:isHasGainAsCollePrize()

	GameUtil.SetActive(self._receiveGo, isHasGain)
	GameUtil.SetActive(self._btnGet, not isHasGain)
end

function SKTCollectTaskView:_onClickBtnGet()
	if not SaintKnightTaskModel.instance:isCanGainAsCollePrize() then
		FloatWordMgr.instance:show("集齐所有圣骑团队精灵后，即可领取哦")

		return
	end

	if SaintKnightTaskModel.instance:isHasGainAsCollePrize() then
		return
	end

	SaintKnightTaskController.instance:sendCollectionTasksGainPrizeReq(self._activityId)
end

function SKTCollectTaskView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.SKTCollectTaskRankView)
end

return SKTCollectTaskView
