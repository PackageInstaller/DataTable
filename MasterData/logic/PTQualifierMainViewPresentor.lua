-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/qualifier/PTQualifierMainViewPresentor.lua

module("logic.extensions.peaktournament.view.qualifier.PTQualifierMainViewPresentor", package.seeall)

local PTQualifierMainViewPresentor = class("PTQualifierMainViewPresentor", ViewPresentor)

function PTQualifierMainViewPresentor:ctor()
	PTQualifierMainViewPresentor.super.ctor(self)
end

function PTQualifierMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PTQualifierMainViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/qualifier/ptqualifiermainview.prefab"
	}
end

function PTQualifierMainViewPresentor:buildViews()
	return {
		PTQualifierMainView.New()
	}
end

return PTQualifierMainViewPresentor
