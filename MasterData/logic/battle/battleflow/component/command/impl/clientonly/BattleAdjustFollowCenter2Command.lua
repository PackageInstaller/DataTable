-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleAdjustFollowCenter2Command.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleAdjustFollowCenter2Command", package.seeall)

local BattleAdjustFollowCenter2Command = class("BattleAdjustFollowCenter2Command", BattleTimingCommandBase)

function BattleAdjustFollowCenter2Command:create(fromUnionIndex, toUnionIndex, toUnit)
	local cmd = BattleAdjustFollowCenter2Command:createInstance()

	cmd:setFromUnionIndex(fromUnionIndex)
	cmd:setToUnionIndex(toUnionIndex, toUnit)

	return cmd
end

function BattleAdjustFollowCenter2Command:onInit()
	self._fromUnionIndex = false
	self._toUnionIndex = false
	self._toUnit = false
	self._duartion = false
end

function BattleAdjustFollowCenter2Command:onClear()
	self._fromUnionIndex = false
	self._toUnionIndex = false
	self._toUnit = false
	self._duartion = false
end

function BattleAdjustFollowCenter2Command:execute(battleFlow, runningContext)
	runningContext = runningContext or battleFlow.cmdExecuter:getContext()

	if runningContext:getParam(BattleCmdRunningContext.Param_CameraLocked) then
		self:finish(true)

		return
	end

	local boardMgr = battleFlow.boardMgr
	local x1, y1, z1 = boardMgr:getCellPosition(self._fromUnionIndex):Get()
	local x2, y2, z2 = boardMgr:getCellPosition(self._toUnionIndex):Get()
	local weightA = 4
	local weightB = 4

	if self._toUnit then
		weightB = self._toUnit.property:getMonsterType() == BattleEnum.MonsterType.BOSS and self._toUnit.transform:isComposite() and 6 or 4
		x2, y2, z2 = BattleUnitUtil.getBattleFocusPos(self._toUnit):Get()
	end

	local tox, toy, toz = (x1 * weightA + x2 * weightB) / (weightA + weightB), y1, (z1 * weightA + z2 * weightB) / (weightA + weightB)
	local cameraFocusDuration = self._duartion or BattleConst.judgeCameraFocusTime(tox, toy, toz)

	BattleCameraUtil.doFollowPosition(tox, toy, toz, cameraFocusDuration)
	self:startTimer(cameraFocusDuration)
end

function BattleAdjustFollowCenter2Command:toString()
	return string.format("[adjust follow center2 command fromUnionIndex = %s,toUnionIndex = %s]", self._fromUnionIndex, self._toUnionIndex)
end

function BattleAdjustFollowCenter2Command:setFromUnionIndex(fromUnionIndex)
	self._fromUnionIndex = fromUnionIndex

	return self
end

function BattleAdjustFollowCenter2Command:setToUnionIndex(toUnionIndex, toUnit)
	self._toUnionIndex = toUnionIndex
	self._toUnit = toUnit

	return self
end

function BattleAdjustFollowCenter2Command:setDuration(duration)
	self._duration = duration
end

return BattleAdjustFollowCenter2Command
