-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxShareListView.lua

module("logic.extensions.giftbox.view.GiftBoxShareListView", package.seeall)

local GiftBoxShareListView = class("GiftBoxShareListView", ViewComponent)

function GiftBoxShareListView:ctor()
	GiftBoxShareListView.super.ctor(self)
end

function GiftBoxShareListView:unbindEvents()
	GiftBoxShareListView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GiftBoxShareListView:bindEvents()
	GiftBoxShareListView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GiftBoxShareListView:buildUI()
	GiftBoxShareListView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._tableView = self:getGo("boxTableCol/boxScrollerview")
	self._tableCell = self:getGo("boxTableCol/boxScrollercell")
	self._txtGainTime = self:getTxt("gainTime/txtTime")
	self._emptyGo = self:getGo("emptyTip")
end

function GiftBoxShareListView:onExit()
	GiftBoxShareListView.super.onExit(self)
end

function GiftBoxShareListView:onEnter()
	GiftBoxShareListView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handleGB_GiftBoxShareListRes, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.handleGB_GiftBoxGainLuckRes, self._PM_GB_GiftBoxGainLuckRes, self)

	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._actId = self:getFirstParam()

	if self._actId <= 0 then
		self:close()

		return
	end

	self._actCfg = GiftBoxConfig.instance:getActCfgById(self._actId)

	GiftBoxAgent.instance:sendGB_GiftBoxShareListReq(self._actId)
end

function GiftBoxShareListView:refreshView()
	local list = GiftBoxModel.instance:getShareList()

	self._tableList:reloadData(list)

	local gainTime = self._actCfg.dailyTimes - GiftBoxModel.instance:getGainLuckTimes()

	self._txtGainTime.text = langPara("%d", gainTime)

	GameUtil.SetActive(self._emptyGo, #list <= 0)
end

function GiftBoxShareListView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local headCon = goutil.findChild(go, "container/headIcon")
	local txtArea = goutil.findChildTextComponent(go, "container/area/txt")
	local txtName = goutil.findChildTextComponent(go, "container/txtName")
	local btnGain = goutil.findChild(go, "container/btnGain")

	txtArea.text = data.headInfo.areaName
	txtName.text = data.headInfo.userName

	HeadItemController.instance:resetHeadCell(headCon)
	HeadItemController.instance:setHeadCellByInfo(headCon, data.headInfo, false)
	GameUtil.rmClickHandler(btnGain)
	GameUtil.addClickHandler(btnGain, function()
		self:_onGainClick(data.headInfo.userId)
	end, self)
end

function GiftBoxShareListView:_clearCell(cell)
	local go = cell.gameObject
	local headCon = goutil.findChild(go, "container/headIcon")
	local btnGain = goutil.findChild(go, "container/btnGain")

	HeadItemController.instance:resetHeadCell(headCon)
	GameUtil.rmClickHandler(btnGain)
end

function GiftBoxShareListView:_onGainClick(targetId)
	if targetId == RoleModel.instance:getUserId() then
		FloatWordMgr.instance:show(lang("不可沾自己的欧气"))

		return
	end

	if GiftBoxModel.instance:getMaxScore() >= self._actCfg.scoreMaxLimit then
		FloatWordMgr.instance:show(lang("欧气值已达上限"))

		return
	end

	if GiftBoxModel.instance:isExistGainLuckUserId(userId) == true then
		UIStateManager.instance:push(ViewName.GiftBoxGetLuckView, false, -36)

		return
	end

	if self._actCfg.dailyTimes <= GiftBoxModel.instance:getGainLuckTimes() then
		FloatWordMgr.instance:show(lang("今日沾欧气次数已用完，明天再来吧~"))

		return
	end

	GiftBoxAgent.instance:sendGB_GiftBoxGainLuckReq(self._actId, targetId)
end

function GiftBoxShareListView:_PM_GB_GiftBoxGainLuckRes()
	GiftBoxAgent.instance:sendGB_GiftBoxShareListReq(self._actId)
end

return GiftBoxShareListView
