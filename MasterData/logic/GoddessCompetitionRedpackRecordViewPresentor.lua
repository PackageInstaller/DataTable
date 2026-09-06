-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionRedpackRecordViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionRedpackRecordViewPresentor", package.seeall)

local GoddessCompetitionRedpackRecordViewPresentor = class("GoddessCompetitionRedpackRecordViewPresentor", ViewPresentor)

function GoddessCompetitionRedpackRecordViewPresentor:ctor()
	GoddessCompetitionRedpackRecordViewPresentor.super.ctor(self)
end

function GoddessCompetitionRedpackRecordViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionRedpackRecordViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionredpackrecordview.prefab"
	}
end

function GoddessCompetitionRedpackRecordViewPresentor:buildViews()
	return {
		GoddessCompetitionRedpackRecordView.New()
	}
end

function GoddessCompetitionRedpackRecordViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionRedpackRecordViewPresentor
