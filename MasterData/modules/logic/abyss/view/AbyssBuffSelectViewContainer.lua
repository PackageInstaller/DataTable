-- chunkname: @modules/logic/abyss/view/AbyssBuffSelectViewContainer.lua

module("modules.logic.abyss.view.AbyssBuffSelectViewContainer", package.seeall)

local AbyssBuffSelectViewContainer = class("AbyssBuffSelectViewContainer", BaseViewContainer)

function AbyssBuffSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, AbyssBuffSelectView.New())

	return views
end

return AbyssBuffSelectViewContainer
