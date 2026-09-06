-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/view/PickupidearankView.lua

module("logic.extensions.pickupidea.view.PickupidearankView", package.seeall)

local PickupidearankView = class("PickupidearankView", ViewComponent)

function PickupidearankView:ctor()
	PickupidearankView.super.ctor(self)

	self._scrollList = {}
end

function PickupidearankView:unbindEvents()
	PickupidearankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose, self)
end

function PickupidearankView:bindEvents()
	PickupidearankView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function PickupidearankView:buildUI()
	PickupidearankView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.goEmpty = self:getGo("content/goEmpty")
	self.rankcell = self:getGo("content/rankcell")
	self.rankview = self:getGo("content/rankview")
	self.txtmyRank = self:getTxt("content/myRank/txtMyRank")
	self.txtTip = self:getTxt("content/myRank/txtTip")
	self.scrollList = ScrollerList.create(self.rankview, self.rankcell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function PickupidearankView:onExit()
	PickupidearankView.super.onExit(self)
	self.scrollList:dispose()
end

function PickupidearankView:onEnter()
	PickupidearankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PickUpIdeaGetRankInfoRes, self._onACRankInfoRes, self)
	self:refreshUI()

	self._activityId = PickupideaModel.instance:getActivityId()

	PickUpIdeaAgent.instance:sendPM_PickUpIdeaGetRankInfoReq(self._activityId)
end

function PickupidearankView:refreshUI()
	self.txtmyRank.text = checknumber(self._myRank) > 0 and self._myRank or lang("text_rank_notrank")

	self.scrollList:reloadData(self._rankInfo)
	GameUtil.SetActive(self.goEmpty, not self._rankInfo or #self._rankInfo == 0)
end

function PickupidearankView:_updateCell(view, cell, data, tag)
	local tableview = goutil.findChild(cell, "tableview")
	local tablecell = goutil.findChild(cell, "tablecell")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtServer = goutil.findChildTextComponent(cell, "txtServer")
	local imgRank = goutil.findChild(cell, "imgRank")

	GameUtil.SetActive(imgRank, data.rank <= 3)

	if data.rank <= 3 then
		GameUtil.setUIImageSpriteIdx(imgRank, data.rank - 1)

		txtRank.text = ""
	else
		txtRank.text = data.rank
	end

	HeadItemController.instance:setHeadCellByInfo(imgHeadIcon, data.headInfo, true)

	txtName.text = data.headInfo.userName
	txtScore.text = data.value
	txtServer.text = data.headInfo.areaName

	local scrollList = self._scrollList[tableview]

	if not scrollList then
		scrollList = ScrollerList.create(tableview, tablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
		self._scrollList[tableview] = scrollList
	end

	local prizeCfg = PickupideaConfig.instance:getRankPrizeCfg(data.rank)
	local prize = string.split(prizeCfg.prize, "#")

	scrollList:reloadData(prize)
end

function PickupidearankView:clearCell(cell)
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")
	local tableview = goutil.findChild(cell, "tableview")

	HeadItemController.instance:resetHeadCell(imgHeadIcon)

	local scrollList = self._scrollList[tableview]

	if scrollList then
		scrollList:dispose()
	end
end

function PickupidearankView:_updateRewardCell(view, cell, cfgStr, tag)
	MaterialMgr.resetAll(cell.gameObject)

	local proxy = MaterialMgr.setCellByCfg(cfgStr, cell.gameObject)

	proxy.binder:setEffStatus(false)
end

function PickupidearankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function PickupidearankView:_onACRankInfoRes(msg)
	self._myRank = msg.myRank
	self._rankInfo = msg.rankInfos
	self._myScore = msg.myScore

	table.sort(self._rankInfo, function(a, b)
		return a.rank < b.rank
	end)
	self:refreshUI()
end

return PickupidearankView
