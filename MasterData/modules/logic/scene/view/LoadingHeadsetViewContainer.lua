-- chunkname: @modules/logic/scene/view/LoadingHeadsetViewContainer.lua

module("modules.logic.scene.view.LoadingHeadsetViewContainer", package.seeall)

local LoadingHeadsetViewContainer = class("LoadingHeadsetViewContainer", BaseViewContainer)

function LoadingHeadsetViewContainer:buildViews()
	return {
		LoadingHeadsetView.New()
	}
end

return LoadingHeadsetViewContainer
