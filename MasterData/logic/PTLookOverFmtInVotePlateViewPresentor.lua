-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/lookfmt/PTLookOverFmtInVotePlateViewPresentor.lua

module("logic.extensions.peaktournament.view.common.PTLookOverFmtInVotePlateViewPresentor", package.seeall)

local PTLookOverFmtInVotePlateViewPresentor = class("PTLookOverFmtInVotePlateViewPresentor", ViewPresentor)

function PTLookOverFmtInVotePlateViewPresentor:ctor()
	PTLookOverFmtInVotePlateViewPresentor.super.ctor(self)
end

function PTLookOverFmtInVotePlateViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PTLookOverFmtInVotePlateViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/common/lookoverfmtbaseview.prefab"
	}
end

function PTLookOverFmtInVotePlateViewPresentor:buildViews()
	return {
		PTLookOverFmtInVotePlateView.New()
	}
end

return PTLookOverFmtInVotePlateViewPresentor
