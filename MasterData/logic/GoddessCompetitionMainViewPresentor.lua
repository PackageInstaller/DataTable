-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionMainViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionMainViewPresentor", package.seeall)

local GoddessCompetitionMainViewPresentor = class("GoddessCompetitionMainViewPresentor", ViewPresentor)

function GoddessCompetitionMainViewPresentor:ctor()
	GoddessCompetitionMainViewPresentor.super.ctor(self)
end

function GoddessCompetitionMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionMainViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionmainview.prefab"
	}
end

function GoddessCompetitionMainViewPresentor:buildViews()
	return {
		GoddessCompetitionMainView.New()
	}
end

function GoddessCompetitionMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionMainViewPresentor
