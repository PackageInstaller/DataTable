-- chunkname: @modules/logic/fight/entity/comp/FightNameUIToughnessView.lua

module("modules.logic.fight.entity.comp.FightNameUIToughnessView", package.seeall)

local FightNameUIToughnessView = class("FightNameUIToughnessView", FightBaseClass)

function FightNameUIToughnessView:onConstructor(entity, viewGO, monsterConfig)
	self.entity = entity
	self.entityData = entity.entityData
	self.viewGO = viewGO
	self.monsterConfig = monsterConfig
	self.tweenComp = self:addComponent(FightTweenComponent)
	self.arr = string.splitToNumber(monsterConfig.toughness, "#")
	self.animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
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
	self:showToughness(true)
	self:com_registFightEvent(FightEvent.OnHpChange, self.onHpChange)
	self:com_registMsg(FightMsgId.ChangeEntityToughness, self.onChangeEntityToughness)
end

function FightNameUIToughnessView:onHpChange(entity)
	if entity.id == self.entity.id then
		self:showToughness()
	end
end

function FightNameUIToughnessView:onChangeEntityToughness(entityID)
	if entityID == self.entity.id then
		self:showToughness()
	end
end

function FightNameUIToughnessView:showToughness(isInit)
	local arr = self.arr
	local showType = arr[3]

	if showType == 0 then
		local oneNum = arr[1]
		local maxNum = oneNum * arr[2]
		local finalValue = ((self.entityData.toughnessPoint - 1) * oneNum + self.entityData.toughnessValue) / maxNum

		self.tweenComp:DOFillAmount(self.fill, finalValue, 0.5)

		if finalValue <= 0 then
			if isInit then
				self.animator:Play("idle")
			else
				self.animator:Play("die")
			end
		else
			self.animator:Play("idle")
		end
	elseif showType == 1 then
		local oneNum = self.entityData.attrMO.hp * arr[1] / 1000
		local maxNum = oneNum * arr[2]
		local finalValue = ((self.entityData.toughnessPoint - 1) * oneNum + self.entityData.toughnessValue) / maxNum

		self.tweenComp:DOFillAmount(self.fill, finalValue, 0.5)

		if finalValue <= 0 then
			if isInit then
				self.animator:Play("idle")
			else
				self.animator:Play("die")
			end
		else
			self.animator:Play("idle")
		end
	end
end

function FightNameUIToughnessView:onItemShow(obj, data, index)
	local posX = 0 - self.fillWidth / 2 + self.fillWidth / (self.lineCount + 1) * index

	recthelper.setAnchorX(obj.transform, posX)
end

return FightNameUIToughnessView
