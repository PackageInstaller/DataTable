-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxSharePopView.lua

module("logic.extensions.giftbox.view.GiftBoxSharePopView", package.seeall)

local GiftBoxSharePopView = class("GiftBoxSharePopView", ViewComponent)

function GiftBoxSharePopView:ctor()
	GiftBoxSharePopView.super.ctor(self)
end

function GiftBoxSharePopView:unbindEvents()
	GiftBoxSharePopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShareAll)
	GameUtil.rmClickHandler(self._btnShareFriend)
end

function GiftBoxSharePopView:bindEvents()
	GiftBoxSharePopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnShareAll, self._onClickShareAll, self)
	GameUtil.addClickHandler(self._btnShareFriend, self._onClickShareFriend, self)
end

function GiftBoxSharePopView:buildUI()
	GiftBoxSharePopView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnShareAll = self:getGo("btnShareAll")
	self._btnShareFriend = self:getGo("btnShareFriend")
end

function GiftBoxSharePopView:onExit()
	GiftBoxSharePopView.super.onExit(self)
end

function GiftBoxSharePopView:onEnter()
	GiftBoxSharePopView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FriendSelected, self._onSelectFriend, self)

	self._actId = self:getFirstParam()
	self._actCfg = GiftBoxConfig.instance:getActCfgById(self._actId)

	if not GiftBoxModel.instance:getFirstOpenShare(self._actId) then
		GiftBoxModel.instance:saveFirstOpenShare(self._actId)
		GlobalDispatcher:dispatch(GlobalNotify.GiftBoxFirstShare)
	end
end

function GiftBoxSharePopView:_onClickShareAll()
	local canShareStamp = GiftBoxModel.instance:getShareAllStamp()

	if GiftBoxModel.instance:getScore() <= 0 then
		FloatWordMgr.instance:show(lang("欧气值小于0，不可分享"))

		return
	end

	if canShareStamp < ServerTime.now() then
		GiftBoxModel.instance:setShareAllStamp(ServerTime.now() + self._actCfg.shareCd)
		GiftBoxAgent.instance:sendGB_GiftBoxShareLuckReq(self._actId)
		self:close()
	else
		FloatWordMgr.instance:show(lang("每次分享需间隔60秒噢，稍后再来分享吧"))
	end
end

function GiftBoxSharePopView:_onClickShareFriend()
	if GiftBoxModel.instance:getScore() <= 0 then
		FloatWordMgr.instance:show(lang("欧气值小于0，不可分享"))

		return
	end

	ViewMgr.instance:open(ViewName.FriendSelect, 0, self._actCfg.shareNumLimit, lang("请选择好友,将自己的幸运值分享给他"))
end

function GiftBoxSharePopView:_onSelectFriend(ids)
	local canShareStamp = GiftBoxModel.instance:getShareFriendStamp()

	if canShareStamp < ServerTime.now() then
		GiftBoxModel.instance:setShareFriendStamp(ServerTime.now() + self._actCfg.shareCd)
		GiftBoxAgent.instance:sendGB_GiftBoxShareLuckReq(self._actId, ids)
		self:close()
	else
		FloatWordMgr.instance:show(lang("每次分享需间隔60秒噢，稍后再来分享吧"))
	end
end

return GiftBoxSharePopView
