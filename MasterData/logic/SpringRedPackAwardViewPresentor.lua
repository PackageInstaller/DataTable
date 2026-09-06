-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/view/SpringRedPackAwardViewPresentor.lua

module("logic.extensions.springredpack.view.SpringRedPackAwardViewPresentor", package.seeall)

local SpringRedPackAwardViewPresentor = class("SpringRedPackAwardViewPresentor", ViewPresentor)

function SpringRedPackAwardViewPresentor:ctor()
	SpringRedPackAwardViewPresentor.super.ctor(self)
end

function SpringRedPackAwardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SpringRedPackAwardViewPresentor:dependWhatResources()
	return {
		"ui/views/springredpack/springredpackawardview.prefab"
	}
end

function SpringRedPackAwardViewPresentor:buildViews()
	return {
		SpringRedPackAwardView.New()
	}
end

return SpringRedPackAwardViewPresentor
