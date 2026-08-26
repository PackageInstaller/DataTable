-- chunkname: @modules/versionactivitybase/fixed1/dungeon/view/map/VersionActivityFixedDungeonMapLevelViewContainer1.lua

module("modules.versionactivitybase.fixed1.dungeon.view.map.VersionActivityFixedDungeonMapLevelViewContainer1", package.seeall)

local VersionActivityFixedDungeonMapLevelViewContainer1 = class("VersionActivityFixedDungeonMapLevelViewContainer1", BaseViewContainer)
local TIME_OUT = 2

function VersionActivityFixedDungeonMapLevelViewContainer1:buildViews()
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	local scriptSuffix = VersionActivityFixedHelper.getVersionActivityScriptSuffix(self._bigVersion, self._smallVersion)

	self.mapLevelView = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelView(self._bigVersion, self._smallVersion, scriptSuffix).New()

	return {
		self.mapLevelView,
		TabViewGroup.New(1, "anim/#go_righttop"),
		TabViewGroup.New(2, "anim/#go_lefttop")
	}
end

function VersionActivityFixedDungeonMapLevelViewContainer1:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.Power
			})
		}
	elseif tabContainerId == 2 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

function VersionActivityFixedDungeonMapLevelViewContainer1:setOpenedEpisodeId(episodeId)
	self.openedEpisodeId = episodeId
end

function VersionActivityFixedDungeonMapLevelViewContainer1:getOpenedEpisodeId()
	return self.openedEpisodeId
end

function VersionActivityFixedDungeonMapLevelViewContainer1:playCloseTransition()
	self:startViewOpenBlock()

	local player = self.mapLevelView.animatorPlayer

	if player then
		player:Play(UIAnimationName.Close, self.onPlayCloseTransitionFinish, self)
	end

	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, TIME_OUT)
end

function VersionActivityFixedDungeonMapLevelViewContainer1:onPlayCloseTransitionFinish()
	SLFramework.AnimatorPlayer.Get(self.mapLevelView.goVersionActivity):Stop()
	VersionActivityFixedDungeonMapLevelViewContainer1.super.onPlayCloseTransitionFinish(self)
end

function VersionActivityFixedDungeonMapLevelViewContainer1:stopCloseViewTask()
	return
end

return VersionActivityFixedDungeonMapLevelViewContainer1
