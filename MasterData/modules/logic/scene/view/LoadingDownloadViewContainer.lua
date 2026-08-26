-- chunkname: @modules/logic/scene/view/LoadingDownloadViewContainer.lua

module("modules.logic.scene.view.LoadingDownloadViewContainer", package.seeall)

local LoadingDownloadViewContainer = class("LoadingDownloadViewContainer", BaseViewContainer)

function LoadingDownloadViewContainer:buildViews()
	return {
		LoadingDownloadView.New()
	}
end

return LoadingDownloadViewContainer
