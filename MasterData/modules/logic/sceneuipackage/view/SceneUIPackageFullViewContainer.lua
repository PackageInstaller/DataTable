-- chunkname: @modules/logic/sceneuipackage/view/SceneUIPackageFullViewContainer.lua

module("modules.logic.sceneuipackage.view.SceneUIPackageFullViewContainer", package.seeall)

local SceneUIPackageFullViewContainer = class("SceneUIPackageFullViewContainer", BaseViewContainer)

function SceneUIPackageFullViewContainer:buildViews()
	local views = {}

	table.insert(views, SceneUIPackageFullView.New())

	return views
end

return SceneUIPackageFullViewContainer
