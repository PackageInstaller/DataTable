-- chunkname: @modules/logic/sp01/assassin2/story/littlegame/AssassinEyeGameViewContainer.lua

module("modules.logic.sp01.assassin2.story.littlegame.AssassinEyeGameViewContainer", package.seeall)

local AssassinEyeGameViewContainer = class("AssassinEyeGameViewContainer", BaseViewContainer)

function AssassinEyeGameViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(views, AssassinEyeGameView.New())

	return views
end

function AssassinEyeGameViewContainer:buildTabViews(tabContainerId)
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

function AssassinEyeGameViewContainer:_closeCallback()
	self:stat(StatEnum.Result.Abort)
	self:closeThis()
end

function AssassinEyeGameViewContainer:onContainerOpenFinish()
	AssassinEyeGameViewContainer.super.onContainerOpenFinish(self)

	self._startTime = Time.realtimeSinceStartup
	self._episodeId = self.viewParam and self.viewParam.episodeId
end

function AssassinEyeGameViewContainer:stat(result)
	StatController.instance:track(StatEnum.EventName.S01_mini_game, {
		[StatEnum.EventProperties.UseTime] = Mathf.Floor(Time.realtimeSinceStartup - self._startTime),
		[StatEnum.EventProperties.EpisodeId] = tostring(self._episodeId),
		[StatEnum.EventProperties.Result] = StatEnum.Result2Cn[result]
	})
end

return AssassinEyeGameViewContainer
