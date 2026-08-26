-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/Anniversary3SignRoleTalkViewContainer.lua

module("modules.logic.versionactivity3_7.anniversary3.view.Anniversary3SignRoleTalkViewContainer", package.seeall)

local Anniversary3SignRoleTalkViewContainer = class("Anniversary3SignRoleTalkViewContainer", BaseViewContainer)

function Anniversary3SignRoleTalkViewContainer:buildViews()
	local views = {}

	table.insert(views, Anniversary3SignRoleTalkView.New())

	return views
end

return Anniversary3SignRoleTalkViewContainer
