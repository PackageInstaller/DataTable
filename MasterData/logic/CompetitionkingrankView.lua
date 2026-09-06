-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/view/CompetitionkingrankView.lua

module("logic.extensions.competitionking.view.CompetitionkingrankView", package.seeall)

local CompetitionkingrankView = class("CompetitionkingrankView", ViewComponent)

function CompetitionkingrankView:ctor()
	CompetitionkingrankView.super.ctor(self)
end

function CompetitionkingrankView:unbindEvents()
	CompetitionkingrankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CompetitionkingrankView:bindEvents()
	CompetitionkingrankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CompetitionkingrankView:buildUI()
	CompetitionkingrankView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txt")
	self._tableviewGo = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._reward = self:getGo("reward")
	self._tableView = ScrollerList.create(self._tableviewGo, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._empty = self:getGo("empty")
	self._txtMyValue = self:getTxt("myRank/txtMyValue")
	self._leftTop = self:getGo("leftTop")
	self._btnClose = self:getGo("leftTop/btnClose")
end

function CompetitionkingrankView:onExit()
	CompetitionkingrankView.super.onExit(self)
	self._tableView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.CompetitionKingGetRankInfoRes, self._refreshUI, self)
end

function CompetitionkingrankView:onEnter()
	CompetitionkingrankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.CompetitionKingGetRankInfoRes, self._refreshUI, self)

	self._activityId = CompetitionKingController.instance:getActivityId()
	self._activityType = CompetitionKingController.instance:getActivityType()

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))

	CompetitionKingController.instance:sendPM_CompetitionKingGetRankInfoReq(self._activityId)
	GameUtil.SetActive(self._reward, false)
	GameUtil.SetActive(self._leftTop, false)
end

function CompetitionkingrankView:_updateCell(view, cell, data)
	local imgRank = goutil.findChild(cell, "imgRank")
	local head = goutil.findChild(cell, "head")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local rewardViewGo = goutil.findChild(cell, "rewardView")
	local rewardView = self._scrollMap[cell]

	if rewardView == nil then
		rewardView = ScrollerList.create(rewardViewGo, self._reward, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))

		rewardView:dragNotifyParent()

		self._scrollMap[cell] = rewardView
	end

	local isTopThree = data.rank >= 1 and data.rank <= 3

	if isTopThree then
		GameUtil.setUIImageSpriteIdx(imgRank, data.rank - 1)
	end

	GameUtil.SetActive(imgRank, isTopThree)
	GameUtil.SetActive(txtRank, not isTopThree)

	local proxy = HeadItemController.instance:setHeadCellByInfo(head, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			FriendController.instance:showInfoView(data.headInfo.userId, head)
		end)
	end

	txtRank.text = data.rank
	txtName.text = data.headInfo.userName
	txtArea.text = data.headInfo.areaName
	txtScore.text = data.value

	local rewardCfg = CompetitionKingConfig.instance:getPrizeByRank(self._activityId, data.rank)
	local rewardData = string.split(rewardCfg, "#")

	rewardView:reloadData(rewardData)
end

function CompetitionkingrankView:_updateRewardCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function CompetitionkingrankView:_clearCell(cell)
	local rewardView = self._scrollMap[cell]

	if rewardView then
		rewardView:dispose()
	end
end

function CompetitionkingrankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
end

function CompetitionkingrankView:_refreshUI()
	self._scrollMap = {}
	self._rankList = CompetitionKingModel.instance:getRankList()

	local rankCount = #self._rankList

	GameUtil.SetActive(self._empty, rankCount <= 0)
	GameUtil.SetActive(self._tableviewGo, rankCount > 0)

	if rankCount > 0 then
		self._tableView:reloadData(self._rankList)
	end

	local myRank = CompetitionKingModel.instance:getMyRank()
	local myValue = CompetitionKingModel.instance:getScore()

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"
	self._txtMyValue.text = myValue > 0 and myValue or "无"
end

return CompetitionkingrankView
