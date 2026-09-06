-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/view/PopularityInputViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.PopularityListMainViewPresentor", package.seeall)

local PopularityListMainViewPresentor = class("PopularityListMainViewPresentor", ViewPresentor)

function PopularityListMainViewPresentor:ctor()
	PopularityListMainViewPresentor.super.ctor(self)
end

function PopularityListMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PopularityListMainViewPresentor:dependWhatResources()
	return {
		"ui/views/popularitylist/popularityinputview.prefab"
	}
end

function PopularityListMainViewPresentor:buildViews()
	return {
		PopularityInputView.New()
	}
end

return PopularityListMainViewPresentor
