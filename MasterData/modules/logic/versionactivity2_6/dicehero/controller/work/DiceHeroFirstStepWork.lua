-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/work/DiceHeroFirstStepWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.work.DiceHeroFirstStepWork", package.seeall)

local DiceHeroFirstStepWork = class("DiceHeroFirstStepWork", BaseWork)

function DiceHeroFirstStepWork:onStart(context)
	self:onDone(true)
end

return DiceHeroFirstStepWork
