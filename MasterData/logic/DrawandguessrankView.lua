-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessrankView.lua

module("logic.extensions.drawandguess.view.DrawandguessrankView", package.seeall)

local DrawandguessrankView = class("DrawandguessrankView", ViewComponent)

function DrawandguessrankView:ctor()
	DrawandguessrankView.super.ctor(self)
end

function DrawandguessrankView:unbindEvents()
	DrawandguessrankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose, self)
end

function DrawandguessrankView:bindEvents()
	DrawandguessrankView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function DrawandguessrankView:buildUI()
	DrawandguessrankView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.goEmpty = self:getGo("content/goEmpty")
	self.rankcell = self:getGo("content/rankcell")
	self.rankview = self:getGo("content/rankview")
	self.txtmyRank = self:getTxt("content/myRank/txtMyRank")
	self.txtTip = self:getTxt("content/myRank/txtTip")
	self.scrollList = ScrollerList.create(self.rankview, self.rankcell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function DrawandguessrankView:onExit()
	DrawandguessrankView.super.onExit(self)
	self.scrollList:dispose()
end

function DrawandguessrankView:onEnter()
	DrawandguessrankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DrawAndGuessRankRes, self._updateUI, self)

	self._activityId = self:getFirstParam()

	DrawAndGuessAgent.instance:sendPM_DrawAndGuessRankReq(self._activityId)
	self:_updateUI()
end

function DrawandguessrankView:_updateUI()
	local info = DrawandguessModel.instance:getRankMsg()

	if not info then
		return
	end

	self.txtmyRank.text = checknumber(info.myRank) > 0 and info.myRank or lang("text_rank_notrank")
	self.txtTip.text = "排行榜每15分钟刷新一次"

	if not info.rankInfos then
		local list = {}

		self.scrollList:reloadData(list)
		GameUtil.SetActive(self.goEmpty, #list == 0)
	end
end

function DrawandguessrankView:_updateCell(view, cell, data, tag)
	local imgRank = goutil.findChild(cell, "imgRank")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local txtWin = goutil.findChildTextComponent(cell, "txtWin")
	local txtRate = goutil.findChildTextComponent(cell, "txtRate")

	GameUtil.SetActive(imgRank, data.rank <= 3)

	if data.rank <= 3 then
		GameUtil.setUIImageSpriteIdx(imgRank, data.rank - 1)

		txtRank.text = ""
	else
		txtRank.text = data.rank
	end

	HeadItemController.instance:setHeadCellByInfo(imgHeadIcon, data.headInfo, true)

	txtName.text = data.headInfo.userName
	txtArea.text = data.areaName
	txtWin.text = data.value

	local date = GameUtil.time2date(checknumber(data.time / 1000))

	txtRate.text = string.format("%s-%s-%s\n%02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)

	local prizeCom = goutil.findChild(cell, "prizeCom")
	local itemGo = goutil.findChild(cell, "item")
	local tableview = ScrollerList.create(prizeCom, itemGo, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
	local prizeCfg = DrawandguessConfig.instance:getRankPrizeCfg(self._activityId, data.rank)

	if prizeCfg then
		local prizeList = string.split(prizeCfg.prize, "#")

		tableview:reloadData(prizeList)
	else
		tableview:reloadData()
	end
end

function DrawandguessrankView:clearCell(cell)
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgHeadIcon)

	local prizeCom = goutil.findChild(cell, "prizeCom")
	local itemGo = goutil.findChild(cell, "item")
	local tableview = ScrollerList.create(prizeCom, itemGo, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	tableview:dispose()
end

function DrawandguessrankView:_updateItemCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function DrawandguessrankView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell)
end

return DrawandguessrankView
