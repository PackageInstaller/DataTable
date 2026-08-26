-- chunkname: @modules/logic/teaching/view/TeachingPopViewContainer.lua

module("modules.logic.teaching.view.TeachingPopViewContainer", package.seeall)

local TeachingPopViewContainer = class("TeachingPopViewContainer", BaseViewContainer)

function TeachingPopViewContainer:buildViews()
	local views = {}

	table.insert(views, TeachingPopView.New())

	return views
end

return TeachingPopViewContainer
