-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emoji/view/EmojiViewPresentor.lua

module("logic.extensions.emoji.view.EmojiViewPresentor", package.seeall)

local EmojiViewPresentor = class("EmojiViewPresentor", ViewPresentor)

function EmojiViewPresentor:ctor()
	EmojiViewPresentor.super.ctor(self)
end

function EmojiViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function EmojiViewPresentor:dependWhatResources()
	return {
		"ui/views/emoji/emojiview.prefab",
		ItemEmojiLayout.ResPath
	}
end

function EmojiViewPresentor:buildViews()
	return {
		EmojiView.New()
	}
end

return EmojiViewPresentor
