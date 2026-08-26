-- chunkname: @modules/logic/versionactivity1_3/buff/view/VersionActivity1_3BuffViewContainer.lua

module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3BuffViewContainer", package.seeall)

local VersionActivity1_3BuffViewContainer = class("VersionActivity1_3BuffViewContainer", BaseViewContainer)

function VersionActivity1_3BuffViewContainer:buildViews()
	self.buffView = VersionActivity1_3BuffView.New()

	return {
		self.buffView,
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function VersionActivity1_3BuffViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return VersionActivity1_3BuffViewContainer
