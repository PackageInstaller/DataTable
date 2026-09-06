-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/DarkDragonKnifeGameCopyViewPresentor.lua

module("logic.extensions.darkdragonknife.view.DarkDragonKnifeGameCopyViewPresentor", package.seeall)

local DarkDragonKnifeGameCopyViewPresentor = class("DarkDragonKnifeGameCopyViewPresentor", ViewPresentor)

function DarkDragonKnifeGameCopyViewPresentor:ctor()
	DarkDragonKnifeGameCopyViewPresentor.super.ctor(self)
end

function DarkDragonKnifeGameCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DarkDragonKnifeGameCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/darkdragonknife/darkdragonknifegamecopyview.prefab"
	}
end

function DarkDragonKnifeGameCopyViewPresentor:buildViews()
	return {
		DarkDragonKnifeGameCopyView.New()
	}
end

return DarkDragonKnifeGameCopyViewPresentor
