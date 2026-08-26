-- chunkname: @modules/logic/versionactivity/view/VersionActivityStoreViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityStoreViewContainer", package.seeall)

local VersionActivityStoreViewContainer = class("VersionActivityStoreViewContainer", BaseViewContainer)

function VersionActivityStoreViewContainer:buildViews()
	return {
		VersionActivityStoreView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function VersionActivityStoreViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end

	if tabContainerId == 2 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.LeiMiTeBei
			})
		}
	end
end

function VersionActivityStoreViewContainer:playOpenTransition()
	self:startViewOpenBlock()

	local animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	animation:Play("activitystore_open")
	TaskDispatcher.runDelay(self.onPlayOpenTransitionFinish, self, 0.5)
end

function VersionActivityStoreViewContainer:playCloseTransition()
	self:startViewCloseBlock()

	local animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	animation:Play("activitystore_close")
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 0.167)
end

return VersionActivityStoreViewContainer
