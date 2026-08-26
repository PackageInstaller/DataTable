-- chunkname: @modules/logic/sceneuipackage/view/SceneUIPackageInfoViewContainer.lua

module("modules.logic.sceneuipackage.view.SceneUIPackageInfoViewContainer", package.seeall)

local SceneUIPackageInfoViewContainer = class("SceneUIPackageInfoViewContainer", BaseViewContainer)

function SceneUIPackageInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, SceneUIPackageInfoView.New())
	table.insert(views, TabViewGroup.New(1, "middle/#go_mainUI"))

	return views
end

function SceneUIPackageInfoViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local t = {}

		self:_addMainUI(t)

		return t
	end
end

function SceneUIPackageInfoViewContainer:_addMainUI(t)
	local views = {}

	self._uishowView = SwitchMainUIShowView.New()

	table.insert(views, self._uishowView)
	table.insert(views, SwitchMainActivityEnterView.New())
	table.insert(views, SwitchMainActExtraDisplay.New())
	table.insert(views, SwitchMainUIView.New())
	table.insert(views, SwitchMainUIEagleAnimView.New())
	table.insert(views, MainBirdAnimView.New())

	t[1] = MultiView.New(views)

	return t[1]
end

function SceneUIPackageInfoViewContainer:playOpenTransition()
	SceneUIPackageInfoViewContainer.super.playOpenTransition(self)
	self._uishowView:_refreshOffest(true)
end

return SceneUIPackageInfoViewContainer
