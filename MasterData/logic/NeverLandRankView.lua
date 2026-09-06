-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neverland/view/NeverLandRankView.lua

module("logic.extensions.neverland.view.NeverLandRankView", package.seeall)

local NeverLandRankView = class("NeverLandRankView", ViewComponent)

function NeverLandRankView:ctor()
	NeverLandRankView.super.ctor(self)
end

function NeverLandRankView:unbindEvents()
	NeverLandRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTeam)
	GameUtil.rmClickHandler(self._btnPerson)
end

function NeverLandRankView:bindEvents()
	NeverLandRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnDefend, self._onClickDefend, self)
	GameUtil.addClickHandler(self._btnAttack, self._onClickAttack, self)
end

function NeverLandRankView:buildUI()
	NeverLandRankView.super.buildUI(self)

	self._rankCell = self:getGo("cell")
	self._empty = self:getGo("empty")
	self._reawrdCell = self:getGo("reward")
	self._tableviewGo = self:getGo("tableview")
	self._txtTip = self:getTxt("myRank/txtTip")
	self._txtTitleTip = self:getTxt("title/txtScore")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._btnDefend = self:getBtn("tab/btnDefend")
	self._btnAttack = self:getBtn("tab/btnAttack")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._defendChange = self._btnDefend.gameObject:GetComponent(typeof(UIChangeGroup))
	self._attackChange = self._btnAttack.gameObject:GetComponent(typeof(UIChangeGroup))
	self._scrollRect = self:getScrollRect("tableview")
	self._tableview = ScrollerList.create(self._tableviewGo, self._rankCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function NeverLandRankView:onExit()
	NeverLandRankView.super.onExit(self)
	self._tableview:dispose()

	for _, v in pairs(self._rewardScroller) do
		v:dispose()
	end

	self._rewardScroller = nil
end

function NeverLandRankView:onEnter()
	NeverLandRankView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.NeverLand)

	self.addGEvent(self, GlobalNotify.NeverLandGetRankRes, self._refresh, self)

	self._mode = "defense"

	GameUtil.SetActive(self._rankCell, false)

	self._rewardScroller = {}
	self._txtTip.text = lang("NeverLandRankTip")

	self:_onClickDefend()
end

function NeverLandRankView:_sendGetInfoReq()
	NeverLandController.instance:sendPM_NeverLandGetRankReq(self._activityId, self._mode)
end

function NeverLandRankView:_refresh()
	local info = NeverLandModel.instance:getRankInfo()
	local isEmpty = TableUtil.isTableEmpty(info)
	local myRank = NeverLandModel.instance:getMyRank()

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

function NeverLandRankView:_updateCell(view, cell, data)
	local imgRank = goutil.findChild(cell, "imgRank")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local head = goutil.findChild(cell, "head")
	local rewardViewGo = goutil.findChild(cell, "rewardView")
	local rewardView = self._rewardScroller[cell]

	if rewardView == nil then
		rewardView = ScrollerList.create(rewardViewGo, self._reawrdCell, GameUtil.handler(self._updateRewarCell, self), GameUtil.handler(self._clearRewardCell, self))
	end

	self._rewardScroller[cell] = rewardView
	txtRank.text = data.rank
	txtScore.text = self._mode == "attack" and string.format("%.2fW", data.value / 10000) or data.value

	local headInfo = data.headInfo

	txtName.text = headInfo.userName

	local time = GameUtil.time2date(data.time / 1000)

	txtTime.text = string.format("%04d年%02d月%02d日\n%02d:%02d:%02d", time.year, time.month, time.day, time.hour, time.min, time.sec)

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

	local prizeCfg = NeverLandConfig.instance:getRankCfg(self._activityId, self._mode, data.rank)
	local prizeData = string.split(prizeCfg, "#")

	if prizeData then
		rewardView:reloadData(prizeData)
	end

	rewardView:dragNotifyParent()
end

function NeverLandRankView:_clearCell(cell)
	if self._rewardScroller[cell] then
		self._rewardScroller[cell]:dispose()
	end
end

function NeverLandRankView:_updateRewarCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function NeverLandRankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
end

function NeverLandRankView:_onClickDefend()
	self._mode = "defense"
	self._txtTitleTip.text = "坚持回合数"

	self._attackChange:SetState(0)
	self._defendChange:SetState(1)
	self:_sendGetInfoReq()
end

function NeverLandRankView:_onClickAttack()
	self._mode = "attack"
	self._txtTitleTip.text = "造成伤害数"

	self._attackChange:SetState(1)
	self._defendChange:SetState(0)
	self:_sendGetInfoReq()
end

return NeverLandRankView
