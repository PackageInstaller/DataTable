-- chunkname: @modules/logic/sp01/assassin2/story/littlegame/AssassinLineGameViewContainer.lua

module("modules.logic.sp01.assassin2.story.littlegame.AssassinLineGameViewContainer", package.seeall)

local AssassinLineGameViewContainer = class("AssassinLineGameViewContainer", BaseViewContainer)

function AssassinLineGameViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinLineGameView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function AssassinLineGameViewContainer:buildTabViews(tabContainerId)
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

function AssassinLineGameViewContainer:_closeCallback()
	self:stat(StatEnum.Result.Abort)
	self:closeThis()
end

function AssassinLineGameViewContainer:onContainerOpenFinish()
	AssassinLineGameViewContainer.super.onContainerOpenFinish(self)

	self._startTime = Time.realtimeSinceStartup
	self._episodeId = self.viewParam and self.viewParam.episodeId
end

function AssassinLineGameViewContainer:stat(result)
	StatController.instance:track(StatEnum.EventName.S01_mini_game, {
		[StatEnum.EventProperties.UseTime] = Mathf.Floor(Time.realtimeSinceStartup - self._startTime),
		[StatEnum.EventProperties.EpisodeId] = tostring(self._episodeId),
		[StatEnum.EventProperties.Result] = StatEnum.Result2Cn[result]
	})
end

return AssassinLineGameViewContainer
