-- chunkname: @modules/logic/postprocessing/define/BlurEnum.lua

module("modules.logic.postprocessing.define.BlurEnum", package.seeall)

local BlurEnum = _M

BlurEnum.Never = 0
BlurEnum.UseRadialBlur = 1
BlurEnum.UseDistortionBlur = 2
BlurEnum.UseGaussianBlur = 3
BlurEnum.IgnoreCloseView = {
	CommandStationPaperGetRewardView = true
}

return BlurEnum
