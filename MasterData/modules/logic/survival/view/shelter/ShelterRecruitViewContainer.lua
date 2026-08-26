-- chunkname: @modules/logic/survival/view/shelter/ShelterRecruitViewContainer.lua

module("modules.logic.survival.view.shelter.ShelterRecruitViewContainer", package.seeall)

local ShelterRecruitViewContainer = class("ShelterRecruitViewContainer", BaseViewContainer)

function ShelterRecruitViewContainer:buildViews()
	local views = {}

	table.insert(views, ShelterRecruitView.New())
	table.insert(views, ShelterCurrencyView.New({
		SurvivalEnum.CurrencyType.Build
	}, "Panel/#go_topright"))

	return views
end

return ShelterRecruitViewContainer
