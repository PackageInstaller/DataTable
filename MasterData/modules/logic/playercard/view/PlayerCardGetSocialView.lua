-- chunkname: @modules/logic/playercard/view/PlayerCardGetSocialView.lua

module("modules.logic.playercard.view.PlayerCardGetSocialView", package.seeall)

local PlayerCardGetSocialView = class("PlayerCardGetSocialView", SocialView)

function PlayerCardGetSocialView:onOpen()
	PlayerCardGetSocialView.super.onOpen(self)

	self._goroot = gohelper.findChild(self.viewGO, "container")

	transformhelper.setLocalScale(self._goroot.transform, 0.8, 0.8, 1)
	recthelper.setAnchorY(self._goroot.transform, 100)

	if self.viewParam.parentGo then
		gohelper.addChild(self.viewParam.parentGo, self.viewGO)
	end
end

return PlayerCardGetSocialView
