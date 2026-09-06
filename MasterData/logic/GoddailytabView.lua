-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddailyrank/view/GoddailytabView.lua

module("logic.extensions.goddailyrank.view.GoddailytabView", package.seeall)

local GoddailytabView = class("GoddailytabView", ViewComponent)

function GoddailytabView:ctor()
	GoddailytabView.super.ctor(self)
end

function GoddailytabView:unbindEvents()
	GoddailytabView.super.unbindEvents(self)
end

function GoddailytabView:bindEvents()
	GoddailytabView.super.bindEvents(self)
end

function GoddailytabView:buildUI()
	GoddailytabView.super.buildUI(self)

	self._emptyGo = self:getGo("emptyGo")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._txtTip = self:getTxt("myRank/txtTip")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._txtMyRankTitle = self:getTxt("myRank/txtMyRankTitle")
	self._txtMyValue = self:getTxt("myRank/txtMyValue")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function GoddailytabView:onExit()
	GoddailytabView.super.onExit(self)
	self._scrollList:dispose()
end

function GoddailytabView:onEnter()
	GoddailytabView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._type = checknumber(params[2])

	self.addGEvent(self, GlobalNotify.GODDAILYRANK_GODRANKVIEW_INFO, self._onRrefreshUI, self)
	self.addGEvent(self, GlobalNotify.GODDAILYRANK_DAILYRANKVIEW_INFO, self._onRrefreshUI, self)

	if not GodDailyRankController.instance:isGodRankClosed(self._activityId) then
		print("麻将排行榜不在关闭时间段，且有数据才显示")

		if self._type == 1 then
			GodDailyRankController.instance:getGodRankInfo(self._activityId)
		elseif self._type == 2 then
			GodDailyRankController.instance:getDailyRankInfo(self._activityId)
		end
	end

	self:_onRrefreshUI()
end

function GoddailytabView:_onRrefreshUI()
	if self._type == 1 then
		self._info = GodDailyRankModel.instance:getGodRankInfo(self._activityId) or {}
	elseif self._type == 2 then
		self._info = GodDailyRankModel.instance:getDailyRankInfo(self._activityId) or {}
	end

	local rankInfoList = {}
	local myRank = -1
	local myScore = 0

	if self._info and not GodDailyRankController.instance:isGodRankClosed(self._activityId) then
		rankInfoList = self._info.rankInfoList or {}
		myRank = checknumber(self._info.myRank)
		myScore = checknumber(self._info.myScore)
	end

	self._scrollList:reloadData(rankInfoList)
	GameUtil.SetActive(self._emptyGo, #rankInfoList == 0)

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"
	self._txtMyValue.text = myScore

	local config = GodDailyRankConfig.instance:getRankCfgById(self._activityId)

	if self._type == 1 then
		self._txtTip.text = config.txtTipsGod or config.txtTipsDaily
	end
end

function GoddailytabView:_updateCell(view, cell, data, tag)
	local headGo = goutil.findChild(cell, "headGo")
	local rankIma = goutil.findChild(cell, "rankIma")
	local imgRank = goutil.findChild(cell, "imgRank")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local rank = checknumber(data.rank)

	txtRank.text = rank
	txtRank.text = ""

	if rank <= 3 then
		GameUtil.SetActive(rankIma, true)
		GameUtil.setUIImageSpriteIdx(rankIma, rank - 1)
	else
		GameUtil.SetActive(rankIma, false)

		txtRank.text = rank
	end

	txtName.text = data.headInfo.userName
	txtScore.text = checknumber(data.value)

	local date = GameUtil.time2date(checknumber(data.time) / 1000)

	txtTime.text = string.format("%04d %02d.%02d\n%02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)

	HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo, true)
end

function GoddailytabView:_clearCell(cell)
	local headGo = goutil.findChild(cell, "headGo")

	HeadItemController.instance:resetHeadCell(headGo)
end

return GoddailytabView
