-- chunkname: @modules/logic/share/view/ShareTipViewContainer.lua

module("modules.logic.share.view.ShareTipViewContainer", package.seeall)

local ShareTipViewContainer = class("ShareTipViewContainer", BaseViewContainer)

function ShareTipViewContainer:buildViews()
	return {
		ShareTipView.New()
	}
end

return ShareTipViewContainer
