-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/maplevel/VersionActivity1_6DungeonMapLevelViewContainer.lua

module("modules.logic.versionactivity1_6.dungeon.view.maplevel.VersionActivity1_6DungeonMapLevelViewContainer", package.seeall)

local VersionActivity1_6DungeonMapLevelViewContainer = class("VersionActivity1_6DungeonMapLevelViewContainer", BaseViewContainer)

function VersionActivity1_6DungeonMapLevelViewContainer:buildViews()
	self.mapLevelView = VersionActivity1_6DungeonMapLevelView.New()

	return {
		self.mapLevelView,
		TabViewGroup.New(1, "anim/#go_righttop"),
		TabViewGroup.New(2, "anim/#go_lefttop")
	}
end

function VersionActivity1_6DungeonMapLevelViewContainer:buildTabViews(tabContainerId)
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

function VersionActivity1_6DungeonMapLevelViewContainer:setOpenedEpisodeId(episodeId)
	self.openedEpisodeId = episodeId
end

function VersionActivity1_6DungeonMapLevelViewContainer:getOpenedEpisodeId()
	return self.openedEpisodeId
end

function VersionActivity1_6DungeonMapLevelViewContainer:playCloseTransition()
	self:startViewOpenBlock()

	local player = SLFramework.AnimatorPlayer.Get(self.mapLevelView.goVersionActivity)

	player:Play(UIAnimationName.Close, self.onPlayCloseTransitionFinish, self)
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 2)
end

function VersionActivity1_6DungeonMapLevelViewContainer:onPlayCloseTransitionFinish()
	SLFramework.AnimatorPlayer.Get(self.mapLevelView.goVersionActivity):Stop()
	VersionActivity1_6DungeonMapLevelViewContainer.super.onPlayCloseTransitionFinish(self)
end

function VersionActivity1_6DungeonMapLevelViewContainer:stopCloseViewTask()
	self.mapLevelView:cancelStartCloseTask()
end

function VersionActivity1_6DungeonMapLevelViewContainer:initChapterRecheck()
	local chapterId = self:_getChapterId()

	if self._navigateButtonView then
		self._navigateButtonView:initChapterRecheck(chapterId)
	end
end

function VersionActivity1_6DungeonMapLevelViewContainer:_getChapterId()
	return VersionActivity1_6DungeonEnum.DungeonChapterId.Story
end

return VersionActivity1_6DungeonMapLevelViewContainer
