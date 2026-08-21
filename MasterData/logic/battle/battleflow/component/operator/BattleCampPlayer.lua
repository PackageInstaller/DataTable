-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/operator/BattleCampPlayer.lua

module("logic.battle.battleflow.component.operator.BattleCampPlayer", package.seeall)

local BattleCampPlayer = class("BattleCampPlayer", IBattleFlowComp)

function BattleCampPlayer:onInit()
	self._operateCampId = false
end

function BattleCampPlayer:onStart()
	self._operateCampId = false
end

function BattleCampPlayer:onClear()
	self._operateCampId = false
end

function BattleCampPlayer:beginOperateCamp(campId)
	self._operateCampId = campId

	BattleMainViewFacade.instance:setForNotOperatable()
end

function BattleCampPlayer:endOperateCamp()
	self._operateCampId = false
end

function BattleCampPlayer:tryOperateNextUnit()
	return
end

return BattleCampPlayer
