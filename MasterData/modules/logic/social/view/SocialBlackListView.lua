-- chunkname: @modules/logic/social/view/SocialBlackListView.lua

module("modules.logic.social.view.SocialBlackListView", package.seeall)

local SocialBlackListView = class("SocialBlackListView", BaseView)

function SocialBlackListView:onInitView()
	self._gohas = gohelper.findChild(self.viewGO, "#go_has")
	self._gono = gohelper.findChild(self.viewGO, "#go_no")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SocialBlackListView:addEvents()
	self.addEventCb(self, SocialController.instance, SocialEvent.BlackListInfoChanged, self._refreshUI, self)
	self.addEventCb(self, SocialController.instance, SocialEvent.AddUnknownBlackList, self._onAddUnknownBlackList, self)
end

function SocialBlackListView:removeEvents()
	self.removeEventCb(self, SocialController.instance, SocialEvent.BlackListInfoChanged, self._refreshUI, self)
	self.removeEventCb(self, SocialController.instance, SocialEvent.AddUnknownBlackList, self._onAddUnknownBlackList, self)
end

function SocialBlackListView:_editableInitView()
	return
end

function SocialBlackListView:onOpen()
	FriendRpc.instance:sendGetBlacklistRequest()

	if self._notFirst then
		self:_refreshUI()
	else
		self:_refreshUI(true)
	end

	self._notFirst = true
end

function SocialBlackListView:_onAddUnknownBlackList()
	FriendRpc.instance:sendGetBlacklistRequest()
end

function SocialBlackListView:_refreshUI(open)
	local blackListCount = SocialModel.instance:getBlackListCount()

	if not open then
		gohelper.setActive(self._gohas, blackListCount > 0)
		gohelper.setActive(self._gono, blackListCount <= 0)
	else
		gohelper.setActive(self._gohas, blackListCount > 0)
		gohelper.setActive(self._gono, false)
	end
end

return SocialBlackListView
