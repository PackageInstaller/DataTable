-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/PTEliTopExhibitionMainViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.PTEliTopExhibitionMainViewPresentor", package.seeall)

local PTEliTopExhibitionMainViewPresentor = class("PTEliTopExhibitionMainViewPresentor", ViewPresentor)

function PTEliTopExhibitionMainViewPresentor:ctor()
	PTEliTopExhibitionMainViewPresentor.super.ctor(self)
end

function PTEliTopExhibitionMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PTEliTopExhibitionMainViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/ptelitopexhibitionmainview.prefab"
	}
end

function PTEliTopExhibitionMainViewPresentor:buildViews()
	return {
		PTEliTopExhibitionMainView.New()
	}
end

return PTEliTopExhibitionMainViewPresentor
