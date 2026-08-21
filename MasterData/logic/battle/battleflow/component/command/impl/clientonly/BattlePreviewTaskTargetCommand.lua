-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattlePreviewTaskTargetCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattlePreviewTaskTargetCommand", package.seeall)

local M = class("BattlePreviewTaskTargetCommand", BattleCommandBase)
local kWalkDuration = 0.5
local kWaitDuration = 0.5

function M:create(winTags, lossTags)
	local cmd = M:createInstance()

	cmd:setWinTags(winTags)
	cmd:setLossTags(lossTags)

	return cmd
end

function M:onInit()
	self._timelineTask = TimelineTask.New()
	self._winTags = {}
	self._lossTags = {}
end

function M:onClear(interrupt)
	self._timelineTask:clear()
	BattleTableUtil.clearTable(self._winTags)
	BattleTableUtil.clearTable(self._lossTags)
end

function M:execute(battleFlow)
	local winTags = self._winTags
	local lossTags = self._lossTags
	local dungeonBattleInfoCOWrapper = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(battleFlow:getBattleLevelCode())
	local killEntityCodeList = BattleTableUtil.getTempList()

	BattleTableUtil.insertto(killEntityCodeList, dungeonBattleInfoCOWrapper:fillKillEntityCodes(winTags))

	local protectEntityCodeList = BattleTableUtil.getTempList()

	BattleTableUtil.insertto(protectEntityCodeList, dungeonBattleInfoCOWrapper:fillProtectEntityCodes(lossTags))

	local hasEscape = dungeonBattleInfoCOWrapper:hasEscape(winTags, lossTags)
	local unitMgr = battleFlow.unitMgr
	local boardMgr = battleFlow.boardMgr
	local units = unitMgr:getAllUnits()
	local duration = 0
	local sequence = DG.Tweening.DOTween.Sequence()

	for _, unit in pairs(units) do
		if BattleCampAdjustmentModel.instance:isKillCharacter(unit.property:getEntityCode()) or BattleCampAdjustmentModel.instance:isProtectCharacter(unit.property:getEntityCode()) then
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
			local position = boardMgr:getCellPosition(unionIndex)

			sequence:Append(BattleCameraUtil.doFollowPosition(position.x, position.y, position.z, kWalkDuration))
			sequence:AppendInterval(kWaitDuration)

			duration = duration + kWalkDuration + kWaitDuration
		end
	end

	if hasEscape or AirWorkShopDefSceneUtil.isInAirBattle(battleFlow.model:getBattleType()) then
		local terrainGroups = battleFlow.additionalTerrainMgr:getAllGroupUnit()

		for k, unit in pairs(terrainGroups) do
			if unit.terrainCode == BattleConst.MonsterEscapeArea or unit.terrainCode == BattleConst.SelfEscapeArea then
				local x, z = unit.rectangle:getRectanglePos()
				local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, z)
				local position = boardMgr:getCellPosition(unionIndex)

				sequence:Append(BattleCameraUtil.doFollowPosition(position.x, position.y, position.z, kWalkDuration))
				sequence:AppendInterval(kWaitDuration)

				duration = duration + kWalkDuration + kWaitDuration
			end
		end
	end

	self._timelineTask:clear()
	self._timelineTask:addTask(duration)
	self._timelineTask:addFinishListener(self._onFinishTask, self)
	self._timelineTask:start()
	BattleTableUtil.releaseTempList(killEntityCodeList)
	BattleTableUtil.releaseTempList(protectEntityCodeList)
end

function M:_onFinishTask()
	self:finish(true)
end

function M:setWinTags(winTags)
	BattleTableUtil.insertto(self._winTags, winTags)

	return self
end

function M:setLossTags(lossTags)
	BattleTableUtil.insertto(self._lossTags, lossTags)

	return self
end

function M:toString()
	return "[post event animation command]"
end

return M
