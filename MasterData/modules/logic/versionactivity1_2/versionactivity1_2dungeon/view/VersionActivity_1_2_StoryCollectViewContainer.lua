-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_StoryCollectViewContainer.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_StoryCollectViewContainer", package.seeall)

local VersionActivity_1_2_StoryCollectViewContainer = class("VersionActivity_1_2_StoryCollectViewContainer", BaseViewContainer)

function VersionActivity_1_2_StoryCollectViewContainer:buildViews()
	return {
		VersionActivity_1_2_StoryCollectView.New()
	}
end

function VersionActivity_1_2_StoryCollectViewContainer:playCloseTransition()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mail_close)

	local rootGO = gohelper.findChild(self.viewGO, "root")

	SLFramework.AnimatorPlayer.Get(rootGO):Play("close", self.onPlayCloseTransitionFinish, self)
end

return VersionActivity_1_2_StoryCollectViewContainer
