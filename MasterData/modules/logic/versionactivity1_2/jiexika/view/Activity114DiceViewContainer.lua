-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114DiceViewContainer.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114DiceViewContainer", package.seeall)

local Activity114DiceViewContainer = class("Activity114DiceViewContainer", BaseViewContainer)

function Activity114DiceViewContainer:buildViews()
	self.view = Activity114DiceView.New()

	return {
		self.view
	}
end

return Activity114DiceViewContainer
