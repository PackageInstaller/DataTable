-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/PTEliVoteGoldGainPopViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.PTEliVoteGoldGainPopViewPresentor", package.seeall)

local PTEliVoteGoldGainPopViewPresentor = class("PTEliVoteGoldGainPopViewPresentor", ViewPresentor)

function PTEliVoteGoldGainPopViewPresentor:ctor()
	PTEliVoteGoldGainPopViewPresentor.super.ctor(self)
end

function PTEliVoteGoldGainPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PTEliVoteGoldGainPopViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/ptelivotegoldgainpopview.prefab"
	}
end

function PTEliVoteGoldGainPopViewPresentor:buildViews()
	return {
		PTEliVoteGoldGainPopView.New()
	}
end

return PTEliVoteGoldGainPopViewPresentor
