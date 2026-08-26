-- chunkname: @modules/logic/versionactivity2_8/nuodika/view/NuoDiKaGameResultViewContainer.lua

module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaGameResultViewContainer", package.seeall)

local NuoDiKaGameResultViewContainer = class("NuoDiKaGameResultViewContainer", BaseViewContainer)

function NuoDiKaGameResultViewContainer:buildViews()
	local views = {}

	table.insert(views, NuoDiKaGameResultView.New())

	return views
end

return NuoDiKaGameResultViewContainer
