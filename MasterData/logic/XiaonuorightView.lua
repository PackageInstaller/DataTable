-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/XiaonuorightView.lua

module("logic.extensions.bonus.view.xiaonuobirthday.XiaonuorightView", package.seeall)

local XiaonuorightView = class("XiaonuorightView", ViewComponent)

function XiaonuorightView:ctor()
	XiaonuorightView.super.ctor(self)
end

function XiaonuorightView:unbindEvents()
	XiaonuorightView.super.unbindEvents(self)
end

function XiaonuorightView:bindEvents()
	XiaonuorightView.super.bindEvents(self)
end

function XiaonuorightView:buildUI()
	XiaonuorightView.super.buildUI(self)

	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function XiaonuorightView:onExit()
	XiaonuorightView.super.onExit(self)
	self.scrollList:dispose()
end

function XiaonuorightView:onEnter()
	XiaonuorightView.super.onEnter(self)

	local list = XiaonuoBirthConfig.instance:getRightList()

	self.scrollList:reloadData(list)
end

function XiaonuorightView:_updateCell(view, cell, data, tag)
	local txt = goutil.findChildTextComponent(cell, "txt")
	local txtTag = goutil.findChildTextComponent(cell, "tag/Text")
	local btnGoto = goutil.findChild(cell, "btnGoto")

	txt.text = data.desc
	txtTag.text = data.tag

	GameUtil.addClickHandler(btnGoto, function()
		GotoMgr.gotoByString(data.jumpTo)
	end)
end

function XiaonuorightView:clearCell(cell)
	return
end

return XiaonuorightView
