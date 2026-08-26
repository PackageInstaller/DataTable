-- chunkname: @modules/logic/rouge/dlc/103/view/RougeBossCollectionDropViewContainer.lua

module("modules.logic.rouge.dlc.103.view.RougeBossCollectionDropViewContainer", package.seeall)

local RougeBossCollectionDropViewContainer = class("RougeBossCollectionDropViewContainer", BaseViewContainer)

function RougeBossCollectionDropViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeBossCollectionDropView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "layout/#go_rougemapdetailcontainer"))

	local helpView = HelpShowView.New()

	helpView:setHelpId(HelpEnum.HelpId.RougeBossCollectionDropHelp)
	table.insert(views, helpView)

	return views
end

function RougeBossCollectionDropViewContainer:playCloseTransition()
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, RougeMapEnum.CollectionChangeAnimDuration)
end

function RougeBossCollectionDropViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				false,
				false,
				true
			}, HelpEnum.HelpId.RougeBossCollectionDropHelp)
		}
	elseif tabContainerId == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return RougeBossCollectionDropViewContainer
