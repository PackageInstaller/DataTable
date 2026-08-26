-- chunkname: @modules/logic/rouge/dlc/101/view/RougeFactionLockedTipsContainer.lua

module("modules.logic.rouge.dlc.101.view.RougeFactionLockedTipsContainer", package.seeall)

local RougeFactionLockedTipsContainer = class("RougeFactionLockedTipsContainer", BaseViewContainer)

function RougeFactionLockedTipsContainer:buildViews()
	local views = {}

	table.insert(views, RougeFactionLockedTips.New())

	return views
end

return RougeFactionLockedTipsContainer
