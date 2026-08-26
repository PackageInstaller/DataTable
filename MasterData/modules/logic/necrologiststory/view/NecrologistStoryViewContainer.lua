-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryViewContainer.lua

module("modules.logic.necrologiststory.view.NecrologistStoryViewContainer", package.seeall)

local NecrologistStoryViewContainer = class("NecrologistStoryViewContainer", BaseViewContainer)

function NecrologistStoryViewContainer:buildViews()
	local views = {}

	table.insert(views, NecrologistStoryButtonView.New())

	self._storyView = NecrologistStoryView.New()
	self._storyItemView = NecrologistStoryView_Item.New()
	self._storyPlayView = NecrologistStoryView_PlayStory.New()

	table.insert(views, self._storyView)
	table.insert(views, self._storyItemView)
	table.insert(views, self._storyPlayView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function NecrologistStoryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			navView
		}
	end
end

function NecrologistStoryViewContainer:getLastItem()
	return self._storyView:getLastItem()
end

function NecrologistStoryViewContainer:getStoryItemView()
	return self._storyItemView
end

function NecrologistStoryViewContainer:getStoryView()
	return self._storyView
end

function NecrologistStoryViewContainer:getStoryPlayView()
	return self._storyPlayView
end

return NecrologistStoryViewContainer
