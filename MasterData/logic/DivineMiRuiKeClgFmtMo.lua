-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiruikeclg/model/DivineMiRuiKeClgFmtMo.lua

module("logic.extensions.divinemiruikeclg.model.DivineMiRuiKeClgFmtMo", package.seeall)

local DivineMiRuiKeClgFmtMo = class("DivineMiRuiKeClgFmtMo", BaseCustomFmtMo)

function DivineMiRuiKeClgFmtMo:initParams(activityId, phaseId, stageId)
	self._activityId = activityId
	self._phaseId = phaseId
	self._stageId = stageId
	self._cfgStage = DivineMiRuiKeClgConfig.instance:getStageCfg(activityId, phaseId, stageId)
	self._monsterCfg = DivineMiRuiKeClgConfig.instance:getMonsterCfg(self._cfgStage.creepsMasterId)
	self._creepsCfgs = DivineMiRuiKeClgConfig.instance:getCreeps(self._cfgStage.creepsMasterId)
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.ruleDesc

	self:setFormCondition(self._monsterCfg.formCondition)

	self._cfgSupport = DivineMiRuiKeClgConfig.instance:getSupportPet(activityId, self._cfgStage.creepsId)
	self._fixPosList = {}

	if self._cfgSupport and checknumber(self._cfgSupport.posId) > 0 then
		table.insert(self._fixPosList, checknumber(self._cfgSupport.posId))
	end
end

function DivineMiRuiKeClgFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		DivineMiRuiKeClgAgent.instance:sendPM_DivineMiRuiKeClgFightReq(self._activityId, form)
	end

	self:setFightHandler(handler, nil)
end

function DivineMiRuiKeClgFmtMo:initPetList()
	DivineMiRuiKeClgFmtMo.super.initPetList(self)
	self:addSupportPet(self._cfgSupport)
end

function DivineMiRuiKeClgFmtMo:updateData()
	self:addSupportPet(self._cfgSupport)

	local fmo = self:getCurFormation()

	if self._cfgSupport then
		if self._stageId ~= self._oldStageId then
			fmo:ResetPosition(true)

			self._oldStageId = self._stageId
		end

		fmo:SetPosition(self._cfgSupport.posId, self._cfgSupport.creepsId, true)
	end
end

function DivineMiRuiKeClgFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function DivineMiRuiKeClgFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function DivineMiRuiKeClgFmtMo:getFixedPosList()
	return self._fixPosList
end

function DivineMiRuiKeClgFmtMo:isRightPetEmpty()
	return self._rightPetMap == nil
end

function DivineMiRuiKeClgFmtMo:addSupportPet(cfgSupport)
	if cfgSupport and not self:isRightPetEmpty() then
		self:removeAllSupportPets()

		local fmo = FightingPowerPetMo.New()

		fmo:fromChallengeCreepCo(cfgSupport)

		local petMo = fmo:toBaseBagPetMo()

		petMo:setSupportedPet(true)
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function DivineMiRuiKeClgFmtMo:removeAllSupportPets()
	if self._rightPetList and self._rightPetMap then
		local count = #self._rightPetList

		for i = count, 1, -1 do
			local mo = self._rightPetList[i]

			if mo and mo.isSupportedPet then
				self._rightPetMap[mo.petId] = nil

				table.remove(self._rightPetList, i)
			end
		end
	end
end

return DivineMiRuiKeClgFmtMo
