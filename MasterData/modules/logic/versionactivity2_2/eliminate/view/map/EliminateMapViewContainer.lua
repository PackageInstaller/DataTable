-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/map/EliminateMapViewContainer.lua

module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapViewContainer", package.seeall)

local EliminateMapViewContainer = class("EliminateMapViewContainer", BaseViewContainer)

function EliminateMapViewContainer:buildViews()
	local views = {}

	table.insert(views, EliminateMapView.New())
	table.insert(views, EliminateMapWindowView.New())
	table.insert(views, EliminateMapAudioView.New())
	table.insert(views, TabViewGroup.New(1, "#go_left"))

	return views
end

function EliminateMapViewContainer:buildTabViews(tabContainerId)
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

function EliminateMapViewContainer:onContainerInit()
	self:initViewParam()
end

function EliminateMapViewContainer:initViewParam()
	self.chapterId = self.viewParam and self.viewParam.chapterId or EliminateMapModel.instance:getLastCanFightChapterId()

	if not EliminateMapModel.instance:checkChapterIsUnlock(self.chapterId) then
		self.chapterId = EliminateMapEnum.DefaultChapterId
	end
end

function EliminateMapViewContainer:changeChapterId(chapterId)
	if self.chapterId == chapterId then
		return
	end

	self.chapterId = chapterId

	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.OnSelectChapterChange)
end

function EliminateMapViewContainer:setVisibleInternal(isVisible)
	EliminateMapViewContainer.super.setVisibleInternal(self, isVisible)
end

return EliminateMapViewContainer
