-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/model/HolyStripeMo.lua

module("logic.extensions.holystripe.model.HolyStripeMo", package.seeall)

local HolyStripeMo = class("HolyStripeMo", MaterialMo)

function HolyStripeMo:ctor()
	self:onReset()
end

function HolyStripeMo:onReset()
	self._configId = 0
	self._type = 0
	self._id = 0
	self._num = 0
	self._equipPetId = -1
	self._strengthenLv = 0
	self._equipRaceId = 0
	self._propertyId = 0
	self._exp = 0
	self.exp = 0
	self._quenchingIds = {}
	self._isLock = false
	self._readyToDiscard = false
	self._replacequenchingDatas = nil
	self._isDeleted = false
	self._cfg = nil
	self.quality = 0
	self._propertyType = 0
	self._costCfgs = {}
	self._zdl = 0
	self._isBagMo = false
end

function HolyStripeMo:initData(info)
	self._info = info
	self._type = MatType.HolyStripe
	self._id = info.id
	self._configId = info.configId
	self._equipPetId = info.equippedPetId

	local petMo = BagPetsController.instance:getPet(self._equipPetId)

	self._equipRaceId = petMo and petMo.raceId
	self._propertyId = info.propertyId
	self._strengthenLv = 0
	self._exp = info.exp
	self.exp = info.exp
	self._quenchingIds = info.quenchingIds
	self._isLock = info.lock
	self._readyToDiscard = info.readyToDiscard == true
	self._replacequenchingDatas = info.replacequenchingDatas
	self._isDeleted = info.deleted
	self._cfg = HolyStripeConfig.instance:getHolyStripeCfg(self._configId)
	self.quality = self._cfg.quality
	self._propertyType = HolyStripeConfig.instance:getPropertyTypeByConfig(self._cfg.positionType, self._propertyId)
	self._costCfgs = self:_loadCostCfgs(self.quality)

	local num = self:_calcDirectZdl() or 0

	for k, v in pairs(self:getAttrs()) do
		local value = CharacterConfig.instance:getPropZdlValue(k)

		num = num + v * value
	end

	self._zdl = math.round(num)
	self._isBagMo = true
end

function HolyStripeMo:initDataByMsg(info)
	self:onReset()

	self._info = info
	self._type = MatType.HolyStripe
	self._id = info.id
	self._configId = checknumber(info.configId)
	self._propertyId = checknumber(info.propertyId)
	self._strengthenLv = checknumber(info.strengthenLv)
	self._quenchingIds = info.quenchingIds
	self._cfg = HolyStripeConfig.instance:getHolyStripeCfg(self._configId)
	self.quality = self._cfg.quality
	self._propertyType = HolyStripeConfig.instance:getPropertyTypeByConfig(self._cfg.positionType, self._propertyId)
	self._costCfgs = self:_loadCostCfgs(self.quality)

	local num = self:_calcDirectZdl() or 0

	for k, v in pairs(self:getAttrs()) do
		local value = CharacterConfig.instance:getPropZdlValue(k)

		num = num + v * value
	end

	self._zdl = math.round(num)
	self._isBagMo = false
end

function HolyStripeMo:getMatType()
	return self._type
end

function HolyStripeMo:getDefineId()
	return self._configId
end

function HolyStripeMo:getId()
	return self._id
end

function HolyStripeMo:isBagMo()
	return self._isBagMo
end

function HolyStripeMo:getEquipPetId()
	return self._equipPetId
end

function HolyStripeMo:getEquipRaceId()
	return self._equipRaceId
end

function HolyStripeMo:getPropertyType()
	return self._propertyType
end

function HolyStripeMo:getLv()
	if self._strengthenLv > 0 then
		return self._strengthenLv
	else
		return self:getLvByAddExp(0)
	end
end

function HolyStripeMo:getLvByAddExp(addExp)
	local startIndex = self._costCfgs[0] and 0 or 1
	local lv = startIndex

	addExp = addExp or 0

	for i = startIndex, #self._costCfgs do
		if self._exp + addExp < self._costCfgs[i].exp then
			return lv
		end

		lv = self._costCfgs[i].level
	end

	local data = self._costCfgs[#self._costCfgs]

	return (data or nil) and (data.level or 0)
end

function HolyStripeMo:getNextLv()
	local lv = self:getLv()
	local nextLv = lv + 1

	if self._costCfgs[nextLv] then
		return nextLv
	end

	return lv
end

function HolyStripeMo:getNextLvByAddExp(addExp)
	addExp = addExp or 0

	local lv = self:getLvByAddExp(addExp)
	local nextLv = lv + 1

	if self._costCfgs[nextLv] then
		return nextLv
	end

	return lv
end

function HolyStripeMo:getMaxStrengthExp()
	local data = self._costCfgs[#self._costCfgs]

	return (data or nil) and (data.exp or 0)
end

function HolyStripeMo:getMaxLv()
	return #self._costCfgs
end

function HolyStripeMo:getQuenchingIds()
	return self._quenchingIds
end

function HolyStripeMo:getPropertyId()
	return self._propertyId
end

function HolyStripeMo:_loadCostCfgs(quality)
	return HolyStripeConfig.instance:getStrengthCostCfgs(quality) or {}
end

function HolyStripeMo:getExp()
	return self._exp
end

function HolyStripeMo:getNextLvCostCfg()
	local lv = self:getNextLv()

	return self._costCfgs[lv]
end

function HolyStripeMo:getLvCostCfg(lv)
	return self._costCfgs[lv]
end

function HolyStripeMo:getLvCostExp(lv)
	local data = self._costCfgs[lv]

	return (data or nil) and (data.exp or 0)
end

function HolyStripeMo:getRefundExp()
	return self._cfg.refundExp
end

function HolyStripeMo:getQuenchingCost()
	return self._cfg.quenchingCost
end

function HolyStripeMo:getRefundExpFromMat()
	local mats = HolyStripeConfig.instance:getStrengthMats()
	local params = string.split(self:getRefundMaterials(), "#")
	local _, id, num
	local totalExp = 0

	for i, v in ipairs(params) do
		_, id, num = MaterialMgr.getMatParams(v)

		for i = #mats, 1, -1 do
			if mats[i].matId == id then
				totalExp = totalExp + mats[i].exp * num
			end
		end
	end

	return totalExp
end

function HolyStripeMo:getAllQuenchingCfgs()
	return HolyStripeConfig.instance:getQuenchingPropertys(self._cfg.positionType, self._cfg.quality)
end

function HolyStripeMo:getBasePropertyParam(lv)
	lv = lv or self:getLv()

	local cfg = HolyStripeConfig.instance:getMainPropertyByLv(self._propertyType, self._cfg.quality, lv)

	return cfg.propertyParam
end

function HolyStripeMo:getQuenchingPropertyParam()
	local str = ""

	for i, id in ipairs(self._quenchingIds) do
		local cfg = HolyStripeConfig.instance:getQuenchingProperty(self._cfg.positionType, self._cfg.quality, id)

		if cfg then
			str = str ~= "" and str .. "#" .. cfg.propertyParam or cfg.propertyParam
		end
	end

	return str
end

function HolyStripeMo:getQuenchingPropertyDoc()
	local str = ""

	for i, id in ipairs(self._quenchingIds) do
		local cfg = HolyStripeConfig.instance:getQuenchingProperty(self._cfg.positionType, self._cfg.quality, id)

		if cfg then
			str = str ~= "" and str .. "#" .. cfg.doc or cfg.doc
		end
	end

	return str
end

function HolyStripeMo:getQuenchingPropertyCfg(id)
	return HolyStripeConfig.instance:getQuenchingProperty(self._cfg.positionType, self._cfg.quality, id)
end

function HolyStripeMo:getPosType()
	return self._cfg.positionType
end

function HolyStripeMo:getIsLock()
	return self._isLock
end

function HolyStripeMo:setLocked(type)
	self._isLock = type
end

function HolyStripeMo:getIsReadyToDiscard()
	return self._readyToDiscard == true
end

function HolyStripeMo:setReadyToDiscard(isDiscard)
	self._readyToDiscard = isDiscard == true
end

function HolyStripeMo:getRefundMaterials()
	return self._cfg.refundMaterials
end

function HolyStripeMo:getQuality()
	return self._cfg.quality
end

function HolyStripeMo:getAttrs()
	local mainProperty = HolyStripeConfig.instance:getMainPropertyByLv(self._propertyType, self._cfg.quality, self:getLv()).propertyParam
	local subProperty, zdl = self:_getSubProperty(self:getDefineId(), self:getQuenchingIds(), self:getLv())

	return (self:_getAttrsWithMainAndSubProperty(mainProperty, subProperty))
end

function HolyStripeMo:getAttrsToCommon()
	local mainAttrParam = string.split(self:getBasePropertyParam(), "#")
	local subAttrParam = string.split(self:getQuenchingPropertyDoc(), "#")
	local attrParams = {}

	for i, mainAttr in ipairs(mainAttrParam) do
		mainAttr = string.split(mainAttr, "+")

		table.insert(attrParams, {
			name = mainAttr[1],
			value = tonumber(mainAttr[2])
		})
	end

	for i, v in ipairs(subAttrParam) do
		local attr = string.split(v, "+")
		local isHad = false

		for i, v in ipairs(attrParams) do
			if v.name == attr[1] then
				isHad = true
				attrParams[i].value = attrParams[i].value + tonumber(attr[2])

				break
			end
		end

		if not isHad then
			table.insert(attrParams, {
				name = attr[1],
				value = attr[2]
			})
		end
	end

	local list = {}

	for i, attr in ipairs(attrParams) do
		local idx = table.keyof(GameEnum.HolyStripeAttrTypeName, attr.name)

		if idx > 0 then
			table.insert(list, {
				id = idx,
				name = attr.name,
				value = attr.value
			})
		end
	end

	return list
end

function HolyStripeMo:_getAttrsWithMainAndSubProperty(mainPropertyApp, subPropertyApps)
	local res = {}

	if mainPropertyApp then
		if string.nilorempty(mainPropertyApp) then
			return res
		end

		local attrs = string.split(mainPropertyApp, "#")
		local attrValues
		local temp = {}

		for i = 1, #attrs do
			local attrName, attrVal = HolyStripeController.instance:getAttrNameValue(attrs[i])

			temp[attrName] = attrVal
		end

		AttrMo.addSameAttrs(temp, res)
	end

	if subPropertyApps and next(subPropertyApps) then
		for i, v in ipairs(subPropertyApps) do
			if string.nilorempty(v) then
				return
			end

			local attrs = string.split(v, "#")
			local attrValues
			local temp = {}

			for i = 1, #attrs do
				local attrName, attrVal = HolyStripeController.instance:getAttrNameValue(attrs[i])

				temp[attrName] = attrVal
			end

			AttrMo.addSameAttrs(temp, res)
		end
	end

	return res
end

function HolyStripeMo:_getSubProperty(configId, ids, lv)
	local list = {}
	local zdl = 0
	local cfg = HolyStripeConfig.instance:getHolyStripeCfg(configId)

	for i, v in ipairs(ids) do
		local quenchingCfg = HolyStripeConfig.instance:getQuenchingProperty(cfg.positionType, cfg.quality, v)

		if quenchingCfg then
			local property = quenchingCfg.doc

			zdl = zdl + quenchingCfg.numZdl

			table.insert(list, property)
		end
	end

	return list, zdl
end

function HolyStripeMo:getAttrInLine(id)
	if id == 0 or GameEnum.HolyStripeAttrType[id] == nil then
		return 0
	end

	local value = 0
	local mainProperty = HolyStripeConfig.instance:getMainPropertyByLv(self._propertyType, self._cfg.quality, self:getLv()).propertyParam
	local res = HolyStripeController.instance:parseAttrValues(mainProperty) or {}

	value = value + checknumber(res[GameEnum.HolyStripeAttrType[id]])

	local subProperty = self:_getSubProperty(self:getDefineId(), self:getQuenchingIds(), self:getLv())

	for i, v in ipairs(subProperty) do
		res = HolyStripeController.instance:parseAttrValues(v) or {}
		value = value + checknumber(res[GameEnum.HolyStripeAttrType[id]])
	end

	return value
end

function HolyStripeMo:isAttrInMo(ids)
	if ids and #ids == 0 then
		return true
	end

	local checkMap = {}
	local mainProperty = HolyStripeConfig.instance:getMainPropertyByLv(self._propertyType, self._cfg.quality, self:getLv()).propertyParam
	local res = HolyStripeController.instance:parseAttrValues(mainProperty) or {}

	for attrType, attrVal in pairs(res) do
		if checknumber(attrVal) > 0 then
			checkMap[attrType] = true
		end
	end

	local subProperty = self:_getSubProperty(self:getDefineId(), self:getQuenchingIds(), self:getLv())

	for i, v in ipairs(subProperty) do
		res = HolyStripeController.instance:parseAttrValues(v) or {}

		for attrType, attrVal in pairs(res) do
			if checknumber(attrVal) > 0 then
				checkMap[attrType] = true
			end
		end
	end

	local isInMo = true

	for i, v in ipairs(ids) do
		if not checkMap[GameEnum.HolyStripeAttrType[v]] then
			isInMo = false

			break
		end
	end

	return isInMo
end

function HolyStripeMo:getName()
	return self._cfg.name
end

function HolyStripeMo:setCuiling(oldId, newId)
	for i, v in pairs(self._quenchingIds) do
		if v == oldId then
			self._quenchingIds[i] = newId

			break
		end
	end
end

function HolyStripeMo:getSuitType()
	return self._cfg.suitType
end

function HolyStripeMo:getZdl()
	return self._zdl
end

function HolyStripeMo:_calcDirectZdl()
	local subProperty, zdl = self:_getSubProperty(self:getDefineId(), self:getQuenchingIds(), self:getLv())

	return zdl
end

return HolyStripeMo
