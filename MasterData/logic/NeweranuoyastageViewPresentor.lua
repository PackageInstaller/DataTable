-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neweranuoya/view/NeweranuoyastageViewPresentor.lua

module("logic.extensions.neweranuoya.view.NeweranuoyastageViewPresentor", package.seeall)

local NeweranuoyastageViewPresentor = class("NeweranuoyastageViewPresentor", ViewPresentor)

function NeweranuoyastageViewPresentor:ctor()
	NeweranuoyastageViewPresentor.super.ctor(self)
end

function NeweranuoyastageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NeweranuoyastageViewPresentor:dependWhatResources()
	return {
		"ui/views/neweranuoya/neweranuoyastageview.prefab"
	}
end

function NeweranuoyastageViewPresentor:buildViews()
	return {
		NeweranuoyastageView.New()
	}
end

return NeweranuoyastageViewPresentor
