-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionmallPreviewViewPresentor.lua

module("logic.extensions.companionmall.view.CompanionmallPreviewViewPresentor", package.seeall)

local CompanionmallPreviewViewPresentor = class("CompanionmallPreviewViewPresentor", ViewPresentor)

function CompanionmallPreviewViewPresentor:ctor()
	CompanionmallPreviewViewPresentor.super.ctor(self)
end

function CompanionmallPreviewViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompanionmallPreviewViewPresentor:dependWhatResources()
	return {
		"ui/views/companionmall/companionmallpreviewview.prefab"
	}
end

function CompanionmallPreviewViewPresentor:buildViews()
	return {
		CompanionmallPreviewView.New()
	}
end

return CompanionmallPreviewViewPresentor
