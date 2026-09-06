-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/model/GodStatuesWarFightPillarCustomFmtMo.lua

module("logic.extensions.godstatueswar.model.GodStatuesWarFightPillarCustomFmtMo", package.seeall)

local GodStatuesWarFightPillarCustomFmtMo = class("GodStatuesWarFightPillarCustomFmtMo", BaseCustomFmtMo)

function GodStatuesWarFightPillarCustomFmtMo:onReset()
	GodStatuesWarFightPillarCustomFmtMo.super.onReset(self)
end

function GodStatuesWarFightPillarCustomFmtMo:updateCfg(seasonId, pillarId, familyId, tierId, step)
	self._seasonId = seasonId
	self._pillarId = pillarId
	self._familyId = familyId
	self._tierId = tierId
	self._step = step

	local stepData = GodStatuesWarConfig.instance:getNfbStepData(seasonId, self._step)

	self._pillarData = GodStatuesWarConfig.instance:getNfbDivinePillarData(stepData.divinePillarPlanId, tierId)
	self._creepsMasterIds = self._pillarData.creepsMasterIds

	self:refreshFormation()
end

function GodStatuesWarFightPillarCustomFmtMo:updateData()
	self.isShowTab = true
	self.ruleDescStr = self:getRuleDesc(self.curTabIndex)
	self.topTitleStr = self:getTopTitleStr(self.curTabIndex)
end

function GodStatuesWarFightPillarCustomFmtMo:getRightPetMo(petId)
	local rightFmtInfoMo = self:getTierFmtInfoMo(self.curTabIndex)

	return rightFmtInfoMo:getPetMo(petId)
end

function GodStatuesWarFightPillarCustomFmtMo:getTierFmtInfoMo(seatIdx)
	return GodStatuesWarController.instance:getTierFmtInfoMo(self._seasonId, self._pillarId, self._tierId, seatIdx)
end

function GodStatuesWarFightPillarCustomFmtMo:getTopTitleStr(index)
	return string.format("第%s层 %s队", self._tierId, index)
end

function GodStatuesWarFightPillarCustomFmtMo:getRuleDesc(index)
	local desc = "击败敌阵所有精灵即可过关"

	if not self._creepsMasterIds[index] then
		local creepsMasterId = 0
		local data = GodStatuesWarConfig.instance:getNfbMasterData(creepsMasterId)

		if data and not string.nilorempty(desc.ruleDesc) then
			desc = desc.ruleDesc
		end

		return desc
	end
end

function GodStatuesWarFightPillarCustomFmtMo:getSpeedInRight()
	local tierFmtInfoMo = self:getTierFmtInfoMo(self.curTabIndex)

	if tierFmtInfoMo then
		return tierFmtInfoMo:getSpeed()
	end
end

function GodStatuesWarFightPillarCustomFmtMo:getZdlInRight()
	local tierFmtInfoMo = self:getTierFmtInfoMo(self.curTabIndex)

	if tierFmtInfoMo then
		return tierFmtInfoMo:getZdl()
	end
end

function GodStatuesWarFightPillarCustomFmtMo:jumpToTabIndex(idx)
	self.topTitleStr = self:getTopTitleStr(idx)
	self.ruleDescStr = self:getRuleDesc(idx)

	GodStatuesWarFightPillarCustomFmtMo.super.jumpToTabIndex(self, idx)
end

function GodStatuesWarFightPillarCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleFormList = self:getSimpleFormList()

		GodStatuesWarController.instance:sendPM_NewFamilyBattleFightDivinePillarReq(self._seasonId, self._familyId, self._tierId, simpleFormList)
	end

	self:setFightHandler(handler, nil)
end

function GodStatuesWarFightPillarCustomFmtMo:initFormationMo()
	self.forMationMaps = {}

	for _, teamId in ipairs(GameEnum.BattleTeamList) do
		self.forMationMaps[teamId] = {}

		for idx = 1, self.maxTabCount do
			self.forMationMaps[teamId][idx] = teamId == GameEnum.BattleTeam.Left and FormationMO.New(GameUtil.handler(self.getPetMoById, self)) or FormationMO.New(GameUtil.handler(self.getRightPetMo, self))
		end
	end

	self.formationMo = self:getCurFormation()
end

function GodStatuesWarFightPillarCustomFmtMo:getCurFormation()
	return self.forMationMaps[GameEnum.BattleTeam.Left][self.curTabIndex]
end

function GodStatuesWarFightPillarCustomFmtMo:getCurRightFormation()
	return self.forMationMaps[GameEnum.BattleTeam.Right][self.curTabIndex]
end

function GodStatuesWarFightPillarCustomFmtMo:refreshFormation()
	for tabIdx = 1, self.maxTabCount do
		local fmtInfoMo = GodStatuesWarController.instance:getTierFmtInfoMo(self._seasonId, self._pillarId, self._tierId, tabIdx)
		local formationMo = self.forMationMaps[GameEnum.BattleTeam.Right][tabIdx]

		if fmtInfoMo then
			local hp = fmtInfoMo:getCurHp()

			if hp > 0 then
				formationMo:SetData(fmtInfoMo:getSimpleForm())
			else
				formationMo:ResetPosition()
			end
		else
			formationMo:ResetPosition()
		end
	end
end

function GodStatuesWarFightPillarCustomFmtMo:getSimpleFormList()
	local list = {}

	for idx = 1, self.maxTabCount do
		local forMation = self.forMationMaps[GameEnum.BattleTeam.Left][idx]

		if forMation then
			table.insert(list, CustomFmtController.instance:createFormPb(forMation))
		end
	end

	return list
end

function GodStatuesWarFightPillarCustomFmtMo:isHaveEmptyFmt()
	local isHave = false

	for _, forMation in pairs(self.forMationMaps[GameEnum.BattleTeam.Left]) do
		if forMation:isEmpty() then
			isHave = true

			break
		end
	end

	return isHave
end

function GodStatuesWarFightPillarCustomFmtMo:checkPetIsForbit(checkPetMo)
	for i = 1, self.maxTabCount do
		if i ~= self.curTabIndex then
			local otherFormationMo = self.forMationMaps[GameEnum.BattleTeam.Left][i]
			local pet_poisition = otherFormationMo:GetPositions() or {}

			for idx, v in ipairs(pet_poisition) do
				if v ~= 0 then
					local petmo = self:getPetMoById(v)

					if petmo and checkPetMo:getDefineId() == petmo:getDefineId() then
						return true, i
					end
				end
			end
		end
	end

	return false
end

function GodStatuesWarFightPillarCustomFmtMo:showForbitPetAlert(petMo)
	local boo, tabIdx = self:checkPetIsForbit(petMo)

	if boo then
		FloatWordMgr.instance:show(langPara("【%s】阵型中已使用该精灵", tabIdx))
	end
end

function GodStatuesWarFightPillarCustomFmtMo:getMonsterConfigList()
	return {}
end

function GodStatuesWarFightPillarCustomFmtMo:getFmtInfoConfig()
	local formationMo = self:getCurRightFormation()
	local simpleForm = CustomFmtController.instance:createFormPb(formationMo)

	return simpleForm.extParams
end

function GodStatuesWarFightPillarCustomFmtMo:getFmtHp(tabIdx)
	local fmtInfoMo = GodStatuesWarController.instance:getTierFmtInfoMo(self._seasonId, self._pillarId, self._tierId, tabIdx)

	return fmtInfoMo:getCurHp()
end

function GodStatuesWarFightPillarCustomFmtMo:getTeamAndFormation(creepCfg)
	local fmtMo = self:getCurRightFormation()
	local teams, formations, speed = fmtMo:getTeamAndFormation()

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

return GodStatuesWarFightPillarCustomFmtMo
