-- chunkname: @modules/logic/sp01/assassin2/story/littlegame/AssassinPointGameViewContainer.lua

module("modules.logic.sp01.assassin2.story.littlegame.AssassinPointGameViewContainer", package.seeall)

local AssassinPointGameViewContainer = class("AssassinPointGameViewContainer", BaseViewContainer)

function AssassinPointGameViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinPointGameView.New())
	table.insert(views, AssassinPointGame2View.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function AssassinPointGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		}, nil, self._closeCallback, nil, nil, self)

		return {
			self.navigateView
		}
	end
end

function AssassinPointGameViewContainer:_closeCallback()
	self:stat(StatEnum.Result.Abort)
	self:closeThis()
end

function AssassinPointGameViewContainer:onContainerOpenFinish()
	AssassinPointGameViewContainer.super.onContainerOpenFinish(self)

	self._startTime = Time.realtimeSinceStartup
	self._episodeId = self.viewParam and self.viewParam.episodeId
end

function AssassinPointGameViewContainer:stat(result)
	StatController.instance:track(StatEnum.EventName.S01_mini_game, {
		[StatEnum.EventProperties.UseTime] = Mathf.Floor(Time.realtimeSinceStartup - self._startTime),
		[StatEnum.EventProperties.EpisodeId] = tostring(self._episodeId),
		[StatEnum.EventProperties.Result] = StatEnum.Result2Cn[result]
	})
end

return AssassinPointGameViewContainer
