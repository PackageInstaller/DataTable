-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickapet/view/PickAPetViewPresentor.lua

module("logic.extensions.pickapet.view.PickAPetViewPresentor", package.seeall)

local PickAPetViewPresentor = class("PickAPetViewPresentor", ViewPresentor)

function PickAPetViewPresentor:ctor()
	PickAPetViewPresentor.super.ctor(self)
end

function PickAPetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PickAPetViewPresentor:dependWhatResources()
	return {
		"ui/views/pickapet/pickapetview.prefab",
		"ui/views/common/item_pet.prefab"
	}
end

function PickAPetViewPresentor:buildViews()
	local views = {}
	local view = PickAPetView.New()

	table.insert(views, view)

	view = PickCoutDownView.New()

	table.insert(views, view)

	view = PickNextGameView.New()

	table.insert(views, view)

	return views
end

return PickAPetViewPresentor
