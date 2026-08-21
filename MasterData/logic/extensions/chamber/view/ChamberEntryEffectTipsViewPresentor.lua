-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/view/ChamberEntryEffectTipsViewPresentor.lua

module("logic.extensions.chamber.view.ChamberEntryEffectTipsViewPresentor", package.seeall)

local M = class("ChamberEntryEffectTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Secret_secret_time_impression_disc_effect_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ChamberEntryEffectTipsView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
