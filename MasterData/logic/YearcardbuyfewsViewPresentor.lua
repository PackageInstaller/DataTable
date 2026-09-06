-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearcardbuyfewsViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearcardbuyfewsViewPresentor", package.seeall)

local YearcardbuyfewsViewPresentor = class("YearcardbuyfewsViewPresentor", ViewPresentor)

function YearcardbuyfewsViewPresentor:ctor()
	YearcardbuyfewsViewPresentor.super.ctor(self)
end

function YearcardbuyfewsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearcardbuyfewsViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2025/main/yearcardbuyfews2025view.prefab"
	}
end

function YearcardbuyfewsViewPresentor:buildViews()
	return {
		YearcardbuyfewsView.New()
	}
end

return YearcardbuyfewsViewPresentor
