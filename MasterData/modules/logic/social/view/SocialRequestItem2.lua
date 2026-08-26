-- chunkname: @modules/logic/social/view/SocialRequestItem2.lua

module("modules.logic.social.view.SocialRequestItem2", package.seeall)

local SocialRequestItem2 = class("SocialRequestItem2", SocialBaseItem)

function SocialRequestItem2:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function SocialRequestItem2:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
end

function SocialRequestItem2:_btnconfirmOnClick()
	if SocialModel.instance:getFriendsCount() >= SocialConfig.instance:getMaxFriendsCount() then
		GameFacade.showToast(ToastEnum.SocialRequest1)

		return
	end

	if SocialModel.instance:isMyBlackListByUserId(self._mo.userId) then
		GameFacade.showToast(ToastEnum.SocialRequest2)

		return
	end

	FriendRpc.instance:sendHandleApplyRequest(self._mo.userId, true)
end

function SocialRequestItem2:_btncancelOnClick()
	FriendRpc.instance:sendHandleApplyRequest(self._mo.userId, false)
end

function SocialRequestItem2:updateBtnState()
	gohelper.setActive(self._btnadd.gameObject, false)
	gohelper.setActive(self._gosent, false)
	gohelper.setActive(self._btnconfirm.gameObject, true)
	gohelper.setActive(self._btncancel.gameObject, true)
end

return SocialRequestItem2
