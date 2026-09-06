-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/qualifier/PTQualifierRankViewPresentor.lua

module("logic.extensions.peaktournament.view.qualifier.PTQualifierRankViewPresentor", package.seeall)

local PTQualifierRankViewPresentor = class("PTQualifierRankViewPresentor", ViewPresentor)

function PTQualifierRankViewPresentor:ctor()
	PTQualifierRankViewPresentor.super.ctor(self)
end

function PTQualifierRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PTQualifierRankViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/qualifier/ptqualifierrankview.prefab"
	}
end

function PTQualifierRankViewPresentor:buildViews()
	return {
		PTQualifierRankView.New()
	}
end

return PTQualifierRankViewPresentor
