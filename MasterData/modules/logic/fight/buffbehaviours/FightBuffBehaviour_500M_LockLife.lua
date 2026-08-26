-- chunkname: @modules/logic/fight/buffbehaviours/FightBuffBehaviour_500M_LockLife.lua

module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_500M_LockLife", package.seeall)

local FightBuffBehaviour_500M_LockLife = class("FightBuffBehaviour_500M_LockLife", FightBuffBehaviourBase)
local lockLifePath = "ui/viewres/fight/fighttower/fighttowerbosshplock.prefab"

function FightBuffBehaviour_500M_LockLife:onAddBuff(entityId, buffId, buffMo)
	self.hpPointList = {}

	FightModel.instance:setMultiHpType(FightEnum.MultiHpType.Tower500M)

	self.root = gohelper.findChild(self.viewGo, "root/bossHpRoot/bossHp/Alpha/bossHp")
	self.loader = PrefabInstantiate.Create(self.root)

	self.loader:startLoad(lockLifePath, self.onLoadFinish, self)
	self:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate)
end

local LockHpBuffId = 102310003

function FightBuffBehaviour_500M_LockLife:onBuffUpdate(entityId, buffId)
	if buffId ~= LockHpBuffId then
		return
	end

	self:refreshUI()
end

function FightBuffBehaviour_500M_LockLife:onLoadFinish()
	self.lockLifeGo = self.loader:getInstGO()
	self.goHpLock = gohelper.findChild(self.lockLifeGo, "go_hpLock")
	self.goPointItem = gohelper.findChild(self.lockLifeGo, "go_hpPoint/#image_point")
	self.goHpPoint = gohelper.findChild(self.lockLifeGo, "go_hpPoint")

	gohelper.setActive(self.goHpLock, false)
	gohelper.setActive(self.goPointItem, false)
	self:refreshUI()
	FightController.instance:dispatchEvent(FightEvent.MultiHpTypeChange)
end

function FightBuffBehaviour_500M_LockLife:refreshUI()
	self.hasLockHpBuff = false

	local entityDict = FightDataHelper.entityMgr:getAllEntityMO()

	for _, entityMo in pairs(entityDict) do
		local buffDict = entityMo:getBuffDic()

		for _, buffMo in pairs(buffDict) do
			if buffMo.buffId == LockHpBuffId then
				self.hasLockHpBuff = true
			end
		end
	end

	self:refreshPoint()
	self:refreshHP()
end

local ImageList = {
	"fight_tower_hp_0",
	"fight_tower_hp_1",
	"fight_tower_hp_2",
	"fight_tower_hp_3",
	"fight_tower_hp_4",
	"fight_tower_hp_5"
}

function FightBuffBehaviour_500M_LockLife:refreshPoint()
	local bossEntityMo = self:getBossMo()

	if not bossEntityMo then
		gohelper.setActive(self.goHpPoint, false)

		return
	end

	local multiHpNum = bossEntityMo.attrMO.multiHpNum

	if multiHpNum <= 1 then
		gohelper.setActive(self.goHpPoint, false)

		return
	end

	if self.hasLockHpBuff then
		gohelper.setActive(self.goHpPoint, false)

		return
	end

	gohelper.setActive(self.goHpPoint, true)

	local multiHpIdx = bossEntityMo.attrMO:getCurMultiHpIndex()

	for i = 1, multiHpNum do
		local hpPointItem = self.hpPointList[i]

		if not hpPointItem then
			hpPointItem = self:getUserDataTb_()
			hpPointItem.go = gohelper.cloneInPlace(self.goPointItem)
			hpPointItem.image = hpPointItem.go:GetComponent(gohelper.Type_Image)
		end

		gohelper.setActive(hpPointItem.go, true)

		local showHp = i <= multiHpNum - multiHpIdx

		if showHp then
			UISpriteSetMgr.instance:setFightTowerSprite(hpPointItem.image, ImageList[i + 1])
		else
			UISpriteSetMgr.instance:setFightTowerSprite(hpPointItem.image, ImageList[1])
		end
	end

	for i = multiHpNum + 1, #self.hpPointList do
		local hpPointItem = self.hpPointList[i]

		if hpPointItem then
			gohelper.setActive(hpPointItem.go, false)
		end
	end
end

function FightBuffBehaviour_500M_LockLife:getBossMo()
	local monsterGroupId = FightModel.instance:getCurMonsterGroupId()
	local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]
	local bossId = monsterGroupCO and not string.nilorempty(monsterGroupCO.bossId) and monsterGroupCO.bossId

	if not bossId then
		return
	end

	local enemyEntityMOList = FightDataHelper.entityMgr:getEnemyNormalList()

	for _, entityMO in ipairs(enemyEntityMOList) do
		if FightHelper.isBossId(bossId, entityMO.modelId) then
			return entityMO
		end
	end
end

function FightBuffBehaviour_500M_LockLife:refreshHP()
	gohelper.setActive(self.goHpLock, self.hasLockHpBuff)
end

function FightBuffBehaviour_500M_LockLife:onUpdateBuff(entityId, buffId, buffMo)
	return
end

function FightBuffBehaviour_500M_LockLife:onRemoveBuff(entityId, buffId, buffMo)
	gohelper.destroy(self.lockLifeGo)
	FightModel.instance:setMultiHpType(nil)
	FightController.instance:dispatchEvent(FightEvent.MultiHpTypeChange)
end

function FightBuffBehaviour_500M_LockLife:onDestroy()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	FightModel.instance:setMultiHpType(nil)
	FightBuffBehaviour_500M_LockLife.super.onDestroy(self)
end

return FightBuffBehaviour_500M_LockLife
