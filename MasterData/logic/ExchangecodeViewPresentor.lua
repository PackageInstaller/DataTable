-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exchangecode/view/ExchangecodeViewPresentor.lua

module("logic.extensions.exchangecode.view.ExchangecodeViewPresentor", package.seeall)

local ExchangecodeViewPresentor = class("ExchangecodeViewPresentor", ViewPresentor)

function ExchangecodeViewPresentor:ctor()
	ExchangecodeViewPresentor.super.ctor(self)
end

function ExchangecodeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExchangecodeViewPresentor:dependWhatResources()
	return {
		"ui/views/exchangecode/exchangecodeview.prefab"
	}
end

function ExchangecodeViewPresentor:buildViews()
	return {
		ExchangeCodeView.New()
	}
end

return ExchangecodeViewPresentor
