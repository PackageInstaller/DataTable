-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/view/CompetitionkingtaskcellViewPresentor.lua

module("logic.extensions.competitionking.view.CompetitionkingtaskcellViewPresentor", package.seeall)

local CompetitionkingtaskcellViewPresentor = class("CompetitionkingtaskcellViewPresentor", ViewPresentor)

function CompetitionkingtaskcellViewPresentor:ctor()
	CompetitionkingtaskcellViewPresentor.super.ctor(self)
end

function CompetitionkingtaskcellViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompetitionkingtaskcellViewPresentor:dependWhatResources()
	return {
		"ui/views/competitionking/competitionkingtaskcellview.prefab"
	}
end

function CompetitionkingtaskcellViewPresentor:buildViews()
	return {
		CompetitionkingtaskcellView.New()
	}
end

function CompetitionkingtaskcellViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CompetitionkingtaskcellViewPresentor
