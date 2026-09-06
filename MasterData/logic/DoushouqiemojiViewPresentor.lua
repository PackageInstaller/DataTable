-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqiemojiViewPresentor.lua

module("logic.extensions.doushouqi.view.DoushouqiemojiViewPresentor", package.seeall)

local DoushouqiemojiViewPresentor = class("DoushouqiemojiViewPresentor", ViewWithGuidePresentor)

function DoushouqiemojiViewPresentor:buildViews()
	return {
		DoushouqiemojiView.New()
	}
end

function DoushouqiemojiViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DoushouqiemojiViewPresentor:dependWhatResources()
	return {
		"ui/views/doushouqi/doushouqiemojiview.prefab"
	}
end

return DoushouqiemojiViewPresentor
