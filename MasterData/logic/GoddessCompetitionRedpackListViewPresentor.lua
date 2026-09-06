-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionRedpackListViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionRedpackListViewPresentor", package.seeall)

local GoddessCompetitionRedpackListViewPresentor = class("GoddessCompetitionRedpackListViewPresentor", ViewPresentor)

function GoddessCompetitionRedpackListViewPresentor:ctor()
	GoddessCompetitionRedpackListViewPresentor.super.ctor(self)
end

function GoddessCompetitionRedpackListViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionRedpackListViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionredpacklistview.prefab"
	}
end

function GoddessCompetitionRedpackListViewPresentor:buildViews()
	return {
		GoddessCompetitionRedpackListView.New()
	}
end

function GoddessCompetitionRedpackListViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionRedpackListViewPresentor
