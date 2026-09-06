-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/CollectblessingtaskViewPresentor.lua

module("logic.extensions.birthdaywishes.view.CollectblessingtaskViewPresentor", package.seeall)

local CollectblessingtaskViewPresentor = class("CollectblessingtaskViewPresentor", ViewPresentor)

function CollectblessingtaskViewPresentor:ctor()
	CollectblessingtaskViewPresentor.super.ctor(self)
end

function CollectblessingtaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectblessingtaskViewPresentor:dependWhatResources()
	return {
		"ui/views/collectblessing/collectblessingtaskview.prefab"
	}
end

function CollectblessingtaskViewPresentor:buildViews()
	return {
		CollectBlessingTaskView.New()
	}
end

return CollectblessingtaskViewPresentor
