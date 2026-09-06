-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neweranuoya/view/NeweranuoyabuffViewPresentor.lua

module("logic.extensions.neweranuoya.view.NeweranuoyabuffViewPresentor", package.seeall)

local NeweranuoyabuffViewPresentor = class("NeweranuoyabuffViewPresentor", ViewPresentor)

function NeweranuoyabuffViewPresentor:ctor()
	NeweranuoyabuffViewPresentor.super.ctor(self)
end

function NeweranuoyabuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NeweranuoyabuffViewPresentor:dependWhatResources()
	return {
		"ui/views/neweranuoya/neweranuoyabuffview.prefab"
	}
end

function NeweranuoyabuffViewPresentor:buildViews()
	return {
		NeweranuoyabuffView.New()
	}
end

return NeweranuoyabuffViewPresentor
