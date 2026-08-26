-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepLoseCardWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepLoseCardWork", package.seeall)

local SodacheStepLoseCardWork = class("SodacheStepLoseCardWork", SodacheStepDropCardWork)

function SodacheStepLoseCardWork:isGetCard()
	return false
end

return SodacheStepLoseCardWork
