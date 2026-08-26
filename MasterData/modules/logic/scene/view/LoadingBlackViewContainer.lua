-- chunkname: @modules/logic/scene/view/LoadingBlackViewContainer.lua

module("modules.logic.scene.view.LoadingBlackViewContainer", package.seeall)

local LoadingBlackViewContainer = class("LoadingBlackViewContainer", BaseViewContainer)

function LoadingBlackViewContainer:buildViews()
	return {
		LoadingBlackView.New()
	}
end

return LoadingBlackViewContainer
