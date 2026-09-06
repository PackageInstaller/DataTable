-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/festiveflower/view/FestiveFlowerRankView.lua

module("logic.extensions.festiveflower.view.FestiveFlowerRankView", package.seeall)

local FestiveFlowerRankView = class("FestiveFlowerRankView", TableViewComponent)

function FestiveFlowerRankView:_getPath()
	return {
		cellPath = "pagecell",
		viewPath = "pagescrollview"
	}
end

function FestiveFlowerRankView:_cellSize(view, index)
	return 132, 64
end

function FestiveFlowerRankView:ctor()
	FestiveFlowerRankView.super.ctor(self)
end

function FestiveFlowerRankView:unbindEvents()
	FestiveFlowerRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPrize)
end

function FestiveFlowerRankView:bindEvents()
	FestiveFlowerRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
end

function FestiveFlowerRankView:buildUI()
	FestiveFlowerRankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnPrize = self:getBtn("btnPrize")
	self._rankCellGo = self:getGo("cell")
	self._rankScrollerGo = self:getGo("tableview")
	self._empty = self:getGo("empty")
	self._txtTip = self:getTxt("myRank/txtTip")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")

	goutil.setActive(self._empty, false)
	goutil.setActive(self._rankCellGo, false)
end

function FestiveFlowerRankView:onExit()
	FestiveFlowerRankView.super.onExit(self)
	FestiveFlowerController.instance:unregisterLocalNotify(FestiveFlowerController.E_GetRankRes, self._onRankInfoResp, self)
	self._rankScrollList:dispose()

	self._myRank = -1
	self._rankInfos = {}
end

function FestiveFlowerRankView:onEnter()
	FestiveFlowerRankView.super.onEnter(self)
	FestiveFlowerController.instance:registerLocalNotify(FestiveFlowerController.E_GetRankRes, self._onRankInfoResp, self)

	self._rankScrollList = ScrollerList.create(self._rankScrollerGo, self._rankCellGo, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))

	self._rankScrollList:regGetCellSize(function(...)
		return 100, 100
	end)

	self._activityId = FestiveFlowerModel.instance:getActivityId()

	local activityConf = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.FESTIVE_FLOWER, self._activityId)

	if not activityConf or not GameUtil.checkIsInTimePeriod(activityConf.startTime, activityConf.endTime) then
		FloatWordMgr.instance:show(lang("FirePowerContestMainView__2"))
		self:close()

		return
	end

	FestiveFlowerAgent.instance:sendPM_FestiveFlowerFlowerGetRankReq(self._activityId)

	self._txtTip.text = lang("FestiveFlowerRankView__1")
end

function FestiveFlowerRankView:_onRankInfoResp(status, msg)
	self._myRank = -1
	self._rankInfos = {}

	if status == 0 then
		self._myRank = checknumber(msg.myRank)
		self._rankInfos = msg.rankInfos
	end

	self:_updateRank()
end

function FestiveFlowerRankView:_updateRank()
	self._txtMyRank.text = self._myRank > 0 and tostring(self._myRank) or lang("world_Boss_tip9")

	self._rankScrollList:reloadData(self._rankInfos)
	goutil.setActive(self._empty, #self._rankInfos <= 0)
end

function FestiveFlowerRankView:_updateRankCell(view, cell, data, tag)
	local imgRank = goutil.findChildComponent(cell, "imgRank", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local imgIcon = goutil.findChild(cell, "head")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtServerName = goutil.findChildTextComponent(cell, "txtServerName")
	local txtValue = goutil.findChildTextComponent(cell, "txtValue")
	local btnSendFlowerGo = goutil.findChild(cell, "btnSendFlower")

	txtName.text = data.headInfo.userName

	local rank = checknumber(data.rank)
	local isTop3 = rank <= 3

	goutil.setActive(imgRank.gameObject, isTop3)
	goutil.setActive(txtRank.gameObject, not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtRank.text = data.rank
	txtServerName.text = data.headInfo.areaName or ""

	local var_12_0 = tostring(data.score or 0)

	var_12_0 = var_12_0 or "0"
	txtValue.text = var_12_0

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if data.headInfo.userId then
				self:onHeadClick(data.headInfo.userId, imgIcon)
			end
		end)
	end

	goutil.setActive(btnSendFlowerGo, tostring(data.headInfo.userId) ~= tostring(LoginModel.instance.userId))
	GameUtil.rmClickHandler(GameUtil.asBtn(btnSendFlowerGo))
	GameUtil.addClickHandler(GameUtil.asBtn(btnSendFlowerGo), function()
		if data.headInfo then
			SendFlowerController.instance:openSendFlowerView(data.headInfo)
		end
	end, self)
end

function FestiveFlowerRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

function FestiveFlowerRankView:_clearRankCell(cell)
	local imgIcon = goutil.findChild(cell, "head")
	local btnSendFlowerGo = goutil.findChild(cell, "btnSendFlower")

	HeadItemController.instance:resetHeadCell(imgIcon)
	GameUtil.rmClickHandler(GameUtil.asBtn(btnSendFlowerGo))
end

function FestiveFlowerRankView:_onClickPrize()
	UIStateManager.instance:push(ViewName.FestiveFlowerRankPrizeView)
end

return FestiveFlowerRankView
