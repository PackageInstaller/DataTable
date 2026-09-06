-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/evolve/view/PetEvolveViewPresentor.lua

module("logic.extensions.evolve.view.PetEvolveViewPresentor", package.seeall)

local PetEvolveViewPresentor = class("PetEvolveViewPresentor", ViewWithGuidePresentor)

function PetEvolveViewPresentor:ctor()
	PetEvolveViewPresentor.super.ctor(self)
end

function PetEvolveViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetEvolveViewPresentor:dependWhatResources()
	return {
		"ui/views/evolve/petevolveview.prefab"
	}
end

function PetEvolveViewPresentor:buildViews()
	local views = {}
	local view = PetEvolveView.New()

	table.insert(views, view)

	return views
end

return PetEvolveViewPresentor
