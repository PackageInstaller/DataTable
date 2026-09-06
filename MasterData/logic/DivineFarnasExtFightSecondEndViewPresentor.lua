-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/view/DivineFarnasExtFightSecondEndViewPresentor.lua

module("logic.extensions.divinefarnas.view.DivineFarnasExtFightSecondEndViewPresentor", package.seeall)

local DivineFarnasExtFightSecondEndViewPresentor = class("DivineFarnasExtFightSecondEndViewPresentor", ViewPresentor)

function DivineFarnasExtFightSecondEndViewPresentor:ctor()
	DivineFarnasExtFightSecondEndViewPresentor.super.ctor(self)
end

function DivineFarnasExtFightSecondEndViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineFarnasExtFightSecondEndViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefarnas/divinefarnasextfightsecondendview.prefab"
	}
end

function DivineFarnasExtFightSecondEndViewPresentor:buildViews()
	return {
		DivineFarnasExtFightSecondEndView.New()
	}
end

return DivineFarnasExtFightSecondEndViewPresentor
