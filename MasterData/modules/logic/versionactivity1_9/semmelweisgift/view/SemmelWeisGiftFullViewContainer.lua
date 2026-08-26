-- chunkname: @modules/logic/versionactivity1_9/semmelweisgift/view/SemmelWeisGiftFullViewContainer.lua

module("modules.logic.versionactivity1_9.semmelweisgift.view.SemmelWeisGiftFullViewContainer", package.seeall)

local SemmelWeisGiftFullViewContainer = class("SemmelWeisGiftFullViewContainer", BaseViewContainer)

function SemmelWeisGiftFullViewContainer:buildViews()
	local views = {}

	table.insert(views, SemmelWeisGiftFullView.New())

	return views
end

return SemmelWeisGiftFullViewContainer
