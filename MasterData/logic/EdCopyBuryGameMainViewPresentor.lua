-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternaldragon/view/bury/EdCopyBuryGameMainViewPresentor.lua

module("logic.extensions.eternaldragon.view.bury.EdCopyBuryGameMainViewPresentor", package.seeall)

local EdCopyBuryGameMainViewPresentor = class("EdCopyBuryGameMainViewPresentor", ViewPresentor)

function EdCopyBuryGameMainViewPresentor:ctor()
	EdCopyBuryGameMainViewPresentor.super.ctor(self)
end

function EdCopyBuryGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EdCopyBuryGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/burygame/copy/edcopyburygamemainview.prefab"
	}
end

function EdCopyBuryGameMainViewPresentor:buildViews()
	return {
		EdCopyBuryGameMainView.New()
	}
end

return EdCopyBuryGameMainViewPresentor
