-- chunkname: @modules/logic/versionactivity1_9/warmup/view/VersionActivity1_9WarmUpViewContainer.lua

module("modules.logic.versionactivity1_9.warmup.view.VersionActivity1_9WarmUpViewContainer", package.seeall)

local VersionActivity1_9WarmUpViewContainer = class("VersionActivity1_9WarmUpViewContainer", BaseViewContainer)

function VersionActivity1_9WarmUpViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity1_9WarmUpView.New())

	return views
end

function VersionActivity1_9WarmUpViewContainer:isPlayingDesc()
	return self._isPlayingDesc
end

function VersionActivity1_9WarmUpViewContainer:setIsPlayingDesc(isPlaying)
	self._isPlayingDesc = isPlaying
end

return VersionActivity1_9WarmUpViewContainer
