-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateVoteRecordViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownEliminateVoteRecordViewPresentor", package.seeall)

local ShowDownEliminateVoteRecordViewPresentor = class("ShowDownEliminateVoteRecordViewPresentor", ViewPresentor)

function ShowDownEliminateVoteRecordViewPresentor:ctor()
	ShowDownEliminateVoteRecordViewPresentor.super.ctor(self)
end

function ShowDownEliminateVoteRecordViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownEliminateVoteRecordViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdowneliminatevoterecordview.prefab"
	}
end

function ShowDownEliminateVoteRecordViewPresentor:buildViews()
	return {
		ShowDownEliminateVoteRecordView.New()
	}
end

return ShowDownEliminateVoteRecordViewPresentor
