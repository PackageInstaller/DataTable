-- chunkname: @modules/logic/social/view/SocialRemarkTipViewContainer.lua

module("modules.logic.social.view.SocialRemarkTipViewContainer", package.seeall)

local SocialRemarkTipViewContainer = class("SocialRemarkTipViewContainer", BaseViewContainer)

function SocialRemarkTipViewContainer:buildViews()
	return {
		SocialRemarkTipView.New()
	}
end

return SocialRemarkTipViewContainer
