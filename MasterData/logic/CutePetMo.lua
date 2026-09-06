-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/model/CutePetMo.lua

module("logic.extensions.cutepet.model.CutePetMo", package.seeall)

local CutePetMo = class("CutePetMo", MaterialMo)

CutePetMo.STATE_SCENE_FOLLOW = 0
CutePetMo.STATE_IN_ADVENTURE = 1
CutePetMo.STATE_GARDEN_SHOW = 2
CutePetMo.LOCKED = 3

function CutePetMo:ctor()
	self.type = MatType.CutePet
	self.id = 0
	self.raceId = 0
	self.name = nil
	self.curLvl = 0
	self.curStar = 0
	self.curQuality = 0
	self.initialTalent = 0
	self.equippedPetId = 0
	self.switchState = 0
	self.gainTime = 0
	self.travelCount = 0
	self.score = 0
	self.readyToDiscard = false
end

function CutePetMo:initData(info)
	self._info = info
	self.id = info.uniqueId
	self.raceId = info.raceId
	self.name = info.name
	self.curLvl = info.curLvl
	self.curStar = info.curStar
	self.curQuality = info.curQuality
	self.equippedPetId = info.equippedPetId
	self.switchState = info.switchState
	self.gainTime = info.gainTime
	self.travelCount = info.travelCount
	self.readyToDiscard = info.readyToDiscard == true
	self.initialTalent = info.initialTalent
	self._initialProps = {}

	for i, v in ipairs(info.initialProps or {}) do
		self._initialProps[v.propClientIndex] = v.propValue
	end

	self.config = CutePetConfig.instance:getCutePetById(self.raceId)

	if string.nilorempty(self.name) then
		self.name = self.config.name
	end

	self.attr = {}

	self:updateAttr()
end

function CutePetMo:initDataByMsg(msg)
	self.id = msg.cutePetId
	self.raceId = msg.cutePetRaceId
	self.curLvl = msg.lvl
	self.curStar = msg.star
	self.curQuality = msg.quality
	self.equippedPetId = 0
	self.initialTalent = msg.initialTalent
	self._initialProps = {}

	for i, v in ipairs(msg.initialProps or {}) do
		self._initialProps[v.propClientIndex] = v.propValue
	end

	self.config = CutePetConfig.instance:getCutePetById(self.raceId)

	if string.nilorempty(self.name) then
		self.name = self.config.name
	end

	self.attr = {}

	self:updateAttr()
end

function CutePetMo:setState(state, isShow)
	local curState = self:getState(state)

	if isShow ~= curState then
		self.switchState = GameUtil.setBitByDigitXor(self.switchState, state)
	end
end

function CutePetMo:getState(state)
	return GameUtil.isBitOpenByDigit(self.switchState, state)
end

function CutePetMo:getId()
	return self.id
end

function CutePetMo:getMatType()
	return self.type
end

function CutePetMo:getDefineId()
	return self.raceId
end

function CutePetMo:GetMatType()
	return self.type
end

function CutePetMo:getQuality()
	return self.curQuality
end

function CutePetMo:getIsReadyToDiscard()
	return self.readyToDiscard == true
end

function CutePetMo:setReadyToDiscard(isDiscard)
	self.readyToDiscard = isDiscard == true
end

function CutePetMo:getInitialActiveProps(quality, list)
	local result = list or {}
	local plan = CutePetConfig.instance:getQualityUpPlan(self.config.qualityUpPlan)

	for i, v in ipairs(plan) do
		if v.quality <= (quality or self.curQuality) then
			for j, attrType in ipairs(v.newActivePropTypes) do
				local typeIndex = FightingPowerFormula.instance:getAttrTypeByName(attrType)

				result[typeIndex] = checknumber(result[typeIndex]) + self._initialProps[typeIndex]
			end
		end
	end

	return result
end

function CutePetMo:updateAttr()
	self.attr = self:calcAttr(self.curQuality, self.curLvl, self.curStar)

	local starSkillCfg = CutePetConfig.instance:getStarSkillCfg(self.raceId, self.curStar)

	self.zdl = starSkillCfg.numZdl

	self:calcScore()
end

function CutePetMo:calcAttr(quality, level, star, isMaxInitialProps)
	local result = {}
	local result1 = self._initialProps

	if isMaxInitialProps and isMaxInitialProps == true then
		local maxInitialProps = {}
		local initPropertyCfg = CutePetConfig.instance:getInitPropCfgs(self.config.initPropertyPlan)

		for i, v in pairs(initPropertyCfg) do
			if v.genRange[2] > 0 then
				maxInitialProps[FightingPowerFormula.instance:getAttrTypeByName(i)] = v.genRange[2]
			end
		end

		result1 = maxInitialProps
	end

	local levelCfg = CutePetConfig.instance:getLevelUpCfg(self.config.lvlUpPlan, level or self.curLvl)
	local result2 = FightingPowerFormula.instance:parseAttrValues(levelCfg.levelProps)
	local qualityCfg = CutePetConfig.instance:getQualityUpCfg(self.config.qualityUpPlan, quality or self.curQuality)

	for i, v in pairs(result2) do
		result2[i] = v * (1 + qualityCfg.propsRate)
	end

	local starCfg = CutePetConfig.instance:getStarUpCfg(self.config.starUpPlan, star or self.curStar)
	local result3 = FightingPowerFormula.instance:parseAttrValues(starCfg.starProps)
	local plan = CutePetConfig.instance:getQualityUpPlan(self.config.qualityUpPlan)

	for i, v in ipairs(plan) do
		if v.quality <= (quality or self.curQuality) then
			for j, attrType in ipairs(v.newActivePropTypes) do
				local typeIndex = FightingPowerFormula.instance:getAttrTypeByName(attrType)

				result[typeIndex] = checknumber(result[typeIndex]) + checknumber(result1[typeIndex]) + checknumber(result2[typeIndex]) + checknumber(result3[typeIndex])
			end
		end
	end

	return result
end

function CutePetMo:getSortAttrList(attr)
	local result = {}
	local tagMap = {}
	local targetAttrMap = attr or self.attr

	for k, v in ipairs(CutePetConfig.instance:getAttrSortByQualityPlan(self.config.qualityUpPlan)) do
		if targetAttrMap[v] then
			tagMap[v] = true

			table.insert(result, v)
		end
	end

	local otherList = {}

	for i, v in pairs(targetAttrMap) do
		if not tagMap[i] then
			table.insert(otherList, i)
		end
	end

	if #otherList > 0 then
		ArraySort.sortOn(otherList, "attrType", ArraySort.NONE)

		for i, v in ipairs(otherList) do
			table.insert(result, v)
		end
	end

	return result
end

function CutePetMo:clone()
	local mat = CutePetMo.New()

	mat:initData(self._info)

	return mat
end

function CutePetMo:calcScore()
	local talentCfg = CutePetConfig.instance:getTalentCfg(self.initialTalent)
	local score1 = talentCfg.score
	local score2 = AttrMo.calcFightPowerByAttrs(self.attr) * CutePetConfig.instance:getCommonValue("PropZdlToScore", true)
	local starSkillCfg = CutePetConfig.instance:getStarSkillCfg(self.raceId, self.curStar)
	local score3 = starSkillCfg.numZdl * CutePetConfig.instance:getCommonValue("AssistanceZdlToScore", true)

	self.score = math.ceil(score1 + score2 + score3)
end

function CutePetMo:getTalentGrade()
	local talentCfg = CutePetConfig.instance:getTalentCfg(self.initialTalent)

	if talentCfg then
		return checknumber(talentCfg.grade)
	end

	return 1
end

function CutePetMo:getInitProp(propType)
	return self._initialProps[propType]
end

return CutePetMo
