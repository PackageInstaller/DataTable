-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114DiceViewWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114DiceViewWork", package.seeall)

local Activity114DiceViewWork = class("Activity114DiceViewWork", Activity114OpenViewWork)

function Activity114DiceViewWork:onStart(context)
	if self.context.diceResult then
		self._viewName = ViewName.Activity114DiceView

		Activity114DiceViewWork.super.onStart(self, context)
	else
		self:onDone(true)
	end
end

return Activity114DiceViewWork
