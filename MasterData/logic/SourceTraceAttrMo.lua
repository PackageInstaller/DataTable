-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/model/SourceTraceAttrMo.lua

module("logic.extensions.bag.model.SourceTraceAttrMo", package.seeall)

local SourceTraceAttrMo = class("SourceTraceAttrMo", AttrMo)

function SourceTraceAttrMo:calcTotalAttrs(extOnly)
	self.isCalcAttr = false
	self.isCalcPower = false
	self.finalAttrs = {}
	self.totalAttr = {}
	self.baseTotalAttr = {}
	self.publicTotalAttr = {}
	self.withoutPercentTotalAttr = {}
	self.baseTotalAttr = AttrMo.addSameAttrs(self.baseAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.petSourceTraceAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.talentAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.awakenAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.decorationAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.runeAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.extAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.petTeamAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.petSkinAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.petHoshigamiAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.starGodPlusAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.petCutePetAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.petHolyStripesAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.equipAttr, self.baseTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.assistAttr, self.publicTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.petRelationAttr, self.publicTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.petThroneAttr, self.publicTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.handbookAttr, self.publicTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.animalAttr, self.publicTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.petGoodfellingAttr, self.publicTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.formStrengthAttr, self.publicTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.mountAttr, self.publicTotalAttr)
	self.totalAttr = AttrMo.addSameAttrs(self.baseTotalAttr, self.totalAttr)
	self.totalAttr = AttrMo.addSameAttrs(self.publicTotalAttr, self.totalAttr)
	self.withoutPercentTotalAttr = AttrMo.addSameAttrs(self.totalAttr, self.withoutPercentTotalAttr)

	if extOnly == true then
		-- block empty
	else
		local res = 0
		local petCo = MaterialMgr.getMatCfg(MatType.Pet, self.petMo.raceId)
		local awakenScfg = CharacterConfig.instance:getPetAwakenCostCfg(petCo.awakenCostStrategyId, self.petMo.awakeLevel)

		if awakenScfg then
			res = res + checknumber(awakenScfg.allPropertyWanPercent) / 10000
		end

		for k, v in pairs(self.baseTotalAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour then
				local next = BagModel.instance:getRelationPercentByMoAndType(self.petMo, k)

				if k == GameEnum.AttrType.Hp then
					self.baseTotalAttr[GameEnum.AttrType.HpRate] = self.baseTotalAttr[GameEnum.AttrType.HpRate] or 0
					self.baseTotalAttr[GameEnum.AttrType.HpRate] = self.baseTotalAttr[GameEnum.AttrType.HpRate] + res + next
				elseif k == GameEnum.AttrType.Attack then
					self.baseTotalAttr[GameEnum.AttrType.AttackRate] = self.baseTotalAttr[GameEnum.AttrType.AttackRate] or 0
					self.baseTotalAttr[GameEnum.AttrType.AttackRate] = self.baseTotalAttr[GameEnum.AttrType.AttackRate] + res + next
				elseif k == GameEnum.AttrType.DefenseMagic then
					self.baseTotalAttr[GameEnum.AttrType.DefenseMagicRate] = self.baseTotalAttr[GameEnum.AttrType.DefenseMagicRate] or 0
					self.baseTotalAttr[GameEnum.AttrType.DefenseMagicRate] = self.baseTotalAttr[GameEnum.AttrType.DefenseMagicRate] + res + next
				elseif k == GameEnum.AttrType.DefensePhysical then
					self.baseTotalAttr[GameEnum.AttrType.DefensePhysicalRate] = self.baseTotalAttr[GameEnum.AttrType.DefensePhysicalRate] or 0
					self.baseTotalAttr[GameEnum.AttrType.DefensePhysicalRate] = self.baseTotalAttr[GameEnum.AttrType.DefensePhysicalRate] + res + next
				elseif k == GameEnum.AttrType.Speed then
					self.baseTotalAttr[GameEnum.AttrType.SpeedRate] = self.baseTotalAttr[GameEnum.AttrType.SpeedRate] or 0
					self.baseTotalAttr[GameEnum.AttrType.SpeedRate] = self.baseTotalAttr[GameEnum.AttrType.SpeedRate] + res + next
				else
					self.baseTotalAttr[k] = v * (1 + next)
				end
			end
		end

		if not self.handBookPercentAttr then
			local handBook = {}

			if not self.animalPercentAttr then
				local animal = {}

				for k, v in pairs(self.publicTotalAttr) do
					if k ~= GameEnum.AttrType.OriginalVigour then
						local handbookV = checknumber(handBook[k])
						local animalV = checknumber(animal[k])

						if k == GameEnum.AttrType.Hp then
							self.publicTotalAttr[GameEnum.AttrType.HpRate] = self.publicTotalAttr[GameEnum.AttrType.HpRate] or 0
							self.publicTotalAttr[GameEnum.AttrType.HpRate] = self.publicTotalAttr[GameEnum.AttrType.HpRate] + handbookV + animalV
						elseif k == GameEnum.AttrType.Attack then
							self.publicTotalAttr[GameEnum.AttrType.AttackRate] = self.publicTotalAttr[GameEnum.AttrType.AttackRate] or 0
							self.publicTotalAttr[GameEnum.AttrType.AttackRate] = self.publicTotalAttr[GameEnum.AttrType.AttackRate] + handbookV + animalV
						elseif k == GameEnum.AttrType.DefenseMagic then
							self.publicTotalAttr[GameEnum.AttrType.DefenseMagicRate] = self.publicTotalAttr[GameEnum.AttrType.DefenseMagicRate] or 0
							self.publicTotalAttr[GameEnum.AttrType.DefenseMagicRate] = self.publicTotalAttr[GameEnum.AttrType.DefenseMagicRate] + handbookV + animalV
						elseif k == GameEnum.AttrType.DefensePhysical then
							self.publicTotalAttr[GameEnum.AttrType.DefensePhysicalRate] = self.publicTotalAttr[GameEnum.AttrType.DefensePhysicalRate] or 0
							self.publicTotalAttr[GameEnum.AttrType.DefensePhysicalRate] = self.publicTotalAttr[GameEnum.AttrType.DefensePhysicalRate] + handbookV + animalV
						elseif k == GameEnum.AttrType.Speed then
							self.publicTotalAttr[GameEnum.AttrType.SpeedRate] = self.publicTotalAttr[GameEnum.AttrType.SpeedRate] or 0
							self.publicTotalAttr[GameEnum.AttrType.SpeedRate] = self.publicTotalAttr[GameEnum.AttrType.SpeedRate] + handbookV + animalV
						else
							self.publicTotalAttr[k] = v * (1 + handbookV + animalV)
						end
					end
				end

				self.totalAttr = {}
				self.totalAttr = AttrMo.addSameAttrs(self.baseTotalAttr, self.totalAttr)
				self.totalAttr = AttrMo.addSameAttrs(self.publicTotalAttr, self.totalAttr)
			end
		end
	end
end

function SourceTraceAttrMo:calcEquipmentAttr(petMo, isForbitCalc)
	self.petMo = petMo

	local result = self:getEquipmentAttr(self.petMo)
	local effectRate = 0

	for i, v in ipairs(self.petMo.sourceTraces) do
		local effectCfg = SourceTraceConfig.instance:getEffectCfg(v.effectId)

		if effectCfg and not string.nilorempty(effectCfg.moduleRate) then
			local effectArray = string.split(effectCfg.moduleRate, "#")

			for j, typeStr in ipairs(effectArray) do
				local infos = string.split(typeStr, ":")
				local type = infos[1]
				local value = checknumber(infos[2])

				if type == GameEnum.SourceEffectModuleTypeCN.Equipment then
					effectRate = effectRate + value / 10000
				end
			end
		end
	end

	local addRate = checknumber(self.extModelBaseAttrRate[GameEnum.AttrModelType.Equipment]) + checknumber(effectRate)

	if addRate ~= 0 then
		for k, v in pairs(result) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				result[k] = v * (1 + addRate)
			end
		end
	end

	self.equipAttr = result

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.equipAttr
end

function SourceTraceAttrMo:calcHolyStripesAttr(petMo, isForbitCalc)
	self.petMo = petMo

	local result = HolyStripeModel.instance:calcByHolyStripeAttrs(petMo.holyStripes, self.petMo.isMyPackPet)
	local effectRate = 0

	for i, v in ipairs(self.petMo.sourceTraces) do
		local effectCfg = SourceTraceConfig.instance:getEffectCfg(v.effectId)

		if not string.nilorempty(effectCfg.moduleRate) then
			local effectArray = string.split(effectCfg.moduleRate, "#")

			for j, typeStr in ipairs(effectArray) do
				local infos = string.split(typeStr, ":")
				local type = infos[1]
				local value = checknumber(infos[2])

				if type == GameEnum.SourceEffectModuleTypeCN.HolyStripe then
					effectRate = effectRate + value / 10000
				end
			end
		end
	end

	local addRate = checknumber(self.extModelBaseAttrRate[GameEnum.AttrModelType.HolyStripe]) + checknumber(effectRate)

	if addRate ~= 0 then
		for k, v in pairs(result) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				result[k] = v * (1 + addRate)
			end
		end
	end

	self.petHolyStripesAttr = result

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.petHolyStripesAttr
end

function SourceTraceAttrMo:calcCutePetAttr(petMo, isForbitCalc)
	self.petMo = petMo

	local result = CutePetModel.instance:calcByCutePetAttrs(petMo.cutePetShelter, self.petMo.isMyPackPet)
	local effectRate = 0

	for i, v in ipairs(self.petMo.sourceTraces) do
		local effectCfg = SourceTraceConfig.instance:getEffectCfg(v.effectId)

		if not string.nilorempty(effectCfg.moduleRate) then
			local effectArray = string.split(effectCfg.moduleRate, "#")

			for j, typeStr in ipairs(effectArray) do
				local infos = string.split(typeStr, ":")
				local type = infos[1]
				local value = checknumber(infos[2])

				if type == GameEnum.SourceEffectModuleTypeCN.CutePet then
					effectRate = effectRate + value / 10000
				end
			end
		end
	end

	local addRate = checknumber(self.extModelBaseAttrRate[GameEnum.AttrModelType.CutePet]) + checknumber(effectRate)

	if addRate ~= 0 then
		for k, v in pairs(result) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				result[k] = v * (1 + addRate)
			end
		end
	end

	self.petCutePetAttr = result

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.petCutePetAttr
end

function SourceTraceAttrMo:calcMountAttr(petMo, isForbitCalc)
	self.petMo = petMo

	table.clear(self.mountAttr)

	if petMo.usePublicStrengthsFlag then
		local mountInfo = FightingPowerPetMo.getMountMax()

		if petMo.usePublicStrengthsSetAttr then
			petMo.mountInfo = mountInfo
		end

		local data = {
			isMyPackPet = false,
			mountInfo = mountInfo
		}

		for k, v in pairs(self:getMountAttr(data)) do
			self.mountAttr[k] = v
		end
	else
		for k, v in pairs(self:getMountAttr(self.petMo)) do
			self.mountAttr[k] = v
		end
	end

	local effectRate = 0

	for i, v in ipairs(self.petMo.sourceTraces) do
		local effectCfg = SourceTraceConfig.instance:getEffectCfg(v.effectId)

		if effectCfg and not string.nilorempty(effectCfg.moduleRate) then
			local effectArray = string.split(effectCfg.moduleRate, "#")

			for j, typeStr in ipairs(effectArray) do
				local infos = string.split(typeStr, ":")
				local type = infos[1]
				local value = checknumber(infos[2])

				if type == GameEnum.SourceEffectModuleTypeCN.Mount then
					effectRate = effectRate + value / 10000
				end
			end
		end
	end

	local addRate = checknumber(self.extModelBaseAttrRate[GameEnum.AttrModelType.Mount]) + checknumber(effectRate)

	if addRate ~= 0 then
		for k, v in pairs(self.mountAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.mountAttr[k] = v * (1 + addRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.mountAttr
end

function SourceTraceAttrMo:baseFormula(type, typeRate)
	local tempB = checknumber(self.baseTotalAttr[type])
	local tempBR = checknumber(self.baseTotalAttr[typeRate]) + 1
	local valueB = tempB * tempBR
	local tempP = checknumber(self.publicTotalAttr[type])
	local tempPR = checknumber(self.publicTotalAttr[typeRate]) + 1
	local valueP = tempP * tempPR

	return math.round(valueB + valueP)
end

SourceTraceAttrMo.instance = SourceTraceAttrMo.New()

return SourceTraceAttrMo
