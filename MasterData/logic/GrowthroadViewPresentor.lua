-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamyouth/view/GrowthroadViewPresentor.lua

module("logic.extensions.dreamyouth.view.GrowthroadViewPresentor", package.seeall)

local GrowthroadViewPresentor = class("GrowthroadViewPresentor", ViewPresentor)

function GrowthroadViewPresentor:ctor()
	GrowthroadViewPresentor.super.ctor(self)
end

function GrowthroadViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GrowthroadViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamyouth/growthroadview.prefab"
	}
end

function GrowthroadViewPresentor:buildViews()
	return {
		GrowthroadView.New()
	}
end

return GrowthroadViewPresentor
