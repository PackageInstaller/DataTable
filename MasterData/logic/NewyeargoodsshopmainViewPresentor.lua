-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyeargoodsshop/view/NewyeargoodsshopmainViewPresentor.lua

module("logic.extensions.newyeargoodsshop.view.NewyeargoodsshopmainViewPresentor", package.seeall)

local NewyeargoodsshopmainViewPresentor = class("NewyeargoodsshopmainViewPresentor", ViewPresentor)

function NewyeargoodsshopmainViewPresentor:ctor()
	NewyeargoodsshopmainViewPresentor.super.ctor(self)
end

function NewyeargoodsshopmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewyeargoodsshopmainViewPresentor:dependWhatResources()
	return {
		"ui/views/newyeargoodsshop/newyeargoodsshopmainview.prefab"
	}
end

function NewyeargoodsshopmainViewPresentor:buildViews()
	return {
		NewyeargoodsshopmainView.New()
	}
end

return NewyeargoodsshopmainViewPresentor
