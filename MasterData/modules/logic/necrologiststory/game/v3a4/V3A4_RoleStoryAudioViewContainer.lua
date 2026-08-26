-- chunkname: @modules/logic/necrologiststory/game/v3a4/V3A4_RoleStoryAudioViewContainer.lua

module("modules.logic.necrologiststory.game.v3a4.V3A4_RoleStoryAudioViewContainer", package.seeall)

local V3A4_RoleStoryAudioViewContainer = class("V3A4_RoleStoryAudioViewContainer", BaseViewContainer)

function V3A4_RoleStoryAudioViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A4_RoleStoryAudioView.New())

	return views
end

return V3A4_RoleStoryAudioViewContainer
