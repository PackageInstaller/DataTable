-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/view/DumplingFeastPetViewPresentor.lua

module("logic.extensions.dumplingfeast.view.DumplingFeastPetViewPresentor", package.seeall)

local DumplingFeastPetViewPresentor = class("DumplingFeastPetViewPresentor", ViewPresentor)

function DumplingFeastPetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DumplingFeastPetViewPresentor:dependWhatResources()
	return {
		"ui/views/dumplingfeast/dumplingfeastpetview.prefab"
	}
end

function DumplingFeastPetViewPresentor:buildViews()
	return {
		DumplingFeastPetView.New()
	}
end

return DumplingFeastPetViewPresentor
