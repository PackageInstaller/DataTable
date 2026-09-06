-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkBattlereSultViewPresentor.lua

module("logic.extensions.pk.view.PkBattlereSultViewPresentor", package.seeall)

local PkBattlereSultViewPresentor = class("PkBattlereSultViewPresentor", ViewPresentor)

function PkBattlereSultViewPresentor:ctor()
	PkBattlereSultViewPresentor.super.ctor(self)
end

function PkBattlereSultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PkBattlereSultViewPresentor:dependWhatResources()
	return {
		"ui/views/pk/pkbattleresultview.prefab"
	}
end

function PkBattlereSultViewPresentor:buildViews()
	return {
		PkBattlereSultView.New()
	}
end

return PkBattlereSultViewPresentor
