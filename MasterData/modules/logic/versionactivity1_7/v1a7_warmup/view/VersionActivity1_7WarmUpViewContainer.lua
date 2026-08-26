-- chunkname: @modules/logic/versionactivity1_7/v1a7_warmup/view/VersionActivity1_7WarmUpViewContainer.lua

module("modules.logic.versionactivity1_7.v1a7_warmup.view.VersionActivity1_7WarmUpViewContainer", package.seeall)

local VersionActivity1_7WarmUpViewContainer = class("VersionActivity1_7WarmUpViewContainer", BaseViewContainer)

function VersionActivity1_7WarmUpViewContainer:buildViews()
	return {
		VersionActivity1_7WarmUpView.New(),
		VersionActivity1_7WarmUpMapView.New()
	}
end

function VersionActivity1_7WarmUpViewContainer:isPlayingDesc()
	return self._isPlayingDesc
end

function VersionActivity1_7WarmUpViewContainer:setIsPlayingDesc(isPlaying)
	self._isPlayingDesc = isPlaying
end

return VersionActivity1_7WarmUpViewContainer
