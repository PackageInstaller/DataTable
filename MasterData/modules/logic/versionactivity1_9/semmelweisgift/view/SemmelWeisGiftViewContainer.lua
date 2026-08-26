-- chunkname: @modules/logic/versionactivity1_9/semmelweisgift/view/SemmelWeisGiftViewContainer.lua

module("modules.logic.versionactivity1_9.semmelweisgift.view.SemmelWeisGiftViewContainer", package.seeall)

local SemmelWeisGiftViewContainer = class("SemmelWeisGiftViewContainer", DecalogPresentViewContainer)

function SemmelWeisGiftViewContainer:buildViews()
	local views = {}

	table.insert(views, SemmelWeisGiftView.New())

	return views
end

return SemmelWeisGiftViewContainer
