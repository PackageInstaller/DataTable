-- chunkname: @modules/logic/rouge/map/view/collectiondrop/RougeCollectionDropViewContainer.lua

module("modules.logic.rouge.map.view.collectiondrop.RougeCollectionDropViewContainer", package.seeall)

local RougeCollectionDropViewContainer = class("RougeCollectionDropViewContainer", BaseViewContainer)

function RougeCollectionDropViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeCollectionDropView.New())
	table.insert(views, TabViewGroup.New(2, "layout/#go_rougemapdetailcontainer"))

	return views
end

function RougeCollectionDropViewContainer:playCloseTransition()
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, RougeMapEnum.CollectionChangeAnimDuration)
end

function RougeCollectionDropViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return RougeCollectionDropViewContainer
