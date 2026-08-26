-- chunkname: @modules/logic/fight/model/data/FightTempDataMgr.lua

module("modules.logic.fight.model.data.FightTempDataMgr", package.seeall)

local FightTempDataMgr = FightDataClass("FightTempDataMgr", FightDataMgrBase)

function FightTempDataMgr:onConstructor()
	self.hasNextWave = false
	self.combineCount = 0
	self.aiJiAoQteCount = 0
	self.aiJiAoQteEndlessLoop = 0
	self.aiJiAoFakeHpOffset = {}
	self.aiJiAoSelectTargetView = nil
	self.playAiJiAoPreTimeline = nil
	self.buffDurationDic = {}
	self.douQuQuDice = nil
	self.canNotSelectEntityIdDic = {}
	self.battleSelectCount = 0
	self.monsterPosList = nil
	self.lockMyturnCamera = false
	self.myStanceId = nil
	self.is3_7BossQteing = false
	self.isSkipBattle = false
	self.isNdkQteing = false
	self.is3_7BossQtePre = false
end

function FightTempDataMgr:onCancelOperation()
	self.combineCount = 0

	if self.unnamedDataMgr then
		self.unnamedDataMgr:onCancelOperation()
	end
end

function FightTempDataMgr:onStageChanged()
	self.combineCount = 0

	if self.unnamedDataMgr then
		self.unnamedDataMgr:onStageChanged()
	end
end

function FightTempDataMgr:getUnnamedDataMgr()
	if not self.unnamedDataMgr then
		self.unnamedDataMgr = FightUnnamedDataMgr.New()

		self.unnamedDataMgr:init()
	end

	return self.unnamedDataMgr
end

function FightTempDataMgr:getHeDuoNieDataMgr()
	if not self.heDuoNieDataMgr then
		self.heDuoNieDataMgr = FightHeDuoNieDataMgr.New()

		self.heDuoNieDataMgr:init()
	end

	return self.heDuoNieDataMgr
end

function FightTempDataMgr:setAutoSelectedCrystal(selected)
	self.autoSelectedCrystal = true
end

function FightTempDataMgr:isAutoSelectedCrystal()
	return self.autoSelectedCrystal
end

function FightTempDataMgr:clearBattleSelectCount()
	self.battleSelectCount = 0
end

function FightTempDataMgr:onInsertHandCard(cardInfoData)
	if not cardInfoData then
		return
	end

	if cardInfoData:checkIsUnnamedCard() then
		local unnamedDataMgr = self:getUnnamedDataMgr()

		unnamedDataMgr:clearUnnamedSpecialSkillPlayedData()
	end
end

function FightTempDataMgr:onPlayHandCard(fightBeginRoundOp)
	local unnamedMgr = self:getUnnamedDataMgr()

	unnamedMgr:onPlayHandCard(fightBeginRoundOp)
end

return FightTempDataMgr
