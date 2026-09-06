-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupRankView.lua

module("logic.extensions.worldcup.view.WorldCupRankView", package.seeall)

local WorldCupRankView = class("WorldCupRankView", ViewComponent)

function WorldCupRankView:ctor()
	WorldCupRankView.super.ctor(self)
end

function WorldCupRankView:unbindEvents()
	WorldCupRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function WorldCupRankView:bindEvents()
	WorldCupRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function WorldCupRankView:buildUI()
	WorldCupRankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local tableviewGo = self:getGo("rankCol/rankScrollerview")
	local cellGo = self:getGo("rankCol/rankScrollercell")

	self._tableviewRank = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._emptyGo = self:getGo("rankCol/emptyGo")
	self._txtMyRank = self:getTxt("tipsCol/txtMyRank")
	self._txtMyScore = self:getTxt("tipsCol/txtMyScore")
end

function WorldCupRankView:onExit()
	WorldCupRankView.super.onExit(self)
	self._tableviewRank:dispose()

	self._subTabs = {}
end

function WorldCupRankView:onEnter()
	WorldCupRankView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.PM_WorldCupRankInfoRes, self._updateByInfo, self)
	WorldCupAgent.instance:sendPM_WorldCupRankInfoReq(self._activityId)
end

function WorldCupRankView:_updateByInfo()
	local rankInfo = WorldCupModel.instance:getRankInfo(self._activityId)

	if rankInfo then
		if not rankInfo.rankList then
			local rankList = {}

			self._tableviewRank:reloadData(rankList)
			goutil.setActive(self._emptyGo, #rankList <= 0)

			self._txtMyRank.text = rankInfo.myRank <= 0 and lang("未上榜") or rankInfo.myRank
		end
	else
		self._tableviewRank:reloadData({})

		self._txtMyRank.text = lang("未上榜")

		goutil.setActive(self._emptyGo, true)
	end

	local actCfg = WorldCupConfig.instance:getActivityCfg(self._activityId)
	local matType, matId, _ = MaterialMgr.getMatParams(actCfg.betItemKey)

	self._txtMyScore.text = MaterialModel.instance:getMaterialsNumber(matType, matId)
end

function WorldCupRankView:_updateRankCell(view, cell, data)
	local goHeadIcon = goutil.findChild(cell.gameObject, "head")
	local imgChangeImgRank = goutil.findChild(cell.gameObject, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtArea = goutil.findChildTextComponent(cell.gameObject, "txtArea")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")

	HeadItemController.instance:resetHeadCell(goHeadIcon)
	HeadItemController.instance:setHeadCellByInfo(goHeadIcon, data.headInfo, true)

	local isTop3 = data.rank <= 3

	if isTop3 then
		imgChangeImgRank:SetState(data.rank - 1)
		goutil.setActive(imgChangeImgRank.gameObject, true)
		goutil.setActive(txtRank.gameObject, false)
	else
		goutil.setActive(txtRank.gameObject, true)
		goutil.setActive(imgChangeImgRank.gameObject, false)

		txtRank.text = data.rank
	end

	txtName.text = data.headInfo.userName
	txtArea.text = data.headInfo.areaName
	txtScore.text = checknumber(data.value)
end

function WorldCupRankView:_clearRankCell(cell)
	local goHeadIcon = goutil.findChild(cell.gameObject, "head")

	HeadItemController.instance:resetHeadCell(goHeadIcon)
end

return WorldCupRankView
