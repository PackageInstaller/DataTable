-- chunkname: @modules/logic/versionactivity2_8/nuodika/view/NuoDiKaInfosViewContainer.lua

module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaInfosViewContainer", package.seeall)

local NuoDiKaInfosViewContainer = class("NuoDiKaInfosViewContainer", BaseViewContainer)

function NuoDiKaInfosViewContainer:buildViews()
	return {
		NuoDiKaInfosView.New()
	}
end

return NuoDiKaInfosViewContainer
