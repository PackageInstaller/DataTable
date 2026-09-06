-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dialogue/view/DialogueViewPresentor.lua

module("logic.extensions.dialogue.view.DialogueViewPresentor", package.seeall)

local DialogueViewPresentor = class("DialogueViewPresentor", ViewPresentor)

function DialogueViewPresentor:ctor()
	DialogueViewPresentor.super.ctor(self)
end

function DialogueViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DialogueViewPresentor:dependWhatResources()
	return {
		"ui/views/dialogue/dialogueview.prefab"
	}
end

function DialogueViewPresentor:buildViews()
	return {
		DialogueView.New()
	}
end

return DialogueViewPresentor
