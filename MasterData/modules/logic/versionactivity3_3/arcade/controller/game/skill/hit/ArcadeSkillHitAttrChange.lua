-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitAttrChange.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitAttrChange", package.seeall)

local ArcadeSkillHitAttrChange = class("ArcadeSkillHitAttrChange", ArcadeSkillHitBase)

function ArcadeSkillHitAttrChange:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._attrId = tonumber(params[2])
	self._attrVal = tonumber(params[3])
	self._skillTargetId = tonumber(params[4])
	self._attrCType = ArcadeGameHelper.getAttrTypeByAttrId(self._attrId)
	self._isTempAttr = tonumber(params[5]) == 1
	self._skillTargetBase = ArcadeSkillFactory.instance:createSkillTargetById(self._skillTargetId)
end

function ArcadeSkillHitAttrChange:onHit()
	local func = self:_getFunc(self._changeName, self._attrCType)

	if func and self._skillTargetBase then
		self._skillTargetBase:findByContext(self._context)

		local unitMOList = self._skillTargetBase:getTargetList()

		self:addHiterList(unitMOList)

		for _, unitMO in ipairs(unitMOList) do
			if unitMO then
				func(self, unitMO)
			end
		end
	end
end

function ArcadeSkillHitAttrChange:onHitPrintLog()
	local unitMOList = self._skillTargetBase:getTargetList()

	logNormal(string.format("%s targetCount:%s attrId:%s attrVal:%s", self:getLogPrefixStr(), #unitMOList, self._attrId, self._attrVal))
end

function ArcadeSkillHitAttrChange:_onAtkAttrBase(unitMO)
	local attrSetMO = unitMO:getAttrSetMO()

	if not attrSetMO then
		return
	end

	if ArcadeGameEnum.BaseAttr.hp == self._attrId then
		ArcadeGameController.instance:changeEntityHp(unitMO, self._attrVal)

		if unitMO:getHp() <= 0 then
			ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnSkillKillDeathSettle, unitMO, self._context and self._context.target)
		end
	else
		if self._isTempAttr then
			attrSetMO:addTempVal(self._attrId, self._attrVal)
		else
			attrSetMO:addValByName(self._attrId, ArcadeGameAttribute.ATTR_BASE, self._attrVal)
		end

		self:_dispatchEvent(ArcadeEvent.OnSkillAttrChange, unitMO)

		if ArcadeGameEnum.BaseAttr.hpCap == self._attrId then
			local attrMO = attrSetMO:getAttrById(self._attrId)

			if attrMO and unitMO:getHp() > attrMO:getValue() then
				local val = attrMO:getValue() - unitMO:getHp()

				ArcadeGameController.instance:changeEntityHp(unitMO, val)

				if unitMO:getHp() <= 0 then
					ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnSkillKillDeathSettle, unitMO, self._context and self._context.target)
				end
			end
		end
	end
end

function ArcadeSkillHitAttrChange:_onAtkAttrRate(unitMO)
	local attrSetMO = unitMO:getAttrSetMO()

	if not attrSetMO then
		return
	end

	if ArcadeGameEnum.BaseAttr.hp == self._attrId then
		local curHp = unitMO:getHp()
		local arrtMO = attrSetMO:getAttrById(ArcadeGameEnum.BaseAttr.hpCap)
		local addVal = math.floor(self._attrVal * arrtMO.base / 1000)

		ArcadeGameController.instance:changeEntityHp(unitMO, addVal)

		if unitMO:getHp() <= 0 then
			ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnSkillKillDeathSettle, unitMO, self._context and self._context.target)
		end
	else
		local arrtMO = attrSetMO:getAttrById(self._attrId)
		local addVal = math.floor(self._attrVal * arrtMO.base / 1000)

		attrSetMO:addValByName(self._attrId, ArcadeGameAttribute.ATTR_RATE, addVal)
		self:_dispatchEvent(ArcadeEvent.OnSkillAttrChange, unitMO, addVal)
	end
end

function ArcadeSkillHitAttrChange:_dispatchEvent(eventName, unitMO, val)
	if unitMO then
		local entityType = unitMO:getEntityType()
		local uid = unitMO:getUid()

		val = val or self._attrVal

		ArcadeGameController.instance:dispatchEvent(eventName, entityType, uid, self._attrId, val)
	end
end

function ArcadeSkillHitAttrChange:_onResourceAttrBase(unitMO)
	local entityType = unitMO:getEntityType()

	if entityType ~= ArcadeGameEnum.EntityType.Character then
		return
	end

	local resMO = unitMO:getResourceMO(self._attrId)

	if resMO then
		local count = resMO:getCount()

		resMO:setCount(self._attrVal + count)

		if self._attrId == ArcadeGameEnum.CharacterResource.GameCoin and self._attrVal > 0 then
			ArcadeGameModel.instance:addGainCoinNum(self._attrVal)
		end

		self:_dispatchEvent(ArcadeEvent.OnSkillResourceChange, unitMO)
	end
end

function ArcadeSkillHitAttrChange:_onResourceAttrRate(unitMO)
	local entityType = unitMO:getEntityType()

	if entityType ~= ArcadeGameEnum.EntityType.Character then
		return
	end

	local resMO = unitMO:getResourceMO(self._attrId)

	if resMO then
		local max = resMO:getMax()

		if ArcadeGameEnum.CharacterResource.SkillEnergy == self._attrId then
			local characterMO = ArcadeGameModel.instance:getCharacterMO()

			if characterMO then
				max = ArcadeConfig.instance:getCharacterSkillCost(characterMO:getId())
			end
		end

		local val = math.floor(self._attrVal * max / 1000)
		local count = resMO:getCount()

		resMO:setCount(val + count)

		if self._attrId == ArcadeGameEnum.CharacterResource.GameCoin and val > 0 then
			ArcadeGameModel.instance:addGainCoinNum(val)
		end

		self:_dispatchEvent(ArcadeEvent.OnSkillResourceChange, unitMO, val)
	end
end

function ArcadeSkillHitAttrChange:_onGameAttrBase(unitMO)
	if self._isTempAttr then
		local val = ArcadeGameModel.instance:getGameTempAttribute(self._attrId)

		ArcadeGameModel.instance:setGameTempAttribute(self._attrId, self._attrVal + val)
	else
		local val = ArcadeGameModel.instance:getGameAttrNoTemp(self._attrId)

		ArcadeGameModel.instance:setGameAttribute(self._attrId, self._attrVal + val)
	end

	ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnSkillGameAttrChange, self._attrId, self._attrVal)
end

function ArcadeSkillHitAttrChange:_onGameAttrRate(unitMO)
	local val = ArcadeGameModel.instance:getGameAttrNoTemp(self._attrId)
	local max = ArcadeConfig.instance:getAttributeMax(self._attrId, true)
	local changeVal = math.floor(self._attrVal * max / 1000)

	ArcadeGameModel.instance:setGameAttribute(self._attrId, changeVal + val)
	ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnSkillGameAttrChange, self._attrId, self._attrVal)
end

function ArcadeSkillHitAttrChange:_onGameSwitchBase(unitMO)
	ArcadeGameModel.instance:setGameSwitch(self._attrId, self._attrVal > 0)
	ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnSkillGameSwitchChange, self._attrId, self._attrVal > 0)
end

function ArcadeSkillHitAttrChange:_getFunc(changeName, attrType)
	local funcMap = ArcadeSkillHitAttrChange.ATTR_FUC_MAP[changeName]

	return funcMap and funcMap[attrType]
end

ArcadeSkillHitAttrChange.ATTR_FUC_MAP = {
	attributeChange1 = {
		[ArcadeGameEnum.AttrType.Attack] = ArcadeSkillHitAttrChange._onAtkAttrBase,
		[ArcadeGameEnum.AttrType.Resource] = ArcadeSkillHitAttrChange._onResourceAttrBase,
		[ArcadeGameEnum.AttrType.GameAttr] = ArcadeSkillHitAttrChange._onGameAttrBase,
		[ArcadeGameEnum.AttrType.GameSwitch] = ArcadeSkillHitAttrChange._onGameSwitchBase
	},
	attributeChange2 = {
		[ArcadeGameEnum.AttrType.Attack] = ArcadeSkillHitAttrChange._onAtkAttrRate,
		[ArcadeGameEnum.AttrType.Resource] = ArcadeSkillHitAttrChange._onResourceAttrRate,
		[ArcadeGameEnum.AttrType.GameAttr] = ArcadeSkillHitAttrChange._onGameAttrRate
	}
}

return ArcadeSkillHitAttrChange
