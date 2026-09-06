-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/PTEliVotePlateRecordViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.PTEliVotePlateRecordViewPresentor", package.seeall)

local PTEliVotePlateRecordViewPresentor = class("PTEliVotePlateRecordViewPresentor", ViewPresentor)

function PTEliVotePlateRecordViewPresentor:ctor()
	PTEliVotePlateRecordViewPresentor.super.ctor(self)
end

function PTEliVotePlateRecordViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PTEliVotePlateRecordViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/ptelivoteplaterecordview.prefab"
	}
end

function PTEliVotePlateRecordViewPresentor:buildViews()
	return {
		PTEliVotePlateRecordView.New()
	}
end

return PTEliVotePlateRecordViewPresentor
