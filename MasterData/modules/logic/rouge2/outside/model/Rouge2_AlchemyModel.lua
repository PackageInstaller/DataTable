-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_AlchemyModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_AlchemyModel", package.seeall)

local Rouge2_AlchemyModel = class("Rouge2_AlchemyModel", BaseModel)

function Rouge2_AlchemyModel:onInit()
	self:reInit()
end

function Rouge2_AlchemyModel:reInit()
	self._materialCountDic = {}
	self._materialIdList = {}
	self._curAlchemyInfo = {}
	self._unlockFormulaList = {}
	self._unlockFormulaDic = {}
	self._newUnlockFormulaList = {}
	self._curFormulaId = nil
	self._curMainMaterialList = nil
	self._curSubMaterialList = nil
	self._curSubMaterialDic = {}
	self._curSubMaterialPosDic = {}
	self._curSubMaterialAddList = {}
end

function Rouge2_AlchemyModel:updateInfo(alchemyInfo)
	tabletool.clear(self._materialCountDic)
	tabletool.clear(self._materialIdList)

	if alchemyInfo then
		self._curAlchemyInfo = alchemyInfo.curAlchemyInfo

		if alchemyInfo.alchemyMaterialInfo then
			for _, materialInfo in ipairs(alchemyInfo.alchemyMaterialInfo) do
				local id = materialInfo.id

				if not self._materialCountDic[id] then
					self._materialCountDic[id] = materialInfo.num

					table.insert(self._materialIdList, id)
				else
					logError("Rouge2Outside materialId already exist id: " .. tostring(id))
				end
			end
		end
	end

	self:updateFormulaInfo()
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.onAlchemyInfoUpdate)
end

function Rouge2_AlchemyModel:updateFormulaInfo()
	self:checkNewUnlockFormula()
	tabletool.clear(self._unlockFormulaList)
	tabletool.clear(self._unlockFormulaDic)

	local configList = Rouge2_OutSideConfig.instance:getFormulaConfigList()

	for _, config in ipairs(configList) do
		if self:isFormulaUnlock(config.id) then
			table.insert(self._unlockFormulaList, config.id)

			self._unlockFormulaDic[config.id] = config.id
		end
	end

	Rouge2_OutsideModel.instance:checkFormulaRedDot()
	table.sort(self._unlockFormulaList, Rouge2_AlchemyModel.sortFormula)
end

function Rouge2_AlchemyModel:checkNewUnlockFormula()
	tabletool.clear(self._newUnlockFormulaList)

	local configList = Rouge2_OutSideConfig.instance:getFormulaConfigList()

	for _, config in ipairs(configList) do
		if not string.nilorempty(config.condition) then
			local isUnlock = Rouge2_AlchemyModel.instance:isFormulaUnlock(config.id)

			if isUnlock and not self._unlockFormulaDic[config.id] then
				table.insert(self._newUnlockFormulaList, config.id)
			end
		end
	end
end

function Rouge2_AlchemyModel:getNewUnlockFormula()
	return self._newUnlockFormulaList
end

function Rouge2_AlchemyModel:getUnlockFormulaList()
	return self._unlockFormulaList
end

function Rouge2_AlchemyModel.sortFormula(a, b)
	local configA = Rouge2_OutSideConfig.instance:getFormulaConfig(a)
	local configB = Rouge2_OutSideConfig.instance:getFormulaConfig(b)

	if configA.sort == configB.sort then
		return configA.id < configB.id
	end

	return configA.sort < configB.sort
end

function Rouge2_AlchemyModel:getMaterialNum(materialId)
	return self._materialCountDic[materialId] or 0
end

function Rouge2_AlchemyModel:getAllMaterialList()
	return self._materialIdList
end

function Rouge2_AlchemyModel:getAllFormulaList()
	return self._unlockFormulaList
end

function Rouge2_AlchemyModel:canMakeFormula()
	local unlockFormulaList = self:getAllFormulaList()

	if not unlockFormulaList or next(unlockFormulaList) == nil then
		return false
	end

	for _, formulaId in ipairs(unlockFormulaList) do
		local formulaConfig = Rouge2_OutSideConfig.instance:getFormulaConfig(formulaId)

		if string.nilorempty(formulaConfig.mainIdNum) then
			return true
		else
			local canMake = true
			local materialParam = string.split(formulaConfig.mainIdNum, "|")

			for _, param in ipairs(materialParam) do
				local data = string.splitToNumber(param, "#")
				local haveNum = self:getMaterialNum(data[1])

				if not haveNum or haveNum < data[2] then
					canMake = false

					break
				end
			end

			if canMake then
				return true
			end
		end
	end

	return false
end

function Rouge2_AlchemyModel:isFormulaUnlock(formulaId)
	local formulaConfig = Rouge2_OutSideConfig.instance:getFormulaConfig(formulaId)

	if string.nilorempty(formulaConfig.condition) then
		return true
	end

	return Rouge2_MapUnlockHelper.checkIsUnlock(formulaConfig.condition)
end

function Rouge2_AlchemyModel:getHaveAlchemyInfo()
	return self._curAlchemyInfo
end

function Rouge2_AlchemyModel:haveAlchemyInfo()
	return self._curAlchemyInfo ~= nil and self._curAlchemyInfo.formula ~= nil and self._curAlchemyInfo.formula ~= 0
end

function Rouge2_AlchemyModel:getCurFormula()
	return self._curFormulaId
end

function Rouge2_AlchemyModel:setCurFormula(formulaId)
	self._curFormulaId = formulaId

	local materialList = {}

	if formulaId ~= nil then
		local formulaConfig = Rouge2_OutSideConfig.instance:getFormulaConfig(formulaId)
		local param = string.split(formulaConfig.mainIdNum, "|")

		for _, materialParam in ipairs(param) do
			local info = string.splitToNumber(materialParam, "#")

			table.insert(materialList, info[1])
		end
	end

	self:setCurMainMaterial(materialList)
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.onSelectAlchemyFormula, formulaId)
end

function Rouge2_AlchemyModel:getCurMainMaterialList()
	return self._curMainMaterialList
end

function Rouge2_AlchemyModel:setCurMainMaterial(materialList)
	self._curMainMaterialList = materialList
end

function Rouge2_AlchemyModel:getCurSubMaterialList()
	return self._curSubMaterialList
end

function Rouge2_AlchemyModel:setCurSubMaterial(materialList)
	self._curSubMaterialList = materialList
end

function Rouge2_AlchemyModel:setCurSubMaterialDic(index, materialId)
	local previousMaterialId = self._curSubMaterialDic[index]

	self._curSubMaterialDic[index] = materialId

	if previousMaterialId ~= nil then
		self._curSubMaterialPosDic[previousMaterialId] = nil

		local materialIndex

		for i, id in ipairs(self._curSubMaterialAddList) do
			if id == previousMaterialId then
				materialIndex = i

				break
			end
		end

		table.remove(self._curSubMaterialAddList, materialIndex)
	end

	if materialId ~= nil then
		self._curSubMaterialPosDic[materialId] = index

		table.insert(self._curSubMaterialAddList, materialId)
	end

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.onSelectAlchemySubMaterial, materialId)
end

function Rouge2_AlchemyModel:isSelectSubMaterial(materialId)
	return self._curSubMaterialPosDic and self._curSubMaterialPosDic[materialId] ~= nil
end

function Rouge2_AlchemyModel:getCurSubMaterialDic()
	return self._curSubMaterialDic
end

function Rouge2_AlchemyModel:getCurSubMaterialAddList()
	return self._curSubMaterialAddList
end

function Rouge2_AlchemyModel:getCurSubMaterialPosDic()
	return self._curSubMaterialPosDic
end

function Rouge2_AlchemyModel:getCurSubMaterialIndex(materialId)
	return self._curSubMaterialPosDic and self._curSubMaterialPosDic[materialId]
end

function Rouge2_AlchemyModel:clearFormula()
	self._curFormulaId = nil

	if self._curMainMaterialList then
		tabletool.clear(self._curMainMaterialList)
	end

	if self._curSubMaterialDic then
		tabletool.clear(self._curSubMaterialDic)
	end

	if self._curSubMaterialPosDic then
		tabletool.clear(self._curSubMaterialPosDic)
	end

	if self._curSubMaterialAddDic then
		tabletool.clear(self._curSubMaterialAddList)
	end

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.onAlchemyFormulaClear)
end

Rouge2_AlchemyModel.instance = Rouge2_AlchemyModel.New()

return Rouge2_AlchemyModel
