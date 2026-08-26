-- chunkname: @modules/logic/versionactivity3_6/yami/model/V3a6YaMiModel.lua

module("modules.logic.versionactivity3_6.yami.model.V3a6YaMiModel", package.seeall)

local V3a6YaMiModel = class("V3a6YaMiModel", BaseModel)

function V3a6YaMiModel:onInit()
	self:reInit()
end

function V3a6YaMiModel:reInit()
	self._heroDict = nil
	self._productDict = nil
	self._selectProductSubType = nil
	self._selectProductMaterials = nil
	self._equipedHeros = nil
	self._productId = nil
	self._gameStatus = nil
	self._heroTeamAttrMo = nil
	self._researchInfo = nil
	self._seatMos = nil
end

function V3a6YaMiModel:getActId()
	return VersionActivity3_6Enum.ActivityId.YaMi
end

function V3a6YaMiModel:refreshInfo(info)
	self._money = info.money

	local seatCount = self:getSeatCount()
	local unlockSeatIds = {}

	if info.unlockSeatIds then
		for i = 1, #info.unlockSeatIds do
			unlockSeatIds[info.unlockSeatIds[i]] = true
		end
	end

	for i = 1, seatCount do
		self:refreshUnlockSeat(i, unlockSeatIds[i])
	end

	self._totalExp = info.exp or 0
	self._level, self._exp = self:parseLevelExp(self._totalExp)

	if not self._heroDict then
		self:_initHeroMoList()
	end

	if info.researchers then
		local unlockHero = {}

		for i = 1, #info.researchers do
			local _info = info.researchers[i]
			local mo = self:getHeroMoById(_info.id)

			mo:refreshInfo(_info)

			unlockHero[_info.id] = true
		end

		for _, mo in pairs(self._heroDict) do
			mo:setLock(not unlockHero[mo.id])
		end
	end

	if not self._productDict then
		self:_initProductMoList()
	end

	if info.illustrations then
		local unlockProduct = {}

		for i = 1, #info.illustrations do
			local _info = info.illustrations[i]
			local mo = self:getProductMoById(_info.id)

			mo:refreshInfo(_info)

			unlockProduct[_info.id] = true
		end

		for _, mo in pairs(self._productDict) do
			mo:setLock(not unlockProduct[mo.id])
		end
	end

	self:refreshResearchInfo(info.researchInfo)
	self:refreshMission(info.missions)
end

function V3a6YaMiModel:_initHeroMoList()
	self._heroDict = {}

	local actId = self:getActId()
	local list = lua_activity231_researcher.configDict[actId]

	for _, co in pairs(list) do
		local mo = V3a6YaMiHeroMO.New()

		mo:initConfig(co)

		self._heroDict[co.id] = mo
	end
end

function V3a6YaMiModel:getHeroMoById(id)
	return self._heroDict[id]
end

function V3a6YaMiModel:getHeroDict()
	if not self._heroDict then
		self:_initHeroMoList()
	end

	return self._heroDict
end

function V3a6YaMiModel:unlockHero(info)
	local heroMo = self:getHeroMoById(info.id)

	heroMo:setLock(false)
end

function V3a6YaMiModel:_initProductMoList()
	self._productDict = {}

	local actId = self:getActId()
	local list = lua_activity231_invention.configDict[actId]

	for _, co in pairs(list) do
		local mo = V3a6YaMiProductMO.New()

		mo:initConfig(co)

		self._productDict[co.id] = mo
	end
end

function V3a6YaMiModel:getProductMoById(id)
	if not self._productDict then
		self:_initProductMoList()
	end

	return self._productDict[id]
end

function V3a6YaMiModel:getProductDict()
	if not self._productDict then
		self:_initProductMoList()
	end

	return self._productDict
end

function V3a6YaMiModel:getWillProductMo()
	if not self._productId then
		self:getGenerateProduct()
	end

	return self:getProductMoById(self._productId)
end

function V3a6YaMiModel:initMaterialMos()
	self._materialDict = {}
	self._materialSubTypeDict = {}

	local actId = self:getActId()
	local list = lua_activity231_material.configDict[actId]

	for _, co in pairs(list) do
		local mo = V3a6YaMiMaterialMO.New()

		mo:initMo(co)

		local dict = self._materialSubTypeDict[co.type]

		if not dict then
			dict = {}
			self._materialSubTypeDict[co.type] = dict
		end

		table.insert(self._materialSubTypeDict[co.type], mo)

		self._materialDict[co.id] = mo
	end
end

function V3a6YaMiModel:getMaterialMo(id)
	if not self._materialDict then
		self:initMaterialMos()
	end

	return self._materialDict[id]
end

function V3a6YaMiModel:getMaterialMosByType(type)
	if not self._materialSubTypeDict then
		self:initMaterialMos()
	end

	return self._materialSubTypeDict[type]
end

function V3a6YaMiModel:getCurSelectMaterialCost()
	local cost = 0

	if self._selectProductSubType then
		local mo = self:getMaterialMo(self._selectProductSubType)

		cost = mo and mo.co.cost or 0
	end

	if self._selectProductMaterials then
		for _, id in ipairs(self._selectProductMaterials) do
			local mo = self:getMaterialMo(id)

			cost = cost + ((mo or nil) and (mo.co.cost or 0))
		end
	end

	return cost
end

function V3a6YaMiModel:onSelectProductRecipe(id)
	local mo = self:getProductMoById(id)

	if mo then
		if mo.isLock then
			return
		end

		local cost = self:_getCostRecipe(mo.subType, mo.materials)
		local isEnoughCurrency = self:isEnoughCurrency(cost)

		if not isEnoughCurrency then
			GameFacade.showToast(V3a6YaMiEnum.ToastId.NoEnoughMoney)

			return
		end

		self._selectProductSubType = mo.subType
		self._selectProductMaterials = tabletool.copy(mo.materials)
	end
end

function V3a6YaMiModel:_getCostRecipe(subType, materials)
	local cost = 0

	if subType then
		local mo = self:getMaterialMo(subType)

		if mo then
			cost = mo.co.cost
		end
	end

	if materials then
		for _, id in ipairs(materials) do
			local mo = self:getMaterialMo(id)

			if mo then
				cost = cost + mo.co.cost
			end
		end
	end

	return cost
end

function V3a6YaMiModel:onSelectProductMaterial(type, id)
	local isSelect = false

	if type == V3a6YaMiEnum.MaterialType.SubType then
		if self._selectProductSubType == id then
			self._selectProductSubType = nil
			isSelect = false
		else
			local isCanSelect, toast = self:_isCanSelectMaterial(id)

			if not isCanSelect then
				return false, toast
			end

			self._selectProductSubType = id
			isSelect = true
		end
	else
		local list = self._selectProductMaterials

		if not list then
			list = {}
			self._selectProductMaterials = list
		end

		local constId = V3a6YaMiEnum.MaterialInfo[type].ConstId
		local maxCount = V3a6YaMiConfig.instance:getConstValueByConst(constId)
		local index = tabletool.indexOf(list, id)
		local count = #list

		if index then
			table.remove(list, index)

			isSelect = false
		else
			if maxCount <= count then
				return false, V3a6YaMiEnum.ToastId.SelectMaterialsMaxCount
			end

			local isCanSelect, toast = self:_isCanSelectMaterial(id)

			if not isCanSelect then
				return false, toast
			end

			table.insert(list, id)

			isSelect = true
		end
	end

	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onSelectProductMaterial, type, id)

	return isSelect
end

function V3a6YaMiModel:_isCanSelectMaterial(id)
	local curCost = self:getCurSelectMaterialCost()
	local mo = self:getMaterialMo(id)

	if mo then
		local isEnoughCurrency = self:isEnoughCurrency(curCost + (mo.co.cost or 0))

		if not isEnoughCurrency then
			return false, V3a6YaMiEnum.ToastId.NoEnoughMoney
		end

		return mo:isUnlock()
	end
end

function V3a6YaMiModel:isSelectProductMaterial(type, id)
	if type == V3a6YaMiEnum.MaterialType.SubType then
		return self._selectProductSubType == id
	elseif self._selectProductMaterials then
		local index = tabletool.indexOf(self._selectProductMaterials, id)

		return index ~= nil
	end
end

function V3a6YaMiModel:isUnselectProductMaterial()
	if not self._selectProductSubType or not self._selectProductMaterials then
		return true
	end

	if #self._selectProductMaterials == 0 then
		return true
	end

	return false
end

function V3a6YaMiModel:getSelectProductMaterialCount()
	local count = #self._selectProductMaterials

	return self._selectProductSubType and count or count + 1
end

function V3a6YaMiModel:getGenerateProduct()
	if self:isUnselectProductMaterial() then
		self._productId = nil

		return
	end

	if self:getProductDict() then
		for _, mo in pairs(self._productDict) do
			if self:_isCanGenerateProduct(mo) then
				self._productId = mo.id

				return mo
			end
		end
	end

	self._productId = V3a6YaMiConfig.instance:getConstValueByConst(V3a6YaMiEnum.ConstId.TrashProduct)

	local mo = self:getProductMoById(self._productId)

	mo:onForceChangeMaterials(self._selectProductSubType, self._selectProductMaterials)

	return mo
end

function V3a6YaMiModel:_isCanGenerateProduct(mo)
	local materials = mo and mo.materials

	if not materials then
		return false
	end

	local selectCount = self:getSelectProductMaterialCount()

	if selectCount == 0 or selectCount ~= #materials then
		return false
	end

	if not self:isSelectProductMaterial(V3a6YaMiEnum.MaterialType.SubType, mo.co.type) then
		return
	end

	for _, id in ipairs(materials) do
		local mo = self:getMaterialMo(id)

		if mo then
			local type = mo.co.type

			if not self:isSelectProductMaterial(type, id) then
				return false
			end
		end
	end

	return true
end

function V3a6YaMiModel:getProductAdvantage()
	if self._selectProductSubType then
		local mo = self:getMaterialMo(self._selectProductSubType)

		return mo and mo.co.advantage
	end
end

function V3a6YaMiModel:getSelectMaterials()
	return self._selectProductSubType, self._selectProductMaterials
end

function V3a6YaMiModel:saveSelectMaterials()
	if self:isUnselectProductMaterial() then
		self:_saveSelectMaterials()

		return
	end

	local str = self._selectProductSubType

	for i, material in ipairs(self._selectProductMaterials) do
		str = string.format("%s#%s", str, material)
	end

	self:_saveSelectMaterials(str)
end

function V3a6YaMiModel:_saveSelectMaterials(str)
	GameUtil.playerPrefsSetStringByUserId(V3a6YaMiEnum.PrefsKey.SelectMaterials, str or "")
end

function V3a6YaMiModel:getSelectHeroCount()
	return (self._equipedHeros or nil) and (#self._equipedHeros or 0)
end

function V3a6YaMiModel:onConfirmSelectHeros(heros)
	self._equipedHeros = {}

	if heros then
		local attrMo = self:getHeroTeamAttrMo()

		attrMo:resetValues()

		for index, id in ipairs(heros) do
			local heroMo = self:getHeroMoById(id)

			if heroMo and not heroMo.isLock then
				self._equipedHeros[index] = id

				local seatMo = self:getSeatMo(index)

				seatMo:setHeroId(id)
				self:_refreshHeroTeamAttr(id, attrMo)
			end
		end
	end
end

function V3a6YaMiModel:getIndexEquipedHero(id)
	if self._equipedHeros then
		return (tabletool.indexOf(self._equipedHeros, id))
	end
end

function V3a6YaMiModel:getSelectHeroIdByIndex(index)
	return self._equipedHeros and self._equipedHeros[index]
end

function V3a6YaMiModel:getSelectHeros()
	return self._equipedHeros
end

function V3a6YaMiModel:getHeroTeamAttrMo()
	if not self._heroTeamAttrMo then
		self._heroTeamAttrMo = V3a6YaMiAttrMO.New()

		self:resetHeroTeamAttrMo()
	end

	return self._heroTeamAttrMo
end

function V3a6YaMiModel:resetHeroTeamAttrMo()
	if self._heroTeamAttrMo then
		for _, type in pairs(V3a6YaMiEnum.AttrType) do
			self._heroTeamAttrMo:setAttrValue(type, 0)
		end

		local heros = self:getSelectHeros()

		if heros then
			for _, id in ipairs(heros) do
				self:_refreshHeroTeamAttr(id, self._heroTeamAttrMo)
			end
		end
	else
		self:getHeroTeamAttrMo()
	end
end

function V3a6YaMiModel:_refreshHeroTeamAttr(id, attrMo)
	local heroMo = self:getHeroMoById(id)

	for _, type in pairs(V3a6YaMiEnum.AttrType) do
		local value = attrMo:getAttrValue(type) or 0

		attrMo:setAttrValue(type, value + (heroMo:getAttrValue(type) or 0))
	end
end

function V3a6YaMiModel:getSelectHerosAttrMo()
	self._selectHerosAttrMo = self._selectHerosAttrMo or V3a6YaMiAttrMO.New()

	return self._selectHerosAttrMo
end

function V3a6YaMiModel:needDeskCount()
	return 2
end

function V3a6YaMiModel:saveSelectHeros()
	if self:getSelectHeroCount() == 0 then
		self:_saveSelectHeros()

		return
	end

	local str = ""

	for _, heroId in ipairs(self._equipedHeros) do
		str = string.format("%s#%s", str, heroId)
	end

	self:_saveSelectHeros(str)
end

function V3a6YaMiModel:_saveSelectHeros(str)
	GameUtil.playerPrefsSetStringByUserId(V3a6YaMiEnum.PrefsKey.SelectHeros, str or "")
end

function V3a6YaMiModel:refreshResearchInfo(info)
	self._researchInfo = self._researchInfo or V3a6YaMiResearchInfo.New()

	self._researchInfo:refreshInfo(info)
end

function V3a6YaMiModel:refreshSelectInfo()
	local status = self:getCurGameStatus()

	if status == V3a6YaMiEnum.GameStatus.Performing then
		local subType, materials = self._researchInfo:getResearchMaterials()

		self._selectProductSubType = subType
		self._selectProductMaterials = tabletool.copy(materials)

		local heros = self._researchInfo:getResearchHeros()

		if heros then
			local heroIds = {}

			for _, info in ipairs(heros) do
				table.insert(heroIds, info.id)
			end

			self:onConfirmSelectHeros(heroIds)
		end
	else
		self:refreshSelectMaterials()
		self:refreshSelectHeros()
	end
end

function V3a6YaMiModel:refreshSelectMaterials()
	local mateialsInfo = GameUtil.playerPrefsGetStringByUserId(V3a6YaMiEnum.PrefsKey.SelectMaterials, "")

	if string.nilorempty(mateialsInfo) then
		self._selectProductSubType = nil
		self._selectProductMaterials = nil
	else
		local materials = string.splitToNumber(mateialsInfo, "#")

		self._selectProductSubType = materials[1]
		self._selectProductMaterials = {}

		for i = 2, #materials do
			if materials[i] then
				table.insert(self._selectProductMaterials, materials[i])
			end
		end
	end

	self:getGenerateProduct()
end

function V3a6YaMiModel:refreshSelectHeros()
	local heroInfo = GameUtil.playerPrefsGetStringByUserId(V3a6YaMiEnum.PrefsKey.SelectHeros, "")

	if string.nilorempty(heroInfo) then
		self._equipedHeros = nil
	else
		local heros = string.splitToNumber(heroInfo, "#")

		self._equipedHeros = {}

		for i = 1, #heros do
			if heros[i] then
				table.insert(self._equipedHeros, heros[i])
			end
		end
	end
end

function V3a6YaMiModel:getResearchInfo()
	return self._researchInfo
end

function V3a6YaMiModel:refreshMoney(money)
	self._money = money

	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onRefreshCurrency)
end

function V3a6YaMiModel:refreshLevelExp(exp)
	self._totalExp = exp or 0

	local _level, _exp = self:parseLevelExp(self._totalExp)

	self._level, self._exp = _level, _exp

	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onRefreshLevelExp)
end

function V3a6YaMiModel:getLevelExp()
	return self._totalExp, self._level, self._exp
end

function V3a6YaMiModel:parseLevelExp(exp)
	local remainExp = 0
	local level = 0
	local cos = V3a6YaMiConfig.instance:getNeedExpLevelCos()

	for i = 0, #cos do
		local co = cos[i]

		if exp < co.exp then
			return level, remainExp
		else
			remainExp = exp - co.exp
			level = co.level
		end
	end

	return level, remainExp
end

function V3a6YaMiModel:getCurrencyNum()
	return self._money or 0
end

function V3a6YaMiModel:isEnoughCurrency(currency)
	return currency <= self._money
end

function V3a6YaMiModel:refreshUnlockSeat(index, isUnlock)
	local mo = self:getSeatMo(index)

	mo:refreshUnlock(isUnlock)
end

function V3a6YaMiModel:getSeatMo(index)
	self._seatMos = self._seatMos or {}

	if not self._seatMos[index] then
		local mo = V3a6YaMiSeatMO.New()

		mo:init(index)

		self._seatMos[index] = mo
	end

	return self._seatMos[index]
end

function V3a6YaMiModel:getSeatCount()
	return (V3a6YaMiConfig.instance:getConstValueByConst(V3a6YaMiEnum.ConstId.WorkHeroMaxCount))
end

function V3a6YaMiModel:isUnlockSeat(index)
	local mo = self:getSeatMo(index)

	return mo:isUnlock()
end

function V3a6YaMiModel:setResearchResult(info)
	if not self._totalExp then
		self:refreshInfo(info.researchInstitute)

		self._addExp = self._totalExp - self._totalExp
		self._adMoney = info.addMoney
		self._evaluateHerosInfos = {}
		self._selfProductMo = {}

		if info.evaluate then
			for i = 1, #info.evaluate.inventions do
				local _info = info.evaluate.inventions[i]
				local mo = V3a6YaMiProductMO.New()
				local co = V3a6YaMiConfig.instance:getInventionCo(_info.id)

				mo:initConfig(co)
				mo:refreshInfo(_info)

				if _info.aiIndex == 0 then
					if not mo.subType or mo.subType == 0 or not mo.materials or #mo.materials == 0 then
						self:refreshSelectMaterials()
						mo:setMaterials(self._selectProductSubType, self._selectProductMaterials)
					end

					self._selfProductMo = mo
					self._productId = _info.id
				end

				self._evaluateHerosInfos[i] = mo
			end

			self._evaluateLevel = info.evaluate.level
		end

		V3a6YaMiStatHelper.instance:FinishResearch()
	end
end

function V3a6YaMiModel:getResearchResult()
	return self._addExp, self._adMoney
end

function V3a6YaMiModel:getEvaluateHerosInfos()
	return self._evaluateLevel, self._evaluateHerosInfos
end

function V3a6YaMiModel:getSelfProductMo()
	return self._selfProductMo
end

function V3a6YaMiModel:clearSelectInfo()
	self._selectProductSubType = nil
	self._selectProductMaterials = nil
	self._equipedHeros = nil

	self:resetHeroTeamAttrMo()
	self:_saveSelectMaterials()
	self:_saveSelectHeros()
end

function V3a6YaMiModel:isCanEnterPerform()
	local cost = self:getCurSelectMaterialCost()
	local isEnoughCurrency = self:isEnoughCurrency(cost)

	if not isEnoughCurrency then
		return false, V3a6YaMiEnum.ToastId.NoEnoughMoney
	end

	return true
end

function V3a6YaMiModel:getResearchStatus()
	if not self._researchInfo then
		return V3a6YaMiEnum.ResearchStatus.Idle
	end

	return self._researchInfo.status
end

function V3a6YaMiModel:setResearchStatus(status)
	if not self._researchInfo then
		return
	end

	self._researchInfo.status = status
end

function V3a6YaMiModel:setPerformPauseSecond(second)
	if not self._researchInfo then
		return
	end

	self._researchInfo:setPerformPauseSecond(second)
end

function V3a6YaMiModel:getPerformPauseSecond()
	if not self._researchInfo then
		return 0
	end

	return self._researchInfo:getPerformPauseSecond()
end

function V3a6YaMiModel:_initMission()
	self._missionMos = {}

	local cos = V3a6YaMiConfig.instance:getMissionCos()

	if cos then
		for _, co in pairs(cos) do
			local mo = V3a6YaMiMissionMO.New()

			mo:initMo(co)

			self._missionMos[co.id] = mo
		end
	end
end

function V3a6YaMiModel:refreshMission(missions)
	local list = {}

	if missions then
		for i = 1, #missions do
			list[missions[i].id] = missions[i]
		end
	end

	if not self._missionMos then
		self:_initMission()
	end

	for _, mo in pairs(self._missionMos) do
		local info = list[mo.id]

		mo:refreshInfo(info)
	end
end

function V3a6YaMiModel:clearMissionCurrency()
	self._addMissionCurrency = 0
end

function V3a6YaMiModel:updateMission(missions)
	if missions then
		for i = 1, #missions do
			local info = missions[i]

			if info.isFinish then
				local mo = self._missionMos[info.id]

				mo:refreshInfo(info)

				self._addMissionCurrency = self._addMissionCurrency + (mo.co.bonus or 0)
			end
		end
	end
end

function V3a6YaMiModel:getAddMissionCurrency()
	return self._addMissionCurrency or 0
end

function V3a6YaMiModel:clearAddMissionCurrency()
	self._addMissionCurrency = 0
end

function V3a6YaMiModel:getMission(id)
	return self._missionMos and self._missionMos[id]
end

function V3a6YaMiModel:getCurMissionMo()
	if not self._missionMos then
		self:_initMission()
	end

	local list = {}

	for _, mo in pairs(self._missionMos) do
		if not mo:isFinished() and mo:isUnlock() and self:checkPreposeMissionFinish(mo.co.prepose) then
			table.insert(list, mo)
		end
	end

	table.sort(list, function(a, b)
		return a.id < b.id
	end)

	if #list > 0 then
		return list[1]
	end
end

function V3a6YaMiModel:checkPreposeMissionFinish(prepose)
	if string.nilorempty(prepose) then
		return true
	else
		local split = string.splitToNumber(prepose)

		for _, id in ipairs(split) do
			local preposeMo = self._missionMos[id]

			if preposeMo and not preposeMo:isFinished() then
				return false
			end
		end

		return true
	end
end

function V3a6YaMiModel:getCurGameStatus()
	local researchStatus = self:getResearchStatus()

	if researchStatus ~= V3a6YaMiEnum.ResearchStatus.Idle then
		return V3a6YaMiEnum.GameStatus.Performing
	end

	local mateialsInfo = GameUtil.playerPrefsGetStringByUserId(V3a6YaMiEnum.PrefsKey.SelectMaterials, "")

	if string.nilorempty(mateialsInfo) then
		return V3a6YaMiEnum.GameStatus.Init
	end

	local herosInfo = GameUtil.playerPrefsGetStringByUserId(V3a6YaMiEnum.PrefsKey.SelectHeros, "")

	if string.nilorempty(herosInfo) then
		return V3a6YaMiEnum.GameStatus.SelectedMaterial
	end

	return V3a6YaMiEnum.GameStatus.SelectHeros
end

V3a6YaMiModel.instance = V3a6YaMiModel.New()

return V3a6YaMiModel
