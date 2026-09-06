-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/lookfmt/PTLookOverFmtInQualifierViewPresentor.lua

module("logic.extensions.peaktournament.view.common.PTLookOverFmtInQualifierViewPresentor", package.seeall)

local PTLookOverFmtInQualifierViewPresentor = class("PTLookOverFmtInQualifierViewPresentor", ViewPresentor)

function PTLookOverFmtInQualifierViewPresentor:ctor()
	PTLookOverFmtInQualifierViewPresentor.super.ctor(self)
end

function PTLookOverFmtInQualifierViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PTLookOverFmtInQualifierViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/common/lookoverfmtbaseview.prefab"
	}
end

function PTLookOverFmtInQualifierViewPresentor:buildViews()
	return {
		PTLookOverFmtInQualifierView.New()
	}
end

return PTLookOverFmtInQualifierViewPresentor
