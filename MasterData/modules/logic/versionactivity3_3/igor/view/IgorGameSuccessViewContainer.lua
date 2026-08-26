-- chunkname: @modules/logic/versionactivity3_3/igor/view/IgorGameSuccessViewContainer.lua

module("modules.logic.versionactivity3_3.igor.view.IgorGameSuccessViewContainer", package.seeall)

local IgorGameSuccessViewContainer = class("IgorGameSuccessViewContainer", BaseViewContainer)

function IgorGameSuccessViewContainer:buildViews()
	local views = {}

	table.insert(views, IgorGameSuccessView.New())

	return views
end

return IgorGameSuccessViewContainer
