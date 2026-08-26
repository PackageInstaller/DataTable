-- chunkname: @modules/logic/gm/view/GMFightStandardEpisodeForTestServerViewContainer.lua

module("modules.logic.gm.view.GMFightStandardEpisodeForTestServerViewContainer", package.seeall)

local GMFightStandardEpisodeForTestServerViewContainer = class("GMFightStandardEpisodeForTestServerViewContainer", BaseViewContainer)

function GMFightStandardEpisodeForTestServerViewContainer:buildViews()
	local views = {}

	table.insert(views, GMFightStandardEpisodeForTestServerView.New())

	return views
end

function GMFightStandardEpisodeForTestServerViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return GMFightStandardEpisodeForTestServerViewContainer
