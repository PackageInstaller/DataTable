-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/view/DreampaintershowView.lua

module("logic.extensions.dreampainter.view.DreampaintershowView", package.seeall)

local DreampaintershowView = class("DreampaintershowView", ViewComponent)

function DreampaintershowView:ctor()
	DreampaintershowView.super.ctor(self)
end

function DreampaintershowView:unbindEvents()
	DreampaintershowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
end

function DreampaintershowView:bindEvents()
	DreampaintershowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickLeft, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickRight, self)
end

function DreampaintershowView:buildUI()
	DreampaintershowView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnLeft = self:getGo("btnLeft")
	self._btnRight = self:getGo("btnRight")
	self._cell = self:getGo("cell")
end

function DreampaintershowView:onExit()
	DreampaintershowView.super.onExit(self)
end

function DreampaintershowView:onEnter()
	DreampaintershowView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._curPhaseId = checknumber(params[2])
	self._works = params[3] or {}
	self._info = params[4] or {}
	self._isDisplay = params[5]
	self._curPage = 1

	for i, v in ipairs(self._works) do
		if self._info.workId == v.workId then
			self._curPage = i
		end
	end

	self:_refreshList()
	self.addGEvent(self, GlobalNotify.DreamPainterPageUpdate, self._onPageUpdate, self)
end

function DreampaintershowView:_onPageUpdate(msg)
	local workId = msg.workId

	if self._info and self._info.workId == workId then
		self:_updateCell(self._cell, self._info)
	end
end

function DreampaintershowView:_onClickLeft()
	self._curPage = math.max(1, self._curPage - 1)

	self:_refreshList()
end

function DreampaintershowView:_onClickRight()
	self._curPage = math.min(#self._works, self._curPage + 1)

	self:_refreshList()
end

function DreampaintershowView:_refreshList()
	local index = self._curPage

	GameUtil.SetActive(self._btnLeft, self._curPage > 1)
	GameUtil.SetActive(self._btnRight, self._curPage < #self._works)

	local info = self._works[index]

	self._info = info

	if info then
		self:_updateCell(self._cell, info)
	end
end

function DreampaintershowView:_updateCell(cell, info)
	local img = goutil.findChild(cell, "img")
	local btnVote = goutil.findChild(cell, "btnVote")
	local tag = goutil.findChild(cell, "tag")
	local txtTag = goutil.findChildTextComponent(cell, "tag/txt")
	local txtCount = goutil.findChildTextComponent(cell, "txtCount")
	local txtPicName = goutil.findChildTextComponent(cell, "txtPicName")
	local txtUserName = goutil.findChildTextComponent(cell, "txtUserName")

	GameUtil.SetActive(btnVote, not self._isDisplay)
	GameUtil.SetActive(tag, false)

	local cfg = DreamPainterConfig.instance:getWorksCfgById(self._activityId, info.workId) or {}

	txtCount.text = info.value
	txtUserName.text = cfg.workerName
	txtPicName.text = cfg.name or ""

	uGuiUtil.setSpriteToImage(img.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("dreampainter", cfg.bigImgUrl))
	GameUtil.addClickHandler(btnVote, function()
		DreamPainterController.instance:sendPM_DreamPainterVoteReq(self._activityId, self._curPhaseId, info.workId)
	end)
end

return DreampaintershowView
