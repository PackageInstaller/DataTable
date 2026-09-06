-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/view/DragonkingchallengerankView.lua

module("logic.extensions.dragonking.view.DragonkingchallengerankView", package.seeall)

local DragonkingchallengerankView = class("DragonkingchallengerankView", ViewComponent)

function DragonkingchallengerankView:ctor()
	DragonkingchallengerankView.super.ctor(self)
end

function DragonkingchallengerankView:unbindEvents()
	DragonkingchallengerankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DragonkingchallengerankView:bindEvents()
	DragonkingchallengerankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DragonkingchallengerankView:buildUI()
	DragonkingchallengerankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableviewGo = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._reward = self:getGo("reward")
	self._tableView = ScrollerList.create(self._tableviewGo, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._txtTip = self:getTxt("myRank/txtTip")
	self._empty = self:getGo("empty")
end

function DragonkingchallengerankView:onExit()
	DragonkingchallengerankView.super.onExit(self)
	self._tableView:dispose()
end

function DragonkingchallengerankView:onEnter()
	DragonkingchallengerankView.super.onEnter(self)

	self._activityId = DragonKingChallengeController.instance:getActivityId()

	if not self._activityId then
		self:close()
	end

	GameUtil.SetActive(self._reward, false)
	self:_refreshUI()
	self.addGEvent(self, GlobalNotify.DragonKingChallengeUpdate, self._refreshUI, self)
	DragonKingChallengeController.instance:sendGetRankInfoReq(self._activityId)
end

function DragonkingchallengerankView:_updateCell(view, cell, data)
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

	local proxy = HeadItemController.instance:setHeadCellByInfo(head, data.headInfo, true)

	txtRank.text = data.rank
	txtName.text = data.headInfo.userName
	txtArea.text = data.headInfo.areaName
	txtScore.text = data.value

	local rewardCfg = DragonKingChallengeConfig.instance:getPrizeByRank(self._activityId, data.rank)
	local rewardData = string.split(rewardCfg, "#")

	rewardView:reloadData(rewardData)
end

function DragonkingchallengerankView:_updateRewardCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function DragonkingchallengerankView:_clearCell(cell)
	local rewardViewGo = goutil.findChild(cell, "rewardView")
	local rewardView = ScrollerList.create(rewardViewGo, self._reward, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))

	rewardView:dispose()
end

function DragonkingchallengerankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
end

function DragonkingchallengerankView:_refreshUI()
	self._scrollMap = {}
	self._rankList = DragonKingChallengeModel.instance.rankInfos or {}

	local rankCount = #self._rankList

	GameUtil.SetActive(self._empty, rankCount <= 0)
	self._tableView:reloadData(self._rankList)

	local myRank = checknumber(DragonKingChallengeModel.instance.myRank)

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"
end

return DragonkingchallengerankView
