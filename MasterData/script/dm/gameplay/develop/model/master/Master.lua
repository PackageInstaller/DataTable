-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/master/Master.lua

require("dm.gameplay.develop.model.master.MasterSkill")
require("dm.gameplay.develop.model.master.MasterAttribute")
require("dm.gameplay.develop.model.master.MasterStarPoint")
require("dm.gameplay.develop.model.effect.SingleEffectList")
require("dm.gameplay.develop.model.master.MasterLeadStage")

Master = class("Master", objectlua.Object, _M)

Master:has("_player", {
	is = "rw"
})
Master:has("_isLock", {
	is = "rw"
})
Master:has("_masterPrototype", {
	is = "rw"
})
Master:has("_skills", {
	is = "rw"
})
Master:has("_id", {
	is = "rw"
})
Master:has("_roleType", {
	is = "rw"
})
Master:has("_attrFactor", {
	is = "rw"
})
Master:has("_effect", {
	is = "rw"
})
Master:has("_effectList", {
	is = "rw"
})
Master:has("_attrsFlag", {
	is = "rw"
})
Master:has("_unloadkernelid", {
	is = "rw"
})
Master:has("_effectCenter", {
	is = "rw"
})
Master:has("_speed", {
	is = "rw"
})
Master:has("_surfaceId", {
	is = "rw"
})
Master:has("_leadStageData", {
	is = "rw"
})
Master:has("_emblemEffect", {
	is = "rw"
})
Master:has("_gallayEffect", {
	is = "rw"
})
Master:has("_gallayAllEffect", {
	is = "rw"
})
Master:has("_starPointEffect", {
	is = "rw"
})
Master:has("_TimeEffect", {
	is = "rw"
})

local StarState = {
	1,
	2,
	3
}

function Master:initialize(masterId, player, devs)
	super.initialize(self)

	self._developSystem = devs
	self._id = masterId
	self._skills = {}
	self._teamSkills = {}
	self._roleType = DevelopRoleType.kMaster
	self._masterPrototype = PrototypeFactory:getInstance():getMasterPrototype(tostring(masterId))
	self._config = self._masterPrototype:getConfig()

	self:initAttr()

	self._player = player
	self._unloadkernelid = ""
	self._masterAura = self._player:getMasterAura()
	self._star = self:getBaseStar()
	self._isLock = true
	self._kernels = {}
	self._speed = self._config.Speed
	self._surfaceId = ""
	self._leadStageData = MasterLeadStage:new(self, self._player)

	self:createSkillList()
	self:createLeaderSkillList()
	self:createKernelList()
	self:createStarPoint()
	self:rCreateEffect()
end

function Master:synchronize(data)
	self._isLock = false

	if data.attrs then
		self._attrs = data.attrs
	end

	if data.surfaceId then
		self._surfaceId = data.surfaceId
	end

	self:syncStarPoint(data)
	self:syncSkillData(data)

	if data.kernels then
		self:syncKernelList(data.kernels)
	end

	if data.sceneCombats then
		for key, num in pairs(data.sceneCombats) do
			self._sceneCombats[key] = num
		end
	end

	if data.leadStage then
		self._leadStageData:syncData(data.leadStage)
	end
end

function Master:synchronizeDel(data)
	if data.kernels then
		self:syncDelKernelList(data.kernels)
	end
end

function Master:createKernelList()
	return
end

function Master:syncKernelList(data)
	for k, v in pairs(data) do
		self._kernels[k] = v
	end
end

function Master:syncDelEquipKernelList(data)
	for k, v in pairs(self._kernels) do
		if tostring(v.id) == tostring(self:getUnloadkernelid()) then
			self._kernels[k] = nil
		end
	end

	self:setUnloadkernelid("")
end

function Master:createStarPoint()
	self._starPointSets = self._config.StarPointSets
	self._starPoint = self._starPointSets[self._star][1]
	self._starPointAttrNum = {}

	local index = self:getMaxStar() - 1

	self._starPointConfig = {}

	for star = 1, self:getMaxStar() - 1 do
		self._starPointConfig[star] = {}

		local starPointSets = self._starPointSets[star]

		for i = 1, #starPointSets do
			local state = StarState[3]
			local pointId = starPointSets[i]

			if self._starPoint == pointId then
				index = i
			end

			if i == index then
				state = StarState[2]
			elseif index < i then
				state = StarState[1]
			end

			self._starPointConfig[star][pointId] = self._starPointConfig[star][pointId] or MasterStarPoint:new(pointId)

			self._starPointConfig[star][pointId]:setState(state)
		end
	end

	self._curStarPointSets = self._starPointSets[self._star]
	self._curStarPointConfig = self._starPointConfig[self._star] or {}
end

function Master:resetStarPoint()
	self._curStarPointSets = self._starPointSets[self._star]
	self._curStarPointConfig = self._starPointConfig[self._star] or {}

	local index = #self._curStarPointSets

	for i = 1, #self._curStarPointSets do
		local pointId = self._curStarPointSets[i]
		local state = StarState[3]

		if pointId == self._starPoint then
			index = i
		end

		if i == index then
			state = StarState[2]
		elseif index < i then
			state = StarState[1]
		end

		if self._curStarPointConfig[pointId] then
			self._curStarPointConfig[pointId]:setState(state)
		end
	end

	self._starPointAttrNum = {}

	for star = 1, self._star do
		local data = self._starPointConfig[star]
		local starPointSets = self._starPointSets[star]

		for i = 1, #starPointSets do
			local pointId = starPointSets[i]

			if pointId == self._starPoint then
				return
			else
				local pointData = data[pointId]
				local attrType = pointData:getAttrType()

				self._starPointAttrNum[attrType] = self._starPointAttrNum[attrType] or 0
				self._starPointAttrNum[attrType] = self._starPointAttrNum[attrType] + pointData:getAttrNum()
			end
		end
	end
end

function Master:syncStarPoint(data)
	if data.star and self._star ~= data.star then
		self._star = data.star
	end

	if data.littleStar and data.littleStar ~= "" then
		self._starPoint = data.littleStar

		self:resetStarPoint()
	end

	self:updateSpeed()
	self:rCreateEffect()
	self:clearAttrsFlag()
end

function Master:syncAttrEffect()
	self:clearAttrsFlag()
	self:updateSpeed()
	self:rCreateEffect()
end

function Master:getStarPointAttrNumByType(type)
	return self._starPointAttrNum[type] or 0
end

function Master:getTimeEffectById(type)
	return self._player._effectCenter:getMasterTimeEffectByIdForType(self._id, type)
end

function Master:getEmblemAttrByType(type)
	return self._player._effectCenter:getEmblenEffectAttrsById(type)
end

function Master:getGalleryAttrByType(type)
	return self._player._effectCenter:getGalleryEffectAttrsById(type)
end

function Master:getGalleryAllAttrByType(type)
	return self._player._effectCenter:getGalleryAllEffectAttrsById(type)
end

function Master:getLeadStageAllAttrByType()
	return self._player._effectCenter:getLeadStageEffectsById(self._id)
end

function Master:getMessageMasterById(type)
	return self._player._effectCenter:getMessageMasterById(type)
end

function Master:getAddAttrByType(type)
	return (self:getMessageMasterById(type))
end

function Master:getAuraEffectByType(type)
	return self._player._effectCenter:getAuraEffectById(type)
end

function Master:isKernelEquip(serverid)
	local isequip = false

	for k, v in pairs(self._kernels) do
		if serverid == v.serverid then
			isequip = true

			break
		end
	end

	return isequip
end

function Master:isKernelEquipPos(pos)
	local isequip = false
	local equipkerneldata

	for k, v in pairs(self._kernels) do
		if pos == ConfigReader:getDataByNameIdAndKey("MasterCoreBase", v.configId, "Position") then
			isequip = true
			equipkerneldata = v

			break
		end
	end

	return isequip, equipkerneldata
end

function Master:createSkillList()
	local skillShowType = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Master_SkillShowType", "content")

	self._skillIndex = {}
	self._skills = {}

	local messageSkills, skillType

	if self._config.Infoshow ~= "" then
		local messageData = self._developSystem._gallerySystem:getMessageById(self._config.Infoshow)

		messageSkills = messageData:getCurSkillIds()
	end

	for i = 1, #skillShowType do
		local skillId = self._config[skillShowType[i]]

		if skillId and skillId ~= "" then
			if messageSkills and messageSkills[i] then
				skillId = messageSkills[i]
				skillType = skillShowType[i]
			end

			table.insert(self._skillIndex, skillId)

			self._skills[skillId] = MasterSkill:new(skillId, skillType)

			self._skills[skillId]:createAttrEffect(self, self._player, AttrSystemName.kMasterSkill)
		end
	end
end

local kConditonKey = {
	TeamSkill5 = "TeamSkillCondition5",
	TeamSkill4 = "TeamSkillCondition4",
	TeamSkill6 = "TeamSkillCondition6",
	TeamSkill3 = "TeamSkillCondition3",
	TeamSkill2 = "TeamSkillCondition2",
	TeamSkill1 = "TeamSkillCondition1"
}

function Master:createLeaderSkillList()
	local teamSkillShow = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Master_TeamSkillShow", "content")

	self._teamSkillIndex = {}
	self._teamSkills = {}

	for i = 1, #teamSkillShow do
		local skillId = self._config[teamSkillShow[i]]
		local conditionKey = kConditonKey[teamSkillShow[i]]
		local condition = self._config[conditionKey]

		if skillId and skillId ~= "" then
			table.insert(self._teamSkillIndex, skillId)

			self._teamSkills[skillId] = MasterSkill:new(skillId)

			self._teamSkills[skillId]:createAttrEffect(self, self._player, AttrSystemName.kMasterSkill)
			self._teamSkills[skillId]:setActiveCondition(condition)
		end
	end
end

function Master:syncSkillData(data)
	self:createSkillList()

	if data.skillList then
		self._skillIndex = {}

		for k, v in pairs(data.skillList) do
			local config = ConfigReader:getRecordById("Skill", tostring(v))

			if config and config.Type == 1 then
				table.insert(self._skillIndex, v)
			end
		end
	end

	if data.skills then
		for k, v in pairs(data.skills) do
			local skill = self._skills[k]

			if not skill then
				skill = MasterSkill:new(k)

				skill:createAttrEffect(self, self._player, AttrSystemName.kMasterSkill)

				self._skills[k] = skill
			end

			skill:syncData(k, v)
		end
	end
end

function Master:updateSpeed()
	self._speed = self._config.Speed + MasterAttribute:getSpeedRatio(self)
end

function Master:initAttr()
	self._effectList = SingleEffectList:new()
	self._attrFactor = AttrFactor:new()
	self._sceneCombats = {}

	self:clearAttrsFlag()

	self._skillIndex = {}
	self._teamSkillIndex = {}
end

function Master:clearAttrsFlag()
	self._attrsFlag = {}
end

function Master:getAttrFlagByType(attrType)
	return self._attrsFlag[attrType]
end

function Master:setAttrFlagByType(attrType, attrNum)
	self._attrsFlag[attrType] = attrNum
end

function Master:getCurUnloadKernelId()
	return
end

function Master:getEffectCenterAttr(attrType)
	return
end

function Master:rCreateBaseAttEffect()
	local allEffects = {}

	for attrType, _ in pairs(AttrBaseType) do
		local star = self:getStar()
		local data = {
			star = star,
			lvl = self._player:getLevel(),
			attrType = attrType,
			id = self:getId()
		}
		local effectConfig = MasterAttribute:getBaseAttEffectConfig(data, self)

		allEffects[#allEffects + 1] = SingleAttrAddEffect:new(effectConfig)
	end

	self._effect = CompositeEffect:new(allEffects)
	self._effect._effectFromName = AttrSystemName.kMasterBase
end

function Master:getEffectsByEffectzCenter(effectCenter)
	local allEffects = {}

	for k, v in pairs(effectCenter) do
		local attrNum = v
		local attrType = k
		local effectEvn = "ALL"
		local elementType = SkillAttribute:getElementByConfig(attrType, effectEvn)

		attrType = AttributeCategory:changeBaseAttrType(attrType)

		local effectConfig = {
			effectType = "ATTR",
			target = "SELF",
			effectEvn = effectEvn,
			attrNum = attrNum,
			attrType = attrType,
			elementType = elementType
		}

		allEffects[#allEffects + 1] = SingleAttrAddEffect:new(effectConfig)
	end

	return allEffects
end

function Master:rCreateEmblemEffect()
	local effectCenter = self._player._effectCenter:getEmblemEffectAttrsInfo()
	local allEffects = self:getEffectsByEffectzCenter(effectCenter)

	if not next(allEffects) then
		return
	end

	self._emblemEffect = CompositeEffect:new(allEffects)
	self._emblemEffect._effectFromName = AttrSystemName.kMasterEmblem
end

function Master:rCreateGallayEffect()
	local effectCenter = self._player._effectCenter:getGalleryEffectAttrsInfo()
	local allEffects = self:getEffectsByEffectzCenter(effectCenter)

	if not next(allEffects) then
		return
	end

	self._gallayEffect = CompositeEffect:new(allEffects)
	self._gallayEffect._effectFromName = AttrSystemName.kMasterGallay
end

function Master:rCreateGallayAllEffect()
	local effectCenter = self._player._effectCenter:getGalleryAllEffectAttrsInfo()
	local allEffects = self:getEffectsByEffectzCenter(effectCenter)

	if not next(allEffects) then
		return
	end

	self._gallayAllEffect = CompositeEffect:new(allEffects)
	self._gallayAllEffect._effectFromName = AttrSystemName.kMasterGallayALL
end

function Master:rCreateStarPointEffect()
	local effectCenter = self._starPointAttrNum
	local allEffects = self:getEffectsByEffectzCenter(effectCenter)

	if not next(allEffects) then
		return
	end

	self._starPointEffect = CompositeEffect:new(allEffects)
	self._starPointEffect._effectFromName = AttrSystemName.kMasterStarPoint
end

function Master:rCreateTimeEffect()
	local effectCenter = self._player._effectCenter:getMasterTimeEffectInfoById(self._id)
	local allEffects = self:getEffectsByEffectzCenter(effectCenter)

	if not next(allEffects) then
		return
	end

	self._TimeEffect = CompositeEffect:new(allEffects)
	self._TimeEffect._effectFromName = AttrSystemName.kMasterTime
end

function Master:getBaseAttrForAura(attrType)
	local star = self:getStar()
	local data = {
		star = star,
		lvl = self._player:getLevel(),
		attrType = attrType,
		id = self:getId()
	}

	return MasterAttribute:getBaseAttEffect(data, self)
end

function Master:getLevel()
	return self._player:getLevel()
end

function Master:rCreateEffect()
	self:removeEffect()
	self:rCreateBaseAttEffect()
	self:rCreateEmblemEffect()
	self:rCreateGallayEffect()
	self:rCreateGallayAllEffect()
	self:rCreateStarPointEffect()
	self:rCreateTimeEffect()
	self:addEffect()

	local effects = self:getLeadStageAllAttrByType()

	self._leadStageData:synchronize(effects)
end

function Master:addEffect()
	self:getEffectList():addEffect(self._effect)
	self:getEffectList():addEffect(self._emblemEffect)
	self:getEffectList():addEffect(self._gallayEffect)
	self:getEffectList():addEffect(self._gallayAllEffect)
	self:getEffectList():addEffect(self._starPointEffect)
	self:getEffectList():addEffect(self._TimeEffect)
end

function Master:removeEffect()
	self:getEffectList():removeEffect(self._effect)
	self:getEffectList():removeEffect(self._emblemEffect)
	self:getEffectList():removeEffect(self._gallayEffect)
	self:getEffectList():removeEffect(self._gallayAllEffect)
	self:getEffectList():removeEffect(self._starPointEffect)
	self:getEffectList():removeEffect(self._TimeEffect)
end

function Master:syncEffectCenter(data)
	return
end

function Master:getHp(env)
	return MasterAttribute:getAttrNumByType("HP", env, self)
end

function Master:getDefense(env)
	return MasterAttribute:getAttrNumByType("DEF", env, self)
end

function Master:getAttack(env)
	return MasterAttribute:getAttrNumByType("ATK", env, self)
end

function Master:getCritRate(env)
	return MasterAttribute:getAttrNumByType("CRITRATE", env, self)
end

function Master:getUncritRate(env)
	return MasterAttribute:getAttrNumByType("UNCRITRATE", env, self)
end

function Master:getCritStrg(env)
	return MasterAttribute:getAttrNumByType("CRITSTRG", env, self)
end

function Master:getBlockRate(env)
	return MasterAttribute:getAttrNumByType("BLOCKRATE", env, self)
end

function Master:getUnblockRate(env)
	return MasterAttribute:getAttrNumByType("UNBLOCKRATE", env, self)
end

function Master:getBlockStrg(env)
	return MasterAttribute:getAttrNumByType("BLOCKSTRG", env, self)
end

function Master:getHurtRate(env)
	return MasterAttribute:getAttrNumByType("HURTRATE", env, self)
end

function Master:getUnhurtRate(env)
	return MasterAttribute:getAttrNumByType("UNHURTRATE", env, self)
end

function Master:getAbsorption(env)
	return MasterAttribute:getAttrNumByType("ABSORPTION", env, self)
end

function Master:getReflection(env)
	return MasterAttribute:getAttrNumByType("REFLECTION", env, self)
end

function Master:getSkillsLevel()
	return 0
end

function Master:getCombat(evn)
	if self._isLock then
		return self:getBasePower()
	end

	MasterAttribute:setAddMasterAttrState(true)
	MasterAttribute:attachAttrToMaster(env, self)

	local attrData = {
		critRate = self:getCritRate(evn),
		hurtRate = self:getHurtRate(evn),
		unhurtRate = self:getUnhurtRate(evn),
		reflection = self:getReflection(evn),
		absorption = self:getAbsorption(evn),
		uncritRate = self:getUncritRate(evn),
		critStrg = self:getCritStrg(evn),
		blockRate = self:getBlockRate(evn),
		unblockRate = self:getUnblockRate(evn),
		blockStrg = self:getBlockStrg(evn),
		attack = self:getAttack(evn),
		defense = self:getDefense(evn),
		hp = self:getHp(evn),
		star = self:getStar(),
		skillOfferCombat = self:getSkillOfferCombat(),
		speed = self:getSpeed()
	}

	MasterAttribute:setAddMasterAttrState(false)

	attrData.attack = math.modf(attrData.attack)
	attrData.defense = math.modf(attrData.defense)
	attrData.hp = math.modf(attrData.hp)
	attrData.speed = math.modf(attrData.speed)

	local combat = self:getSceneCombats()

	return combat, attrData
end

function Master:getSceneCombats()
	return self._sceneCombats.ALL
end

function Master:getSkillOfferCombat()
	local offerCombat = 0

	for key, value in pairs(self._skills) do
		if value._config.Type == "UNIQUE" or value._config.Type == "BATTLEPASSIVE" then
			offerCombat = value._level + offerCombat
		end
	end

	return offerCombat
end

function Master:getId()
	return self._config.Id
end

function Master:getSkillIndexs()
	return self._skillIndex
end

function Master:getDesc()
	return (Strings:get(self._config.Desc))
end

function Master:getName()
	return (Strings:get(self._config.Name))
end

function Master:getNamePath()
	return self._config.NamePic
end

function Master:getSkillList()
	return self._skills
end

function Master:getEquipKernelsList()
	return self._kernels
end

function Master:getStar()
	return self._star
end

function Master:getBaseStar()
	return self._config.BaseStar
end

function Master:getBaseSpeed()
	return self._config.Speed
end

function Master:getSkillIndex(skillid)
	for k, v in pairs(self._skillIndex) do
		if v == skillid then
			return k
		end
	end

	return 1
end

function Master:getSkillByIndex(idx)
	local skillid = self._skillIndex[idx]

	for k, v in pairs(self._skills) do
		if tostring(skillid) == k then
			return v
		end
	end

	return nil
end

function Master:getSkillById(skillid)
	for k, v in pairs(self._skills) do
		if tostring(k) == tostring(skillid) then
			return v
		end
	end

	return nil
end

function Master:getTeamSkillByIndex(idx)
	local skillid = self._teamSkillIndex[idx]

	return self._teamSkills[skillid]
end

function Master:getStarPointBG()
	return self._config.StarPointBG or "diwen_img_01.png"
end

function Master:getStarUpItemId()
	return self._config.StarUpItemId
end

function Master:getCompositePay()
	return self._config.CompositePay
end

function Master:getCurStarPoints()
	return self._curStarPointSets
end

function Master:getCurStarPointConfig()
	return self._curStarPointConfig
end

function Master:getStarPointUpConfig()
	return self._curStarPointConfig[self._starPoint]
end

function Master:getStarUpItemCostByStar()
	return (self._curStarPointConfig[self._starPoint]:getItemPay())
end

function Master:getStarUpMoneyCostByStar()
	return (self._curStarPointConfig[self._starPoint]:getCrystalPay())
end

function Master:getModel()
	local roleModel = self._config.RoleModel

	if self._surfaceId ~= "" then
		roleModel = ConfigReader:getDataByNameIdAndKey("Surface", self._surfaceId, "Model")
	end

	roleModel = self._leadStageData:getLeadStageModel() or roleModel

	return roleModel
end

function Master:getType()
	return self._config.Type
end

function Master:getDefaultHp()
	return self._config.DefaultHp
end

function Master:getDefaultDefence()
	return self._config.DefaultDefence
end

function Master:getDefaultAttack()
	return self._config.DefaultAttack
end

function Master:getUndeadRate()
	return self._config.UndeadRate
end

function Master:getBeCuredRate()
	return self._config.BeCuredRate
end

function Master:getWeaken()
	return self._config.Weaken
end

function Master:getPenetration()
	return self._config.Penetration
end

function Master:getControlDefence()
	return self._config.ControlDefence
end

function Master:getControl()
	return self._config.Control
end

function Master:getDamageDefence()
	return self._config.DamageDefence
end

function Master:getDamageRate()
	return self._config.DamageRate
end

function Master:getCritDefence()
	return self._config.CritDefence
end

function Master:getDefenceRate()
	return self._config.DefenceRate
end

function Master:getAttackRate()
	return self._config.AttackRate
end

function Master:getEnergy()
	return self._config.Energy
end

function Master:getDefence()
	return self._config.Defence
end

function Master:getBaseHp()
	return self._config.BaseHp
end

function Master:getBaseDefence()
	return self._config.BaseDefence
end

function Master:getBaseAttack()
	return self._config.BaseAttack
end

function Master:getBasePower()
	return self._config.BasePower
end

function Master:getAttackSkill()
	return self._config.AttackSkill
end

function Master:getFeature()
	return Strings:get(self._config.Feature)
end

function Master:getMaxStar()
	return (ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_Maxstar", "content"))
end

function Master:getImage()
	local sprite = IconFactory:createRoleIconSpriteNew({
		iconType = 2,
		id = self:getModel()
	})

	if self._isLock then
		sprite:setGray(true)
	end

	return sprite
end

function Master:getHalfImage()
	local sprite = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe6_2",
		id = self:getModel()
	})

	sprite:setAnchorPoint(cc.p(0, 0))

	if self._isLock then
		sprite:setGray(true)
		sprite:setColor(cc.c3b(0, 0, 0))
	end

	return sprite
end

function Master:getTeamSkillCondition(index)
	if index then
		return self._config["TeamSkillCondition" .. index]
	end

	return ""
end

function Master:getSurfaceList()
	return self._config.SurfaceList or {}
end

function Master:isShow()
	return self._config.IfHidden == 1
end

function Master:getMasterOrder()
	return self._config.MasterOrder
end
