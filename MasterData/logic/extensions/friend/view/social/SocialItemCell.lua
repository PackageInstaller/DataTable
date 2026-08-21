-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/social/SocialItemCell.lua

module("logic.extensions.friend.view.social.SocialItemCell", package.seeall)

local M = class("SocialItemCell", FriendBaseItemCell)

function M:ctor(...)
	M.super.ctor(self, ...)

	self._tipsPosGo = nil
end

function M:updateData(data)
	M.super.updateData(self, data)
	self._btnChat.gameObject:SetActive(true)
end

function M:_buildUI()
	M.super._buildUI(self)
end

function M:setTipsPosGo(go)
	self._tipsPosGo = go
end

function M:_onClickBtnClick()
	local info = ToolTipsUtil.createFriendTipsData({
		friendMo = self._data
	}, self._imgHeadIcon, true)

	ToolTipsMgr.showTips(ViewName.FriendTips, info)
end

function M:_onClickBtnChat()
	local channelType = GameEnum.ChannelTypeEnum.Friend
	local targetId = self._data:getUserId()

	ChatMainFacade.instance:openChatMainView(channelType, targetId)
end

return M
