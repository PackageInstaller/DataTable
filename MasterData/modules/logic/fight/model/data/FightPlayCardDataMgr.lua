-- chunkname: @modules/logic/fight/model/data/FightPlayCardDataMgr.lua

module("modules.logic.fight.model.data.FightPlayCardDataMgr", package.seeall)

local FightPlayCardDataMgr = FightDataClass("FightPlayCardDataMgr", FightDataMgrBase)

function FightPlayCardDataMgr:onConstructor()
	self.playCard = {}
	self.enemyPlayCard = {}
	self.enemyAct174PlayCard = {}
end

function FightPlayCardDataMgr:setAct174EnemyCard(cardListProto)
	FightDataUtil.coverData(FightCardDataHelper.newPlayCardList(cardListProto), self.enemyAct174PlayCard)
end

return FightPlayCardDataMgr
