-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/view/OriginaresmombufftipViewPresentor.lua

module("logic.extensions.originaresmom.view.OriginaresmombufftipViewPresentor", package.seeall)

local OriginaresmombufftipViewPresentor = class("OriginaresmombufftipViewPresentor", ViewPresentor)

function OriginaresmombufftipViewPresentor:ctor()
	OriginaresmombufftipViewPresentor.super.ctor(self)
end

function OriginaresmombufftipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginaresmombufftipViewPresentor:dependWhatResources()
	return {
		"ui/views/originaresmom/originaresmombufftipview.prefab"
	}
end

function OriginaresmombufftipViewPresentor:buildViews()
	return {
		OriginaresmombufftipView.New()
	}
end

return OriginaresmombufftipViewPresentor
