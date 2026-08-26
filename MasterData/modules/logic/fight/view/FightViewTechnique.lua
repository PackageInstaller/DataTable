-- chunkname: @modules/logic/fight/view/FightViewTechnique.lua

module("modules.logic.fight.view.FightViewTechnique", package.seeall)

local FightViewTechnique = class("FightViewTechnique", BaseView)
local buffType2Id, battleId2Id, invalidBuff2Id, resistanceIdList, getCardEnergyList, getASFDSkillList, createBloodPoolList, heatScaleList, weakCareerList, DeviceList

function FightViewTechnique:onInitView()
	if not buffType2Id then
		buffType2Id = {}
		battleId2Id = {}
		resistanceIdList = {}
		getCardEnergyList = {}
		getASFDSkillList = {}
		createBloodPoolList = {}
		heatScaleList = {}
		weakCareerList = {}
		DeviceList = {}

		for _, co in ipairs(lua_fight_technique.configList) do
			local array = string.split(co.condition, "|")

			for i, v in ipairs(array) do
				local temp = string.split(v, "#")

				if temp[1] == "1" then
					local buffType = tonumber(temp[2])

					buffType2Id[buffType] = co.id
				elseif temp[1] == "2" then
					local battleId = tonumber(temp[2])

					battleId2Id[battleId] = co.id
				elseif temp[1] == "3" then
					invalidBuff2Id = co.id
				elseif temp[1] == "4" then
					table.insert(resistanceIdList, co.id)
				elseif temp[1] == "5" then
					table.insert(getCardEnergyList, co.id)
				elseif temp[1] == "6" then
					table.insert(getASFDSkillList, co.id)
				elseif temp[1] == "7" then
					table.insert(createBloodPoolList, co.id)
				elseif temp[1] == "8" then
					table.insert(heatScaleList, co.id)
				elseif temp[1] == "9" then
					table.insert(weakCareerList, co.id)
				elseif temp[1] == "10" then
					table.insert(DeviceList, co.id)
				end
			end
		end
	end

	self._scrollGO = gohelper.findChild(self.viewGO, "root/#scroll_effecttips")
	self._originY = recthelper.getAnchorY(self._scrollGO.transform)
end

function FightViewTechnique:addEvents()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightTechnique) then
		return
	end

	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnDistributeCards, self._onDistributeCards, self)
	self.addEventCb(self, FightController.instance, FightEvent.BeforePlaySkill, self._beforePlaySkill, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	self.addEventCb(self, PlayerController.instance, PlayerEvent.UpdateSimpleProperty, self._updateSimpleProperty, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetStateForDialogBeforeStartFight, self._onSetStateForDialogBeforeStartFight, self)
	self.addEventCb(self, FightController.instance, FightEvent.TriggerCardShowResistanceTag, self.onTriggerCardShowResistanceTag, self)
	self.addEventCb(self, FightController.instance, FightEvent.ASFD_StartAllocateCardEnergy, self.onStartAllocateCardEnergy, self)
	self.addEventCb(self, FightController.instance, FightEvent.AddUseCard, self.AddUseCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.BloodPool_OnCreate, self.onBloodPoolCreate, self)
	self.addEventCb(self, FightController.instance, FightEvent.HeatScale_OnCreate, self.onHeatScaleCreate, self)
	self.addEventCb(self, FightController.instance, FightEvent.AfterCreateDeviceArea, self.onAfterCreateDeviceArea, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnAddNewEntity, self.onAddNewEntity, self)
end

function FightViewTechnique:removeEvents()
	self.removeEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnDistributeCards, self._onDistributeCards, self)
	self.removeEventCb(self, FightController.instance, FightEvent.BeforePlaySkill, self._beforePlaySkill, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	self.removeEventCb(self, PlayerController.instance, PlayerEvent.UpdateSimpleProperty, self._updateSimpleProperty, self)
	self.removeEventCb(self, FightController.instance, FightEvent.SetStateForDialogBeforeStartFight, self._onSetStateForDialogBeforeStartFight, self)
	self.removeEventCb(self, FightController.instance, FightEvent.TriggerCardShowResistanceTag, self.onTriggerCardShowResistanceTag, self)
	self.removeEventCb(self, FightController.instance, FightEvent.ASFD_StartAllocateCardEnergy, self.onStartAllocateCardEnergy, self)
	self.removeEventCb(self, FightController.instance, FightEvent.AddUseCard, self.AddUseCard, self)
	self.removeEventCb(self, FightController.instance, FightEvent.BloodPool_OnCreate, self.onBloodPoolCreate, self)
	self.removeEventCb(self, FightController.instance, FightEvent.HeatScale_OnCreate, self.onHeatScaleCreate, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnAddNewEntity, self.onAddNewEntity, self)
end

function FightViewTechnique:onOpen()
	FightViewTechniqueModel.instance:initFromSimpleProperty()

	local entityDataDic = FightDataHelper.entityMgr.entityDataDic

	for k, entityData in pairs(entityDataDic) do
		self:onAddNewEntity(entityData.id, entityData)
	end

	self:_udpateAnchorY()
end

function FightViewTechnique:onAddNewEntity(entityId, entityData)
	local weaknessList = entityData.weakCareers
	local hasWeakness = weaknessList and #weaknessList > 0

	if hasWeakness then
		for _, v in ipairs(weakCareerList) do
			self:_checkAdd(v)
		end
	end
end

function FightViewTechnique:onBloodPoolCreate(teamType)
	if teamType ~= FightEnum.TeamType.MySide then
		return
	end

	for _, v in ipairs(createBloodPoolList) do
		self:_checkAdd(v)
	end
end

function FightViewTechnique:onHeatScaleCreate(teamType)
	if teamType ~= FightEnum.TeamType.MySide then
		return
	end

	if heatScaleList then
		for _, v in ipairs(heatScaleList) do
			self:_checkAdd(v)
		end
	end
end

function FightViewTechnique:onAfterCreateDeviceArea()
	if DeviceList then
		for _, v in ipairs(DeviceList) do
			self:_checkAdd(v)
		end
	end
end

function FightViewTechnique:onTriggerCardShowResistanceTag()
	for _, v in ipairs(resistanceIdList) do
		self:_checkAdd(v)
	end
end

function FightViewTechnique:onStartAllocateCardEnergy()
	for _, v in ipairs(getCardEnergyList) do
		self:_checkAdd(v)
	end
end

function FightViewTechnique:AddUseCard(cardIndexList)
	local usedCards = FightPlayCardModel.instance:getUsedCards()

	for _, cardIndex in ipairs(cardIndexList) do
		local cardInfo = usedCards[cardIndex]

		if cardInfo and FightHelper.isASFDSkill(cardInfo.skillId) then
			for _, v in ipairs(getASFDSkillList) do
				self:_checkAdd(v)
			end
		end
	end
end

function FightViewTechnique:_onBuffUpdate(targetId, effectType, buffId)
	if effectType ~= FightEnum.EffectType.BUFFADD then
		return
	end

	local buffCO = lua_skill_buff.configDict[buffId]

	if not buffCO then
		return
	end

	local id = buffType2Id[buffCO.typeId]

	if not id then
		return
	end

	self:_checkAdd(id)
end

function FightViewTechnique:_onDistributeCards()
	self.removeEventCb(self, FightController.instance, FightEvent.OnDistributeCards, self._onDistributeCards, self)

	local battleId = FightModel.instance:getFightParam().battleId
	local id = battleId and battleId2Id[battleId]

	if not id then
		return
	end

	self:_checkAdd(id)
end

function FightViewTechnique:_beforePlaySkill(entity, skillId, fightStepData)
	if not entity:getMO() then
		return
	end

	self._rejectTypes = nil
	self._rejectIds = nil

	local buffDic = entity:getMO():getBuffDic()

	for _, buffMO in pairs(buffDic) do
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]
		local buffTypeCO = lua_skill_bufftype.configDict[buffCO.typeId]

		if not string.nilorempty(buffTypeCO.rejectTypes) then
			local sp = string.split(buffTypeCO.rejectTypes, "#")
			local param = string.split(sp[2], ",")
			local dict

			if sp[1] == "1" then
				self._rejectTypes = self._rejectTypes or {}
				dict = self._rejectTypes
			elseif sp[1] == "2" then
				self._rejectIds = self._rejectIds or {}
				dict = self._rejectIds
			end

			if dict then
				for _, one in ipairs(dict) do
					dict[one] = true
				end
			end
		end
	end
end

function FightViewTechnique:_onSkillPlayFinish(entity, skillId, fightStepData)
	if not invalidBuff2Id then
		return
	end

	if not entity:isMySide() then
		return
	end

	if entity.id == FightEntityScene.MySideId or entity.id == FightEntityScene.EnemySideId then
		return
	end

	local skillCO = lua_skill.configDict[skillId]

	if not skillCO then
		return
	end

	local serverUpdateBuffIdDict = {}

	for _, actEffectData in ipairs(fightStepData.actEffect) do
		if (actEffectData.effectType == FightEnum.EffectType.BUFFADD or actEffectData.effectType == FightEnum.EffectType.BUFFUPDATE) and actEffectData.buff then
			serverUpdateBuffIdDict[actEffectData.buff.buffId] = true
		end
	end

	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCO["behavior" .. i]

		if not string.nilorempty(behavior) then
			local spRes = FightStrUtil.instance:getSplitToNumberCache(behavior, "#")
			local behaviorType = spRes[1]
			local buffId = spRes[2]
			local buffCO = lua_skill_buff.configDict[buffId]
			local isAddBuff = behaviorType == 1
			local updateBuffFail = not serverUpdateBuffIdDict[buffId]

			if self._rejectTypes then
				local var_15_0 = self._rejectTypes[buffCO.typeId]

				if not self._rejectTypes[buffCO.typeId] then
					var_15_0 = self._rejectIds

					if self._rejectIds then
						local rejectBuff = self._rejectIds[buffId]

						if isAddBuff and updateBuffFail and not rejectBuff then
							self:_checkAdd(invalidBuff2Id)

							break
						end
					end
				end
			end
		end
	end
end

function FightViewTechnique:_checkAdd(id)
	local mo = FightViewTechniqueModel.instance:addUnread(id)

	if not mo then
		return
	end

	local propertyStr = FightViewTechniqueModel.instance:getPropertyStr()

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.FightTechnique, propertyStr)
	self:_udpateAnchorY()
end

function FightViewTechnique:_updateSimpleProperty(simplePropertyId)
	if simplePropertyId == PlayerEnum.SimpleProperty.FightTechnique then
		self:_udpateAnchorY()
	end
end

function FightViewTechnique:_udpateAnchorY()
	local temp_data = {}

	for _, mo in ipairs(FightViewTechniqueModel.instance:getList()) do
		local co = lua_fight_technique.configDict[mo.id]

		if co and co.iconShow == "1" then
			table.insert(temp_data, mo)

			if #temp_data >= 3 then
				break
			end
		end
	end

	FightViewTechniqueListModel.instance:showUnreadFightViewTechniqueList(temp_data)

	local unreadCount = #temp_data

	if unreadCount >= 3 then
		recthelper.setAnchorY(self._scrollGO.transform, self._originY)
	elseif unreadCount > 0 then
		recthelper.setAnchorY(self._scrollGO.transform, self._originY - (3 - unreadCount) * 140 / 2)
	end

	local isOpenShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightTechnique)

	gohelper.setActive(self._scrollGO, isOpenShow and unreadCount > 0)
end

function FightViewTechnique:_onSetStateForDialogBeforeStartFight(state)
	gohelper.setActive(self._scrollGO, not state)

	if not state then
		self:_udpateAnchorY()
	end
end

return FightViewTechnique
