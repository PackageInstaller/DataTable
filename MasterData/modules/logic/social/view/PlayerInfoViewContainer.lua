-- chunkname: @modules/logic/social/view/PlayerInfoViewContainer.lua

module("modules.logic.social.view.PlayerInfoViewContainer", package.seeall)

local PlayerInfoViewContainer = class("PlayerInfoViewContainer", BaseViewContainer)

function PlayerInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerInfoView.New())

	return views
end

function PlayerInfoViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function PlayerInfoViewContainer:openInternal(viewParam, isImmediate)
	local viewResPath = SocialEnum.ThemeViewResPath[viewParam.mo.bg]
	local defaultviewResPath = SocialEnum.ThemeViewResPath[0]

	if viewResPath then
		if not viewResPath.playerinfoview then
			self._viewSetting.mainRes = defaultviewResPath.playerinfoview

			PlayerInfoViewContainer.super.openInternal(self, viewParam, isImmediate)
		end
	end
end

return PlayerInfoViewContainer
