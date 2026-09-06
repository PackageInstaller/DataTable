-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/IslandlistView.lua

module("logic.extensions.login.view.IslandlistView", package.seeall)

local IslandlistView = class("IslandlistView", ViewComponent)

function IslandlistView:ctor()
	IslandlistView.super.ctor(self)
end

function IslandlistView:buildUI()
	IslandlistView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.cell = self:getGo("cell")
	self.tableview = self:getGo("tableview")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self.updateCell, self))
end

function IslandlistView:bindEvents()
	IslandlistView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function IslandlistView:unbindEvents()
	IslandlistView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function IslandlistView:destroyUI()
	IslandlistView.super.destroyUI(self)
end

function IslandlistView:onEnter()
	IslandlistView.super.onEnter(self)

	self.data = self:getFirstParam()

	local list = self.data.socketAddresses

	self.scrollList:reloadData(list)
end

function IslandlistView:onEnterFinished()
	IslandlistView.super.onEnterFinished(self)
end

function IslandlistView:onExit()
	IslandlistView.super.onExit(self)
	self.scrollList:dispose()
end

function IslandlistView:onExitFinished()
	IslandlistView.super.onExitFinished(self)
end

function IslandlistView:updateCell(view, cell, data)
	local imgState = goutil.findChild(cell, "imgState")
	local txtSeverName = goutil.findChildTextComponent(cell, "txtSeverName")

	txtSeverName.text = data.name

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickCell, self, data))
end

function IslandlistView:onClickCell(data)
	LoginModel.instance.wantGoIslandId = data.id

	GlobalDispatcher:dispatch(GlobalNotify.OnIslandListCellSelect, data)
	self:close()
end

return IslandlistView
