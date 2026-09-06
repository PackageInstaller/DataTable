-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenPetView.lua

module("logic.extensions.dragonawaken.view.DragonAwakenPetView", package.seeall)

local DragonAwakenPetView = class("DragonAwakenPetView", ViewComponent)
local TAB_LIST = {
	{
		index = 1,
		name = "招募",
		viewName = ViewName.DragonAwakenPetListView
	},
	{
		index = 2,
		name = "强化",
		viewName = ViewName.DragonAwakenPetLvUpView
	}
}

function DragonAwakenPetView:ctor()
	DragonAwakenPetView.super.ctor(self)
end

function DragonAwakenPetView:unbindEvents()
	DragonAwakenPetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DragonAwakenPetView:bindEvents()
	DragonAwakenPetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DragonAwakenPetView:buildUI()
	DragonAwakenPetView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._container = self:getGo("container")
	self._tableView = self:getGo("tableView")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableView, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DragonAwakenPetView:onExit()
	DragonAwakenPetView.super.onExit(self)
	self._scrollList:dispose()
end

function DragonAwakenPetView:onEnter()
	DragonAwakenPetView.super.onEnter(self)

	self._activityId = 419001

	local params = self:getOpenParam() or {}
	local actId = checknumber(params[1])

	if actId > 0 then
		self._activityId = actId
	end

	self:_onRefershUI()
end

function DragonAwakenPetView:_onRefershUI()
	self._selectTab = 1

	self._scrollList:reloadData(TAB_LIST)
	self:_showSelectTabView()
end

function DragonAwakenPetView:_updateCell(view, cell, data, tag)
	local imgSelected = goutil.findChild(cell, "imgSelected")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	txtName.text = data.name

	GameUtil.SetActive(imgSelected, self._selectTab == data.index)
	GameUtil.setUITextColorIdx(txtName, 1)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCell, self, data))
end

function DragonAwakenPetView:_clearCell(cell)
	return
end

function DragonAwakenPetView:_onClickCell(data)
	if self._selectTab ~= data.index then
		self._selectTab = data.index

		self._scrollList:refresh()
		self:_showSelectTabView()
	end
end

function DragonAwakenPetView:_showSelectTabView()
	if not TAB_LIST[self._selectTab] then
		self:showTabAt(self._container, "")
		self:showTabAt(self._container, TAB_LIST[self._selectTab].viewName, self._activityId)
	end
end

return DragonAwakenPetView
