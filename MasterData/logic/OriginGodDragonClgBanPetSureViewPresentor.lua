-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/view/OriginGodDragonClgBanPetSureViewPresentor.lua

module("logic.extensions.origingoddragonclg.view.OriginGodDragonClgBanPetSureViewPresentor", package.seeall)

local OriginGodDragonClgBanPetSureViewPresentor = class("OriginGodDragonClgBanPetSureViewPresentor", ViewPresentor)

function OriginGodDragonClgBanPetSureViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginGodDragonClgBanPetSureViewPresentor:dependWhatResources()
	return {
		"ui/views/origingoddragonclg/origingoddragonclgbanpetsureview.prefab"
	}
end

function OriginGodDragonClgBanPetSureViewPresentor:buildViews()
	return {
		OriginGodDragonClgBanPetSureView.New()
	}
end

return OriginGodDragonClgBanPetSureViewPresentor
