-- chunkname: @modules/logic/messagebox/view/TopMessageBoxViewContainer.lua

module("modules.logic.messagebox.view.TopMessageBoxViewContainer", package.seeall)

local TopMessageBoxViewContainer = class("TopMessageBoxViewContainer", BaseViewContainer)

function TopMessageBoxViewContainer:buildViews()
	return {
		MessageBoxView.New()
	}
end

return TopMessageBoxViewContainer
