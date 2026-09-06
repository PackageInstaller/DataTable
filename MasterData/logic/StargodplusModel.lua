-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/model/StargodplusModel.lua

module("logic.extensions.stargodplus.view.StargodplusModel", package.seeall)

local StargodplusModel = class("StargodplusModel", BaseModel)
local EMPYT_TABLE = {}

function StargodplusModel:ctor()
	return
end

function StargodplusModel:onInit()
	self:onReset()
end

function StargodplusModel:onReset()
	self._fillers = {}
	self._fillersMo = {}
end

function StargodplusModel:addFillerMo(info)
	if not info.deleted then
		local mo = self._fillersMo[info.fillerId]

		if not mo then
			mo = StargodplusMaterialMo.New()
			self._fillersMo[info.fillerId] = mo
		end

		mo:initData(info)
	else
		self._fillersMo[info.fillerId] = nil
	end
end

function StargodplusModel:getFillerMoList()
	local dataList = {}

	for k, v in pairs(self._fillersMo) do
		local data = v

		table.insert(dataList, data)
	end

	return dataList
end

function StargodplusModel:setAllFillerinfos(list)
	self._fillers = list

	for i, info in ipairs(list) do
		self:addFillerMo(info)
	end
end

function StargodplusModel:getStarGodMo(fillerId)
	return self._fillersMo[fillerId]
end

function StargodplusModel:fillersChangeRes(changedFillers)
	for i, info in ipairs(changedFillers) do
		self:addFillerMo(info)
	end
end

function StargodplusModel:getPetEquipMos(petId)
	local list = {}

	for i, mo in pairs(self._fillersMo) do
		if mo:getUsePetId() == petId then
			table.insert(list, mo)
		end
	end

	return list
end

function StargodplusModel:getCurrShowPetId()
	return BagPetsController.instance:GetCurPetId()
end

function StargodplusModel:getCurrShowPetRaceId()
	local petMo = BagPetsController.instance:GetCurPetMo()

	return petMo and petMo.raceId
end

function StargodplusModel:getSlotLv(solt, exp)
	local lv = 1
	local cfg = StargodplusConfig.instance:getSlotCfg(solt)
	local planCfg = StargodplusConfig.instance:getSlotLvPlan(cfg.slotLvPlan)

	for i, v in ipairs(planCfg) do
		lv = i

		if exp < v.exp then
			lv = i - 1

			break
		end
	end

	return lv
end

function StargodplusModel:isSlotMaxLv(solt, exp)
	local lv = self:getSlotLv(solt, exp)
	local cfg = StargodplusConfig.instance:getSlotCfg(solt)
	local planCfg = StargodplusConfig.instance:getSlotLvPlan(cfg.slotLvPlan)

	return planCfg[lv + 1] == nil
end

function StargodplusModel:getMaxSlotLevel(slot)
	local cfg = StargodplusConfig.instance:getSlotCfg(slot)

	if cfg then
		local planCfg = StargodplusConfig.instance:getSlotLvPlan(cfg.slotLvPlan)

		if planCfg then
			local lvCfg = planCfg[#planCfg]

			if lvCfg then
				return lvCfg.lv, lvCfg.exp
			end
		end
	end

	return 0, 0
end

function StargodplusModel:getAttrList(defineId, slotLv)
	local list = {}
	local kvList = self:_getAttrKVList(defineId, slotLv)

	for k, v in pairs(kvList) do
		table.insert(list, {
			id = k,
			value = v
		})
	end

	return list
end

function StargodplusModel:_getAttrKVList(defineId, slotLv)
	local propCfg = StargodplusConfig.instance:getPropCfg(defineId, slotLv)
	local list = {}

	if not string.nilorempty(propCfg.propertyApp) then
		local attrs = string.split(propCfg.propertyApp, "#")

		for i = 1, #attrs do
			local temp = string.split(attrs[i], "+")
			local name = temp[1]
			local value = checknumber(temp[2])
			local id = table.indexof(GameEnum.AttrTypeName, name)

			list[id] = value
		end
	end

	if not string.nilorempty(propCfg.formulaPropertyType) then
		local nameList = string.split(propCfg.formulaPropertyType, "#")
		local percent = propCfg.formulaWanPercent

		for k, name in pairs(nameList) do
			local id = table.indexof(GameEnum.AttrTypeName, name)

			list[id] = percent
		end
	end

	return list
end

function StargodplusModel:getPetAttrs(petId)
	local petMo = BagPetsController.instance:getPet(petId)

	if not petMo then
		return EMPYT_TABLE
	end

	return self:getPetAttrsByPetMo(petMo)
end

function StargodplusModel:getPetAttrsByPetMo(petMo)
	local slotDatas = petMo:getStarGodPlusSlots()
	local list = {}

	for i, v in ipairs(slotDatas) do
		local cfg = StargodplusConfig.instance:getSlotCfg(v.slot)

		if cfg and petMo.level >= cfg.unlockPetLv and v.fillerDefineId > 0 then
			local slotLv = self:getSlotLv(v.slot, v.exp)
			local attrKvList = self:_getAttrKVList(v.fillerDefineId, slotLv)

			AttrMo.addSameAttrs(attrKvList, list)
		end
	end

	local resList = {}

	for k, v in pairs(list) do
		table.insert(resList, {
			id = k,
			value = v
		})
	end

	return resList
end

function StargodplusModel:getSlotCompareList(fillerDefineId, oldLv, newLv)
	local resList = {}
	local attrOld = StargodplusModel.instance:getAttrList(fillerDefineId, oldLv)
	local attrNew = StargodplusModel.instance:getAttrList(fillerDefineId, newLv)
	local attrOldKv = {}
	local attrNewKv = {}

	for i, v in ipairs(attrOld) do
		attrOldKv[v.id] = v
	end

	for i, v in ipairs(attrNew) do
		attrNewKv[v.id] = v
	end

	for k, v in pairs(attrNewKv) do
		attrOldKv[v.id] = attrOldKv[v.id] or {
			value = 0,
			id = v.id
		}
	end

	for k, data in pairs(attrOldKv) do
		local name, preValue = GameUtil.getPropertyInfo(data.id, data.value)
		local lastValue = GameUtil.GetPropertyValue(data.id, attrNewKv[data.id].value)

		table.insert(resList, {
			name = name,
			id = data.id,
			preValue = preValue,
			lastValue = lastValue
		})
	end

	return resList
end

function StargodplusModel:checkPetCanEquip()
	local petIdsInFormation = FormationNewModel.instance:getHasPets()

	for i, petId in ipairs(petIdsInFormation) do
		local red = self:checkPetCanEquipById(petId)

		if red then
			return true
		end
	end
end

function StargodplusModel:checkPetCanEquipById(petId)
	if not FuncOpenModel.instance:getFuncIsOpen(194) then
		return false
	end

	if FormationGroupModel.instance:checkIsInTeam(petId) then
		return self:_checkEmptySlotCanEquip(petId) or self:_checkCanReplaceBestInType(petId)
	end

	return false
end

function StargodplusModel:_checkEmptySlotCanEquip(petId)
	local slotDatasKV = self:getSlotDatasKV(petId)
	local useTypeList = {}
	local useSlotList = {}

	for k, v in pairs(slotDatasKV) do
		if v.fillerDefineId > 0 then
			local cfg = StargodplusConfig.instance:getFillerCfg(v.fillerDefineId)

			useTypeList[cfg.type] = true
			useSlotList[v.slot] = cfg.type
		end
	end

	local petMo = BagPetsController.instance:getPet(petId)

	if not petMo then
		return false
	end

	local co = CharacterConfig.instance:getPetCo(petMo.raceId)
	local recommendCfgs = StargodplusConfig.instance:getRecommendCfgs(co.SGPRecommendId)
	local petLv = petMo:getPetLv()
	local emptySlot = {}

	for slot, _ in ipairs(recommendCfgs) do
		local scfg = StargodplusConfig.instance:getSlotCfg(slot)
		local isUnlock = petLv >= scfg.unlockPetLv

		if isUnlock and not useSlotList[slot] then
			emptySlot[slot] = true
		end
	end

	if not next(emptySlot) then
		return false
	end

	local moList = self:getFillerMoList()

	for i, mo in ipairs(moList) do
		if mo:getUsePetId() <= 0 and not useTypeList[mo:getEquipType()] and (mo:getBindPetId() <= 0 or petMo.raceId == mo:getBindPetId()) and (string.nilorempty(mo:getEquipPetChecker()) or FightingPowerFormula.instance:OnFilter(petMo, mo:getEquipPetChecker()) == true) then
			return true
		end
	end

	return false
end

function StargodplusModel:_checkCanReplaceBestInType(petId)
	local petMo = BagPetsController.instance:getPet(petId)
	local slotDatasKV = self:getSlotDatasKV(petId)

	for k, v in pairs(slotDatasKV) do
		if v.fillerDefineId > 0 then
			local cfg = StargodplusConfig.instance:getFillerCfg(v.fillerDefineId)
			local newFillerId = StargodplusModel.instance:getBestFillerIdByType(v.fillerId, cfg.type)
			local newMo = self:getStarGodMo(newFillerId)

			if newMo then
				local newCfg = StargodplusConfig.instance:getFillerCfg(newMo:getDefineId())

				if newFillerId ~= v.fillerId and (not newCfg.bindRace or petMo.raceId == newMo:getBindPetId()) and newMo:getQuality() > cfg.quality and (string.nilorempty(newMo:getEquipPetChecker()) or FightingPowerFormula.instance:OnFilter(petMo, newMo:getEquipPetChecker()) == true) then
					return true
				end
			end
		end
	end

	return false
end

function StargodplusModel:calcStarGodPlusAttrs(starGodPlusSlots)
	local res = {}

	if starGodPlusSlots and #starGodPlusSlots > 0 then
		for i, v in ipairs(starGodPlusSlots) do
			if v.fillerDefineId > 0 then
				local lv = self:getSlotLv(v.slot, v.exp)
				local temp = self:_getAttrKVList(v.fillerDefineId, lv)

				AttrMo.addSameAttrs(temp, res)
			end
		end
	end

	return res
end

function StargodplusModel:jumpStarGod(view)
	local isUnlock = MaterialChallengeModel.instance:isChapterUnlock(GameEnum.ResCopyType.Stargod)

	if isUnlock then
		MaterialChallengeController.instance:openChapterView(GameEnum.ResCopyType.Stargod)
		view:close()
	else
		local cfg = MaterialChallengeConfig.instance:getStageById(GameEnum.ResCopyType.Stargod, 1)
		local unlockId = cfg.unlockId
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(unlockId)

		FloatWordMgr.instance:show(cfg.description)
	end
end

function StargodplusModel:checkPetCanUpgradeEquipById(petId, slot)
	if not FuncOpenModel.instance:getFuncIsOpen(194) then
		return false
	end

	local cfgs = StargodplusConfig.instance:getSlotCfgs()

	if FormationGroupModel.instance:checkIsInTeam(petId) then
		local petMo = BagPetsController.instance:getPet(petId)

		if not petMo then
			return false
		end

		local petLv = petMo:getPetLv()
		local slotKVDatas = {}
		local slotDatas = petMo:getStarGodPlusSlots()

		for i, v in ipairs(slotDatas) do
			if v.fillerId > 0 then
				slotKVDatas[v.slot] = v
			end
		end

		for k, v in pairs(slotKVDatas) do
			if not slot or slot == v.slot then
				local slotUnlock = petLv >= cfgs[v.slot].unlockPetLv

				if slotUnlock then
					local canUp = self:checkSlotCanUpgrade(v.slot, v.exp)

					if canUp then
						return true
					end
				end
			end
		end
	end

	return false
end

function StargodplusModel:checkSlotCanUpgrade(slot, exp)
	local cfgMatList = StargodplusConfig.instance:getCommonStrenMatDatas()
	local hasMat = false

	for i, v in ipairs(cfgMatList) do
		local hasNum = MaterialFacade.instance:getMatNumber(v.matType, v.matId)

		if hasNum > 0 then
			hasMat = true

			break
		end
	end

	if hasMat then
		local isMaxLv = self:isSlotMaxLv(slot, exp)

		if not isMaxLv and hasMat then
			return true
		end
	end

	return false
end

function StargodplusModel:getFillterPower(defineId, slotLv)
	local kvList = self:_getAttrKVList(defineId, slotLv)

	return AttrMo.calcFightPowerByAttrs(kvList)
end

function StargodplusModel:getBestFillerIdByType(oldFillerId, equipType)
	local oldMo = self:getStarGodMo(oldFillerId)
	local currMoList = {}
	local moList = StargodplusModel.instance:getFillerMoList()

	for i, mo in pairs(moList) do
		local _equipType = mo:getEquipType()

		if mo:getUsePetId() <= 0 and equipType == _equipType then
			table.insert(currMoList, mo)
		end
	end

	table.sort(currMoList, function(a, b)
		return a:getQuality() > b:getQuality()
	end)

	local currMo = currMoList[1]

	if currMo then
		if oldMo and oldMo:getQuality() >= currMo:getQuality() then
			return oldFillerId
		else
			return currMo:getId()
		end
	else
		return oldFillerId
	end
end

function StargodplusModel:getOnekeyBestFillerIds(petId)
	local slotDatasKV = self:getSlotDatasKV(petId)
	local useTypeList = {}
	local useSlotList = {}
	local checkReplaceList = {}

	for k, v in pairs(slotDatasKV) do
		if v.fillerDefineId > 0 then
			local cfg = StargodplusConfig.instance:getFillerCfg(v.fillerDefineId)

			useTypeList[cfg.type] = true
			useSlotList[v.slot] = cfg.type
			checkReplaceList[v.slot] = {
				equipType = cfg.type,
				fillerId = v.fillerId
			}
		end
	end

	if table.nums(useSlotList) >= 4 then
		local finalList = self:_getReplaceBestFillerIds(petId)

		finalList = self:_modFinalList(petId, finalList)

		return finalList
	end

	local petMo = BagPetsController.instance:getPet(petId)
	local co = CharacterConfig.instance:getPetCo(petMo.raceId)
	local recommendCfgs = StargodplusConfig.instance:getRecommendCfgs(co.SGPRecommendId)
	local petLv = petMo:getPetLv()
	local emptySlot = {}
	local finalList = {}

	for slot, _ in ipairs(recommendCfgs) do
		local scfg = StargodplusConfig.instance:getSlotCfg(slot)
		local isUnlock = petLv >= scfg.unlockPetLv

		if isUnlock and not useSlotList[slot] then
			emptySlot[slot] = true
		end
	end

	local maxQuality = -1
	local moList = self:getFillerMoList()
	local moGroupByQuality = {}

	for i, mo in ipairs(moList) do
		local defineId = mo:getDefineId()
		local cfg = StargodplusConfig.instance:getFillerCfg(defineId)

		if mo:getUsePetId() <= 0 and not useTypeList[mo:getEquipType()] and (cfg.bindRace == false or petMo.raceId == mo:getBindPetId()) and (string.nilorempty(mo:getEquipPetChecker()) or FightingPowerFormula.instance:OnFilter(petMo, mo:getEquipPetChecker()) == true) then
			moGroupByQuality[cfg.quality] = moGroupByQuality[cfg.quality] or {}
			moGroupByQuality[cfg.quality][defineId] = mo
			maxQuality = math.max(maxQuality, cfg.quality)
		end
	end

	for slot, v in pairs(emptySlot) do
		local recTypeKV = {}
		local recCfg = recommendCfgs[slot]

		for i, rDefineId in ipairs(recCfg.recommend) do
			local cfg = StargodplusConfig.instance:getFillerCfg(rDefineId)

			recTypeKV[cfg.type] = rDefineId
		end

		local currQuality = maxQuality
		local moList = moGroupByQuality[currQuality]

		while currQuality > 0 and (not moList or table.nums(moList) <= 0) do
			currQuality = currQuality - 1
			moList = moGroupByQuality[currQuality]
		end

		if moList then
			local result = self:_findFillEmptySlotMatchId(petId, slot, recTypeKV, moList, useTypeList)

			if result then
				table.insert(finalList, result)
			end
		end
	end

	local results = self:_getReplaceBestFillerIds(petId, useTypeList)

	if results and #results > 0 then
		table.insertto(finalList, results)
	end

	finalList = self:_modFinalList(petId, finalList)

	return finalList
end

function StargodplusModel:_modFinalList(petId, finalList)
	local slotDatasKV = self:getSlotDatasKV(petId)
	local useType2Slot = {}

	for k, v in pairs(slotDatasKV) do
		if v.fillerDefineId > 0 then
			local cfg = StargodplusConfig.instance:getFillerCfg(v.fillerDefineId)

			useType2Slot[cfg.type] = {
				slot = v.slot,
				fillerId = v.fillerId,
				defineId = cfg.id
			}
		end
	end

	local newFinalList = {}
	local tempFinalList2 = {}
	local emptySlotList = {}
	local useSlotList = {}

	for i, v in ipairs(finalList) do
		local mo = self:getStarGodMo(v.usedFillerId)
		local etype = mo:getEquipType()

		if useType2Slot[etype] then
			local oldSlot = useType2Slot[etype].slot

			useSlotList[oldSlot] = true
			emptySlotList[oldSlot] = false

			if not useSlotList[v.slot] then
				emptySlotList[v.slot] = true
			end

			if mo:getDefineId() ~= useType2Slot[etype].defineId then
				table.insert(newFinalList, {
					slot = oldSlot,
					usedFillerId = v.usedFillerId
				})
			end
		else
			table.insert(tempFinalList2, v)
		end
	end

	local emptySlotList2 = {}

	for slot, flag in pairs(emptySlotList) do
		if flag then
			table.insert(emptySlotList2, slot)
		end
	end

	for i, v in ipairs(tempFinalList2) do
		local mo = self:getStarGodMo(v.usedFillerId)
		local etype = mo:getEquipType()

		if useSlotList[v.slot] then
			local slot = table.remove(emptySlotList2)

			if slot then
				table.insert(newFinalList, {
					slot = slot,
					usedFillerId = v.usedFillerId
				})
			end
		else
			table.insert(newFinalList, v)
		end
	end

	return newFinalList
end

function StargodplusModel:getSlotDatasKV(petId)
	local slotDatasKV = {}
	local petMo = BagPetsController.instance:getPet(petId)

	if petMo then
		local slotDatas = petMo:getStarGodPlusSlots()

		for i, v in ipairs(slotDatas) do
			slotDatasKV[v.slot] = v
		end
	end

	return slotDatasKV
end

function StargodplusModel:_getReplaceBestFillerIds(petId, useTypeList)
	local finalList = {}
	local petMo = BagPetsController.instance:getPet(petId)

	if not petMo then
		return finalList
	end

	local slotDatas = petMo:getStarGodPlusSlots()

	if slotDatas and #slotDatas > 0 then
		local wearMos = {}
		local useTypeList = useTypeList or {}

		for i, v in ipairs(slotDatas) do
			if v.fillerDefineId > 0 then
				local cfg = StargodplusConfig.instance:getFillerCfg(v.fillerDefineId)

				useTypeList[cfg.type] = true
				wearMos[v.slot] = self:getStarGodMo(v.fillerId)
			end
		end

		local co = CharacterConfig.instance:getPetCo(petMo.raceId)
		local recommendCfgs = StargodplusConfig.instance:getRecommendCfgs(co.SGPRecommendId)
		local maxQuality = -1
		local moList = self:getFillerMoList()
		local moGroupByQuality = {}

		for i, mo in ipairs(moList) do
			local defineId = mo:getDefineId()
			local cfg = StargodplusConfig.instance:getFillerCfg(defineId)

			if mo:getUsePetId() <= 0 and (cfg.bindRace == false or mo:getBindPetId() == petMo.raceId) then
				moGroupByQuality[cfg.quality] = moGroupByQuality[cfg.quality] or {}
				moGroupByQuality[cfg.quality][defineId] = mo
				maxQuality = math.max(maxQuality, cfg.quality)
			end
		end

		for slot, mo in pairs(wearMos) do
			local fillerId = mo:getId()
			local defineId = mo:getDefineId()
			local equipType = mo:getEquipType()

			if fillerId > 0 and defineId > 0 then
				local currMo = self:getStarGodMo(fillerId)
				local fcfg = StargodplusConfig.instance:getFillerCfg(defineId)
				local recCfg = recommendCfgs[slot]
				local recCfgKV = {}
				local recTypeKV = {}

				for i, rDefineId in ipairs(recCfg.recommend) do
					local cfg = StargodplusConfig.instance:getFillerCfg(rDefineId)

					if not useTypeList[cfg.type] then
						recCfgKV[rDefineId] = rDefineId
					end

					recTypeKV[cfg.type] = rDefineId
				end

				if maxQuality > fcfg.quality then
					for quality = maxQuality, fcfg.quality, -1 do
						if moGroupByQuality[quality] then
							local result = quality == fcfg.quality and (recTypeKV[fcfg.type] or self:_findReplaceMatchId(petId, slot, defineId, recTypeKV, moGroupByQuality[quality], equipType, useTypeList)) or self:_findReplaceMatchId(petId, slot, defineId, recTypeKV, moGroupByQuality[quality], equipType, useTypeList)

							if result then
								table.insert(finalList, result)

								break
							end
						end
					end
				elseif maxQuality == fcfg.quality and not recTypeKV[fcfg.type] then
					local result = self:_findReplaceMatchId(petId, slot, defineId, recTypeKV, moGroupByQuality[maxQuality], equipType, useTypeList)

					if result then
						table.insert(finalList, result)
					end
				end
			end
		end
	end

	return finalList
end

function StargodplusModel:_findReplaceMatchId(petId, slot, defineId, recTypeKV, moList, equipType, useTypeList)
	local petMo = BagPetsController.instance:getPet(petId)
	local isMatch = false
	local result
	local fcfg = StargodplusConfig.instance:getFillerCfg(defineId)
	local matchConditionMoList_eTypeKey = {}

	for _, mo2 in pairs(moList) do
		local etype = mo2:getEquipType()
		local dId = mo2:getDefineId()

		if etype == equipType or not useTypeList[etype] then
			matchConditionMoList_eTypeKey[etype] = mo2

			local cfg = StargodplusConfig.instance:getFillerCfg(dId)

			if recTypeKV[cfg.type] then
				result = {
					slot = slot,
					usedFillerId = mo2:getId()
				}
				useTypeList[etype] = true

				if etype ~= equipType then
					useTypeList[equipType] = nil
				end

				isMatch = true

				break
			end
		end
	end

	if not isMatch then
		local jobTypeIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)
		local rankCfg = StargodplusConfig.instance:getJobTypeRank(jobTypeIdx)
		local typeRecordList2 = {}

		for etype, mo in pairs(matchConditionMoList_eTypeKey) do
			table.insert(typeRecordList2, {
				mo = mo,
				etype = etype
			})
		end

		table.sort(typeRecordList2, function(a, b)
			return rankCfg[a.etype].rank < rankCfg[b.etype].rank
		end)

		local firstMo = table.remove(typeRecordList2, 1)

		if firstMo and (firstMo.mo:getQuality() > fcfg.quality or firstMo.mo:getQuality() == fcfg.quality and rankCfg[firstMo.etype].rank < rankCfg[fcfg.type].rank) then
			result = {
				slot = slot,
				usedFillerId = firstMo.mo:getId()
			}
			useTypeList[firstMo.etype] = true

			if firstMo.mo:getEquipType() ~= equipType then
				useTypeList[equipType] = nil
			end
		end
	end

	return result
end

function StargodplusModel:_findFillEmptySlotMatchId(petId, slot, recTypeKV, moList, useTypeList)
	local petMo = BagPetsController.instance:getPet(petId)
	local isMatch = false
	local result
	local matchConditionMoList_eTypeKey = {}

	for _, mo2 in pairs(moList) do
		local etype = mo2:getEquipType()
		local dId = mo2:getDefineId()

		if not useTypeList[etype] then
			matchConditionMoList_eTypeKey[etype] = mo2

			local cfg = StargodplusConfig.instance:getFillerCfg(dId)

			if recTypeKV[cfg.type] then
				result = {
					slot = slot,
					usedFillerId = mo2:getId()
				}
				useTypeList[etype] = true
				moList[mo2:getDefineId()] = nil
				isMatch = true

				break
			end
		end
	end

	if not isMatch then
		local jobTypeIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)
		local rankCfg = StargodplusConfig.instance:getJobTypeRank(jobTypeIdx)
		local typeRecordList2 = {}

		for etype, mo in pairs(matchConditionMoList_eTypeKey) do
			table.insert(typeRecordList2, {
				mo = mo,
				etype = etype
			})
		end

		table.sort(typeRecordList2, function(a, b)
			return rankCfg[a.etype].rank < rankCfg[b.etype].rank
		end)

		local firstMo = table.remove(typeRecordList2, 1)

		if firstMo then
			result = {
				slot = slot,
				usedFillerId = firstMo.mo:getId()
			}
			useTypeList[firstMo.etype] = true
			moList[firstMo.mo:getDefineId()] = nil
		end
	end

	return result
end

function StargodplusModel:setAutoDecomposeQuality(quality)
	self._autoDecomposeQuality = quality
end

function StargodplusModel:getAutoDecomposeQuality()
	return self._autoDecomposeQuality or -1
end

function StargodplusModel:getMaterialNumWithBindRace(defineId, raceId)
	local moList = self:getFillerMoList()
	local num = 0

	if moList then
		for k, mo in pairs(moList) do
			if mo:getDefineId() == defineId and mo:getBindPetId() == raceId then
				num = num + 1
			end
		end
	end

	return num
end

function StargodplusModel:getMaterialNumWithoutBindRace(defineId)
	local moList = self:getFillerMoList()
	local num = 0

	if moList then
		for k, mo in pairs(moList) do
			if mo:getDefineId() == defineId and mo:getBindPetId() <= 0 then
				num = num + 1
			end
		end
	end

	return num
end

function StargodplusModel:getMaterialNumWithCfg(cfgStr)
	local haveNum = 0
	local params = string.split(cfgStr, ":")
	local cfgId = checknumber(params[2])

	if #params <= 3 then
		haveNum = self:getMaterialNumWithoutBindRace(cfgId)
	else
		local raceId = checknumber(params[3])

		haveNum = self:getMaterialNumWithBindRace(cfgId, raceId)
	end

	return haveNum
end

StargodplusModel.instance = StargodplusModel.New()

return StargodplusModel
