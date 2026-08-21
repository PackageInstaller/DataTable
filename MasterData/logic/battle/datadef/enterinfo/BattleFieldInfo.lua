-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/enterinfo/BattleFieldInfo.lua

module("logic.battle.datadef.enterinfo.BattleFieldInfo", package.seeall)

local BattleFieldInfo = class("BattleFieldInfo", AbstractGlobalReusable)

function BattleFieldInfo:ctor()
	self.battleId = 0
	self.battleType = 0
	self.mode = 0
	self.round = 0
	self.leftUndoCount = 0
	self.pvpType = 0
	self.sceneCode = 0
	self.operateCampId = 0
	self.stepCampId = 0
	self.npcCampId = 0
	self.campInfos = {}
	self.entityInfos = {}
	self.cellInfos = {}
	self.initCommands = {}
	self.initUndoes = {}
	self.heroesInBattle = {}
	self.aiMode = BattleExtension_pb.AiMode.NONE
	self.multiplied = 1
	self.gamePlay = BattleEnum.GamePlayType.NORMAL
end

function BattleFieldInfo:reset()
	BattleTableUtil.clearCommands(self.initCommands)
	BattleTableUtil.clearReusableTable(self.entityInfos)
	BattleTableUtil.clearReusableTable(self.campInfos)
	BattleTableUtil.clearReusableTable(self.cellInfos)
	BattleTableUtil.clearReusableTable(self.initUndoes)
	BattleTableUtil.clearTable(self.heroesInBattle)
end

function BattleFieldInfo:destroy()
	self:reset()
end

function BattleFieldInfo:copyFromForUndo(srcBattleFieldInfo)
	self.round = srcBattleFieldInfo.round
	self.leftUndoCount = srcBattleFieldInfo.leftUndoCount
	self.stepCampId = srcBattleFieldInfo.stepCampId

	BattleTableUtil.clearCommands(self.initCommands)
	BattleTableUtil.passList(self.initCommands, srcBattleFieldInfo.initCommands)
	BattleTableUtil.clearReusableTable(self.entityInfos)
	BattleTableUtil.passList(self.entityInfos, srcBattleFieldInfo.entityInfos)
	BattleTableUtil.clearReusableTable(self.cellInfos)
	BattleTableUtil.passList(self.cellInfos, srcBattleFieldInfo.cellInfos)
	BattleTableUtil.clearReusableTable(self.initUndoes)
	BattleTableUtil.passList(self.initUndoes, srcBattleFieldInfo.initUndoes)
end

function BattleFieldInfo:addEntityInfo(entityInfo)
	table.insert(self.entityInfos, entityInfo)
end

function BattleFieldInfo:addCellInfo(cellInfo)
	table.insert(self.cellInfos, cellInfo)
end

function BattleFieldInfo:addInitCommand(cmd)
	table.insert(self.initCommands, cmd)
end

function BattleFieldInfo:addInitUndoMO(undoMO)
	table.insert(self.initUndoes, undoMO)
end

function BattleFieldInfo:addHeroInBattle(heroId)
	table.insert(self.heroesInBattle, heroId)
end

function BattleFieldInfo:removeEntityInfo(entityId)
	for index, entityInfo in pairs(self.entityInfos) do
		if entityInfo.entityId == entityId then
			entityInfo:returnSelf()
			table.remove(self.entityInfos, index)

			return true
		end
	end

	return false
end

function BattleFieldInfo:findEntityInfo(entityId)
	for _, entityInfo in pairs(self.entityInfos) do
		if entityInfo.entityId == entityId then
			return entityInfo
		end
	end
end

function BattleFieldInfo:addCampInfo(campInfo)
	table.insert(self.campInfos, campInfo)
end

function BattleFieldInfo:getCampInfo(campId)
	for _, campInfo in ipairs(self.campInfos) do
		if campInfo.campId == campId then
			return campInfo
		end
	end
end

function BattleFieldInfo:getCampInfoByUserId(userId)
	for _, campInfo in ipairs(self.campInfos) do
		if campInfo.userId == userId then
			return campInfo
		end
	end
end

return BattleFieldInfo
