-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NineplacebuffenemyPresentor.lua

module("logic.extensions.nineplacebuffenemy.view.NineplacebuffenemyPresentor", package.seeall)

local NineplacebuffenemyPresentor = class("NineplacebuffenemyPresentor", ViewPresentor)

function NineplacebuffenemyPresentor:ctor()
	NineplacebuffenemyPresentor.super.ctor(self)
end

function NineplacebuffenemyPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NineplacebuffenemyPresentor:dependWhatResources()
	return {
		"ui/views/nineplace/nineplacebuffenemyview.prefab"
	}
end

function NineplacebuffenemyPresentor:buildViews()
	return {
		NineplacebuffenemyView.New()
	}
end

return NineplacebuffenemyPresentor
