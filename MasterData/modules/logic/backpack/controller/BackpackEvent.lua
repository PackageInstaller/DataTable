-- chunkname: @modules/logic/backpack/controller/BackpackEvent.lua

module("modules.logic.backpack.controller.BackpackEvent", package.seeall)

local BackpackEvent = {}

BackpackEvent.SelectCategory = GameUtil.getUniqueTb()
BackpackEvent.UpdateItemList = GameUtil.getUniqueTb()
BackpackEvent.UsePowerPotionFinish = GameUtil.getUniqueTb()
BackpackEvent.SelectCategoryById = 4
BackpackEvent.UsePowerPotionListFinish = GameUtil.getUniqueTb()
BackpackEvent.BeforeUsePowerPotionList = GameUtil.getUniqueTb()
BackpackEvent.UseInsightItemFinished = GameUtil.getUniqueTb()
BackpackEvent.onUseItemFinished = GameUtil.getUniqueTb()

return BackpackEvent
