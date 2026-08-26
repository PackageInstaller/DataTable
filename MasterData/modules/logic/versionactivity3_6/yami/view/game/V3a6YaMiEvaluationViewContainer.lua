-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/V3a6YaMiEvaluationViewContainer.lua

module("modules.logic.versionactivity3_6.yami.view.game.V3a6YaMiEvaluationViewContainer", package.seeall)

local V3a6YaMiEvaluationViewContainer = class("V3a6YaMiEvaluationViewContainer", BaseViewContainer)

function V3a6YaMiEvaluationViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a6YaMiEvaluationView.New())

	return views
end

return V3a6YaMiEvaluationViewContainer
