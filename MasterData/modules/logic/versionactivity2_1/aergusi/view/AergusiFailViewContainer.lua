-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiFailViewContainer.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiFailViewContainer", package.seeall)

local AergusiFailViewContainer = class("AergusiFailViewContainer", BaseViewContainer)

function AergusiFailViewContainer:buildViews()
	return {
		AergusiFailView.New()
	}
end

function AergusiFailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return AergusiFailViewContainer
