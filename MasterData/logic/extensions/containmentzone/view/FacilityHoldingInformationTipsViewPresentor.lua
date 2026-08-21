-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingInformationTipsViewPresentor.lua

module("logic.extensions.containmentzone.view.FacilityHoldingInformationTipsViewPresentor", package.seeall)

local M = class("FacilityHoldingInformationTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Room_facility_holding_facility_holding_information_tips,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Room)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FacilityHoldingInformationTipsView.New())

	return views
end

return M
