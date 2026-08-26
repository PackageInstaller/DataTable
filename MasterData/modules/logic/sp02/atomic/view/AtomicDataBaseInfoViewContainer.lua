-- chunkname: @modules/logic/sp02/atomic/view/AtomicDataBaseInfoViewContainer.lua

module("modules.logic.sp02.atomic.view.AtomicDataBaseInfoViewContainer", package.seeall)

local AtomicDataBaseInfoViewContainer = class("AtomicDataBaseInfoViewContainer", BaseViewContainer)

function AtomicDataBaseInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicDataBaseInfoView.New())

	return views
end

return AtomicDataBaseInfoViewContainer
