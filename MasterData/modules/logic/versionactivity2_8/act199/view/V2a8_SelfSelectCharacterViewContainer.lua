-- chunkname: @modules/logic/versionactivity2_8/act199/view/V2a8_SelfSelectCharacterViewContainer.lua

module("modules.logic.versionactivity2_8.act199.view.V2a8_SelfSelectCharacterViewContainer", package.seeall)

local V2a8_SelfSelectCharacterViewContainer = class("V2a8_SelfSelectCharacterViewContainer", BaseViewContainer)

function V2a8_SelfSelectCharacterViewContainer:buildViews()
	local views = {}

	table.insert(views, V2a8_SelfSelectCharacterView.New())

	return views
end

function V2a8_SelfSelectCharacterViewContainer:buildTabViews(tabContainerId)
	return
end

return V2a8_SelfSelectCharacterViewContainer
