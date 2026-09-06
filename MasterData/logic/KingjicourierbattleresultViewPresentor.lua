-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/view/KingjicourierbattleresultViewPresentor.lua

module("logic.extensions.kingjichallenge.view.KingjicourierbattleresultViewPresentor", package.seeall)

local KingjicourierbattleresultViewPresentor = class("KingjicourierbattleresultViewPresentor", ViewPresentor)

function KingjicourierbattleresultViewPresentor:ctor()
	KingjicourierbattleresultViewPresentor.super.ctor(self)
end

function KingjicourierbattleresultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function KingjicourierbattleresultViewPresentor:dependWhatResources()
	return {
		"ui/views/kingjichallenge/kingjicourierbattleresultview.prefab"
	}
end

function KingjicourierbattleresultViewPresentor:buildViews()
	return {
		KingjicourierbattleresultView.New()
	}
end

return KingjicourierbattleresultViewPresentor
