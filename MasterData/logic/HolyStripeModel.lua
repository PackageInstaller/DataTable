-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/model/HolyStripeModel.lua

module("logic.extensions.holystripe.model.HolyStripeModel", package.seeall)

local HolyStripeModel = class("HolyStripeModel", BaseModel)

HolyStripeModel.DefaultAttr = {
	GameEnum.HolyStripeAttrType.Attack,
	GameEnum.HolyStripeAttrType.DefensePhysical,
	GameEnum.HolyStripeAttrType.DefenseMagic,
	GameEnum.HolyStripeAttrType.Hp
}
HolyStripeModel.NotAttrSort = {
	[-3] = "lv",
	[-5] = "discard",
	[-2] = "gainTime",
	[-1] = "equiped"
}
HolyStripeModel.TempSuitId = -100
HolyStripeModel.ReadFlag = "HolyStripeModel.ReadFlag"

function HolyStripeModel:ctor()
	self._holyStripeList = {}
	self._holyStripeMoList = {}
	self._pickHolyStripeList = {}
	self._autoSmeltDays = 0
	self._autoSmeltQuality = {}
	self._stengthTips = false
end

function HolyStripeModel:onInit()
	self:onReset()
end

function HolyStripeModel:onReset()
	self.holyStripeListInited = false
	self._holyStripeList = {}
	self._holyStripeMoList = {}
	self._curTempSuitMo = nil
end

function HolyStripeModel:getAllHolyStripeMo(excludeHolyStripeId)
	if not excludeHolyStripeId then
		return (self:getExistHolyStripeMoList())
	end

	local list = {}

	for i, v in pairs(self._holyStripeMoList) do
		if v and excludeHolyStripeId ~= v:getId() then
			table.insert(list, v)
		end
	end

	return list
end

function HolyStripeModel:getExistHolyStripeMoList()
	local newList = {}

	if self._holyStripeMoList == nil then
		return newList
	end

	for k, v in pairs(self._holyStripeMoList) do
		if v then
			table.insert(newList, v)
		end
	end

	return newList
end

function HolyStripeModel:getHolyStripeMo(holyStripeId)
	return self._holyStripeMoList[holyStripeId]
end

function HolyStripeModel:getUnequipHolyStripeMo()
	local list = {}

	for i, v in pairs(self._holyStripeMoList) do
		if v and v:getEquipPetId() < 0 then
			table.insert(list, v)
		end
	end

	return list
end

function HolyStripeModel:addHolyStripeMo(info)
	if info and info.id then
		local mo = self._holyStripeMoList[info.id]

		if not mo then
			mo = HolyStripeMo.New()
			self._holyStripeMoList[info.id] = mo
		end

		if info.deleted then
			self._holyStripeMoList[info.id] = nil
		else
			mo:initData(info)
		end

		return mo
	end
end

function HolyStripeModel:addHolyStripeMos(changedInfos)
	for i, v in ipairs(changedInfos) do
		local mo = self:addHolyStripeMo(v)

		if mo then
			BagPetsController.instance:updatePetHolyStripesAttrById(mo:getEquipPetId())
		end
	end
end

function HolyStripeModel:setHolyStripe(holyStripeList)
	for i, v in ipairs(holyStripeList) do
		self:addHolyStripeMo(v)
	end

	if self.holyStripeListInited == false then
		self.holyStripeListInited = true

		BagPetsController.instance:calcAllPetHolyStripesAttr()
	end
end

function HolyStripeModel:getEquippedByPetId(petId)
	if not self._holyStripeMoList then
		return {}
	end

	local list = {}

	for i, v in pairs(self._holyStripeMoList) do
		if v and v:getEquipPetId() == petId then
			table.insert(list, v)
		end
	end

	return list
end

function HolyStripeModel:getUnqequippedHolyStripe()
	local list = {}

	for i, v in ipairs(self._holyStripeMoList) do
		if v and v:getEquipPetId() == -1 then
			table.insert(list, v)
		end
	end

	return list
end

function HolyStripeModel:getCurrShowPetId()
	return BagPetsController.instance:GetCurPetId()
end

function HolyStripeModel:getCurShowFaceId()
	local petMo = BagPetsController.instance:GetCurPetMo()

	return petMo and petMo.curFaceId
end

function HolyStripeModel:getActiveSuitByPetId(petId)
	local list = {}

	for i, v in pairs(self._holyStripeMoList) do
		if v and v:getEquipPetId() == petId then
			table.insert(list, v)
		end
	end

	return list
end

function HolyStripeModel:getAllSuitList()
	local list = {}

	for i, v in pairs(self._holyStripeMoList) do
		if v then
			local cfg = HolyStripeConfig.instance:getHolyStripeCfg(v:getDefineId())

			list[cfg.suitType] = (list[cfg.suitType] or 0) + 1
		end
	end

	local result = {}

	for i, v in pairs(list) do
		table.insert(result, {
			type = i,
			num = v
		})
	end

	return result
end

function HolyStripeModel:getSuitLitByEquipList(equipList)
	local suitTypeCount = {}
	local suitList = {}

	for i, v in ipairs(equipList) do
		local cfg = HolyStripeConfig.instance:getHolyStripeCfg(v:getDefineId())

		suitTypeCount[cfg.suitType] = (suitTypeCount[cfg.suitType] or 0) + 1
	end

	for type, count in pairs(suitTypeCount) do
		local cfg = HolyStripeConfig.instance:getSuitCfgBySuitType(type)

		for i, v in ipairs(cfg) do
			if count >= v.num then
				table.insert(suitList, v)
			end
		end

		table.sort(suitList, function(cfg1, cfg2)
			return cfg1.num < cfg2.num
		end)
	end

	return suitList
end

function HolyStripeModel:getSuitListByPet(petId)
	local suitTypeCount = {}
	local suitList = {}
	local curPetId = petId

	if curPetId == nil then
		return {}
	end

	local equipList = self:getEquippedByPetId(curPetId)

	for i, v in ipairs(equipList) do
		local cfg = HolyStripeConfig.instance:getHolyStripeCfg(v:getDefineId())

		suitTypeCount[cfg.suitType] = (suitTypeCount[cfg.suitType] or 0) + 1
	end

	for type, count in pairs(suitTypeCount) do
		local cfg = HolyStripeConfig.instance:getSuitCfgBySuitType(type)

		for i, v in ipairs(cfg) do
			if count >= v.num then
				table.insert(suitList, v)
			end
		end

		table.sort(suitList, function(cfg1, cfg2)
			return cfg1.num < cfg2.num
		end)
	end

	return suitList
end

function HolyStripeModel:getCurSuitList()
	return self:getSuitListByPet(self:getCurrShowPetId())
end

function HolyStripeModel:getCurWearAttrList()
	local curPetId = self:getCurrShowPetId()
	local petMo = BagPetsController.instance:getExistPet(curPetId)

	return self:getWearAttrList(petMo)
end

function HolyStripeModel:getWearAttrList(petMo)
	local equipList = self:getEquippedByPetId(petMo.petId)
	local suitList = self:getSuitListByPet(petMo.petId)

	return self:getAttrListByMo(equipList, suitList)
end

function HolyStripeModel:getAttrListByMo(equipList, suitList)
	local list = {}

	for i, v in ipairs(equipList) do
		local temp = v:getAttrs()

		AttrMo.addSameAttrs(temp, list)
	end

	for i, v in ipairs(suitList or {}) do
		if not string.nilorempty(v.propertyParam) then
			local attrs = string.split(v.propertyParam, "#")
			local attrValues
			local temp = {}

			for i = 1, #attrs do
				local attrName, attrVal = HolyStripeController.instance:getAttrNameValue(attrs[i])

				temp[attrName] = attrVal
			end

			AttrMo.addSameAttrs(temp, list)
		end
	end

	local attrs = {}
	local beginattrs = {}
	local headattrs = {}

	for i, v in pairs(list) do
		local type = HolyStripeController.instance:getAttrTypeByName(i)

		if type then
			if self:_isDefaultAttr(type) then
				table.insert(headattrs, {
					type = type,
					value = v,
					name = i
				})
			else
				table.insert(beginattrs, {
					type = type,
					value = v,
					name = i
				})
			end
		else
			table.insert(attrs, {
				value = v,
				name = i
			})
		end
	end

	table.sort(headattrs, function(a, b)
		return a.type < b.type
	end)

	for i, v in ipairs(beginattrs) do
		table.insert(attrs, 1, v)
	end

	for i, v in ipairs(headattrs) do
		table.insert(attrs, 1, v)
	end

	return attrs
end

function HolyStripeModel:_isDefaultAttr(type)
	for i, v in ipairs(HolyStripeModel.DefaultAttr) do
		if type == v then
			return true
		end
	end

	return false
end

function HolyStripeModel:filterList(moList, suitId, posId)
	local list = {}

	for i, mo in ipairs(moList) do
		local cfg = HolyStripeConfig.instance:getHolyStripeCfg(mo:getDefineId())

		if (suitId == nil or cfg.suitType == suitId) and (posId == nil or cfg.positionType == posId) then
			table.insert(list, mo)
		end
	end

	return list
end

function HolyStripeModel:filterListBySuitId(moList, suitId)
	local list = {}

	for i, mo in ipairs(moList) do
		local cfg = HolyStripeConfig.instance:getHolyStripeCfg(mo:getDefineId())

		if cfg.suitType == suitId then
			table.insert(list, mo)
		end
	end

	return list
end

function HolyStripeModel:filterListByPosId(moList, posId)
	local list = {}

	for i, mo in ipairs(moList) do
		local cfg = HolyStripeConfig.instance:getHolyStripeCfg(mo:getDefineId())

		if cfg.positionType == posId then
			table.insert(list, mo)
		end
	end

	return list
end

function HolyStripeModel:filterListByQualityId(moList, qualityId)
	local list = {}

	for i, mo in ipairs(moList) do
		if mo:getQuality() == qualityId then
			table.insert(list, mo)
		end
	end

	return list
end

function HolyStripeModel:filterListByConditonId(moList, conditionFilterIds)
	local list = {}

	for i, mo in pairs(moList) do
		if mo:isAttrInMo(conditionFilterIds) == true then
			table.insert(list, mo)
		end
	end

	return list
end

function HolyStripeModel:filterListBySortId(moList, conditionSortId)
	local list

	if type(conditionSortId) ~= "number" then
		list = {}

		for i, v in pairs(moList) do
			local vline = v:getAttrInLine(conditionSortId)

			if vline > 0 then
				table.insert(list, v)
			end
		end
	else
		list = moList
	end

	return list
end

function HolyStripeModel:setAutoSmelt(smeltInfo)
	if smeltInfo == nil then
		self._autoSmeltDays = 0
		self._autoSmeltQuality = {}
	else
		for i, v in ipairs(smeltInfo.qualities) do
			table.insert(self._autoSmeltQuality, checknumber(v))
		end

		self._autoSmeltDays = checknumber(smeltInfo.days)
	end
end

function HolyStripeModel:getAutoSmeltQualityList()
	return self._autoSmeltQuality
end

function HolyStripeModel:getAutoSmeltDays()
	return self._autoSmeltDays
end

function HolyStripeModel:setCacheAutoSmelt(qualitys, day)
	self._autoSmeltQuality = qualitys
	self._autoSmeltDays = day
end

function HolyStripeModel:getNoAttrName(conditionId)
	local id = -conditionId

	return HolyStripeModel.NoAttrName[id]
end

function HolyStripeModel:haveRedPoint()
	return
end

function HolyStripeModel:petHaveRetPoint(petId)
	if not FuncOpenModel.instance:getFuncIsOpen(603) or petId == nil then
		return false
	end

	if checknumber(#self:getEquippedByPetId(petId)) < 5 and self:getIsPickHolyStripeSlot(petId) == nil then
		return true
	end

	return false
end

function HolyStripeModel:getIsPickHolyStripeSlot(petId)
	if petId then
		return GameUtil.getUserDayData(HolyStripeModel.ReadFlag .. petId)
	end

	return nil
end

function HolyStripeModel:setIsPickHolyStripeSlot(petId)
	if petId then
		GameUtil.saveUserDayData(HolyStripeModel.ReadFlag .. petId, true)
		GlobalDispatcher:dispatch(GlobalNotify.PetRedPointUpdate)
	end
end

function HolyStripeModel:getStrengthTip()
	return self._stengthTips
end

function HolyStripeModel:setStrengthTip(status)
	self._stengthTips = status
end

function HolyStripeModel:calcByHolyStripeAttrs(holyStripes, isMyPackPet)
	local res

	if isMyPackPet then
		res = {}

		local suitTypeCount = {}

		for i, v in pairs(holyStripes or {}) do
			local id = v.id
			local mo = self:getHolyStripeMo(id)

			if mo then
				local quenchingIds = mo:getQuenchingIds() or {}
				local quality = mo:getQuality()
				local positionType = mo:getPosType()
				local propertyParam = mo:getBasePropertyParam()
				local attrs = FightingPowerFormula.instance:parseAttrValues(propertyParam) or {}

				res = AttrMo.addSameAttrs(attrs, res)

				for j, qId in ipairs(quenchingIds) do
					local qCfg = HolyStripeConfig.instance:getQuenchingProperty(positionType, quality, qId)

					if qCfg then
						local attrs = FightingPowerFormula.instance:parseAttrValues(qCfg.propertyParam) or {}

						res = AttrMo.addSameAttrs(attrs, res)
						res[AttrMo.KEY_DIRECT_ZDL] = checknumber(res[AttrMo.KEY_DIRECT_ZDL]) + qCfg.numZdl
					end
				end

				suitTypeCount[mo:getSuitType()] = checknumber(suitTypeCount[mo:getSuitType()]) + 1
			end
		end

		for type, count in pairs(suitTypeCount) do
			local suitCfg = HolyStripeConfig.instance:getSuitCfgBySuitType(type)

			for i, v in ipairs(suitCfg) do
				if count >= v.num then
					local attrs = FightingPowerFormula.instance:parseAttrValues(v.propertyParam) or {}

					res = AttrMo.addSameAttrs(attrs, res)
					res[AttrMo.KEY_DIRECT_ZDL] = checknumber(res[AttrMo.KEY_DIRECT_ZDL]) + v.numZdl
				end
			end
		end
	else
		res = self:_calcByHolyStripeAllValueAttrs(holyStripes)
	end

	return res
end

function HolyStripeModel:_calcByHolyStripeAllValueAttrs(holyStripes)
	local res = {}
	local suitTypeCount = {}

	for i, v in pairs(holyStripes or {}) do
		local configId = v.configId
		local propertyId = v.propertyId
		local strengthenLv = v.strengthenLv

		if not v.quenchingIds then
			local cfg = HolyStripeConfig.instance:getHolyStripeCfg(configId)

			if cfg then
				local quality = cfg.quality
				local positionType = cfg.positionType
				local propCfg = HolyStripeConfig.instance:getPropertyCfg(positionType, propertyId)

				if propCfg then
					local propertyType = propCfg.propertyType
					local strengthCfg = HolyStripeConfig.instance:getMainPropertyByLv(propertyType, quality, strengthenLv)

					if strengthCfg then
						local attrs = FightingPowerFormula.instance:parseAttrValues(strengthCfg.propertyParam) or {}

						res = AttrMo.addSameAttrs(attrs, res)
					end
				end

				for j, qId in ipairs(v.quenchingIds) do
					local qCfg = HolyStripeConfig.instance:getQuenchingProperty(positionType, quality, qId)

					if qCfg then
						local attrs = FightingPowerFormula.instance:parseAttrValues(qCfg.propertyParam) or {}

						res = AttrMo.addSameAttrs(attrs, res)
						res[AttrMo.KEY_DIRECT_ZDL] = checknumber(res[AttrMo.KEY_DIRECT_ZDL]) + qCfg.numZdl
					end
				end

				suitTypeCount[cfg.suitType] = checknumber(suitTypeCount[cfg.suitType]) + 1
			end
		end
	end

	for type, count in pairs(suitTypeCount) do
		local suitCfg = HolyStripeConfig.instance:getSuitCfgBySuitType(type)

		for i, v in ipairs(suitCfg) do
			if count >= v.num then
				local attrs = FightingPowerFormula.instance:parseAttrValues(v.propertyParam) or {}

				res = AttrMo.addSameAttrs(attrs, res)
				res[AttrMo.KEY_DIRECT_ZDL] = checknumber(res[AttrMo.KEY_DIRECT_ZDL]) + v.numZdl
			end
		end
	end

	return res
end

function HolyStripeModel:getHolyStripeNum(id)
	local count = 0

	for i, v in pairs(self._holyStripeMoList) do
		if v and v:getDefineId() and v:getDefineId() == id then
			count = count + 1
		end
	end

	return count
end

function HolyStripeModel:saveTempHolyStripe(holyStripeMo)
	self._tempHolyStripe = holyStripeMo and clone(holyStripeMo) or nil
end

function HolyStripeModel:getTempHolyStripe()
	return self._tempHolyStripe
end

function HolyStripeModel:setSuitInfo(msg)
	self._isInSuitMap = {}
	self._suitGroupCount = 0
	self._suitGroup = {}

	for i, v in ipairs(msg.groups or {}) do
		self._suitGroup[v.groupId] = {
			groupId = v.groupId,
			groupName = v.groupName
		}
		self._suitGroupCount = self._suitGroupCount + 1
	end

	self._suitInfos = {}

	for i, v in ipairs(msg.suits or {}) do
		local suitMo = HolyStripeSuitMo.New()

		suitMo:initData(v)

		self._suitInfos[suitMo.suitId] = suitMo

		for i, v in pairs(suitMo.wearIds) do
			self._isInSuitMap[v] = suitMo.suitId
		end
	end
end

function HolyStripeModel:setSuitGroupChange(msg)
	if msg.deletedSuitGroupIds then
		for i, v in ipairs(msg.deletedSuitGroupIds) do
			self._suitGroup[v] = nil
			self._suitGroupCount = self._suitGroupCount - 1
		end
	end

	if msg.suitGroupInfos then
		for i, v in ipairs(msg.suitGroupInfos) do
			if not self._suitGroup[v.groupId] then
				self._suitGroupCount = self._suitGroupCount + 1
			end

			self._suitGroup[v.groupId] = {
				groupId = v.groupId,
				groupName = v.groupName
			}
		end
	end
end

function HolyStripeModel:setSuitChange(msg)
	if msg.deletedSuitIds then
		for i, v in ipairs(msg.deletedSuitIds) do
			self._suitInfos[v] = nil
		end
	end

	if msg.suitInfos then
		for i, v in ipairs(msg.suitInfos) do
			local suitMo = HolyStripeSuitMo.New()

			suitMo:initData(v)

			self._suitInfos[suitMo.suitId] = suitMo
		end
	end

	self._isInSuitMap = {}

	for i, suitMo in pairs(self._suitInfos) do
		for j, v in pairs(suitMo.wearIds) do
			self._isInSuitMap[v] = suitMo.suitId
		end
	end
end

function HolyStripeModel:getSuitGroupList()
	local result = {}

	for i, v in pairs(self._suitGroup) do
		table.insert(result, v)
	end

	table.sort(result, function(a, b)
		return a.groupId < b.groupId
	end)

	return result
end

function HolyStripeModel:getSuitGroupById(groupId)
	return self._suitGroup[groupId]
end

function HolyStripeModel:getSuitGroupCount()
	return math.max(self._suitGroupCount, 0)
end

function HolyStripeModel:getSuitListByGroup(groupId)
	local result = {}

	for i, v in pairs(self._suitInfos or {}) do
		if v.groupId == groupId then
			table.insert(result, v)
		end
	end

	table.sort(result, function(a, b)
		return a.suitId < b.suitId
	end)

	return result
end

function HolyStripeModel:getSuitMo(suitId)
	if suitId == HolyStripeModel.TempSuitId then
		return self._curTempSuitMo
	end

	return self._suitInfos[suitId]
end

function HolyStripeModel:getAllSuitMo()
	return self._suitInfos
end

function HolyStripeModel:getIsInSuit(holyStripeId)
	if self._isInSuitMap then
		return self._isInSuitMap[holyStripeId] or 0
	else
		return 0
	end
end

function HolyStripeModel:createTempSuitMo(groupId)
	self:clearTempSuitMo()

	self._curTempSuitMo = HolyStripeSuitMo.New()

	local info = {
		groupId = groupId,
		suitId = HolyStripeModel.TempSuitId,
		suitName = lang("新建套装")
	}

	self._curTempSuitMo:initData(info)
end

function HolyStripeModel:clearTempSuitMo()
	self._curTempSuitMo = nil
end

function HolyStripeModel:saveSuitReplaceTip()
	GameUtil.saveUserDayData(HolyStripeModel.ReadFlag .. "#SuitReplaceTip", true)
end

function HolyStripeModel:getSuitReplaceTip()
	return GameUtil.getUserDayData(HolyStripeModel.ReadFlag .. "#SuitReplaceTip")
end

function HolyStripeModel:saveRecommendCalculateSetting(mainAttrPriority, subAttrPriority, selectSuit, raceId, projectIndex)
	local info = {}

	info.mainAttrPriority = mainAttrPriority
	info.subAttrPriority = subAttrPriority
	info.selectSuit = selectSuit

	local resultString = GameUtil.jsonToString(info)
	local key = string.format("%s#RecommendSetting#%d%d", HolyStripeModel.ReadFlag, raceId, projectIndex)

	GameUtil.saveUserData(key, resultString)
end

function HolyStripeModel:getRecommendCalculateSetting(raceId, projectIndex)
	local key = string.format("%s#RecommendSetting#%d%d", HolyStripeModel.ReadFlag, raceId, projectIndex)
	local result = GameUtil.getUserData(key)
	local info = GameUtil.jsonToTable(result)

	if info then
		return info.mainAttrPriority, info.subAttrPriority, info.selectSuit
	else
		return nil, nil, nil
	end
end

function HolyStripeModel:setAutoDecomposeQuality(quality)
	self._autoDecomposeQuality = quality
end

function HolyStripeModel:getAutoDecomposeQuality()
	return self._autoDecomposeQuality or -1
end

HolyStripeModel.instance = HolyStripeModel.New()

return HolyStripeModel
