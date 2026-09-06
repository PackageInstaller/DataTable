-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehope/view/DivinehopeextViewPresentor.lua

module("logic.extensions.divinehope.view.DivinehopeextViewPresentor", package.seeall)

local DivinehopeextViewPresentor = class("DivinehopeextViewPresentor", ViewPresentor)

function DivinehopeextViewPresentor:ctor()
	DivinehopeextViewPresentor.super.ctor(self)
end

function DivinehopeextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinehopeextViewPresentor:dependWhatResources()
	return {
		"ui/views/divinehope/divinehopeextview.prefab"
	}
end

function DivinehopeextViewPresentor:buildViews()
	return {
		DivinehopeextView.New()
	}
end

return DivinehopeextViewPresentor
