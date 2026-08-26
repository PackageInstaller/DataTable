-- chunkname: @modules/logic/versionactivity2_8/nuodika/view/NuoDiKaGameUnitDetailViewContainer.lua

module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaGameUnitDetailViewContainer", package.seeall)

local NuoDiKaGameUnitDetailViewContainer = class("NuoDiKaGameUnitDetailViewContainer", BaseViewContainer)

function NuoDiKaGameUnitDetailViewContainer:buildViews()
	return {
		NuoDiKaGameUnitDetailView.New()
	}
end

return NuoDiKaGameUnitDetailViewContainer
