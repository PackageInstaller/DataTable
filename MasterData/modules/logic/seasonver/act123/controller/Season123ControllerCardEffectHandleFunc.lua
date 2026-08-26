-- chunkname: @modules/logic/seasonver/act123/controller/Season123ControllerCardEffectHandleFunc.lua

module("modules.logic.seasonver.act123.controller.Season123ControllerCardEffectHandleFunc", package.seeall)

local Season123Controller = Season123Controller

function Season123Controller.activeHandleFuncController()
	return
end

function Season123Controller:ReduceRoundCount(effectParams, param)
	local canReduce = GameUtil.getTabLen(effectParams) > 0
	local seasonMO = Season123Model.instance:getActInfo(param.actId)
	local stageMO = seasonMO:getStageMO(param.stage)

	stageMO:updateReduceEpisodeRoundState(param.layer, canReduce)
end

Season123Controller.SpecialEffctHandleFunc = {
	[Activity123Enum.EquipCardEffect.ReduceRoundCount] = Season123Controller.ReduceRoundCount
}

return Season123Controller
