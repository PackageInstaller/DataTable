-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/newyear/NewyearskinitemViewPresentor.lua

module("logic.extensions.bonus.view.newyear.NewyearskinitemViewPresentor", package.seeall)

local NewyearskinitemViewPresentor = class("NewyearskinitemViewPresentor", ViewPresentor)

function NewyearskinitemViewPresentor:ctor()
	NewyearskinitemViewPresentor.super.ctor(self)
end

function NewyearskinitemViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewyearskinitemViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/newyear/newyearskinitemview.prefab"
	}
end

function NewyearskinitemViewPresentor:buildViews()
	return {
		NewyearskinitemView.New()
	}
end

return NewyearskinitemViewPresentor
