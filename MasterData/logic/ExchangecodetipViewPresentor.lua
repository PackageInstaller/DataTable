-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exchangecode/view/ExchangecodetipViewPresentor.lua

module("logic.extensions.exchangecode.view.ExchangecodetipViewPresentor", package.seeall)

local ExchangecodetipViewPresentor = class("ExchangecodetipViewPresentor", ViewPresentor)

function ExchangecodetipViewPresentor:ctor()
	ExchangecodetipViewPresentor.super.ctor(self)
end

function ExchangecodetipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExchangecodetipViewPresentor:dependWhatResources()
	return {
		"ui/views/exchangecode/exchangecodetipview.prefab"
	}
end

function ExchangecodetipViewPresentor:buildViews()
	return {
		ExchangeCodeView.New()
	}
end

return ExchangecodetipViewPresentor
