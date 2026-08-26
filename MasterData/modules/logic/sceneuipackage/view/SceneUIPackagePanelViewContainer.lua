-- chunkname: @modules/logic/sceneuipackage/view/SceneUIPackagePanelViewContainer.lua

module("modules.logic.sceneuipackage.view.SceneUIPackagePanelViewContainer", package.seeall)

local SceneUIPackagePanelViewContainer = class("SceneUIPackagePanelViewContainer", BaseViewContainer)

function SceneUIPackagePanelViewContainer:buildViews()
	local views = {}

	table.insert(views, SceneUIPackagePanelView.New())

	return views
end

return SceneUIPackagePanelViewContainer
