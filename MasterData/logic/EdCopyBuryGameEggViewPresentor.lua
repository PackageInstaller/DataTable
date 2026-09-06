-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternaldragon/view/bury/EdCopyBuryGameEggViewPresentor.lua

module("logic.extensions.eternaldragon.view.bury.EdCopyBuryGameEggViewPresentor", package.seeall)

local EdCopyBuryGameEggViewPresentor = class("EdCopyBuryGameEggViewPresentor", ViewPresentor)

function EdCopyBuryGameEggViewPresentor:ctor()
	EdCopyBuryGameEggViewPresentor.super.ctor(self)
end

function EdCopyBuryGameEggViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EdCopyBuryGameEggViewPresentor:dependWhatResources()
	return {
		"ui/views/burygame/burygameeggview.prefab"
	}
end

function EdCopyBuryGameEggViewPresentor:buildViews()
	return {
		EdCopyBuryGameEggView.New()
	}
end

return EdCopyBuryGameEggViewPresentor
