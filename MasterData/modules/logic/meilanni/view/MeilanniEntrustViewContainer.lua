-- chunkname: @modules/logic/meilanni/view/MeilanniEntrustViewContainer.lua

module("modules.logic.meilanni.view.MeilanniEntrustViewContainer", package.seeall)

local MeilanniEntrustViewContainer = class("MeilanniEntrustViewContainer", BaseViewContainer)

function MeilanniEntrustViewContainer:buildViews()
	local views = {}

	table.insert(views, MeilanniEntrustView.New())

	return views
end

return MeilanniEntrustViewContainer
