-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NineplacelvupViewPresentor.lua

module("logic.extensions.nineplace.view.NineplacelvupViewPresentor", package.seeall)

local NineplacelvupViewPresentor = class("NineplacelvupViewPresentor", ViewWithGuidePresentor)

function NineplacelvupViewPresentor:ctor()
	NineplacelvupViewPresentor.super.ctor(self)
end

function NineplacelvupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NineplacelvupViewPresentor:dependWhatResources()
	return {
		"ui/views/nineplace/nineplacelvupview.prefab"
	}
end

function NineplacelvupViewPresentor:buildViews()
	return {
		NineplacelvupView.New()
	}
end

return NineplacelvupViewPresentor
