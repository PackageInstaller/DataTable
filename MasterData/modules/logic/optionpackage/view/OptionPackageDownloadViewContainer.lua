-- chunkname: @modules/logic/optionpackage/view/OptionPackageDownloadViewContainer.lua

module("modules.logic.optionpackage.view.OptionPackageDownloadViewContainer", package.seeall)

local OptionPackageDownloadViewContainer = class("OptionPackageDownloadViewContainer", BaseViewContainer)

function OptionPackageDownloadViewContainer:buildViews()
	return {
		OptionPackageDownloadView.New()
	}
end

return OptionPackageDownloadViewContainer
