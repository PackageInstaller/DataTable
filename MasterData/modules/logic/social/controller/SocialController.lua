-- chunkname: @modules/logic/social/controller/SocialController.lua

module("modules.logic.social.controller.SocialController", package.seeall)

local SocialController = class("SocialController", BaseController)

function SocialController:onInit()
	return
end

function SocialController:onInitFinish()
	return
end

function SocialController:addConstEvents()
	return
end

function SocialController:reInit()
	return
end

function SocialController:openSocialView(viewParam)
	if SDKNativeUtil.isGamePad() then
		GameFacade.showToast(ToastEnum.ClassShow)
	else
		ViewMgr.instance:openView(ViewName.SocialView, viewParam)
	end
end

function SocialController:AddFriend(userId, callback, callbackObj)
	local myUserId = PlayerModel.instance:getMyUserId()

	if myUserId == userId then
		GameFacade.showToast(ToastEnum.SocialIsMyFriend)

		return false
	end

	local isMyFriend = SocialModel.instance:isMyFriendByUserId(userId)

	if isMyFriend then
		GameFacade.showToast(ToastEnum.SocialIsMaxFriend)

		return false
	end

	if SocialModel.instance:getFriendsCount() >= SocialConfig.instance:getMaxFriendsCount() then
		GameFacade.showToast(ToastEnum.SocialRequest1)

		return false
	end

	FriendRpc.instance:sendApplyRequest(userId, callback, callbackObj)
end

function SocialController:openInformPlayerTipView(viewParam)
	if not ReportTypeListModel.instance:initDone() then
		self.informPlayerTipViewParam = viewParam

		ChatRpc.instance:sendGetReportTypeRequest(self.onReceiveGetReportTypeReplay, self)

		return
	end

	ViewMgr.instance:openView(ViewName.InformPlayerTipView, viewParam)
end

function SocialController:onReceiveGetReportTypeReplay(cmd, resultCode, msg)
	ReportTypeListModel.instance:initType(msg.reportTypes)
	ViewMgr.instance:openView(ViewName.InformPlayerTipView, self.informPlayerTipViewParam)

	self.informPlayerTipViewParam = nil
end

SocialController.instance = SocialController.New()

return SocialController
