-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/MassivelotteryView.lua

module("logic.extensions.bonus.view.xiaonuobirthday.MassivelotteryView", package.seeall)

local MassivelotteryView = class("MassivelotteryView", SummarySubTabView)

function MassivelotteryView:ctor()
	MassivelotteryView.super.ctor(self)
end

function MassivelotteryView:unbindEvents()
	MassivelotteryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnLottery)
end

function MassivelotteryView:bindEvents()
	MassivelotteryView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnLottery, self.onJumpTo, self)
end

function MassivelotteryView:buildUI()
	MassivelotteryView.super.buildUI(self)

	self.btnLottery = self:getGo("btnLottery")
	self.txtTime = self:getTxt("time/txtTime")
	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function MassivelotteryView:buildBtnJump()
	return
end

function MassivelotteryView:onExit()
	MassivelotteryView.super.onExit(self)
	self.scrollList:dispose()
end

function MassivelotteryView:onEnter()
	MassivelotteryView.super.onEnter(self)
	self.scrollList:reloadData(self._cfgs)
end

function MassivelotteryView:_updateCell(view, cell, data, tag)
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local icon = goutil.findChild(cell, "icon")
	local btnGoto = goutil.findChild(cell, "btnGoto")

	MaterialMgr.updateItemByStr(icon, data.background)
	GameUtil.addClickHandler(icon, function()
		CommonTipsMgr.instance:openTipsByConfStr(icon, data.background)
	end)

	txtDesc.text = ""
	txtTitle.text = data.params

	GameUtil.addClickHandler(btnGoto, GameUtil.handler(self._onJump, self, data))
end

function MassivelotteryView:clearCell(cell)
	local icon = goutil.findChild(cell, "icon")
	local btnGoto = goutil.findChild(cell, "btnGoto")

	MaterialMgr.clearIcon(icon)
end

function MassivelotteryView:onJumpTo()
	local str = XiaonuoBirthConfig.instance:getCommonValue("LOTTERY_JUMP")

	GotoMgr.gotoByString(str)
end

return MassivelotteryView
