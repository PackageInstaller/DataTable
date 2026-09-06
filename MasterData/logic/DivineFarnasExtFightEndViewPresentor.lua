-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/view/DivineFarnasExtFightEndViewPresentor.lua

module("logic.extensions.divinefarnas.view.DivineFarnasExtFightEndViewPresentor", package.seeall)

local DivineFarnasExtFightEndViewPresentor = class("DivineFarnasExtFightEndViewPresentor", ViewPresentor)

function DivineFarnasExtFightEndViewPresentor:ctor()
	DivineFarnasExtFightEndViewPresentor.super.ctor(self)
end

function DivineFarnasExtFightEndViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineFarnasExtFightEndViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefarnas/divinefarnasextfightendview.prefab"
	}
end

function DivineFarnasExtFightEndViewPresentor:buildViews()
	return {
		DivineFarnasExtFightEndView.New()
	}
end

return DivineFarnasExtFightEndViewPresentor
