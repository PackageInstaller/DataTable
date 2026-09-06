-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionFansPrizeViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionFansPrizeViewPresentor", package.seeall)

local GoddessCompetitionFansPrizeViewPresentor = class("GoddessCompetitionFansPrizeViewPresentor", ViewPresentor)

function GoddessCompetitionFansPrizeViewPresentor:ctor()
	GoddessCompetitionFansPrizeViewPresentor.super.ctor(self)
end

function GoddessCompetitionFansPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionFansPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionfansprizeview.prefab"
	}
end

function GoddessCompetitionFansPrizeViewPresentor:buildViews()
	return {
		GoddessCompetitionFansPrizeView.New()
	}
end

function GoddessCompetitionFansPrizeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionFansPrizeViewPresentor
