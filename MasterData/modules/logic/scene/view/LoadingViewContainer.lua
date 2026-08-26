-- chunkname: @modules/logic/scene/view/LoadingViewContainer.lua

module("modules.logic.scene.view.LoadingViewContainer", package.seeall)

local LoadingViewContainer = class("LoadingViewContainer", BaseViewContainer)

function LoadingViewContainer:buildViews()
	return {
		LoadingView.New()
	}
end

return LoadingViewContainer
