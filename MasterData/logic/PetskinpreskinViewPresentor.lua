-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskinpreview/view/PetskinpreskinViewPresentor.lua

module("logic.extensions.petskinpreview.view.PetskinpreskinViewPresentor", package.seeall)

local PetskinpreskinViewPresentor = class("PetskinpreskinViewPresentor", ViewPresentor)

function PetskinpreskinViewPresentor:ctor()
	PetskinpreskinViewPresentor.super.ctor(self)
end

function PetskinpreskinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetskinpreskinViewPresentor:dependWhatResources()
	return {
		"ui/views/petskinpreview/petskinpreskinview.prefab"
	}
end

function PetskinpreskinViewPresentor:buildViews()
	return {
		PetskinpreskinView.New()
	}
end

function PetskinpreskinViewPresentor:_getSpineResUrl(raceId, isLihui)
	local cfg = CharacterConfig.instance:getModelCo(checknumber(raceId))

	if isLihui == nil then
		isLihui = true
	end

	if cfg then
		if isLihui and not string.nilorempty(cfg.bustName) then
			return GameUrl.getLihuiSpineUrl(cfg.bustName), true
		else
			return GameUrl.getSpineUrl(cfg.resName), false
		end
	end
end

return PetskinpreskinViewPresentor
