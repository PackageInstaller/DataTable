-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186GiftViewContainer.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186GiftViewContainer", package.seeall)

local Activity186GiftViewContainer = class("Activity186GiftViewContainer", BaseViewContainer)

function Activity186GiftViewContainer:buildViews()
	return {
		Activity186GiftView.New()
	}
end

return Activity186GiftViewContainer
