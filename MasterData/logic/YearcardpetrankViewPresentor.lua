-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearcardpetrankViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearcardpetrankViewPresentor", package.seeall)

local YearcardpetrankViewPresentor = class("YearcardpetrankViewPresentor", ViewPresentor)

function YearcardpetrankViewPresentor:ctor()
	YearcardpetrankViewPresentor.super.ctor(self)
end

function YearcardpetrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearcardpetrankViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2025/main/yearcardpetrank2025view.prefab"
	}
end

function YearcardpetrankViewPresentor:buildViews()
	return {
		YearcardpetrankView.New()
	}
end

return YearcardpetrankViewPresentor
