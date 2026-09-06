-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegoddragonclg/view/DivineGodDragonClgMainViewPresentor.lua

module("logic.extensions.divinegoddragonclg.view.DivineGodDragonClgMainViewPresentor", package.seeall)

local DivineGodDragonClgMainViewPresentor = class("DivineGodDragonClgMainViewPresentor", ViewPresentor)

function DivineGodDragonClgMainViewPresentor:ctor()
	DivineGodDragonClgMainViewPresentor.super.ctor(self)
end

function DivineGodDragonClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineGodDragonClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinegoddragonclg/divinegoddragonclgmainview.prefab"
	}
end

function DivineGodDragonClgMainViewPresentor:buildViews()
	return {
		DivineGodDragonClgMainView.New()
	}
end

return DivineGodDragonClgMainViewPresentor
