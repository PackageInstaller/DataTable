-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiurep/view/HeartofaojiurepmainViewPresentor.lua

module("logic.extensions.heartofaojiurep.view.HeartofaojiurepmainViewPresentor", package.seeall)

local HeartofaojiurepmainViewPresentor = class("HeartofaojiurepmainViewPresentor", ViewPresentor)

function HeartofaojiurepmainViewPresentor:ctor()
	HeartofaojiurepmainViewPresentor.super.ctor(self)
end

function HeartofaojiurepmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeartofaojiurepmainViewPresentor:dependWhatResources()
	return {
		"ui/views/heartofaojiurep/heartofaojiurepmainview.prefab"
	}
end

function HeartofaojiurepmainViewPresentor:buildViews()
	return {
		HeartofaojiurepmainView.New()
	}
end

return HeartofaojiurepmainViewPresentor
