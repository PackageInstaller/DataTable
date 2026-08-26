-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaGameResultViewContainer.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaGameResultViewContainer", package.seeall)

local LoperaGameResultViewContainer = class("LoperaGameResultViewContainer", BaseViewContainer)

function LoperaGameResultViewContainer:buildViews()
	local views = {}

	self._resultView = LoperaGameResultView.New()

	table.insert(views, self._resultView)

	return views
end

return LoperaGameResultViewContainer
