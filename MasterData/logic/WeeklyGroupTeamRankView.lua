-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklygroup/view/WeeklyGroupTeamRankView.lua

module("logic.extensions.weeklygroup.view.WeeklyGroupTeamRankView", package.seeall)

local WeeklyGroupTeamRankView = class("WeeklyGroupTeamRankView", ViewComponent)

function WeeklyGroupTeamRankView:ctor()
	WeeklyGroupTeamRankView.super.ctor(self)
end

function WeeklyGroupTeamRankView:unbindEvents()
	WeeklyGroupTeamRankView.super.unbindEvents(self)
end

function WeeklyGroupTeamRankView:bindEvents()
	WeeklyGroupTeamRankView.super.bindEvents(self)
end

function WeeklyGroupTeamRankView:buildUI()
	WeeklyGroupTeamRankView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._scrollRect = self:getScrollRect("tableview")
	self._rankCell = self:getGo("teamCell")
	self._tableview = ScrollerList.create(self._tableviewGo, self._rankCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._empty = self:getGo("empty")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._reawrdCell = self:getGo("reward")
	self._txtTip = self:getTxt("myRank/txtTip")
	self._txtScore = self:getTxt("title/txtScore")
end

function WeeklyGroupTeamRankView:onExit()
	WeeklyGroupTeamRankView.super.onExit(self)
	self._tableview:dispose()

	for _, v in pairs(self._rewardScroller) do
		v:dispose()
	end

	self._rewardScroller = nil
end

function WeeklyGroupTeamRankView:onEnter()
	WeeklyGroupTeamRankView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.WeeklyGroup)
	self._groupCfg = WeeklyGroupConfig.instance:getWeeklyGroupCfgById(self._activityId)

	self.addGEvent(self, GlobalNotify.WeeklyGroupRankViewRes, self._refresh, self)
	WeeklyGroupController.instance:sendPM_WeeklyGroupRankViewReq(self._activityId, 2)
	GameUtil.SetActive(self._rankCell, false)

	self._rewardScroller = {}
	self._txtTip.text = string.nilorempty(self._groupCfg.teamRankTip) and lang("weeklyGroupTeamRankTip") or self._groupCfg.teamRankTip

	local matName = MaterialMgr.getMaterialsNameByCfg(self._groupCfg.itemKey)

	self._txtScore.text = string.format("累计%s", matName)
end

function WeeklyGroupTeamRankView:_refresh()
	local info = WeeklyGroupModel.instance:getRankInfo()
	local isEmpty = TableUtil.isTableEmpty(info)
	local myRank = WeeklyGroupModel.instance:getMyRank()

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"

	if isEmpty then
		GameUtil.SetActive(self._tableviewGo, false)
		GameUtil.SetActive(self._empty, true)
	else
		GameUtil.SetActive(self._tableviewGo, true)
		GameUtil.SetActive(self._empty, false)
		self._tableview:reloadData(info)
		self._tableview:regReloadFinish(function()
			self._scrollRect.scrollRect.verticalNormalizedPosition = 1
		end)
	end
end

function WeeklyGroupTeamRankView:_updateCell(view, cell, data)
	local imgRank = goutil.findChild(cell, "imgRank")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local head = goutil.findChild(cell, "head")
	local rewardView = goutil.findChild(cell, "rewardView")
	local rewardView = ScrollerList.create(rewardView, self._reawrdCell, GameUtil.handler(self._updateRewarCell, self), GameUtil.handler(self._clearRewardCell, self))

	self._rewardScroller[cell] = rewardView
	txtRank.text = data.rank
	txtScore.text = data.score

	local headInfo = data.headInfo

	txtName.text = headInfo.userName

	local proxy = HeadItemController.instance:setHeadCellByInfo(head, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			FriendController.instance:showInfoView(data.headInfo.userId, head)
		end)
	end

	local isTopThree = data.rank >= 1 and data.rank <= 3

	if isTopThree then
		GameUtil.setUIImageSpriteIdx(imgRank, data.rank - 1)
	end

	GameUtil.SetActive(imgRank, isTopThree)
	GameUtil.SetActive(txtRank, not isTopThree)

	local prizeCfg = WeeklyGroupConfig.instance:getTeamPrizeByRank(self._activityId, data.rank)
	local prizeData = string.split(prizeCfg, "#")

	if prizeData then
		rewardView:reloadData(prizeData)
	end

	rewardView:reloadData(prizeData)
	rewardView:dragNotifyParent()
end

function WeeklyGroupTeamRankView:_clearCell(cell)
	if self._rewardScroller[cell] then
		self._rewardScroller[cell]:dispose()
	end
end

function WeeklyGroupTeamRankView:_updateRewarCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function WeeklyGroupTeamRankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
end

return WeeklyGroupTeamRankView
