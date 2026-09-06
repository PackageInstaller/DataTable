-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/PTEliVotePlateBagViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.PTEliVotePlateBagViewPresentor", package.seeall)

local PTEliVotePlateBagViewPresentor = class("PTEliVotePlateBagViewPresentor", ViewPresentor)

function PTEliVotePlateBagViewPresentor:ctor()
	PTEliVotePlateBagViewPresentor.super.ctor(self)
end

function PTEliVotePlateBagViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PTEliVotePlateBagViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/ptelivoteplatebagview.prefab"
	}
end

function PTEliVotePlateBagViewPresentor:buildViews()
	return {
		PTEliVotePlateBagView.New()
	}
end

return PTEliVotePlateBagViewPresentor
