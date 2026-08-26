-- chunkname: @modules/logic/login/view/ServerListItem.lua

module("modules.logic.login.view.ServerListItem", package.seeall)

local ServerListItem = class("ServerListItem", ListScrollCell)

function ServerListItem:init(go)
	self._serverStateGOList = {}

	for i = 0, 2 do
		self._serverStateGOList[i] = gohelper.findChild(go, "imgState" .. i)
	end

	self._txtServerName = gohelper.findChildText(go, "Text")
	self._click = SLFramework.UGUI.UIClickListener.Get(go)
end

function ServerListItem:addEventListeners()
	self._click:AddClickListener(self._onClick, self)
end

function ServerListItem:removeEventListeners()
	self._click:RemoveClickListener()
end

function ServerListItem:onUpdateMO(mo)
	self._mo = mo
	self._txtServerName.text = self._mo.name

	for i = 0, 2 do
		gohelper.setActive(self._serverStateGOList[i], i == self._mo.state)
	end
end

function ServerListItem:_onClick()
	LoginController.instance:dispatchEvent(LoginEvent.SelectServerItem, self._mo)
	self._view:closeThis()
end

return ServerListItem
