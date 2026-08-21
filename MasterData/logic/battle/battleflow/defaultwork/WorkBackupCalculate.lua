-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkBackupCalculate.lua

module("logic.battle.battleflow.defaultwork.WorkBackupCalculate", package.seeall)

local WorkBackupCalculate = class("WorkBackupCalculate", WorkBase)

function WorkBackupCalculate:onEnter(context)
	BattleCampAdjustmentModel.instance:recordAllHeroesByBackInfo()

	local model = context.model
	local operateCampId = model:getOperateCampId()
	local battleFieldInfo = model:getBattleFieldInfo()
	local allHeroIdList = BattleCalculateModel.instance:getAllHeroIdList()

	for _, entityInfo in pairs(battleFieldInfo.entityInfos) do
		if operateCampId == entityInfo.campId then
			table.insert(allHeroIdList, entityInfo.entityCode)
		end
	end

	local calculateHeroIdList = BattleCalculateModel.instance:getCalculateHeroIdList()

	BattleTableUtil.insertto(calculateHeroIdList, allHeroIdList)
	context:backupCalculateModel()
	BattleCalculateModel.instance:backupCalculateModel()
	self:onDone(WorkResult.Succeed)
end

function WorkBackupCalculate:onExit(isInterrupt)
	return
end

return WorkBackupCalculate
