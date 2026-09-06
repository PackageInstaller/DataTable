-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monopoly/view/MonopolyPresentor.lua

module("logic.extensions.monopoly.view.MonopolyPresentor", package.seeall)

local MonopolyPresentor = class("MonopolyPresentor", ViewPresentor)

function MonopolyPresentor:ctor()
	MonopolyPresentor.super.ctor(self)
end

function MonopolyPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MonopolyPresentor:dependWhatResources()
	return {
		"ui/views/monopoly/monopolyview.prefab"
	}
end

function MonopolyPresentor:buildViews()
	return {
		MonopolyView.New()
	}
end

function MonopolyPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MonopolyPresentor
