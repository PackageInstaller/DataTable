-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/view/OriginGodDragonClgBanPetViewPresentor.lua

module("logic.extensions.origingoddragonclg.view.OriginGodDragonClgBanPetViewPresentor", package.seeall)

local OriginGodDragonClgBanPetViewPresentor = class("OriginGodDragonClgBanPetViewPresentor", ViewPresentor)

function OriginGodDragonClgBanPetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginGodDragonClgBanPetViewPresentor:dependWhatResources()
	return {
		"ui/views/origingoddragonclg/origingoddragonclgbanpetview.prefab"
	}
end

function OriginGodDragonClgBanPetViewPresentor:buildViews()
	return {
		OriginGodDragonClgBanPetView.New()
	}
end

return OriginGodDragonClgBanPetViewPresentor
