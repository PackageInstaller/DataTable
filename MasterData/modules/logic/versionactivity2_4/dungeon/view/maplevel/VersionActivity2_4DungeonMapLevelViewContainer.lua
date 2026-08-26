-- chunkname: @modules/logic/versionactivity2_4/dungeon/view/maplevel/VersionActivity2_4DungeonMapLevelViewContainer.lua

module("modules.logic.versionactivity2_4.dungeon.view.maplevel.VersionActivity2_4DungeonMapLevelViewContainer", package.seeall)

local VersionActivity2_4DungeonMapLevelViewContainer = class("VersionActivity2_4DungeonMapLevelViewContainer", BaseViewContainer)
local TIME_OUT = 2

function VersionActivity2_4DungeonMapLevelViewContainer:buildViews()
	self.mapLevelView = VersionActivity2_4DungeonMapLevelView.New()

	return {
		self.mapLevelView,
		TabViewGroup.New(1, "anim/#go_righttop"),
		TabViewGroup.New(2, "anim/#go_lefttop")
	}
end

function VersionActivity2_4DungeonMapLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.Power
			})
		}
	elseif tabContainerId == 2 then
		self._navigateButtonView = DungeonNavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setOpenCallback(self.initChapterRecheck, self)
		self._navigateButtonView:setOverrideClickRecheck(self.closeThis, self)

		return {
			self._navigateButtonView
		}
	end
end

function VersionActivity2_4DungeonMapLevelViewContainer:setOpenedEpisodeId(episodeId)
	self.openedEpisodeId = episodeId
end

function VersionActivity2_4DungeonMapLevelViewContainer:getOpenedEpisodeId()
	return self.openedEpisodeId
end

function VersionActivity2_4DungeonMapLevelViewContainer:playCloseTransition()
	self:startViewOpenBlock()

	local player = self.mapLevelView.animatorPlayer

	if player then
		player:Play(UIAnimationName.Close, self.onPlayCloseTransitionFinish, self)
	end

	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, TIME_OUT)
end

function VersionActivity2_4DungeonMapLevelViewContainer:onPlayCloseTransitionFinish()
	SLFramework.AnimatorPlayer.Get(self.mapLevelView.goVersionActivity):Stop()
	VersionActivity2_4DungeonMapLevelViewContainer.super.onPlayCloseTransitionFinish(self)
end

function VersionActivity2_4DungeonMapLevelViewContainer:stopCloseViewTask()
	return
end

function VersionActivity2_4DungeonMapLevelViewContainer:initChapterRecheck()
	local chapterId = self:_getChapterId()

	if self._navigateButtonView then
		self._navigateButtonView:initChapterRecheck(chapterId)
	end
end

function VersionActivity2_4DungeonMapLevelViewContainer:_getChapterId()
	return VersionActivity2_4DungeonEnum.DungeonChapterId.Story
end

return VersionActivity2_4DungeonMapLevelViewContainer
