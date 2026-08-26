-- chunkname: @modules/logic/meilanni/view/MeilanniBossInfoViewContainer.lua

module("modules.logic.meilanni.view.MeilanniBossInfoViewContainer", package.seeall)

local MeilanniBossInfoViewContainer = class("MeilanniBossInfoViewContainer", BaseViewContainer)

function MeilanniBossInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, MeilanniBossInfoView.New())

	return views
end

return MeilanniBossInfoViewContainer
