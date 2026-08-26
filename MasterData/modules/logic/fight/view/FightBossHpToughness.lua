-- chunkname: @modules/logic/fight/view/FightBossHpToughness.lua

module("modules.logic.fight.view.FightBossHpToughness", package.seeall)

local FightBossHpToughness = class("FightBossHpToughness", FightBaseClass)

function FightBossHpToughness:onConstructor(viewGO, entityData)
	self.viewGO = viewGO
	self.entityData = entityData
	self.tweenComp = self:addComponent(FightTweenComponent)

	local monsterConfig = lua_monster.configDict[self.entityData.modelId]

	if not monsterConfig then
		gohelper.setActive(self.viewGO, false)

		return
	end

	self.monsterConfig = monsterConfig
	self.arr = string.splitToNumber(monsterConfig.toughness, "#")

	if not self.arr then
		gohelper.setActive(self.viewGO, false)

		return
	end

	if #self.arr < 3 then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	self.fill = gohelper.findChildImage(self.viewGO, "fill")
	self.fillWidth = recthelper.getWidth(self.fill.transform)
	self.lineObj = gohelper.findChild(self.viewGO, "fill/line")

	local lineCount = self.arr[2] - 1

	self.lineCount = lineCount

	local dataList = {}

	for i = 1, lineCount do
		dataList[i] = i
	end

	gohelper.CreateObjList(self, self.onItemShow, dataList, self.fill.gameObject, self.lineObj)
	self:com_registMsg(FightMsgId.AfterDestroyEntity, self.onAfterDestroyEntity)
	self:com_registMsg(FightMsgId.ChangeEntityToughness, self.onChangeEntityToughness)
	self:com_registFightEvent(FightEvent.OnHpChange, self.showToughness)
	self:showToughness()
end

function FightBossHpToughness:showToughness()
	local arr = self.arr
	local showType = arr[3]

	if showType == 0 then
		local oneNum = arr[1]
		local maxNum = oneNum * arr[2]
		local finalValue = ((self.entityData.toughnessPoint - 1) * oneNum + self.entityData.toughnessValue) / maxNum

		self.tweenComp:DOFillAmount(self.fill, finalValue, 0.5)
	elseif showType == 1 then
		local oneNum = self.entityData.attrMO.hp * arr[1] / 1000
		local maxNum = oneNum * arr[2]
		local finalValue = ((self.entityData.toughnessPoint - 1) * oneNum + self.entityData.toughnessValue) / maxNum

		self.tweenComp:DOFillAmount(self.fill, finalValue, 0.5)
	end
end

function FightBossHpToughness:onChangeEntityToughness(entityID)
	if entityID == self.entityData.id then
		self:showToughness()
	end
end

function FightBossHpToughness:onAfterDestroyEntity(entityID)
	if entityID == self.entityData.id then
		gohelper.setActive(self.viewGO, false)
		self:disposeSelf()
	end
end

function FightBossHpToughness:onItemShow(obj, data, index)
	local posX = 0 - self.fillWidth / 2 + self.fillWidth / (self.lineCount + 1) * index

	recthelper.setAnchorX(obj.transform, posX)
end

return FightBossHpToughness
