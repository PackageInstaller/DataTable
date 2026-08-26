-- chunkname: @modules/logic/help/view/HelpPageTabViewContainer.lua

module("modules.logic.help.view.HelpPageTabViewContainer", package.seeall)

local HelpPageTabViewContainer = class("HelpPageTabViewContainer", BaseViewContainer)

function HelpPageTabViewContainer:buildViews()
	self._helpPageTabView = HelpPageTabView.New()

	return {
		self._helpPageTabView,
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_helpview"),
		TabViewGroup.New(3, "#go_voidepage")
	}
end

function HelpPageTabViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	elseif tabContainerId == 2 then
		return {
			HelpPageHelpView.New()
		}
	elseif tabContainerId == 3 then
		return {
			HelpPageVideoView.New()
		}
	end
end

function HelpPageTabViewContainer:setBtnShow(isShow)
	if self._navigateButtonsView then
		self._navigateButtonsView:setParam({
			isShow,
			isShow,
			false
		})
	end
end

function HelpPageTabViewContainer:setVideoFullScreen(isFull)
	if self._helpPageTabView then
		self._helpPageTabView:setVideoFullScreen(isFull)
	end
end

function HelpPageTabViewContainer:checkHelpPageCfg(pageCfg, isAll, guideId)
	if not pageCfg then
		return false
	end

	if isAll then
		if HelpController.instance:canShowPage(pageCfg) or pageCfg.unlockGuideId == self._matchGuideId then
			return true
		end
	elseif guideId then
		if pageCfg.unlockGuideId == guideId then
			return true
		end
	elseif HelpController.instance:canShowPage(pageCfg) then
		return true
	end

	return false
end

function HelpPageTabViewContainer:checkHelpVideoCfg(videoCfg, isAll, guideId)
	if not videoCfg then
		return false
	end

	if isAll then
		if HelpController.instance:canShowVideo(videoCfg) or videoCfg.unlockGuideId == self._matchGuideId then
			return true
		end
	elseif guideId then
		if videoCfg.unlockGuideId == guideId then
			return true
		end
	elseif HelpController.instance:canShowVideo(videoCfg) then
		return true
	end

	return false
end

return HelpPageTabViewContainer
