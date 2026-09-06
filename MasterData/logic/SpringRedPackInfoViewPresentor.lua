-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/view/SpringRedPackInfoViewPresentor.lua

module("logic.extensions.springredpack.view.SpringRedPackInfoViewPresentor", package.seeall)

local SpringRedPackInfoViewPresentor = class("SpringRedPackInfoViewPresentor", ViewPresentor)

function SpringRedPackInfoViewPresentor:ctor()
	SpringRedPackInfoViewPresentor.super.ctor(self)
end

function SpringRedPackInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SpringRedPackInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/springredpack/springredpackinfoview.prefab"
	}
end

function SpringRedPackInfoViewPresentor:buildViews()
	return {
		SpringRedPackInfoView.New()
	}
end

return SpringRedPackInfoViewPresentor
