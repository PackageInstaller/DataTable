-- chunkname: @modules/logic/social/view/SocialRequestView.lua

module("modules.logic.social.view.SocialRequestView", package.seeall)

local SocialRequestView = class("SocialRequestView", BaseView)

function SocialRequestView:onInitView()
	self._gonorequest = gohelper.findChild(self.viewGO, "#go_norequest")
	self._gobottom = gohelper.findChild(self.viewGO, "#go_top")
	self._txtfriendscount = gohelper.findChildText(self.viewGO, "#go_top/#txt_friendscount")
	self._txtfriends = gohelper.findChildText(self.viewGO, "#go_top/#txt_friends")
end

function SocialRequestView:addEvents()
	self.addEventCb(self, SocialController.instance, SocialEvent.RequestInfoChanged, self._refreshUI, self)
end

function SocialRequestView:removeEvents()
	self.removeEventCb(self, SocialController.instance, SocialEvent.RequestInfoChanged, self._refreshUI, self)
end

function SocialRequestView:onOpen()
	FriendRpc.instance:sendGetApplyListRequest()
	self:_refreshUI()
end

function SocialRequestView:_refreshUI()
	local requestCount = SocialModel.instance:getRequestCount()

	gohelper.setActive(self._gonorequest, requestCount <= 0)
	gohelper.setActive(self._gobottom, requestCount > 0)

	if requestCount > 0 then
		local requestcount = SocialModel.instance:getRequestCount()

		self._txtfriendscount.text = string.format("%d/%d", requestcount, SocialConfig.instance:getMaxRequestCount())
		self._txtfriends.text = luaLang("social_tabviewinfo_request")
	end
end

return SocialRequestView
