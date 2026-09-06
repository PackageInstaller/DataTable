-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionmallboardViewPresentor.lua

module("logic.extensions.companionmall.view.CompanionmallboardViewPresentor", package.seeall)

local CompanionmallboardViewPresentor = class("CompanionmallboardViewPresentor", ViewPresentor)

function CompanionmallboardViewPresentor:ctor()
	CompanionmallboardViewPresentor.super.ctor(self)
end

function CompanionmallboardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompanionmallboardViewPresentor:dependWhatResources()
	return {
		"ui/views/companionmall/companionmallboardview.prefab"
	}
end

function CompanionmallboardViewPresentor:buildViews()
	return {
		CompanionmallboardView.New()
	}
end

return CompanionmallboardViewPresentor
