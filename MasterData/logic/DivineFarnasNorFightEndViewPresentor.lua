-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/view/DivineFarnasNorFightEndViewPresentor.lua

module("logic.extensions.divinefarnas.view.DivineFarnasNorFightEndViewPresentor", package.seeall)

local DivineFarnasNorFightEndViewPresentor = class("DivineFarnasNorFightEndViewPresentor", ViewPresentor)

function DivineFarnasNorFightEndViewPresentor:ctor()
	DivineFarnasNorFightEndViewPresentor.super.ctor(self)
end

function DivineFarnasNorFightEndViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineFarnasNorFightEndViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefarnas/divinefarnasnorfightendview.prefab"
	}
end

function DivineFarnasNorFightEndViewPresentor:buildViews()
	return {
		DivineFarnasNorFightEndView.New()
	}
end

return DivineFarnasNorFightEndViewPresentor
