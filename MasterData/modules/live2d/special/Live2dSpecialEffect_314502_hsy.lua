-- chunkname: @modules/live2d/special/Live2dSpecialEffect_314502_hsy.lua

module("modules.live2d.special.Live2dSpecialEffect_314502_hsy", package.seeall)

local Live2dSpecialEffect_314502_hsy = class("Live2dSpecialEffect_314502_hsy", Live2dSpecialEffect_314501_hsy)

function Live2dSpecialEffect_314502_hsy:_onInit()
	Live2dSpecialEffect_314502_hsy.super._onInit(self)

	self._normalMapPath0 = "live2d/dynamic/314502_hsy_01_bloom_special.png"
	self._normalMapPath1 = "live2d/dynamic/314502_hsy_00_bloom_special.png"
end

return Live2dSpecialEffect_314502_hsy
