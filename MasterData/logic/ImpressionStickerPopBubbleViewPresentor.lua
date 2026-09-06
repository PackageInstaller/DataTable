-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/impressionstickerpopbubble/view/ImpressionStickerPopBubbleViewPresentor.lua

module("logic.extensions.impressionstickerpopbubble.view.ImpressionStickerPopBubbleViewPresentor", package.seeall)

local ImpressionStickerPopBubbleViewPresentor = class("ImpressionStickerPopBubbleViewPresentor", ViewPresentor)

function ImpressionStickerPopBubbleViewPresentor:ctor()
	ImpressionStickerPopBubbleViewPresentor.super.ctor(self)
end

function ImpressionStickerPopBubbleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ImpressionStickerPopBubbleViewPresentor:dependWhatResources()
	return {
		"ui/views/impressionstickerpopbubble/impressionstickerpopbubbleview.prefab"
	}
end

function ImpressionStickerPopBubbleViewPresentor:buildViews()
	return {
		ImpressionStickerPopBubbleView.New()
	}
end

return ImpressionStickerPopBubbleViewPresentor
