-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/PetArtifactAwakenViewPresentor.lua

module("logic.extensions.recommendfmt.view.PetArtifactAwakenViewPresentor", package.seeall)

local PetArtifactAwakenViewPresentor = class("PetArtifactAwakenViewPresentor", ViewPresentor)

function PetArtifactAwakenViewPresentor:ctor()
	PetArtifactAwakenViewPresentor.super.ctor(self)
end

function PetArtifactAwakenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetArtifactAwakenViewPresentor:dependWhatResources()
	return {
		"ui/views/recommendfmt/petartifactawakenview.prefab"
	}
end

function PetArtifactAwakenViewPresentor:buildViews()
	return {
		PetArtifactAwakenView.New()
	}
end

return PetArtifactAwakenViewPresentor
