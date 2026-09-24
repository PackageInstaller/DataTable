-- chunkname: @modules/logic/fight/model/data/FightQTEDataMgr.lua

module("modules.logic.fight.model.data.FightQTEDataMgr", package.seeall)

local FightQTEDataMgr = FightDataClass("FightQTEDataMgr", FightDataMgrBase)

function FightQTEDataMgr:onConstructor()
	self.qteTotal = 0
end

function FightQTEDataMgr:updateData(fightData)
	if fightData.attacker and fightData.attacker.qteInfo then
		self:createMyQteData()
		self.myQteInfoData:updateByInfo(fightData.attacker.qteInfo)
	end

	if fightData.defender and fightData.defender.qteInfo then
		self:createEnemyQteData()
		self.enemyQteInfoData:updateByInfo(fightData.defender.qteInfo)
	end
end

function FightQTEDataMgr:createMyQteData()
	self.myQteInfoData = self.myQteInfoData or FightQTEInfoData.New()
end

function FightQTEDataMgr:createEnemyQteData()
	self.enemyQteInfoData = self.enemyQteInfoData or FightQTEInfoData.New()
end

function FightQTEDataMgr:getQteInfo(teamType)
	teamType = teamType or FightEnum.TeamType.MySide

	if teamType == FightEnum.TeamType.MySide then
		return self.myQteInfoData
	else
		return self.enemyQteInfoData
	end
end

function FightQTEDataMgr:updateQteInfo(qteInfo, teamType)
	teamType = teamType or FightEnum.TeamType.MySide

	if teamType == FightEnum.TeamType.MySide then
		if not self.myQteInfoData then
			self:createMyQteData()
		end

		self.myQteInfoData:updateByInfo(qteInfo)
	else
		if not self.enemyQteInfoData then
			self:createEnemyQteData()
		end

		self.enemyQteInfoData:updateByInfo(qteInfo)
	end
end

function FightQTEDataMgr:setQteTotal(value)
	self.qteTotal = value
end

function FightQTEDataMgr:getQteTotal()
	return self.qteTotal
end

function FightQTEDataMgr:setEnteredSecondStage()
	self.enteredSecondStage = true
end

function FightQTEDataMgr:checkEnteredSecondStage()
	return self.enteredSecondStage == true
end

function FightQTEDataMgr:clearEnteredSecondStage()
	self.enteredSecondStage = nil
end

return FightQTEDataMgr
