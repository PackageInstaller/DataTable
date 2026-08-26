-- chunkname: @modules/logic/versionactivity1_8/warmup/view/VersionActivity1_8WarmUpViewContainer.lua

module("modules.logic.versionactivity1_8.warmup.view.VersionActivity1_8WarmUpViewContainer", package.seeall)

local VersionActivity1_8WarmUpViewContainer = class("VersionActivity1_8WarmUpViewContainer", BaseViewContainer)

function VersionActivity1_8WarmUpViewContainer:buildViews()
	return {
		VersionActivity1_8WarmUpView.New(),
		Act1_8WarmUpLeftView.New()
	}
end

function VersionActivity1_8WarmUpViewContainer:isPlayingDesc()
	return self._isPlayingDesc
end

function VersionActivity1_8WarmUpViewContainer:setIsPlayingDesc(isPlaying)
	self._isPlayingDesc = isPlaying
end

return VersionActivity1_8WarmUpViewContainer
