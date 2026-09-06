-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/model/PetEquipModel.lua

module("logic.extensions.equipment.model.PetEquipModel", package.seeall)

local PetEquipModel = class("PetEquipModel", BaseModel)

PetEquipModel.EquipPos = {
	EquipExclusive = 6,
	EquipHelmet = 3,
	EquipClothes = 2,
	EquipArms = 1,
	EquipJewelry = 5,
	EquipShose = 4
}
PetEquipModel.PetEquipRedType = {
	All = 3,
	Wear = 1,
	Strengthen = 2,
	TuPo = 4
}
PetEquipModel.AlchemyType = {
	StarGod = 3,
	Equip = 1,
	Artifact = 2
}
PetEquipModel.FunctionType = {
	ReyeType = 3,
	SttnType = 1,
	TupoType = 2
}
PetEquipModel.FilterType = {
	NotwearTogType = 2,
	AllTogType = 0,
	WearTogType = 1
}

function PetEquipModel:ctor()
	self.isGetAllEquip = false
	self.allEquipInfoList = nil
	self.fictitiousExp = 0
	self.dectInfoList = nil
	self.dianpingInfoList = nil
	self.isOpenDecorations = false
	self.attrRateList = nil
	self.attrStoneId = nil
	self._optionalInfo = nil
	self._equipFactoryCount = nil
	self.equipRecycleQua = nil
end

function PetEquipModel:onInit()
	PetEquipModel.super.onInit(self)
	self:onReset()
end

function PetEquipModel:onReset()
	self.isGetAllEquip = false
	self.allEquipInfoList = nil
	self.fictitiousExp = 0
	self.upgradeInfo = nil
	self.beforeWearList = nil
	self.dectInfoList = nil
	self.dianpingInfoList = nil
	self.attrRateList = nil
	self.attrStoneId = nil
	self._equipFactoryCount = nil
	self.equipRecycleQua = nil
	self._optionalInfo = {
		shopId = 4004,
		actType = 47
	}
end

function PetEquipModel:SynchronizationAllEquipInfo(data, isInit)
	if isInit then
		self.allEquipInfoList = nil
	end

	if data == nil then
		return
	end

	self.allEquipInfoList = self.allEquipInfoList or {}

	local addList, updList, deleList = {}, {}, {}

	for _, info in pairs(data) do
		if info and checknumber(info.equipmentId) > 0 then
			if info.deleted then
				table.insert(deleList, info.equipmentId)
				self:DeleteEquipInfo(info.equipmentId)
			else
				if self.allEquipInfoList[info.equipmentId] then
					self.allEquipInfoList[info.equipmentId]:InitEquipInfo(info)
					table.insert(updList, info.equipmentId)
				elseif self:AddEquipInfo(info) then
					table.insert(addList, info.equipmentId)
				end

				BagPetsController.instance:updatePetEquipAttrById(info.equippedPetId)
			end
		end
	end

	if isInit then
		BagPetsController.instance:calcAllPetEquipAttr()
	end

	if addList and #addList > 0 then
		local info = {
			updataType = "add",
			matType = MatType.Equipment,
			list = addList
		}

		GlobalDispatcher:dispatch(GlobalNotify.PET_EQUIP_CHANGES, info)
	end

	if updList and #updList > 0 then
		local info = {
			updataType = "upd",
			matType = MatType.Equipment,
			list = updList
		}

		GlobalDispatcher:dispatch(GlobalNotify.PET_EQUIP_CHANGES, info)
	end

	if deleList and #deleList > 0 then
		local info = {
			updataType = "del",
			matType = MatType.Equipment,
			list = deleList
		}

		GlobalDispatcher:dispatch(GlobalNotify.PET_EQUIP_CHANGES, info)
	end
end

function PetEquipModel:AddEquipInfo(data)
	if data == nil or checknumber(data.equipmentId) <= 0 or checknumber(data.defineId) <= 0 then
		return false
	end

	if self.allEquipInfoList == nil then
		self.allEquipInfoList = {}
	end

	local info = EquipInfoMo.New(data, MatType.Equipment)

	if info and checknumber(info.onlyId) > 0 then
		self.allEquipInfoList[info.onlyId] = info

		return true
	else
		printError("sr--- PetEquipModel:AddEquipInfo()   添加装备失败  baseId = ", data.defineId, data.equipmentId)

		return false
	end
end

function PetEquipModel:DeleteEquipInfo(onlyId)
	if self.allEquipInfoList == nil then
		return
	end

	self.allEquipInfoList[onlyId] = nil

	if next(self.allEquipInfoList) == nil then
		self.allEquipInfoList = nil
	end
end

function PetEquipModel:SCEquipInfoChange(infos)
	if infos == nil or #infos == 0 then
		return
	end

	self.allEquipInfoList = self.allEquipInfoList or {}

	for i = 1, #infos do
		local onlyId = infos[i].equipmentId

		if infos[i].deleted then
			self.allEquipInfoList[onlyId] = nil
		elseif self.allEquipInfoList[onlyId] == nil then
			self.allEquipInfoList[onlyId] = EquipInfoMo.New(infos[i])
		else
			self.allEquipInfoList[onlyId]:UpdataBaseInfo(infos[i].equippedPetId, infos[i].exp)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PET_EQUIP_UPDATA)
end

function PetEquipModel:GetEquipInfo(onlyId)
	if checknumber(onlyId) < 1 or self.allEquipInfoList == nil then
		return
	end

	return self.allEquipInfoList[onlyId]
end

function PetEquipModel:GetEquipInfos(baseId)
	if checknumber(baseId) < 1 or self.allEquipInfoList == nil then
		return
	end

	local infoList = {}

	for k, info in pairs(self.allEquipInfoList) do
		if info and info.baseId == baseId then
			table.insert(infoList, info)
		end
	end

	return infoList
end

function PetEquipModel:GetWearEquipInfosByPetInfo(petInfo)
	local equipList = {
		{
			isOpen = true,
			isWear = false
		},
		{
			isOpen = true,
			isWear = false
		},
		{
			isOpen = true,
			isWear = false
		},
		{
			isOpen = true,
			isWear = false
		},
		{
			isOpen = true,
			isWear = false
		},
		{
			isOpen = true,
			isWear = false
		}
	}

	if petInfo == nil or petInfo.equipments == nil then
		return equipList
	end

	for i = 1, #equipList do
		if petInfo.equipments and petInfo.equipments[i] and petInfo.equipments[i].id then
			equipList[i].isWear = true

			local equipInfo = self:GetEquipInfo(petInfo.equipments[i].id)

			if equipInfo == nil then
				printError(">>>>>>>>>>>>>>找不到这精灵的装备:", petInfo.petId, petInfo.curFaceId, i, petInfo.equipments[i].id)
			end

			if equipInfo and not equipInfo:isEquipArtifact() then
				if equipInfo:isEnableWearExcl() then
					equipList[i].isExclSttr = true
				else
					equipList[i].isAddSttr = PetSkinConfig.instance:checkHasEleAttr(petInfo.curFaceId, equipInfo.attrType) or AttrMo.checkHasYuanEle(petInfo.curFaceId, equipInfo.attrType)
				end
			end

			equipList[i].info = equipInfo
		else
			equipList[i].isOpen = self:_isOpenArtifact(petInfo.curFaceId, i)
		end
	end

	return equipList
end

function PetEquipModel:_isOpenArtifact(skinId, pos)
	pos = checknumber(pos)

	if pos ~= 5 and pos ~= 6 then
		return true
	end

	local list = EquipmentConfig.instance:getArtifactSkinIds(pos)

	if list == nil then
		return false
	end

	skinId = checknumber(skinId)

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if skinCfg == nil or skinCfg.raceId == 0 then
		return false
	end

	local baseCfg

	for sId, ids in pairs(list) do
		if sId and ids and #ids > 0 then
			baseCfg = PetSkinConfig.instance:getPetSkinCfg(checknumber(sId))

			if baseCfg and baseCfg.raceId == skinCfg.raceId and baseCfg.bodyType == skinCfg.bodyType then
				return true
			end
		end
	end

	return false
end

function PetEquipModel:getPetStrengthenInfoMos(infoMo)
	if infoMo == nil or infoMo.matType ~= MatType.Equipment then
		return false
	end

	if infoMo.equipPetId < 1 then
		return false
	end

	local petInfo = BagPetsController.instance:getPet(infoMo.equipPetId)

	if petInfo == nil then
		return false
	end

	local wearList = self:GetWearEquipInfosByPetInfo(petInfo)
	local num = 1

	for i = 1, #wearList do
		if wearList[i] and wearList[i].info and wearList[i].info.onlyId == infoMo.onlyId then
			num = i

			break
		end
	end

	return true, wearList, num
end

function PetEquipModel:getStrengthenEquipSelectList(sifterList, showTog)
	showTog = showTog or PetEquipModel.FilterType.AllTogType

	local tempList = {}

	for _, info in pairs(self.allEquipInfoList or {}) do
		if info and self:isNengStrengthenEquip(info.onlyId) and self:isKeyiStrengthenInfoMo(info, true) and self:_isConformEquipSifter(info, sifterList) and (showTog == PetEquipModel.FilterType.AllTogType or showTog == PetEquipModel.FilterType.WearTogType and info:isWearEquip() or showTog == PetEquipModel.FilterType.NotwearTogType and not info:isWearEquip()) then
			table.insert(tempList, info)
		end
	end

	if #tempList > 1 then
		table.sort(tempList, PetEquipModel._sortStrengthenEquipSelectList)
	end

	return tempList
end

function PetEquipModel._sortStrengthenEquipSelectList(a, b)
	local isWearA = a:isWearEquip()
	local isWearB = b:isWearEquip()

	if isWearA == isWearB then
		if a.quality == b.quality then
			return a.starCount > b.starCount
		end

		return a.quality > b.quality
	end

	return isWearA
end

function PetEquipModel:isNengStrengthenEquip(onlyId)
	local equipInfo = self:GetEquipInfo(onlyId)

	if equipInfo == nil then
		return
	end

	local planList = EquipmentConfig.instance:GetEquipLevelInfos(equipInfo.attrPlan)

	if planList == nil then
		return
	end

	return planList[1] ~= nil
end

function PetEquipModel:GetEquipUpgradeMaxLevel(baseId)
	local equipCfg = EquipmentConfig.instance:GetEquipDefineInfoById(baseId)
	local index = 0

	if equipCfg == nil then
		return index
	end

	local planCfg = EquipmentConfig.instance:GetEquipLevelInfos(equipCfg.equipmentLvStrategy)

	if planCfg == nil then
		return index
	end

	while planCfg[index] do
		index = index + 1
	end

	index = index - 1

	return index
end

function PetEquipModel:GetEquipNowBaseAttrInfoById(equipInfo)
	if equipInfo == nil or checknumber(equipInfo.attrPlan) < 1 then
		return
	end

	local planList = EquipmentConfig.instance:GetEquipLevelInfos(equipInfo.attrPlan)

	if planList == nil then
		return
	end

	local baseInfo = {
		starCount = planList[0].level,
		levelExp = planList[0].exp,
		attrList = self:AnalysisInfoMoAttr(planList[0].propertyApp),
		attrAddList = self:AnalysisInfoMoAttr(planList[0].propertyApp2)
	}

	if checknumber(equipInfo.exclRaceId) > 0 then
		baseInfo.attrExclList = self:AnalysisInfoMoAttr(planList[0].racePropertyApp)
	end

	local lv = checknumber(equipInfo.starCount)

	if lv < 1 or planList[lv] == nil then
		return baseInfo, baseInfo
	end

	local nowInfo = {
		starCount = planList[lv].level,
		levelExp = planList[lv].exp,
		attrList = self:AnalysisInfoMoAttr(planList[lv].propertyApp),
		attrAddList = self:AnalysisInfoMoAttr(planList[lv].propertyApp2)
	}

	if checknumber(equipInfo.exclRaceId) > 0 then
		nowInfo.attrExclList = self:AnalysisInfoMoAttr(planList[lv].racePropertyApp)
	end

	return baseInfo, nowInfo
end

function PetEquipModel:getStrengthenEquipList(equipInfo, sifterList)
	if equipInfo == nil then
		return {}, {}
	end

	local isSifter = false

	for planId, list in pairs(sifterList or {}) do
		if planId and list and #list > 0 then
			isSifter = true

			break
		end
	end

	local tempList = {}

	if not isSifter then
		local sttMatList = EquipmentConfig.instance:GetStrengtheningMaterial()

		if sttMatList and #sttMatList > 0 then
			for i = 1, #sttMatList do
				local baseId = sttMatList[i].matId
				local info = MaterialModel.instance:getMaterialMo(MatType.Item, baseId)
				local cfg = MaterialMgr.getMatCfg(MatType.Item, baseId)

				if info and info.num > 0 then
					if cfg then
						if not cfg.name then
							if cfg then
								if not cfg.qualityBase then
									local quaNum = 0

									if cfg then
										if not cfg.icon then
											local icon = "icon_" .. baseId

											table.insert(tempList, {
												useCount = 0,
												isEquip = false,
												sort = 1,
												baseId = baseId,
												onlyId = info.id,
												quaNum = quaNum,
												icon = icon,
												quality = cfg.quality,
												count = info.num,
												allExp = sttMatList[i].matExp
											})
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	local ssList = {}
	local aeList = {}

	for _, item in pairs(self.allEquipInfoList or {}) do
		if item and not item.isWear and not item:isEquipArtifact() and item.onlyId ~= equipInfo.onlyId and item.quality <= equipInfo.quality and self:_isConformEquipSifter(item, sifterList) then
			if item.haveAllExp == 0 then
				if ssList[item.baseId] then
					table.insert(ssList[item.baseId].countList, item.onlyId)
				else
					ssList[item.baseId] = {
						useCount = 0,
						isEquip = true,
						sort = 2,
						baseId = item.baseId,
						onlyId = item.onlyId,
						quaNum = item.qualityBase,
						quality = item.quality,
						icon = item.icon,
						countList = {
							item.onlyId
						},
						starCount = item.starCount,
						allExp = item.equalExp,
						power = item.commPower,
						attrType = item.attrType
					}
				end
			else
				table.insert(aeList, {
					useCount = 0,
					isEquip = true,
					sort = 2,
					baseId = item.baseId,
					onlyId = item.onlyId,
					quaNum = item.qualityBase,
					quality = item.quality,
					icon = item.icon,
					starCount = item.starCount,
					allExp = item.equalExp + item.haveAllExp,
					power = item.commPower,
					attrType = item.attrType
				})
			end
		end
	end

	for _, info in pairs(ssList or {}) do
		if info and #info.countList > 0 then
			table.insert(aeList, info)
		end
	end

	ssList = nil

	return tempList, aeList
end

function PetEquipModel:GetEquipNowNextAttrList(equipInfo)
	if equipInfo == nil then
		return
	end

	local planList = EquipmentConfig.instance:GetEquipLevelInfos(equipInfo.attrPlan)
	local tempExp = equipInfo.haveAllExp + self.fictitiousExp
	local nowPlan = planList[0]

	if tempExp > 0 then
		local index = 0

		while planList[index] do
			if tempExp < planList[index].exp then
				break
			else
				nowPlan = planList[index]
			end

			index = index + 1
		end
	end

	local nowInfo = {
		starCount = nowPlan.level,
		levelExp = nowPlan.exp,
		attrList = self:AnalysisInfoMoAttr(nowPlan.propertyApp),
		attrAddList = self:AnalysisInfoMoAttr(nowPlan.propertyApp2)
	}
	local nextInfo

	if planList[nowPlan.level + 1] then
		nextInfo = {
			starCount = planList[nowPlan.level + 1].level,
			levelExp = planList[nowPlan.level + 1].exp,
			attrList = self:AnalysisInfoMoAttr(planList[nowPlan.level + 1].propertyApp),
			attrAddList = self:AnalysisInfoMoAttr(planList[nowPlan.level + 1].propertyApp2)
		}
	end

	if checknumber(equipInfo.exclRaceId) > 0 then
		nowInfo.attrExclList = self:AnalysisInfoMoAttr(nowPlan.racePropertyApp)

		if nextInfo then
			nextInfo.attrExclList = self:AnalysisInfoMoAttr(planList[nowPlan.level + 1].racePropertyApp)
		end
	end

	return nowInfo, nextInfo
end

function PetEquipModel:IsHaveBestEquip(pos, petInfo, equipInfo)
	if checknumber(pos) < 1 or petInfo == nil or self.allEquipInfoList == nil then
		return false
	end

	local petCfg = CharacterConfig.instance:getPetCo(petInfo.raceId)

	if petCfg == nil then
		return false
	end

	local oldPower, oldTypeNum = self:_getEquipPowerTypeNum(equipInfo, petInfo, true)
	local typeNum = 0
	local count = 0

	for _, info in pairs(self.allEquipInfoList) do
		if info and info.wearPos == pos and not info.isWear and petInfo.level >= checknumber(info.limitLevel) then
			local isAdd = true

			if info:isEquipArtifact() then
				isAdd = self:_isPetCanArtifact(info.sqSkinId, petInfo.curFaceId)
			elseif info.jobTypeList and #info.jobTypeList > 0 then
				isAdd = false

				for _, str in pairs(info.jobTypeList) do
					if PetSkinConfig.instance:checkHasJob(petInfo.curFaceId, str) then
						isAdd = true
					end
				end
			end

			if isAdd then
				count, typeNum = self:_getEquipPowerTypeNum(info, petInfo)

				if oldPower < count or count == oldPower and oldTypeNum < typeNum then
					return true
				end
			end
		end
	end

	return false
end

function PetEquipModel:petExclEquipList(raceId)
	raceId = checknumber(raceId)

	local exclList = {}

	for _, mo in pairs(self.allEquipInfoList) do
		if mo and checknumber(mo.exclRaceId) == raceId then
			table.insert(exclList, mo)
		end
	end

	return exclList
end

function PetEquipModel:_getEquipPowerTypeNum(infoMo, petInfo, isWear)
	if infoMo == nil then
		return 0, 0
	end

	local typeNum = 0
	local power = infoMo.commPower

	if infoMo:isEquipArtifact() then
		return power, typeNum
	end

	if checknumber(infoMo.exclRaceId) > 0 then
		if isWear then
			typeNum = infoMo:isEnableWearExcl() and 3 or 1
		elseif petInfo then
			typeNum = infoMo:isEnableIdleExcl(petInfo.raceId) and 3 or 1
		end
	elseif petInfo and petInfo:checkHasRace(infoMo.attrType) then
		typeNum = 2
	end

	if typeNum == 2 then
		power = infoMo.addPower
	elseif typeNum == 3 then
		power = infoMo.exclPower
	end

	return power, typeNum
end

function PetEquipModel:GetTemporaryEquip(baseId, lv, exclInfo)
	if checknumber(baseId) < 1 then
		return
	end

	local infoMo = EquipInfoMo.New(nil, MatType.Equipment)

	infoMo:GetTemporaryEquip(baseId, lv, exclInfo)

	return infoMo
end

function PetEquipModel:GetAllDecorationInfo()
	return self.dectInfoList
end

function PetEquipModel:GetDecorationInfoByOnlyId(onlyId)
	if self.dectInfoList == nil or self.dectInfoList[onlyId] == nil then
		return nil
	end

	return self.dectInfoList[onlyId]
end

function PetEquipModel:GetDecorationInfosByBaseId(baseId)
	if self.dectInfoList == nil or checknumber(baseId) < 1 then
		return nil
	end

	local list = {}

	for _, info in pairs(self.dectInfoList or {}) do
		if info and info.baseId == baseId then
			table.insert(list, info)
		end
	end

	return list
end

function PetEquipModel:SetAllDecorationInfo(data, isInit)
	if isInit then
		self.dectInfoList = nil
	end

	if data == nil then
		return
	end

	self.dectInfoList = self.dectInfoList or {}

	local addList, updList, deleList = {}, {}, {}

	for _, info in pairs(data) do
		if info and checknumber(info.decorationId) > 0 then
			if info.deleted then
				table.insert(deleList, info.decorationId)
				self:DeleteDecorationInfo(info.decorationId)
			elseif self.dectInfoList[info.decorationId] then
				self.dectInfoList[info.decorationId]:InitEquipInfo(info)
				table.insert(updList, info.decorationId)
			elseif self:AddDecorationInfo(info) then
				table.insert(addList, info.decorationId)
			end
		end
	end

	if addList and #addList > 0 then
		local info = {
			updataType = "add",
			matType = MatType.Decoration,
			list = addList
		}

		GlobalDispatcher:dispatch(GlobalNotify.PET_EQUIP_CHANGES, info)
	end

	if updList and #updList > 0 then
		local info = {
			updataType = "upd",
			matType = MatType.Decoration,
			list = updList
		}

		GlobalDispatcher:dispatch(GlobalNotify.PET_EQUIP_CHANGES, info)
	end

	if deleList and #deleList > 0 then
		local info = {
			updataType = "del",
			matType = MatType.Decoration,
			list = deleList
		}

		GlobalDispatcher:dispatch(GlobalNotify.PET_EQUIP_CHANGES, info)
	end
end

function PetEquipModel:AddDecorationInfo(data)
	if data == nil or checknumber(data.decorationId) <= 0 or checknumber(data.defineId) <= 0 then
		return false
	end

	if self.dectInfoList == nil then
		self.dectInfoList = {}
	end

	local info = EquipInfoMo.New(data, MatType.Decoration)

	if info and checknumber(info.onlyId) > 0 then
		self.dectInfoList[info.onlyId] = info

		return true
	else
		printError("sr--- PetEquipModel:AddDecorationInfo()   添加装备失败  baseId = ", data.defineId, data.decorationId)

		return false
	end
end

function PetEquipModel:DeleteDecorationInfo(onlyId)
	if self.dectInfoList == nil then
		return
	end

	self.dectInfoList[onlyId] = nil

	if next(self.dectInfoList) == nil then
		self.dectInfoList = nil
	end
end

function PetEquipModel:GetDecorationByPetId(petId)
	if checknumber(petId) < 1 then
		return
	end

	local petInfo = BagPetsController.instance:getPet(petId)

	if petInfo == nil then
		return
	end

	return self:GetWearDecorationByPetInfo(petInfo)
end

function PetEquipModel:GetWearDecorationByPetInfo(petInfo)
	if petInfo == nil or petInfo.decoration == nil or checknumber(petInfo.decoration.id) < 1 then
		return
	end

	local info = self:GetDecorationInfoByOnlyId(petInfo.decoration.id)

	if info == nil then
		printError("sr--- PetEquipModel:GetWearDecorationByPetInfo()   精灵饰品空 petId = ", petInfo.petId)

		return
	end

	return info
end

function PetEquipModel:GetEquipFuncIsUnlock(isTips)
	if not self.isOpenDecorations then
		if isTips then
			FloatWordMgr.instance:show(lang("text_equip_not_open"))
		end

		return false
	end

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(50)

	if cfg == nil then
		if isTips then
			FloatWordMgr.instance:show("此功能还未开启，请继续前往做任务！")
		end

		return false
	end

	if not FuncOpenController.instance:getConditionReached(cfg.openCondition, cfg.openTime) then
		if isTips then
			FloatWordMgr.instance:show(lang(cfg.lockedTips))
		end

		return false
	end

	return true
end

function PetEquipModel:GetDecorationFuncIsUnlock(isTips)
	if not self.isOpenDecorations then
		if isTips then
			FloatWordMgr.instance:show(lang("text_equip_not_open"))
		end

		return false
	end

	if not self:GetEquipFuncIsUnlock(isTips) then
		return false
	end

	local funcId = DecorationConfig.instance:GetOpenFuncId()
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

	if cfg == nil then
		if isTips then
			FloatWordMgr.instance:show("此功能还未开启，请继续前往做任务！")
		end

		return false
	end

	if not FuncOpenController.instance:getConditionReached(cfg.openCondition, cfg.openTime) then
		if isTips then
			FloatWordMgr.instance:show(lang(cfg.lockedTips))
		end

		return false
	end

	return true
end

function PetEquipModel:IsNengStrengthenDecorat(onlyId)
	if not self.isOpenDecorations then
		return false
	end

	local infoMo = self:GetDecorationInfoByOnlyId(onlyId)

	if infoMo == nil then
		return false
	end

	local sttyId = DecorationConfig.instance:GetStrategyPlanId(infoMo.attrPlan, infoMo.mainAttrName)

	if checknumber(sttyId) < 1 then
		return false
	end

	local planList = DecorationConfig.instance:GetStrategyCfgs(sttyId)

	if planList == nil then
		return
	end

	return planList[1] ~= nil
end

function PetEquipModel:IsHaveBestDecoration(petInfo)
	if not self.isOpenDecorations then
		return false
	end

	if petInfo == nil or self.dectInfoList == nil then
		return false
	end

	local petCfg = CharacterConfig.instance:getPetCo(petInfo.raceId)

	if petCfg == nil then
		return false
	end

	local info = self:GetWearDecorationByPetInfo(petInfo)

	for _, item in pairs(self.dectInfoList or {}) do
		if item and item.equipPetId < 0 and not item.isWear and petInfo.level >= checknumber(item.limitLevel) then
			local isSame = false

			if item.jobTypeList == nil or #item.jobTypeList == 0 then
				isSame = true
			else
				local elementAttr = PetSkinConfig.instance:getAllElementAttrs(petInfo.curFaceId)

				if self:IsHaveSameRaceType(item.jobTypeList, elementAttr) then
					isSame = true
				end
			end

			if isSame and (info == nil or info.commPower < item.commPower) then
				return true
			end
		end
	end

	return false
end

function PetEquipModel:GetDecoratMainBaseAttr(onlyId)
	if checknumber(onlyId) < 1 then
		return 0
	end

	local infoMo = self:GetDecorationInfoByOnlyId(onlyId)

	if infoMo == nil then
		return 0
	end

	local sttyId = DecorationConfig.instance:GetStrategyPlanId(infoMo.attrPlan, infoMo.mainAttrName)

	if checknumber(sttyId) < 1 then
		return 0
	end

	local planList = DecorationConfig.instance:GetStrategyCfgs(sttyId)

	if planList == nil or planList[0] == nil then
		return 0
	end

	return planList[0].addPropValue
end

function PetEquipModel:getStrengthenDecoratList()
	local sttMatList = DecorationConfig.instance:GetStrengtheningMaterial()

	if sttMatList == nil or #sttMatList == 0 then
		return {}
	end

	local tempList = {}

	for i = 1, #sttMatList do
		local baseId = sttMatList[i].matId
		local info = MaterialModel.instance:getMaterialMo(MatType.Item, baseId)

		if info and info.num > 0 then
			local cfg = MaterialMgr.getMatCfg(MatType.Item, baseId)

			if cfg then
				if not cfg.name then
					if cfg then
						if not cfg.qualityBase then
							local quaNum = 0

							if cfg then
								if not cfg.icon then
									local icon = "icon_" .. baseId

									table.insert(tempList, {
										useCount = 0,
										isEquip = false,
										sort = 1,
										baseId = baseId,
										onlyId = info.id,
										quaNum = quaNum,
										icon = icon,
										quality = cfg.quality,
										count = info.num,
										allExp = sttMatList[i].matExp
									})
								end
							end
						end
					end
				end
			end
		end
	end

	return tempList
end

function PetEquipModel:GetDecoratNextMainAttrValue(dectInfo)
	if dectInfo == nil or dectInfo.addAttrs == nil then
		return nil
	end

	local sttyId = DecorationConfig.instance:GetStrategyPlanId(dectInfo.attrPlan, dectInfo.mainAttrName)

	if checknumber(sttyId) < 1 then
		return nil
	end

	local planList = DecorationConfig.instance:GetStrategyCfgs(sttyId)
	local tempExp = dectInfo.haveAllExp + self.fictitiousExp
	local nowPlan = planList[0]
	local leijiaValue = 0

	if tempExp > 0 then
		local index = 0

		while planList[index] do
			if tempExp < planList[index].exp then
				break
			else
				nowPlan = planList[index]

				if index > dectInfo.starCount then
					leijiaValue = leijiaValue + planList[index].addPropValue
				end
			end

			index = index + 1
		end
	end

	local nextPlan = DecorationConfig.instance:GetStrategyCfgs(nowPlan.id, nowPlan.level + 1)
	local data = {
		isMax = true,
		isFuAttr = false,
		nowLv = nowPlan.level,
		nextLv = nowPlan.level,
		nowExp = nowPlan.exp,
		nextExp = nowPlan.exp,
		attrValue = nowPlan.addPropValue,
		addValue = leijiaValue
	}
	local targeLv = nowPlan.level

	if nextPlan then
		data.nextLv = nextPlan.level
		data.nextExp = nextPlan.exp
		data.attrValue = nextPlan.addPropValue
		data.isMax = false
		targeLv = nextPlan.level
	end

	data.isFuAttr = self:IsDecoratAddViceAttr(sttyId, dectInfo.starCount, targeLv)

	return data
end

function PetEquipModel:IsDecoratAddViceAttr(sttyId, lv, targeLv)
	if checknumber(sttyId) < 1 then
		return false
	end

	lv = lv or 0
	targeLv = targeLv or lv

	for i = lv, targeLv do
		if lv < i then
			local cfg = DecorationConfig.instance:GetStrategyCfgs(sttyId, i)

			if cfg and checknumber(cfg.percent) >= 10000 then
				return true
			end
		end
	end

	return false
end

function PetEquipModel:GetTemporaryDectn(baseId, lv, attrs)
	if checknumber(baseId) < 1 then
		return
	end

	local infoMo = EquipInfoMo.New(nil, MatType.Decoration)

	infoMo:GetTemporaryDectn(baseId, lv, attrs)

	return infoMo
end

function PetEquipModel:IsHaveSameRaceType(decJobList, petJobLits)
	if decJobList == nil or #decJobList == 0 then
		return true
	end

	if petJobLits == nil or #petJobLits == 0 then
		return true
	end

	for i = 1, #decJobList do
		for j = 1, #petJobLits do
			if decJobList[i] == petJobLits[j] then
				return true
			end
		end
	end

	return false
end

function PetEquipModel:getArtifactAttrDescShow(infoMo, isSee)
	local isMulti = false
	local str = lang("text_equip_desc_35")

	if infoMo == nil then
		return str
	end

	local cfg = EquipmentConfig.instance:GetEquipDefineInfoById(infoMo.baseId)

	if cfg == nil or string.nilorempty(cfg.throneDes) then
		return str
	end

	local maxQuality = 9

	if isSee then
		str = self:_getWholeArtifactAttrDesc(infoMo.wearPos, infoMo.sqSkinId, 0, maxQuality)
	else
		local petMo = BagPetsController.instance:getPet(infoMo.equipPetId)

		if petMo == nil or petMo.equipments == nil then
			return str, isMulti
		end

		local otherPos = infoMo.wearPos == 5 and 6 or 5

		if petMo.equipments[otherPos] == nil then
			str = self:_getWholeArtifactAttrDesc(infoMo.wearPos, infoMo.sqSkinId, 0, maxQuality)
		else
			local otherInfoMo = self:GetEquipInfo(petMo.equipments[otherPos].id)

			if otherInfoMo == nil or not otherInfoMo.isWear then
				str = self:_getWholeArtifactAttrDesc(infoMo.wearPos, infoMo.sqSkinId, 0, maxQuality)
			else
				local highlightQuality = Mathf.Min(infoMo.quality, otherInfoMo.quality)

				str = self:_getWholeArtifactAttrDesc(infoMo.wearPos, infoMo.sqSkinId, highlightQuality, maxQuality)
			end
		end
	end

	return str, isMulti
end

function PetEquipModel:getArtifactAttrName(quality, symbol)
	quality = checknumber(quality)

	if quality < 8 then
		return
	end

	local name = "穿戴神器均为橙"

	if quality == 9 then
		name = "穿戴神器均为橙+1"
	elseif quality == 10 then
		name = "穿戴神器均为橙+2"
	elseif quality == 11 then
		name = "穿戴神器均为橙+3"
	elseif quality == 12 then
		name = "穿戴神器均为橙+4"
	end

	if not string.nilorempty(symbol) then
		name = name .. symbol
	end

	return name
end

function PetEquipModel:_getArtifactAttrDesc(pos, skinId, quality, isEnable)
	local list = EquipmentConfig.instance:getArtifactIds(skinId, pos)

	if list == nil or #list == 0 then
		return
	end

	local cfg

	for i = 1, #list do
		cfg = EquipmentConfig.instance:GetEquipDefineInfoById(list[i])

		if cfg and cfg.positionType == pos and cfg.throneRelatedSkinId == skinId and cfg.quality == quality then
			if isEnable then
				return string.format("<color=#B3484BFF>%s\n%s</color>", self:getArtifactAttrName(quality), cfg.throneDes)
			else
				return string.format("<color=#8c8c8c>%s\n%s</color>", self:getArtifactAttrName(quality), cfg.throneDes)
			end
		end
	end

	return nil
end

function PetEquipModel:_getWholeArtifactAttrDesc(pos, skinId, highlightQuality, maxQuality)
	local list = EquipmentConfig.instance:getArtifactIds(skinId, pos)

	if list == nil or #list == 0 then
		return
	end

	local cfg
	local str = ""

	for i = 1, #list do
		cfg = EquipmentConfig.instance:GetEquipDefineInfoById(list[i])

		if cfg and maxQuality >= cfg.quality then
			str = cfg.quality == highlightQuality and str .. string.format("<color=#%sFF>%s\n%s</color>", ColorConst.Green2, self:getArtifactAttrName(cfg.quality), cfg.throneDes) or str .. string.format("<color=#8c8c8c>%s\n%s</color>", self:getArtifactAttrName(cfg.quality), cfg.throneDes)

			if maxQuality > cfg.quality then
				str = str .. "\n\n"
			else
				break
			end
		end
	end

	return str
end

function PetEquipModel:_getEquipQualityDesc(quality)
	quality = checknumber(quality)

	if quality == 4 or quality == 6 or quality == 9 then
		return "+1"
	end

	if quality == 7 or quality == 10 then
		return "+2"
	end

	if quality == 11 then
		return "+3"
	end

	return nil
end

function PetEquipModel:GetChoiseQualityPlanId(matType, isSttn)
	local planId = 0

	if matType == MatType.Equipment then
		planId = isSttn and EquipmentConfig.instance:GetStrtQuaPlanId() or EquipmentConfig.instance:GetRecyQuaPlanId()
	elseif matType == MatType.Decoration then
		planId = isSttn and DecorationConfig.instance:GetStrtQuaPlanId() or DecorationConfig.instance:GetRecyQuaPlanId()
	end

	if checknumber(planId) <= 0 then
		return nil, nil
	end

	local list = EquipmentConfig.instance:GetEquipQualityPlans(planId)

	if list and #list > 0 then
		return planId, list
	end

	return nil, nil
end

function PetEquipModel:GetInfoMoByOnlyId(onlyId, matType)
	if checknumber(onlyId) < 1 then
		return nil
	end

	if matType == MatType.Equipment then
		return self:GetEquipInfo(onlyId)
	end

	if matType == MatType.Decoration then
		return self:GetDecorationInfoByOnlyId(onlyId)
	end

	return nil
end

function PetEquipModel:ClickTakeoffAllEquips(petInfo)
	if petInfo == nil then
		return
	end

	local unloadList = {}

	for pos, tem in pairs(petInfo.equipments or {}) do
		local id = tem.id

		if pos and id and id > 0 then
			table.insert(unloadList, {
				pos = pos,
				equipId = id
			})
		end
	end

	if petInfo.decoration and checknumber(petInfo.decoration.id) > 0 then
		table.insert(unloadList, {
			pos = 5,
			equipId = petInfo.decoration.id
		})
	end

	return unloadList
end

function PetEquipModel:getUnloadListInEquips(petInfo)
	local unloadList = {}

	if petInfo then
		for pos, tem in pairs(petInfo.equipments or {}) do
			local id = tem.id

			if pos and id and id > 0 then
				table.insert(unloadList, id)
			end
		end
	end

	return unloadList
end

function PetEquipModel:ClickWearAllBestEquips(petInfo)
	local equipList = {
		{
			typeNum = 0,
			poewr = -1,
			isBest = false
		},
		{
			typeNum = 0,
			poewr = -1,
			isBest = false
		},
		{
			typeNum = 0,
			poewr = -1,
			isBest = false
		},
		{
			typeNum = 0,
			poewr = -1,
			isBest = false
		},
		{
			typeNum = 0,
			poewr = -1,
			isBest = false
		},
		{
			typeNum = 0,
			poewr = -1,
			isBest = false
		}
	}

	if petInfo == nil then
		return equipList, nil, false, false
	end

	local petCfg = CharacterConfig.instance:getPetCo(petInfo.raceId)
	local typeNum = 0
	local count = 0

	for _, item in pairs(self.allEquipInfoList or {}) do
		if item and not item.isWear and item.limitLevel <= petInfo.level then
			local isAdd = true

			if item:isEquipArtifact() then
				isAdd = self:_isPetCanArtifact(item.sqSkinId, petInfo.curFaceId)
			elseif item.jobTypeList and #item.jobTypeList > 0 then
				isAdd = false

				for _, str in pairs(item.jobTypeList) do
					if PetSkinConfig.instance:checkHasJob(petInfo.curFaceId, str) then
						isAdd = true

						break
					end
				end
			end

			if isAdd then
				count, typeNum = self:_getEquipPowerTypeNum(item, petInfo)

				if count > equipList[item.wearPos].poewr or equipList[item.wearPos].poewr == count and typeNum > equipList[item.wearPos].typeNum then
					equipList[item.wearPos].info = item
					equipList[item.wearPos].isBest = true
					equipList[item.wearPos].poewr = count
					equipList[item.wearPos].typeNum = typeNum
				end
			end
		end
	end

	for pos, tem in pairs(petInfo.equipments or {}) do
		if pos and checknumber(tem.id) > 0 then
			local info = self:GetEquipInfo(tem.id)

			if info then
				count, typeNum = self:_getEquipPowerTypeNum(info, petInfo, true)

				if count >= equipList[pos].poewr or equipList[pos].poewr == count and typeNum >= equipList[pos].typeNum then
					equipList[pos] = {
						isBest = false,
						poewr = count,
						info = info,
						typeNum = typeNum
					}
				end
			end
		end
	end

	local isHave = false
	local isBest = false

	for _, item in pairs(equipList) do
		if item then
			if item.isBest then
				isBest = true
			end

			if item.info then
				isHave = true
			end
		end
	end

	return equipList, dectInfo, isHave, isBest
end

function PetEquipModel:_isPetCanArtifact(eqSkinId, petSkinId)
	eqSkinId = checknumber(eqSkinId)
	petSkinId = checknumber(petSkinId)

	if eqSkinId == petSkinId then
		return true
	end

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(petSkinId)

	if petSkinCfg == nil then
		return false
	end

	local eqSkinCfg = PetSkinConfig.instance:getPetSkinCfg(eqSkinId)

	if eqSkinCfg == nil then
		return false
	end

	if petSkinCfg.raceId == eqSkinCfg.raceId and petSkinCfg.bodyType == eqSkinCfg.bodyType then
		return true
	end

	return false
end

function PetEquipModel:SetCurrentUpgradeInfo(info)
	self.upgradeInfo = info
end

function PetEquipModel:GetCurrentUpgradeInfo()
	return self.upgradeInfo
end

function PetEquipModel:IsNengStrengthenInfoMo(onlyId, matType)
	if checknumber(onlyId) < 1 then
		return false
	end

	if matType == MatType.Equipment then
		return self:isNengStrengthenEquip(onlyId)
	end

	if matType == MatType.Decoration then
		return self:IsNengStrengthenDecorat(onlyId)
	end

	return false
end

function PetEquipModel:isKeyiStrengthenInfoMo(infoMo, isSelectList)
	if infoMo == nil then
		return false
	end

	local maxLevel = self:GetInfoMoMaxLevel(infoMo.onlyId, infoMo.matType)

	if maxLevel < 1 or maxLevel <= infoMo.starCount then
		return false
	end

	if isSelectList then
		return true
	end

	if infoMo:GetEquipExclRaceId() <= 0 then
		return self:_isHaveStrengthenGoods(infoMo.matType)
	end

	local matInfo = EquipmentConfig.instance:GetExclusiveMaterial(infoMo.wearPos)

	if matInfo and checknumber(matInfo.id) <= 0 then
		return false
	end

	local count = MaterialModel.instance:getMaterialsNumber(MatType.Item, matInfo.id)

	return checknumber(count) > 0
end

function PetEquipModel:isCanTupoInfoMo(infoMo, isSelectList)
	if infoMo == nil then
		return false
	end

	if infoMo:isCanTupo() then
		if infoMo:isEquipArtifact() then
			local count = 0

			for _, mo in pairs(self.allEquipInfoList or {}) do
				if mo and not mo:isWearEquip() and mo.onlyId ~= infoMo.onlyId and mo.baseId == infoMo.baseId then
					count = count + 1

					if count >= 3 then
						return true
					end
				end
			end
		elseif infoMo.quality == 9 then
			local goodConsume = EquipmentConfig.instance:getTupoGoodConsume()
			local itemStr = goodConsume[infoMo.wearPos]

			if MaterialMgr.getMatEnough(itemStr) then
				local count = 0

				for _, mo in pairs(self.allEquipInfoList or {}) do
					if mo and not mo:isWearEquip() and mo.onlyId ~= infoMo.onlyId and mo.baseId == infoMo.baseId then
						count = count + 1

						if count >= 2 then
							return true
						end
					end
				end
			end
		elseif infoMo.quality == 8 then
			local count = 0

			for _, mo in pairs(self.allEquipInfoList or {}) do
				if mo and not mo:isWearEquip() and mo.onlyId ~= infoMo.onlyId and mo.beforeNum == infoMo.beforeNum then
					count = count + 1

					if count >= 3 then
						return true
					end
				end
			end
		end
	end

	return false
end

function PetEquipModel:_isHaveStrengthenGoods(matType)
	local sttMatList

	if matType == MatType.Equipment then
		sttMatList = EquipmentConfig.instance:GetStrengtheningMaterial()
	elseif matType == MatType.Decoration then
		if not self.isOpenDecorations then
			return false
		end

		sttMatList = DecorationConfig.instance:GetStrengtheningMaterial()
	end

	if sttMatList == nil or #sttMatList < 1 then
		return false
	end

	for i = 1, #sttMatList do
		if MaterialModel.instance:getMaterialsNumber(MatType.Item, sttMatList[i].matId) > 0 then
			return true
		end
	end

	return false
end

function PetEquipModel:GetInfoMoMaxLevel(onlyId, matType)
	local planCfg

	if matType == MatType.Equipment then
		local infoMo = self:GetEquipInfo(onlyId)

		if infoMo then
			planCfg = EquipmentConfig.instance:GetEquipLevelInfos(infoMo.attrPlan)
		end
	elseif matType == MatType.Decoration then
		local infoMo = self:GetDecorationInfoByOnlyId(onlyId)

		if infoMo then
			local sttyId = DecorationConfig.instance:GetStrategyPlanId(infoMo.attrPlan, infoMo.mainAttrName)

			planCfg = DecorationConfig.instance:GetStrategyCfgs(sttyId)
		end
	end

	local index = 0

	if planCfg == nil then
		return index
	end

	while planCfg[index] do
		index = index + 1
	end

	index = index - 1

	return index
end

function PetEquipModel:AnalysisInfoMoAttr(attrStr, isNotSort)
	if string.nilorempty(attrStr) then
		return
	end

	local list = string.split(attrStr, "#")

	if list == nil or #list == 0 then
		return
	end

	local attrList = {}

	for i = 1, #list do
		local attrs = string.split(list[i], "+")

		table.insert(attrList, {
			index = self:GetChineseAttrIndex(attrs[1]),
			name = attrs[1],
			extCount = tonumber(attrs[2])
		})
	end

	if not isNotSort and #attrList > 1 then
		table.sort(attrList, function(a, b)
			return a.index < b.index
		end)
	end

	return attrList
end

function PetEquipModel:GetChineseAttrIndex(str)
	local num = 0

	if not string.nilorempty(str) then
		local ind = table.indexof(GameEnum.AttrTypeName, str)

		if ind ~= false then
			num = ind
		end
	end

	return num
end

function PetEquipModel:GetWearInfoMoList(wearPos, petInfo, isComm, showAll)
	local infoList = {}

	if checknumber(wearPos) < 1 or petInfo == nil then
		return infoList
	end

	if self.allEquipInfoList == nil then
		return infoList
	end

	for _, item in pairs(self.allEquipInfoList) do
		if item and item.wearPos == wearPos and (showAll or item.equipPetId ~= petInfo.petId) then
			if wearPos >= 5 then
				if self:_isPetCanArtifact(item.sqSkinId, petInfo.curFaceId) then
					table.insert(infoList, item)
				end
			elseif item.jobTypeList == nil or #item.jobTypeList == 0 then
				if isComm then
					table.insert(infoList, item)
				end
			else
				for _, str in pairs(item.jobTypeList) do
					if PetSkinConfig.instance:checkHasJob(petInfo.curFaceId, str) then
						table.insert(infoList, item)
					end
				end
			end
		end
	end

	local index = PetSkinConfig.instance:getFisrtEleAttrIdx(petInfo.curFaceId)
	local petLevel = petInfo.level

	ArraySort.sortOn(infoList, {
		function(a)
			return (petLevel >= a.limitLevel or nil) and (a.limitLevel or -1)
		end,
		function(a)
			return a.qualityBase
		end,
		function(a)
			local aIdx = GameEnum.Races[a.attrType]

			if index == aIdx then
				return -1
			elseif index == GameEnum.RaceType.Yuan then
				if aIdx == 0 then
					return 9999
				end

				return aIdx
			else
				return aIdx
			end
		end,
		"commPower",
		"quality",
		"starCount",
		"onlyId"
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.NUMERIC,
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.DESCENDING
	})

	return infoList
end

function PetEquipModel:getStrengthenMaterials(infoMo, sifterList)
	local sttMatList, equipList = {}, {}

	if infoMo.matType == MatType.Equipment then
		if infoMo == nil then
			return {}
		end

		sttMatList, equipList = self:getStrengthenEquipList(infoMo, sifterList)
	elseif infoMo.matType == MatType.Decoration then
		sttMatList = self:getStrengthenDecoratList()
	end

	if equipList and #equipList > 0 then
		for i = 1, #equipList do
			if equipList[i] then
				table.insert(sttMatList, equipList[i])
			end
		end
	end

	if sttMatList and #sttMatList > 1 then
		table.sort(sttMatList, function(a, b)
			if a.sort == b.sort then
				if a.quality == b.quality then
					return a.onlyId < b.onlyId
				end

				return a.quality < b.quality
			end

			return a.sort < b.sort
		end)
	end

	return sttMatList
end

function PetEquipModel:SetStrengthenFictitiousExp(value)
	if value == nil or value == 0 then
		self.fictitiousExp = 0

		return
	end

	self.fictitiousExp = self.fictitiousExp + value
end

function PetEquipModel:GetStrengthenFictitiousExp()
	return self.fictitiousExp
end

function PetEquipModel:GetAllInfoMoList(matType)
	matType = matType or MatType.Equipment

	local allList

	if matType == MatType.Equipment then
		allList = self.allEquipInfoList
	elseif matType == MatType.Decoration then
		allList = self.dectInfoList
	end

	if allList == nil then
		return
	end

	local list = {}

	for _, item in pairs(allList) do
		if item and checknumber(item.onlyId) > 0 then
			table.insert(list, item)
		end
	end

	return list
end

function PetEquipModel:GetWearEquipAllPower(petInfo, equipList)
	local allPower = 0

	if equipList == nil or #equipList == 0 then
		equipList = self:GetWearEquipInfosByPetInfo(petInfo)
	end

	if equipList and #equipList > 0 then
		for i = 1, #equipList do
			if equipList[i].isWear and equipList[i].info then
				allPower = equipList[i].isExclSttr and allPower + equipList[i].info.exclPower or equipList[i].isAddSttr and allPower + equipList[i].info.addPower or allPower + equipList[i].info.commPower
				allPower = allPower + equipList[i].info.goodPower
			end
		end
	end

	local info = self:GetWearDecorationByPetInfo(petInfo)

	if info then
		allPower = allPower + info.commPower
	end

	return allPower
end

function PetEquipModel:GetPetEquipPosRedPoint(petId, index, redType)
	index = checknumber(index)

	if index < PetEquipModel.EquipPos.EquipArms or index > PetEquipModel.EquipPos.EquipExclusive then
		return false
	end

	local petInfo = petId == nil and BagPetsController.instance:GetCurPetMo() or BagPetsController.instance:getPet(petId)

	if self.allEquipInfoList == nil or petInfo == nil then
		return false
	end

	local wearEquipInfo

	if petInfo.equipments and petInfo.equipments[index] and petInfo.equipments[index].id then
		wearEquipInfo = self:GetEquipInfo(petInfo.equipments[index].id)
	end

	redType = redType or PetEquipModel.PetEquipRedType.Wear

	if redType == PetEquipModel.PetEquipRedType.Wear then
		return self:IsHaveBestEquip(index, petInfo, wearEquipInfo)
	elseif redType == PetEquipModel.PetEquipRedType.Strengthen then
		return self:isKeyiStrengthenInfoMo(wearEquipInfo)
	elseif redType == PetEquipModel.PetEquipRedType.TuPo then
		return self:isCanTupoInfoMo(wearEquipInfo)
	elseif redType == PetEquipModel.PetEquipRedType.All then
		return self:IsHaveBestEquip(index, petInfo, wearEquipInfo) or self:isKeyiStrengthenInfoMo(wearEquipInfo) or self:isCanTupoInfoMo(wearEquipInfo)
	end

	return false
end

function PetEquipModel:GetPetCardRedPoint(petId, redType)
	if self:GetPetEquipPosRedPoint(petId, PetEquipModel.EquipPos.EquipArms, redType) then
		return true
	end

	if self:GetPetEquipPosRedPoint(petId, PetEquipModel.EquipPos.EquipClothes, redType) then
		return true
	end

	if self:GetPetEquipPosRedPoint(petId, PetEquipModel.EquipPos.EquipHelmet, redType) then
		return true
	end

	if self:GetPetEquipPosRedPoint(petId, PetEquipModel.EquipPos.EquipShose, redType) then
		return true
	end

	if self:GetPetEquipPosRedPoint(petId, PetEquipModel.EquipPos.EquipJewelry, redType) then
		return true
	end

	return self:GetPetEquipPosRedPoint(petId, PetEquipModel.EquipPos.EquipExclusive, redType)
end

function PetEquipModel:GetTupoQualityList(infoMo)
	if infoMo == nil then
		return
	end

	local tempList = {}
	local tupoList

	if infoMo:isEquipArtifact() then
		tupoList = EquipmentConfig.instance:GetTupoGropCfgs(infoMo.wearPos, infoMo.sqSkinId)
	else
		local jobStr = table.concat(infoMo.jobTypeList, ",")

		tupoList = EquipmentConfig.instance:GetTupoGropCfgs(infoMo.wearPos, jobStr)
	end

	if tupoList and #tupoList > 0 then
		for i = 1, #tupoList do
			if tupoList[i] and checknumber(tupoList[i].afterNum) > 0 and string.nilorempty(tupoList[i].attr) then
				table.insert(tempList, tupoList[i])
			end
		end
	end

	if #tempList > 1 then
		table.sort(tempList, function(a, b)
			return a.beforeNum < b.beforeNum
		end)
	end

	return tempList
end

function PetEquipModel:getTupoRightEquip(infoMo)
	if infoMo == nil then
		return nil
	end

	local tupoList

	if infoMo:isEquipArtifact() then
		tupoList = EquipmentConfig.instance:GetTupoGropCfgs(infoMo.wearPos, infoMo.sqSkinId)
	else
		local jobStr = table.concat(infoMo.jobTypeList, ",")

		tupoList = EquipmentConfig.instance:GetTupoGropCfgs(infoMo.wearPos, jobStr)
	end

	local baseId = 0
	local isSameAttr = infoMo.quality >= 9

	for _, cfg in pairs(tupoList or {}) do
		if cfg and cfg.beforeNum == infoMo.afterNum and (isSameAttr and infoMo.attrType == cfg.attr or isSameAttr == false and string.nilorempty(cfg.attr)) then
			baseId = cfg.baseId

			break
		end
	end

	if baseId <= 0 then
		return nil
	end

	return self:GetTemporaryEquip(baseId, 0, infoMo)
end

function PetEquipModel:_getTupoMeetDemandList(infoMo, sifterList)
	if infoMo == nil or self.allEquipInfoList == nil then
		return
	end

	if not infoMo:isCanTupo() then
		return
	end

	local tempList = {}
	local tupoList

	if infoMo:isEquipArtifact() then
		tupoList = EquipmentConfig.instance:GetTupoGropCfgs(infoMo.wearPos, infoMo.sqSkinId)
	else
		local jobStr = table.concat(infoMo.jobTypeList, ",")

		tupoList = EquipmentConfig.instance:GetTupoGropCfgs(infoMo.wearPos, jobStr)
	end

	if tupoList and #tupoList > 0 then
		for i = 1, #tupoList do
			if tupoList[i] and tupoList[i].beforeNum == infoMo.beforeNum then
				tempList[tupoList[i].baseId] = true
			end
		end
	end

	local expendList = {}

	for _, mo in pairs(self.allEquipInfoList) do
		if mo and checknumber(mo.exclRaceId) <= 0 and tempList[mo.baseId] and mo.onlyId ~= infoMo.onlyId and self:_isConformEquipSifter(mo, sifterList) then
			table.insert(expendList, mo)
		end
	end

	return expendList
end

function PetEquipModel:getTupoEquipItemList(infoMo, sifterList)
	local list = self:_getTupoMeetDemandList(infoMo, sifterList)

	if list == nil or #list == 0 then
		return {}
	end

	local tempList = {}
	local isSameAttr = infoMo.quality == 9

	for _, info in pairs(list) do
		if info and not info:isWearEquip() and (not isSameAttr or info.attrType == infoMo.attrType) then
			table.insert(tempList, info)
		end
	end

	return tempList
end

function PetEquipModel:getTupoEquipSelectList(sifterList, showTog)
	if self.allEquipInfoList == nil then
		return {}
	end

	showTog = checknumber(showTog)

	local target = {}

	for _, mo in pairs(self.allEquipInfoList) do
		if mo and mo:isCanTupo() and (mo.quality < 9 or mo:isAttributesEquip()) and self:_isConformEquipSifter(mo, sifterList) then
			local isWear = mo:isWearEquip()

			if showTog == PetEquipModel.FilterType.AllTogType or showTog == PetEquipModel.FilterType.WearTogType and isWear or showTog == PetEquipModel.FilterType.NotwearTogType and not isWear then
				table.insert(target, mo)
			end
		end
	end

	if #target > 1 then
		table.sort(target, function(a, b)
			if a.starCount == b.starCount then
				return a.baseId < b.baseId
			end

			return a.starCount < b.starCount
		end)
	end

	return target
end

function PetEquipModel:GetAllAttrStones(planId)
	planId = planId or 1

	local allCfgs = EquipmentConfig.instance:GetAttrStoneCfgs(planId)
	local tempList = {}

	for _, cfg in pairs(allCfgs or {}) do
		if cfg and not string.nilorempty(cfg.cost) then
			local goods = string.split(cfg.cost, ":")
			local matType = checknumber(goods[1])
			local matId = checknumber(goods[2])
			local matNeed = checknumber(goods[3])
			local matHave = MaterialModel.instance:getMaterialsNumber(matType, matId)

			if matHave > 0 then
				table.insert(tempList, {
					matType = matType,
					matId = matId,
					matNeed = matNeed,
					matHave = matHave,
					matUse = (checknumber(self.attrStoneId) == cfg.id or nil) and 1,
					index = cfg.id,
					attr = cfg.raceType,
					rate = cfg.providePercent
				})
			end
		end
	end

	if #tempList > 1 then
		table.sort(tempList, function(a, b)
			return a.index < b.index
		end)
	end

	return tempList
end

function PetEquipModel:SetAttrStoneIndex(index)
	self.attrStoneId = index
end

function PetEquipModel:GetAttrStoneIndex()
	return checknumber(self.attrStoneId)
end

function PetEquipModel:ResetAttrStoneIndex()
	self.attrStoneId = nil
end

function PetEquipModel:SetAttrRateByString(stri, count, isReplace)
	if string.nilorempty(stri) then
		return
	end

	self:SetAttrRateByIndex((stri ~= "无" or nil) and checknumber(GameEnum.Races[stri]), count, isReplace)
end

function PetEquipModel:SetAttrRateByIndex(index, count, isReplace)
	self.attrRateList = self.attrRateList or {}

	if self.attrRateList[index] == nil then
		self.attrRateList[index] = index == 0 and 100 or 0
	end

	self.attrRateList[index] = isReplace and count or self.attrRateList[index] + count

	if self.attrRateList[index] < 0 then
		self.attrRateList[index] = 0
	end
end

function PetEquipModel:GetAttrRateList()
	self.attrRateList = self.attrRateList or {}

	local count = 0

	for k, v in pairs(self.attrRateList) do
		if k ~= 0 then
			count = count + v
		end
	end

	self.attrRateList[0] = math.max(0, 100 - count)

	if checknumber(self.attrStoneId) <= 0 then
		return self.attrRateList
	end

	local list = {}

	list[self.attrStoneId] = 100

	return list
end

function PetEquipModel:ResetAttrRateList()
	self.attrRateList = nil
end

function PetEquipModel:getFactorySifterList(alchemyType, cfg, attrs)
	if cfg == nil or cfg.requiredPlayerLevel > RoleModel.instance:getMyLevel() then
		return {}
	end

	local tempList = {}

	if alchemyType == PetEquipModel.AlchemyType.Equip then
		tempList = self:getFactoryEquipList(cfg.realCostQuality, attrs)
	elseif alchemyType == PetEquipModel.AlchemyType.Artifact then
		tempList = self:getFactoryArtifactList(cfg.realCostQuality, attrs)
	elseif alchemyType == PetEquipModel.AlchemyType.StarGod then
		tempList = self:getFactoryStarGodList(cfg.realCostQuality, attrs, false, (cfg.costQuality == 1 or nil) and 410)
	end

	return tempList
end

function PetEquipModel:getFactoryEquipList(quaNum, attrs, isFill)
	local ssList = {}
	local tempList = {}

	for _, item in pairs(self.allEquipInfoList or {}) do
		if item and not item.isWear and item.quality == quaNum and not item:isEquipArtifact() and self:_isConformEquipSifter(item, attrs) then
			if item.haveAllExp == 0 then
				if ssList[item.baseId] then
					table.insert(ssList[item.baseId].countList, item.onlyId)
				else
					ssList[item.baseId] = {
						useCount = 0,
						baseId = item.baseId,
						onlyId = item.onlyId,
						countList = {
							item.onlyId
						}
					}
				end
			else
				table.insert(tempList, {
					useCount = 0,
					baseId = item.baseId,
					onlyId = item.onlyId
				})
			end
		end
	end

	for _, info in pairs(ssList or {}) do
		if info and #info.countList > 0 then
			table.insert(tempList, info)
		end
	end

	table.sort(tempList, function(a, b)
		local moA = self:GetEquipInfo(a.onlyId)
		local moB = self:GetEquipInfo(b.onlyId)

		if moA:isAttributesEquip() == moB:isAttributesEquip() then
			return moA.haveAllExp < moB.haveAllExp
		elseif moA:isAttributesEquip() == true then
			return false
		else
			return true
		end
	end)

	if tempList then
		if not #tempList then
			local count = 0

			if not isFill or count >= 16 then
				return tempList
			end

			for i = count + 1, 16 do
				tempList[i] = {
					isEmpty = true
				}
			end

			return tempList
		end
	end
end

function PetEquipModel:_isConformEquipSifter(equipMo, attrs)
	if equipMo == nil then
		return false
	end

	for planId, list in pairs(attrs or {}) do
		local planCfg = EquipmentConfig.instance:getSifterPlanCfgs(planId)

		if planCfg and planCfg[1] then
			if planCfg[1].showType == 1 then
				local findType = equipMo.attrType

				if checknumber(equipMo.sqSkinId) > 0 then
					local skinCfg = PetSkinConfig.instance:getPetSkinCfg(equipMo.sqSkinId)

					if skinCfg then
						findType = skinCfg.elementAttr
					end
				end

				if list and #list > 0 and not table.indexof(list, findType) then
					return false
				end
			elseif planCfg[1].showType == 2 then
				local isFind = false

				if not equipMo.jobTypeList then
					local jobList = {}

					if checknumber(equipMo.sqSkinId) > 0 then
						local skinCfg = PetSkinConfig.instance:getPetSkinCfg(equipMo.sqSkinId)

						if skinCfg then
							jobList = string.split(skinCfg.job, ",")
						end
					end

					for i, jobType in pairs(jobList) do
						for j, v in pairs(list or {}) do
							if string.find(v, jobType) then
								isFind = true

								break
							end
						end

						if isFind == true then
							break
						end
					end

					if list and #list > 0 and not isFind then
						return false
					end
				end
			elseif planCfg[1].showType == 6 then
				if list and #list > 0 and not table.indexof(list, equipMo.quality) then
					return false
				end
			elseif planCfg[1].showType == 5 then
				if list and #list > 0 and not table.indexof(list, (equipMo:isEquipArtifact() == true or nil) and 5) then
					return false
				end
			end
		end
	end

	return true
end

function PetEquipModel:getFactoryArtifactList(quaNum, attrs, isFill)
	local allInfos = ThroneModel.instance:getAllThroneInfos()
	local cfg, list, allCfgs
	local tempList = {}

	for _, info in ipairs(allInfos) do
		if info and info.throneId then
			cfg = ThroneConfig.instance:getThroneCfg(info.throneId)

			if cfg and cfg.quality == quaNum and info.leftNum >= 1 and self:_isConformArtifactSifter(cfg, attrs) then
				allCfgs = ThroneConfig.instance:getLvStrategyCfg(cfg.levelStrategy)

				if allCfgs and #allCfgs > 0 and #allCfgs <= info.lv then
					list = {}

					for i = 1, info.leftNum do
						list[i] = cfg.id
					end

					table.insert(tempList, {
						useCount = 0,
						baseId = cfg.id,
						onlyId = cfg.id,
						countList = list,
						quality = cfg.quality
					})
				end
			end
		end
	end

	if tempList then
		if not #tempList then
			local count = 0

			if not isFill or count >= 16 then
				return tempList
			end

			for i = count + 1, 16 do
				tempList[i] = {
					isEmpty = true
				}
			end

			return tempList
		end
	end
end

function PetEquipModel:_isConformArtifactSifter(cfg, attrs)
	if cfg == nil then
		return false
	end

	for planId, list in pairs(attrs or {}) do
		local planCfg = EquipmentConfig.instance:getSifterPlanCfgs(planId)

		if planCfg and planCfg[1] and planCfg[1].showType == 3 and list and #list > 0 and not table.indexof(list, cfg.quality) then
			return false
		end
	end

	return true
end

function PetEquipModel:getFactoryStarGodList(quaNum, attrs, isFill, tmId)
	local moList = MaterialMgr.getModelList(MatType.StarGodPlus)
	local tempList = {}

	tmId = checknumber(tmId)

	for _, mo in ipairs(moList or {}) do
		if mo and mo:getQuality() == quaNum and (tmId <= 0 or tmId ~= mo:getDefineId()) and self:_isConformStarGodSifter(mo, attrs) then
			table.insert(tempList, {
				useCount = 0,
				baseId = mo:getDefineId(),
				onlyId = mo:getId(),
				countList = {
					mo:getId()
				},
				isWear = mo:isWear(),
				quality = mo:getQuality(),
				petId = mo:getUsePetId(),
				raceId = mo:getUseRaceId(),
				sgType = mo:getEquipType(),
				name = mo:getName()
			})
		end
	end

	table.sort(tempList, function(a, b)
		if a.petId <= 0 and b.petId <= 0 or a.petId > 0 and b.petId > 0 then
			return a.onlyId < b.onlyId
		else
			return a.petId < b.petId
		end
	end)

	if tempList then
		if not #tempList then
			local count = 0

			if not isFill or count >= 16 then
				return tempList
			end

			for i = count + 1, 16 do
				tempList[i] = {
					isEmpty = true
				}
			end

			return tempList
		end
	end
end

function PetEquipModel:_isConformStarGodSifter(sgMo, attrs)
	if sgMo == nil then
		return false
	end

	for planId, list in pairs(attrs or {}) do
		local planCfg = EquipmentConfig.instance:getSifterPlanCfgs(planId)

		if planCfg and planCfg[1] and planCfg[1].showType == 4 and list and #list > 0 and not table.indexof(list, sgMo:getEquipType()) then
			return false
		end
	end

	return true
end

function PetEquipModel:getConformEquipSifterPool(alchemyType, cfg, sifterList)
	if alchemyType == nil or cfg == nil then
		return
	end

	local poolCfgs

	if cfg.poolType == PetEquipModel.AlchemyType.Equip then
		poolCfgs = EquipmentConfig.instance:getComposeEquipPoolCfgs(cfg.poolId)
	elseif cfg.poolType == PetEquipModel.AlchemyType.Artifact then
		poolCfgs = EquipmentConfig.instance:getComposeThronePoolCfgs(cfg.poolId)
	elseif cfg.poolType == PetEquipModel.AlchemyType.StarGod then
		poolCfgs = EquipmentConfig.instance:getComposePoolCfg(cfg.poolId)
	end

	local tempList = {}

	for _, v in pairs(poolCfgs or {}) do
		if v and v.equipmentId then
			if alchemyType == PetEquipModel.AlchemyType.Equip then
				local mo = self:GetTemporaryEquip(v.equipmentId, 0)

				if self:_isConformEquipSifter(mo, sifterList) then
					table.insert(tempList, v.equipmentId)
				end
			elseif alchemyType == PetEquipModel.AlchemyType.Artifact then
				local thCfg = ThroneConfig.instance:getThroneCfg(v.equipmentId)

				if self:_isConformArtifactSifter(thCfg, sifterList) then
					table.insert(tempList, v.equipmentId)
				end
			elseif alchemyType == PetEquipModel.AlchemyType.StarGod then
				local mo = StargodplusMaterialMo.New()

				mo:initData({
					defineId = v.equipmentId
				})

				if self:_isConformStarGodSifter(mo, sifterList) then
					table.insert(tempList, v.equipmentId)
				end
			end
		end
	end

	if #tempList > 1 then
		table.sort(tempList, function(a, b)
			return a < b
		end)
	end

	return tempList
end

function PetEquipModel:GetRecycleEquipList(isFill)
	if self.allEquipInfoList == nil then
		return {}
	end

	local ssList = {}
	local tempList = {}

	for _, item in pairs(self.allEquipInfoList) do
		if item and not item.isWear then
			if item.haveAllExp == 0 then
				if ssList[item.baseId] then
					table.insert(ssList[item.baseId].countList, item.onlyId)
				else
					ssList[item.baseId] = {
						useCount = 0,
						infoMo = item,
						countList = {
							item.onlyId
						}
					}
				end
			else
				table.insert(tempList, {
					useCount = 0,
					infoMo = item
				})
			end
		end
	end

	for _, info in pairs(ssList or {}) do
		if info and #info.countList > 0 then
			table.insert(tempList, info)
		end
	end

	if #tempList > 1 then
		table.sort(tempList, function(a, b)
			return a.infoMo.qualityBase < b.infoMo.qualityBase
		end)
	end

	if tempList then
		if not #tempList then
			local count = 0

			if not isFill or count >= 30 then
				return tempList
			end

			for i = count + 1, 30 do
				tempList[i] = {
					isEmpty = true
				}
			end

			return tempList
		end
	end
end

function PetEquipModel:GetRecycleDecorationList(isFill)
	if self.dectInfoList == nil then
		return {}
	end

	local tempList = {}

	for _, item in pairs(self.dectInfoList) do
		if item and not item.isWear then
			table.insert(tempList, {
				useCount = 0,
				infoMo = item
			})
		end
	end

	if #tempList > 1 then
		table.sort(tempList, function(a, b)
			return a.infoMo.qualityBase < b.infoMo.qualityBase
		end)
	end

	if tempList then
		if not #tempList then
			local count = 0

			if not isFill or count >= 30 then
				return tempList
			end

			for i = count + 1, 30 do
				tempList[i] = {
					isEmpty = true
				}
			end

			return tempList
		end
	end
end

function PetEquipModel:GetRecycleQualityPlan()
	local planId = EquipmentConfig.instance:GetRecyQuaPlanId()

	if checknumber(planId) <= 0 then
		return nil
	end

	local list = EquipmentConfig.instance:GetEquipQualityPlans(planId)

	if list and #list > 0 then
		return list
	end

	return nil
end

function PetEquipModel:getAlchemyTableList(planId)
	planId = checknumber(planId)

	local allList = EquipmentConfig.instance:GetComposePlanCfgs(planId)
	local targetList = {}

	for _, cfg in pairs(allList or {}) do
		if cfg and cfg.planId and cfg.planId == planId then
			table.insert(targetList, cfg)
		end
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			return a.costQuality > b.costQuality
		end)
	end

	local index = 1

	if #targetList > 0 then
		local nowLevel = RoleModel.instance:getMyLevel()

		for i = 1, #targetList do
			if targetList[i] and nowLevel >= targetList[i].requiredPlayerLevel then
				index = i

				break
			end
		end
	end

	return targetList, index
end

function PetEquipModel:getAlchemyUnlockLevel(planId)
	planId = checknumber(planId)

	if planId <= 0 then
		return 0
	end

	local allList = EquipmentConfig.instance:GetComposePlanCfgs(planId)

	if allList == nil then
		return 0
	end

	local level = 9999

	for _, cfg in pairs(allList or {}) do
		if cfg and cfg.planId and level > cfg.requiredPlayerLevel then
			level = cfg.requiredPlayerLevel
		end
	end

	return level
end

function PetEquipModel:getEquipFactoryCostPlanCfg(planId, count)
	local allCfgs = EquipmentConfig.instance:getCostPlanCfgs(planId)
	local temp

	for _, cfg in pairs(allCfgs or {}) do
		if cfg and cfg.costPlanId then
			if temp == nil or count > temp.times and temp.times < cfg.times then
				temp = cfg
			end

			if temp.times == count then
				break
			end
		end
	end

	if temp == nil or string.nilorempty(temp.costMaterial) then
		return nil
	end

	return string.split(temp.costMaterial, "#")
end

function PetEquipModel:getEquipFactoryCount(tabId)
	if self._equipFactoryCount == nil or self._equipFactoryCount[tabId] == nil then
		return {}
	end

	return self._equipFactoryCount[tabId]
end

function PetEquipModel:scSendComposeTimes(msg)
	self._equipFactoryCount = {}

	if msg == nil or msg.times == nil then
		return
	end

	for _, info in pairs(msg.times) do
		if info and info.tabId then
			self._equipFactoryCount[info.tabId] = self._equipFactoryCount[info.tabId] or {}
			self._equipFactoryCount[info.tabId][info.costQuality] = checknumber(info.times)
		end
	end
end

function PetEquipModel:setEquipFactoryCount(tabId, costQuality)
	self._equipFactoryCount = self._equipFactoryCount or {}
	self._equipFactoryCount[tabId] = self._equipFactoryCount[tabId] or {}
	self._equipFactoryCount[tabId][costQuality] = checknumber(self._equipFactoryCount[tabId][costQuality]) + 1
end

function PetEquipModel:getEquipRecycleQualityList()
	local targetList = {}

	targetList[1] = {
		quaDesc = "停止自动分解",
		quaCost = 0
	}
	targetList[2] = {
		quaDesc = "<color=#0083e7>蓝色及以下装备</color>",
		quaCost = 3
	}
	targetList[3] = {
		quaDesc = "<color=#0083e7>蓝+1及以下装备</color>",
		quaCost = 4
	}
	targetList[4] = {
		quaDesc = "<color=#df5bff>紫色及以下装备</color>",
		quaCost = 5
	}
	targetList[5] = {
		quaDesc = "<color=#df5bff>紫+1及以下装备</color>",
		quaCost = 6
	}
	targetList[6] = {
		quaDesc = "<color=#df5bff>紫+2及以下装备</color>",
		quaCost = 7
	}

	return targetList
end

function PetEquipModel:getFactorySifterCfgs(sifter, viewName)
	if string.nilorempty(sifter) or string.nilorempty(viewName) then
		return nil
	end

	local list = string.split(sifter, "#")

	if list == nil or #list <= 1 then
		return nil
	end

	if list[1] ~= viewName then
		return nil
	end

	local tempList = {}
	local index = 0

	for i = 2, #list do
		local aa = string.split(list[i], ":")

		if aa and #aa > 1 then
			index = index + 1
			tempList[index] = {}
			tempList[index].viewName = viewName
			tempList[index].planId = checknumber(aa[1])
			tempList[index].btnName = aa[2]
			tempList[index].subName = aa[3]
			tempList[index].btnPos = string.split(aa[4], ",") or {
				0,
				0
			}
			tempList[index].subList = EquipmentConfig.instance:getSifterPlanCfgs(checknumber(aa[1]))
		end
	end

	return tempList
end

function PetEquipModel:getAllEquipAlchemyRedpoint()
	local allCfgs = EquipmentConfig.instance:GetComposeDdefineCfgs()

	for _, cfg in pairs(allCfgs or {}) do
		if cfg and cfg.tabId and self:getSingleEquipAlchemyRedpoint(cfg.tabId) then
			return true
		end
	end

	return false
end

function PetEquipModel:getSingleEquipAlchemyRedpoint(tabId)
	local cfg = EquipmentConfig.instance:GetComposeDdefineCfgs(tabId)

	if cfg == nil then
		return false
	end

	local nowLevel = RoleModel.instance:getMyLevel()

	if nowLevel < self:getAlchemyUnlockLevel(cfg.planId) then
		return false
	end

	local value = GameUtil.getUserDayData("EquipAlchemy_Redpoint_%s", tabId)

	if checknumber(value) == 1 then
		return false
	end

	print("sr--------------------------------         红点 = ", cfg.redPointId)

	return RedPointModel.instance:isActiveByServer(cfg.redPointId)
end

function PetEquipModel:getSingleEquipFactoryRedpoint(cfg, tabId)
	if cfg == nil or cfg.periodType == "none" or cfg.limitTimes == 0 then
		return false
	end

	local value = GameUtil.getUserDayData("EquipFactory_Redpoint_%s_%s_%s", tabId, cfg.planId, cfg.costQuality)

	if checknumber(value) == 1 then
		return false
	end

	if self._equipFactoryCount == nil or self._equipFactoryCount[tabId] == nil then
		return true
	end

	local infos = self._equipFactoryCount[tabId]

	if infos and infos[cfg.costQuality] and cfg.limitTimes > checknumber(infos[cfg.costQuality]) then
		return true
	end

	return false
end

function PetEquipModel:setSingleEquipAlchemyRedpoint(tabId)
	if tabId == nil then
		return
	end

	local keyStr = string.format("EquipAlchemy_Redpoint_%s", tabId)
	local value = GameUtil.getUserDayData(keyStr)

	if checknumber(value) ~= 1 then
		GameUtil.saveUserDayData(keyStr, 1)
	end
end

function PetEquipModel:setSingleEquipFactoryRedpoint(cfg, tabId)
	if cfg == nil or tabId == nil then
		return
	end

	local keyStr = string.format("EquipFactory_Redpoint_%s_%s_%s", tabId, cfg.planId, cfg.costQuality)
	local value = GameUtil.getUserDayData(keyStr)

	if checknumber(value) ~= 1 then
		GameUtil.saveUserDayData(keyStr, 1)
	end
end

function PetEquipModel:SetPinglunPetInfo(data)
	if data == nil or data.raceId == nil then
		return
	end

	if self.dianpingInfoList == nil then
		self.dianpingInfoList = {}
	end

	local var_121_0 = {
		raceId = data.raceId,
		isPL = data.hadDiscuss
	}

	var_121_0.dzList = data.likeIds or {}
	var_121_0.zxList = {}
	var_121_0.zrList = {}
	self.dianpingInfoList[data.raceId] = var_121_0

	return true
end

function PetEquipModel:SetPinglunInfoList(data)
	if data == nil or data.raceId == nil then
		return
	end

	if self.dianpingInfoList == nil or self.dianpingInfoList[data.raceId] == nil then
		self:SetPinglunPetInfo({
			hadDiscuss = false,
			raceId = data.raceId
		})
	end

	if data.news and #data.news > 0 then
		for i = #data.news, 1, -1 do
			local info = {
				isDZ = false,
				plId = data.news[i].commentId,
				roleId = data.news[i].userId,
				roleName = data.news[i].userName,
				petDes = data.news[i].content,
				dzCount = data.news[i].likeNum
			}

			if self.dianpingInfoList[data.raceId] and self.dianpingInfoList[data.raceId].dzList then
				for _, id in pairs(self.dianpingInfoList[data.raceId].dzList) do
					if id and id == data.news[i].commentId then
						info.isDZ = true

						break
					end
				end
			end

			table.insert(self.dianpingInfoList[data.raceId].zxList, info)
		end
	end

	if data.hots and #data.hots > 0 then
		for i = 1, #data.hots do
			local info = {
				isDZ = false,
				plId = data.hots[i].commentId,
				roleId = data.hots[i].userId,
				roleName = data.hots[i].userName,
				petDes = data.hots[i].content,
				dzCount = data.hots[i].likeNum
			}

			if self.dianpingInfoList[data.raceId] and self.dianpingInfoList[data.raceId].dzList then
				for _, id in pairs(self.dianpingInfoList[data.raceId].dzList) do
					if id and id == data.hots[i].commentId then
						info.isDZ = true

						break
					end
				end
			end

			table.insert(self.dianpingInfoList[data.raceId].zrList, info)
		end
	end

	GlobalDispatcher:dispatch("UpdatePetPinglunInfo")
end

function PetEquipModel:SetPinglunDianzan(raceId, plId)
	if checknumber(raceId) <= 0 or checknumber(plId) <= 0 then
		return
	end

	if self.dianpingInfoList == nil or self.dianpingInfoList[raceId] == nil then
		return
	end

	self.dianpingInfoList[raceId].dzList = self.dianpingInfoList[raceId].dzList or {}

	table.insert(self.dianpingInfoList[raceId].dzList, plId)

	for _, info in pairs(self.dianpingInfoList[raceId].zxList) do
		if info and info.plId == plId then
			info.dzCount = info.dzCount + 1
			info.isDZ = true

			break
		end
	end

	for _, info in pairs(self.dianpingInfoList[raceId].zrList) do
		if info and info.plId == plId then
			info.dzCount = info.dzCount + 1
			info.isDZ = true

			break
		end
	end

	GlobalDispatcher:dispatch("UpdatePetPinglunInfo")
end

function PetEquipModel:SetOwnPinglunInfo(info)
	if info == nil or info.comment == nil or checknumber(info.raceId) <= 0 then
		return
	end

	if self.dianpingInfoList == nil or self.dianpingInfoList[info.raceId] == nil then
		self:SetPinglunPetInfo({
			hadDiscuss = true,
			raceId = info.raceId
		})
	end

	self.dianpingInfoList[info.raceId].isPL = true

	local zxInfo = {
		dzCount = 0,
		isDZ = false,
		plId = info.comment.commentId,
		roleId = info.comment.userId,
		roleName = info.comment.userName,
		petDes = info.comment.content
	}

	table.insert(self.dianpingInfoList[info.raceId].zxList, 1, zxInfo)

	local zrInfo = {
		dzCount = 0,
		isDZ = false,
		plId = info.comment.commentId,
		roleId = info.comment.userId,
		roleName = info.comment.userName,
		petDes = info.comment.content
	}

	if self.dianpingInfoList[info.raceId].zrList then
		if not #self.dianpingInfoList[info.raceId].zrList then
			local num = 0

			if num > 3 then
				table.insert(self.dianpingInfoList[info.raceId].zrList, 4, zrInfo)
			else
				table.insert(self.dianpingInfoList[info.raceId].zrList, num + 1, zrInfo)
			end

			GlobalDispatcher:dispatch("UpdatePetPinglunInfo")
		end
	end
end

function PetEquipModel:GetPinglunInfoList(raceId)
	if self.dianpingInfoList == nil or self.dianpingInfoList[raceId] == nil then
		self:SetPinglunPetInfo({
			hadDiscuss = false,
			raceId = raceId
		})
	end

	local tempData = {
		raceId = self.dianpingInfoList[raceId].raceId,
		isPL = self.dianpingInfoList[raceId].isPL,
		dzList = self.dianpingInfoList[raceId].dzList,
		zxList = {},
		zrList = {}
	}
	local zrList = self.dianpingInfoList[raceId].zrList
	local allCount = 30
	local count = allCount < #zrList and allCount or #zrList

	for i = 1, count do
		table.insert(tempData.zrList, zrList[i])
	end

	local pinglun1, pinglun2, pinglun3 = 0, 0, 0

	count = count > 3 and 3 or count

	for i = 1, count do
		if i == 1 then
			pinglun1 = zrList[1].plId
		elseif i == 2 then
			pinglun2 = zrList[2].plId
		else
			pinglun3 = zrList[3].plId
		end

		table.insert(tempData.zxList, zrList[i])
	end

	local zxList = self.dianpingInfoList[raceId].zxList

	count = #zxList > allCount - 3 and allCount - 3 or #zxList

	for i = 1, count do
		if zxList[i] and zxList[i].plId ~= pinglun1 and zxList[i].plId ~= pinglun2 and zxList[i].plId ~= pinglun3 then
			table.insert(tempData.zxList, zxList[i])
		end
	end

	return tempData
end

function PetEquipModel:calcDecorationAttrs(decoration, isMyPackPet)
	local res = {}

	if decoration and next(decoration) then
		if isMyPackPet then
			if decoration.id > 0 then
				local mo = self:GetDecorationInfoByOnlyId(decoration.id)

				if mo then
					AttrMo.addSameAttrs(mo:getAllAttrList(), res)
				end
			end
		elseif decoration.defineId > 0 then
			local mo = self:GetTemporaryDectn(decoration.defineId, decoration.lv, decoration.propertyApps)

			AttrMo.addSameAttrs(mo:getAllAttrList(), res)
		end
	end

	return res
end

function PetEquipModel:getOptionalFuncOpen()
	local actId = self:getOptionalActivityId()

	if checknumber(actId) <= 0 then
		return false
	end

	return true
end

function PetEquipModel:getOptionalActivityId()
	local typeId = self._optionalInfo.actType
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(typeId)

	if cfgs == nil then
		return -2, typeId
	end

	for _, item in pairs(cfgs) do
		local isFill = ActivityDefineController.instance:isRelateServerBy(item.relatedAreaIds)

		if isFill and GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			self._optionalInfo.lastActId = item.activityId

			return item.activityId, typeId
		end
	end

	return -3, typeId
end

function PetEquipModel:getOptionalFuncInfo()
	if not self._optionalInfo.isBuy then
		local count = PayShopModel.instance:getMibaoBuyTimesById(self._optionalInfo.shopId)

		if checknumber(count) > 0 then
			self._optionalInfo.isBuy = true
		end
	end

	return self._optionalInfo
end

function PetEquipModel:getOptionalEquipList(jobStr, attrNum)
	if self._optionalInfo.equipList == nil or #self._optionalInfo.equipList == 0 then
		local shopCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._optionalInfo.shopId)

		if shopCfg == nil or string.nilorempty(shopCfg.content) then
			return
		end

		local goodsList = string.split(shopCfg.content, "#")

		if goodsList == nil or #goodsList == 0 then
			return
		end

		self._optionalInfo.equipList = {}

		for i = 1, #goodsList do
			self:_getMatEquipList(goodsList[i])
		end
	end

	local tempList = self._optionalInfo.equipList

	if tempList == nil or #tempList == 0 then
		return
	end

	local targetList = {}

	for i = 1, #tempList do
		if (string.nilorempty(jobStr) or not string.nilorempty(jobStr) and table.indexof(tempList[i].jobTypeList, jobStr) ~= false or nil) and true and (checknumber(attrNum) <= 0 or attrNum > 0 and checknumber(GameEnum.Races[tempList[i].attrType]) == attrNum or nil) and true then
			table.insert(targetList, tempList[i])
		end
	end

	return targetList
end

function PetEquipModel:_getMatEquipList(str)
	if string.nilorempty(str) then
		return
	end

	local list = string.split(str, ":")

	if list == nil or #list == 0 then
		return
	end

	if checknumber(list[1]) ~= MatType.Item then
		return
	end

	local matCfg = MaterialConfig.instance:getCfgByMatAndId(MatType.Item, checknumber(list[2]))

	if matCfg == nil or string.nilorempty(matCfg.content) then
		return
	end

	local tempList = string.split(matCfg.content, ";")

	if tempList == nil or #tempList == 0 then
		return
	end

	for i = 1, #tempList do
		local aa = string.split(tempList[i], ":")

		if aa and #aa > 0 and checknumber(aa[1]) == MatType.Equipment then
			table.insert(self._optionalInfo.equipList, self:GetTemporaryEquip(checknumber(aa[2]), checknumber(aa[3])))
		end
	end
end

function PetEquipModel:getOptionalRedpoint()
	if not self:getOptionalFuncOpen() then
		return false
	end

	local value = GameUtil.getUserData("optionalredpoint")

	if string.nilorempty(value) or value ~= "optionalredpoint" then
		return true
	end

	return false
end

function PetEquipModel:setOptionalRedpoint()
	local value = GameUtil.getUserData("optionalredpoint")

	if string.nilorempty(value) or value ~= "optionalredpoint" then
		GameUtil.saveUserData("optionalredpoint", "optionalredpoint")
	end
end

PetEquipModel.instance = PetEquipModel.New()

return PetEquipModel
