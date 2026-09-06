-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengenomalViewPresentor.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengenomalViewPresentor", package.seeall)

local DivinefeiyinchallengenomalViewPresentor = class("DivinefeiyinchallengenomalViewPresentor", ViewPresentor)

function DivinefeiyinchallengenomalViewPresentor:ctor()
	DivinefeiyinchallengenomalViewPresentor.super.ctor(self)
end

function DivinefeiyinchallengenomalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinefeiyinchallengenomalViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefeiyin/divinefeiyinchallengenomalview.prefab"
	}
end

function DivinefeiyinchallengenomalViewPresentor:buildViews()
	return {
		DivinefeiyinchallengenomalView.New()
	}
end

return DivinefeiyinchallengenomalViewPresentor
