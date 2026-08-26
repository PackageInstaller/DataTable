-- chunkname: @modules/logic/test/view/TestUIViewContainer.lua

module("modules.logic.test.view.TestUIViewContainer", package.seeall)

local TestUIViewContainer = class("TestUIViewContainer", BaseViewContainer)

function TestUIViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_lefttopbtns"),
		TestUIView.New()
	}
end

function TestUIViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			}, nil, function()
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_story_close)
			end)
		}
	end
end

return TestUIViewContainer
