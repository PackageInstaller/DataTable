-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/triggers/WorkTriggerResourceLoaded.lua

module("logic.battle.battleflow.defaultwork.triggers.WorkTriggerResourceLoaded", package.seeall)

local WorkTriggerResourceLoaded = class("WorkTriggerResourceLoaded", WorkBase)

function WorkTriggerResourceLoaded:onEnter(context)
	context:internal_NotifyComponent(BattleFunctionName.onResourceLoaded)
	self:onDone(WorkResult.Succeed)
end

function WorkTriggerResourceLoaded:onExit(isInterrupt)
	return
end

return WorkTriggerResourceLoaded
