-- chunkname: @modules/logic/versionactivity3_3/igor/view/IgorGameFailViewContainer.lua

module("modules.logic.versionactivity3_3.igor.view.IgorGameFailViewContainer", package.seeall)

local IgorGameFailViewContainer = class("IgorGameFailViewContainer", BaseViewContainer)

function IgorGameFailViewContainer:buildViews()
	local views = {}

	table.insert(views, IgorGameFailView.New())

	return views
end

return IgorGameFailViewContainer
