-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepUseCardWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepUseCardWork", package.seeall)

local SodacheStepUseCardWork = class("SodacheStepUseCardWork", SodacheStepBaseWork)

function SodacheStepUseCardWork:onWorkStart(context)
	local cardCo = lua_sodache_card.configDict[self._stepMo.paramInt[1]]

	if cardCo then
		SodacheUtil.showToast(cardCo.useDesc)
	end

	self:onDone(true)
end

return SodacheStepUseCardWork
