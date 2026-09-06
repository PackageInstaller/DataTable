-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenRankView.lua

module("logic.extensions.dragonawaken.view.DragonAwakenRankView", package.seeall)

local DragonAwakenRankView = class("DragonAwakenRankView", ViewComponent)

function DragonAwakenRankView:ctor()
	DragonAwakenRankView.super.ctor(self)
end

function DragonAwakenRankView:unbindEvents()
	DragonAwakenRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DragonAwakenRankView:bindEvents()
	DragonAwakenRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DragonAwakenRankView:buildUI()
	DragonAwakenRankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local tableviewGo = self:getGo("rankCol/rankScrollerview")
	local cellGo = self:getGo("rankCol/rankScrollercell")

	self._tableviewRank = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._prizeItem = self:getGo("rankCol/prizeItem")
	self._emptyGo = self:getGo("rankCol/emptyGo")
	self._txtMyRank = self:getTxt("tipsCol/txtMyRank")
end

function DragonAwakenRankView:onExit()
	DragonAwakenRankView.super.onExit(self)
	self._tableviewRank:dispose()
end

function DragonAwakenRankView:onEnter()
	DragonAwakenRankView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.DragonAwakenGetRankInfoRes, self._updateByInfo, self)
	DragonAwakenController.instance:getRankInfo(self._activityId)
end

function DragonAwakenRankView:_updateByInfo()
	local rankInfo = DragonAwakenModel.instance:getRankInfoByActId(self._activityId)

	if rankInfo then
		if not rankInfo.rankList then
			local rankList = {}

			self._tableviewRank:reloadData(rankList)
			goutil.setActive(self._emptyGo, #rankList <= 0)

			self._txtMyRank.text = rankInfo.myRank <= 0 and "未上榜" or rankInfo.myRank
		end
	end
end

function DragonAwakenRankView:_updateRankCell(view, cell, data)
	local goHeadIcon = goutil.findChild(cell.gameObject, "head")
	local imgChangeImgRank = goutil.findChild(cell.gameObject, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtArena = goutil.findChildTextComponent(cell.gameObject, "txtArena")
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "txtTime")

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
	txtArena.text = data.headInfo.areaName

	local time = GameUtil.time2date(checknumber(data.time) / 1000)

	txtTime.text = string.format("%02d.%02d  %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.sec)

	local prizeCom = goutil.findChild(cell.gameObject, "itemScrollerview")
	local tableview = ScrollerList.create(prizeCom, self._prizeItem, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
	local prizeCfg = DragonAwakenConfig.instance:getRankCfgByRank(self._activityId, data.rank)

	if prizeCfg then
		if not prizeCfg.prize then
			local prize = ""
			local itemList = string.split(prize, "#")

			tableview:reloadData(itemList)
			tableview:MoveCellToBegin(0)
		end
	end
end

function DragonAwakenRankView:_clearRankCell(cell)
	local goHeadIcon = goutil.findChild(cell.gameObject, "head")

	HeadItemController.instance:resetHeadCell(goHeadIcon)

	local prizeCom = goutil.findChild(cell.gameObject, "itemScrollerview")
	local tableview = ScrollerList.create(prizeCom, self._prizeItem, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	tableview:dispose()
end

function DragonAwakenRankView:_updateItemCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function DragonAwakenRankView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return DragonAwakenRankView
