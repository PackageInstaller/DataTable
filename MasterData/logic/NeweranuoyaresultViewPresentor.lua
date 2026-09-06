-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neweranuoya/view/NeweranuoyaresultViewPresentor.lua

module("logic.extensions.neweranuoya.view.NeweranuoyaresultViewPresentor", package.seeall)

local NeweranuoyaresultViewPresentor = class("NeweranuoyaresultViewPresentor", ViewPresentor)

function NeweranuoyaresultViewPresentor:ctor()
	NeweranuoyaresultViewPresentor.super.ctor(self)
end

function NeweranuoyaresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NeweranuoyaresultViewPresentor:dependWhatResources()
	return {
		"ui/views/neweranuoya/neweranuoyaresultview.prefab"
	}
end

function NeweranuoyaresultViewPresentor:buildViews()
	return {
		NeweranuoyaresultView.New()
	}
end

return NeweranuoyaresultViewPresentor
