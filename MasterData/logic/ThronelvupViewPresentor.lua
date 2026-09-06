-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/view/ThronelvupViewPresentor.lua

module("logic.extensions.throne.view.ThronelvupViewPresentor", package.seeall)

local ThronelvupViewPresentor = class("ThronelvupViewPresentor", ViewPresentor)

function ThronelvupViewPresentor:ctor()
	ThronelvupViewPresentor.super.ctor(self)
end

function ThronelvupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ThronelvupViewPresentor:dependWhatResources()
	return {
		"ui/views/throne/thronelvupview.prefab"
	}
end

function ThronelvupViewPresentor:buildViews()
	return {
		ThronelvupView.New()
	}
end

function ThronelvupViewPresentor:onClickOutside()
	self:close()
end

return ThronelvupViewPresentor
