-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingnuoya/view/KingNuoyaBuffViewPresentor.lua

module("logic.extensions.kingnuoya.view.KingNuoyaBuffViewPresentor", package.seeall)

local KingNuoyaBuffViewPresentor = class("KingNuoyaBuffViewPresentor", ViewPresentor)

function KingNuoyaBuffViewPresentor:ctor()
	KingNuoyaBuffViewPresentor.super.ctor(self)
end

function KingNuoyaBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function KingNuoyaBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattlebuffview.prefab"
	}
end

function KingNuoyaBuffViewPresentor:buildViews()
	return {
		KingNuoyaBuffView.New()
	}
end

return KingNuoyaBuffViewPresentor
