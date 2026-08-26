-- chunkname: @modules/logic/versionactivity1_5/act142/view/game/Activity142ResultViewContainer.lua

module("modules.logic.versionactivity1_5.act142.view.game.Activity142ResultViewContainer", package.seeall)

local Activity142ResultViewContainer = class("Activity142ResultViewContainer", BaseViewContainer)

function Activity142ResultViewContainer:buildViews()
	return {
		Activity142ResultView.New()
	}
end

return Activity142ResultViewContainer
