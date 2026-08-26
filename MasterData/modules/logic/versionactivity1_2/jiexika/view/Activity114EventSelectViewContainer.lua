-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114EventSelectViewContainer.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114EventSelectViewContainer", package.seeall)

local Activity114EventSelectViewContainer = class("Activity114EventSelectViewContainer", BaseViewContainer)

function Activity114EventSelectViewContainer:buildViews()
	return {
		Activity114EventSelectView.New()
	}
end

return Activity114EventSelectViewContainer
