-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petshandbook/view/PetsHandBookViewPresentor.lua

module("logic.extensions.petshandbook.view.PetsHandBookViewPresentor", package.seeall)

local PetsHandBookViewPresentor = class("PetsHandBookViewPresentor", ViewPresentor)

function PetsHandBookViewPresentor:ctor()
	PetsHandBookViewPresentor.super.ctor(self)
end

function PetsHandBookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetsHandBookViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/handbookview.prefab",
		"ui/views/common/item_pet.prefab",
		"ui/skinlib/ui_gray.mat"
	}
end

function PetsHandBookViewPresentor:buildViews()
	local views = {}
	local view = PetsHandBookView.New()

	table.insert(views, view)

	return views
end

return PetsHandBookViewPresentor
