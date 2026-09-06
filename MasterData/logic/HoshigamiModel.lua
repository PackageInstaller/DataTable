-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/model/HoshigamiModel.lua

module("logic.extensions.hoshigami.view.HoshigamiModel", package.seeall)

local HoshigamiModel = class("HoshigamiModel", BaseModel)

function HoshigamiModel:ctor()
	return
end

function HoshigamiModel:onInit()
	self:onReset()
end

function HoshigamiModel:onReset()
	self._hoshigamis = nil
	self._hoshigamisMoList = {}
	self._prefabSuits = {}
	self._hoshigamiId2LvplanId = {}
end

function HoshigamiModel:addHoshigamiMo(info)
	if not info.deleted then
		local mo = self._hoshigamisMoList[info.hoshigamiId]

		if not mo then
			mo = HoshigamiMaterialMo.New()
			self._hoshigamisMoList[info.hoshigamiId] = mo
		end

		mo:initData(info)
		self:_saveHoshigamiId2LvplanId(info)
	else
		self._hoshigamisMoList[info.hoshigamiId] = nil
	end
end

function HoshigamiModel:_saveHoshigamiId2LvplanId(info)
	local id = self._hoshigamiId2LvplanId[info.hoshigamiId]

	if not id then
		local cfg = HoshigamiConfig.instance:getHoshigamiCfg(info.defineId)
		local plans = HoshigamiConfig.instance:getMainPropPlan(cfg.mainPropPlan)
		local plan = plans[info.mainPropId]

		self._hoshigamiId2LvplanId[info.hoshigamiId] = plan.lvPlan
	end
end

function HoshigamiModel:getLvPlanIdByHoshigamiId(hoshigamiId)
	return self._hoshigamiId2LvplanId[hoshigamiId]
end

function HoshigamiModel:seHoshigamis(hoshigamis)
	self._hoshigamis = hoshigamis

	for i, v in ipairs(self._hoshigamis) do
		self:addHoshigamiMo(v)
	end
end

function HoshigamiModel:getHoshigamis()
	return self._hoshigamis
end

function HoshigamiModel:addNewHoshigamis(infos)
	self._hoshigamis = self._hoshigamis or {}

	for i, info in ipairs(infos) do
		self:_checkIsEquip(infos)
		self:_checkIsUpgrade(infos)
		self:addHoshigamiMo(info)

		for i, v in ipairs(self._hoshigamis) do
			if v.hoshigamiId == info.hoshigamiId then
				table.remove(self._hoshigamis, i)

				break
			end
		end

		table.insert(self._hoshigamis, info)
	end
end

function HoshigamiModel:getHoshigamisInfo(id)
	if self._hoshigamis then
		for i, v in ipairs(self._hoshigamis) do
			if v.hoshigamiId == id then
				return v
			end
		end
	end
end

function HoshigamiModel:getHoshigamiWithPosType(petId, posType)
	local info

	if self._hoshigamis then
		local cfg

		for i, v in ipairs(self._hoshigamis) do
			if v.equippedPetId == petId and HoshigamiConfig.instance:getHoshigamiCfg(v.defineId).positionType == posType then
				info = v

				break
			end
		end
	end

	return info
end

function HoshigamiModel:getHoshigamisByPetId(petId)
	local list = {}

	if self._hoshigamis then
		local cfg

		for i, v in ipairs(self._hoshigamis) do
			if not v.deleted and v.equippedPetId == petId then
				table.insert(list, v)
			end
		end
	end

	return list
end

function HoshigamiModel:getResolveHoshigamiMos()
	local list = {}

	for k, v in pairs(self._hoshigamisMoList) do
		if v:getUsePetId() <= 0 then
			table.insert(list, v)
		end
	end

	return list
end

function HoshigamiModel:getHoshigamiMo(id)
	return self._hoshigamisMoList[id]
end

function HoshigamiModel:getHoshigamisFilterByPos(pos)
	local list = {}
	local cfg

	for i, mo in pairs(self._hoshigamisMoList) do
		cfg = HoshigamiConfig.instance:getHoshigamiCfg(mo:getDefineId())

		if cfg.positionType == pos then
			table.insert(list, {
				mo = mo,
				cfg = cfg,
				filterType = GameEnum.HoshigamiBagViewTabType.Pos
			})
		end
	end

	return list
end

function HoshigamiModel:getHoshigamisFilterByType()
	local list = {}
	local cfg
	local typeNumList = {}

	for i, mo in pairs(self._hoshigamisMoList) do
		if not mo.deleted then
			cfg = HoshigamiConfig.instance:getHoshigamiCfg(mo:getDefineId())
			typeNumList[cfg.type] = (typeNumList[cfg.type] or 0) + 1
		end
	end

	for id, v in pairs(typeNumList) do
		local suitInfo = HoshigamiConfig.instance:getSuitInfo(id)

		table.insert(list, {
			typeId = id,
			name = suitInfo.name,
			num = v,
			filterType = GameEnum.HoshigamiBagViewTabType.Type
		})
	end

	return list
end

function HoshigamiModel:getHoshigamisFilterBySuitType(suitType)
	local list = {}
	local cfg

	for i, mo in pairs(self._hoshigamisMoList) do
		cfg = HoshigamiConfig.instance:getHoshigamiCfg(mo:getDefineId())

		if cfg.type == suitType then
			table.insert(list, {
				mo = mo,
				cfg = cfg,
				filterType = GameEnum.HoshigamiBagViewTabType.Pos
			})
		end
	end

	return list
end

function HoshigamiModel:getCurrShowPetId()
	local petMo = BagPetsController.instance:GetCurPetMo()

	return petMo and petMo.petId
end

function HoshigamiModel:getCurrShowPetRaceId()
	local petMo = BagPetsController.instance:GetCurPetMo()

	return petMo and petMo.raceId
end

function HoshigamiModel:isMaxStren(hoshigamiId)
	local nextLvCfg
	local info = self:getHoshigamisInfo(hoshigamiId)

	if info then
		local lvPlan = self:getLvPlanIdByHoshigamiId(hoshigamiId)
		local lvCfgs = HoshigamiConfig.instance:getLvStrenCfg(lvPlan)

		nextLvCfg = lvCfgs[checknumber(info.lv) + 1]
	end

	return not nextLvCfg
end

function HoshigamiModel:getMaxStren(hoshigamiId)
	local maxLv = 1
	local info = self:getHoshigamisInfo(hoshigamiId)

	if info then
		local cfg = HoshigamiConfig.instance:getHoshigamiCfg(info.defineId)
		local plans = HoshigamiConfig.instance:getMainPropPlan(cfg.mainPropPlan)
		local plan = plans[info.mainPropId]
		local lvCfgs = HoshigamiConfig.instance:getLvStrenCfg(plan.lvPlan)

		index = 1

		while lvCfgs[index] do
			maxLv = lvCfgs[index].level
			index = index + 1
		end
	end

	return maxLv
end

function HoshigamiModel:getCanStrenMax(hoshigamiId)
	local maxLv = 0
	local roleLv = MofangModel.instance:getCurLv()
	local info = self:getHoshigamisInfo(hoshigamiId)

	if info then
		local cfg = HoshigamiConfig.instance:getHoshigamiCfg(info.defineId)
		local plans = HoshigamiConfig.instance:getMainPropPlan(cfg.mainPropPlan)
		local plan = plans[info.mainPropId]
		local lvCfgs = HoshigamiConfig.instance:getLvStrenCfg(plan.lvPlan)
		local index = 0
		local cfg = lvCfgs[index]
		local roleLvEnough = false

		if cfg then
			roleLvEnough = roleLv >= cfg.playerLevelReq
			maxLv = cfg.level
		end

		while roleLvEnough do
			index = index + 1
			cfg = lvCfgs[index]

			if lvCfgs[index] then
				roleLvEnough = roleLv >= cfg.playerLevelReq
				maxLv = cfg.level
			else
				roleLvEnough = false
			end
		end
	end

	return maxLv
end

function HoshigamiModel:getStrenCfg(info, lv)
	local cfg = HoshigamiConfig.instance:getHoshigamiCfg(info.defineId)
	local plans = HoshigamiConfig.instance:getMainPropPlan(cfg.mainPropPlan)
	local plan = plans[info.mainPropId]
	local lvCfgs = HoshigamiConfig.instance:getLvStrenCfg(plan.lvPlan)

	return lvCfgs[lv]
end

function HoshigamiModel:checkCanStren(hoshigamiId, targetLv)
	local can = false

	if not self:isMaxStren(hoshigamiId) then
		local info = self:getHoshigamisInfo(hoshigamiId)

		if info and targetLv > info.lv then
			local currCfg = self:getStrenCfg(info, info.lv)
			local nextCfg = self:getStrenCfg(info, targetLv)
			local roleLv = MofangModel.instance:getCurLv()

			if nextCfg and roleLv >= nextCfg.playerLevelReq then
				local raito = HoshigamiConfig.instance:getRefundRatio()
				local needcostItemCount = (nextCfg.costItemCount - currCfg.costItemCount) * raito
				local id = HoshigamiConfig.instance:getUpgradeCostMatId()
				local hasMatNum = MaterialFacade.instance:getMatNumber(MatType.Item, id)

				if needcostItemCount <= hasMatNum then
					local needcostCoinCount = (nextCfg.costCoinCount - currCfg.costCoinCount) * raito
					local hasCoinNum = MaterialFacade.instance:getMatNumber(MatType.Coin, MatType.Coin_Gold)

					if needcostCoinCount <= hasCoinNum then
						can = true
					end
				end
			end
		end
	end

	return can
end

function HoshigamiModel:setPrefabSuit(suits)
	local maxSuit = HoshigamiConfig.instance:getMaxPrefabSuitNum()

	self._prefabSuits = suits
end

function HoshigamiModel:getPrefabSuit()
	return self._prefabSuits
end

function HoshigamiModel:getPrefabSuitById(suitId)
	for i, v in ipairs(self._prefabSuits) do
		if v.suitId == suitId then
			return v.hoshigamiIds
		end
	end
end

function HoshigamiModel:getNewSuitId()
	local hasSuitId = {}

	for i, v in ipairs(self._prefabSuits) do
		hasSuitId[v.suitId] = true
	end

	local index = 1

	while hasSuitId[index] do
		index = index + 1
	end

	return index
end

function HoshigamiModel:setCurrEditPrefabIdList(suitId, hoshigamiIds)
	self._currEditSuitId = suitId
	self._currEditHoshigamiIds = hoshigamiIds
end

function HoshigamiModel:getCurrEditPrefabIdList()
	return self._currEditHoshigamiIds
end

function HoshigamiModel:isWearHoshigamiInPrefabSuit(hoshigamiId)
	local isWear = false
	local list = self:getCurrEditPrefabIdList()

	if list then
		for k, v in pairs(list) do
			if v == hoshigamiId then
				isWear = true

				break
			end
		end
	end

	return isWear
end

function HoshigamiModel:getCompareInfoInPrefabSuit(hoshigamiId)
	local info = false
	local list = self:getCurrEditPrefabIdList()

	if list then
		local infoTemp = HoshigamiModel.instance:getHoshigamisInfo(hoshigamiId)
		local cfg = HoshigamiConfig.instance:getHoshigamiCfg(infoTemp.defineId)
		local id = list[cfg.positionType]

		if id then
			info = HoshigamiModel.instance:getHoshigamisInfo(id)
		end
	end

	return info
end

function HoshigamiModel:changeHoshigamiInPrefabSuit(hoshigamiId, posType)
	self._currEditHoshigamiIds = self._currEditHoshigamiIds or {}
	self._currEditHoshigamiIds[posType] = hoshigamiId
end

function HoshigamiModel:saveHoshigamiPrefabSuit()
	if self._currEditSuitId and self._currEditHoshigamiIds then
		local ids = {}

		for k, id in pairs(self._currEditHoshigamiIds) do
			table.insert(ids, id)
		end

		local hasOld = false

		for i, v in ipairs(self._prefabSuits) do
			if v.suitId == self._currEditSuitId then
				hasOld = true

				for i = #v.hoshigamiIds, 1, -1 do
					v.hoshigamiIds:remove(i)
				end

				for _, id in ipairs(ids) do
					v.hoshigamiIds:append(id)
				end

				break
			end
		end

		if not hasOld then
			local suit = HoshigamiExtension_pb.PM_HoshigamiPrefabSuit()

			suit.suitId = self._currEditSuitId

			for i, id in ipairs(ids) do
				suit.hoshigamiIds:append(id)
			end

			table.insert(self._prefabSuits, suit)
		end
	end
end

function HoshigamiModel:getWearAttrList(petId, getKVList)
	local hoshigamis = self:getHoshigamisByPetId(petId)
	local res = self:getAttrByHoshigamis(hoshigamis)
	local newList = {}

	if getKVList then
		newList = res
	else
		for k, v in pairs(res) do
			table.insert(newList, {
				id = k,
				value = v
			})
		end

		table.sort(newList, function(a, b)
			return a.id < b.id
		end)
	end

	return newList
end

function HoshigamiModel:getAttrByHoshigamis(hoshigamis)
	local res = {}

	for i, v in ipairs(hoshigamis) do
		local lvPlanId = self:getLvPlanIdByHoshigamiId(v.hoshigamiId)
		local lvCfgs = HoshigamiConfig.instance:getLvStrenCfg(lvPlanId)
		local cfg = lvCfgs[v.lv]
		local temp = self:_getAttrWithMainAndSubProperty(cfg.mainPropertyApp, v.subPropertyApps)

		AttrMo.addSameAttrs(temp, res)
	end

	return res
end

function HoshigamiModel:_getAttrWithMainAndSubProperty(mainPropertyApp, subPropertyApps)
	local res = FightingPowerFormula.instance:parseAttrValues(mainPropertyApp) or {}

	if subPropertyApps and next(subPropertyApps) then
		for i, v1 in ipairs(subPropertyApps) do
			local temp = {
				[v1.proertyType] = checknumber(string.format("%.4f", v1.value))
			}

			GameUtil.addSameAttrs(temp, res)
		end
	end

	return res
end

function HoshigamiModel:getFightingPower(hoshigamiId)
	local power = 0
	local info = self:getHoshigamisInfo(hoshigamiId)

	if info and not info.deleted then
		local lvPlan = self:getLvPlanIdByHoshigamiId(hoshigamiId)
		local strengthCfgs = HoshigamiConfig.instance:getLvStrenCfg(lvPlan)
		local currCfg = strengthCfgs[info.lv]
		local res = FightingPowerFormula.instance:parseAttrValues(currCfg.mainPropertyApp) or {}

		for i, v in ipairs(info.subPropertyApps) do
			res[v.proertyType] = (res[v.proertyType] or 0) + v.value
		end

		power = AttrMo.calcFightPowerByAttrs(res)
	end

	return power
end

function HoshigamiModel:_checkIsEquip(infos)
	if #infos == 2 or #infos == 1 then
		local equipInfo = false
		local unloadInfo = false

		for i, info in ipairs(infos) do
			if not info.deleted then
				local oldInfo = self:getHoshigamisInfo(info.hoshigamiId)

				if oldInfo and oldInfo.equippedPetId <= 0 and info.equippedPetId > 0 then
					equipInfo = info
				elseif oldInfo and oldInfo.equippedPetId > 0 and info.equippedPetId <= 0 then
					unloadInfo = info
				end
			end
		end

		if equipInfo then
			FloatWordMgr.instance:show("Todo  显示装备穿戴效果")

			local hoshigamis = self:getHoshigamisByPetId(equipInfo.equippedPetId)

			if unloadInfo then
				for i, v in ipairs(hoshigamis) do
					if v.hoshigamiId == unloadInfo.hoshigamiId then
						table.remove(hoshigamis, i)
					end
				end
			end

			local cfg
			local oldTypeList = {}
			local oldTypeActiveNumList = {}

			for i, v in ipairs(hoshigamis) do
				cfg = HoshigamiConfig.instance:getHoshigamiCfg(v.defineId)
				oldTypeList[cfg.type] = (oldTypeList[cfg.type] or 0) + 1
			end

			for typeId, num in pairs(oldTypeList) do
				local scfgs = HoshigamiConfig.instance:getSuitCfg(typeId)

				for count, scfg in pairs(scfgs) do
					if count <= num then
						oldTypeActiveNumList[typeId] = oldTypeActiveNumList[typeId] or {}
						oldTypeActiveNumList[typeId][count] = true
					end
				end
			end

			local newTypeList = {}
			local newTypeActiveNumList = {}

			table.insert(hoshigamis, equipInfo)

			for i, v in ipairs(hoshigamis) do
				cfg = HoshigamiConfig.instance:getHoshigamiCfg(v.defineId)
				newTypeList[cfg.type] = (newTypeList[cfg.type] or 0) + 1
			end

			for typeId, num in pairs(newTypeList) do
				local scfgs = HoshigamiConfig.instance:getSuitCfg(typeId)

				for count, scfg in pairs(scfgs) do
					if count <= num then
						newTypeActiveNumList[typeId] = newTypeActiveNumList[typeId] or {}
						newTypeActiveNumList[typeId][count] = true
					end
				end
			end

			local newActiveSuit = {}

			for typeId, list in pairs(oldTypeActiveNumList) do
				for count, v in pairs(list) do
					if newTypeActiveNumList[typeId] then
						newTypeActiveNumList[typeId][count] = false
					end
				end
			end

			for typeId, list in pairs(newTypeActiveNumList) do
				for count, v in pairs(list) do
					if v then
						newActiveSuit[typeId] = newActiveSuit[typeId] or {}
						newActiveSuit[typeId][count] = true
					end
				end
			end

			local str = ""

			for typeId, list in pairs(newActiveSuit) do
				for count, v in pairs(list) do
					local sinfoCfg = HoshigamiConfig.instance:getSuitInfo(typeId)

					str = str .. string.format("激活%s%s件套\n", sinfoCfg.name, count)
				end
			end

			if not string.nilorempty(str) then
				FloatWordMgr.instance:show(string.trim(str))
			end
		end
	end
end

function HoshigamiModel:_checkIsUpgrade(infos)
	for i, info in ipairs(infos) do
		if not info.deleted then
			local oldInfo = self:getHoshigamisInfo(info.hoshigamiId)

			if oldInfo and oldInfo.equippedPetId > 0 and info.equippedPetId > 0 and oldInfo.lv < info.lv then
				BagPetsController.instance:updatePetHoshigamiAttrById(info.equippedPetId)
			end
		end
	end
end

function HoshigamiModel:getSuitIdByHoshigamiId(hoshigamiId)
	for i, v in ipairs(self._prefabSuits) do
		for _, id in ipairs(v.hoshigamiIds) do
			if id == hoshigamiId then
				return v.suitId
			end
		end
	end

	return 0
end

function HoshigamiModel:calcByHoshigamisAttrs(hoshigamis, isMyPackPet)
	local res = {}

	if hoshigamis and next(hoshigamis) then
		local realHoshigamis = {}

		if isMyPackPet then
			for i, v in ipairs(hoshigamis) do
				local info = self:getHoshigamisInfo(v.id)

				if info then
					table.insert(realHoshigamis, info)
				end
			end
		else
			realHoshigamis = hoshigamis
		end

		if isMyPackPet then
			res = self:getAttrByHoshigamis(realHoshigamis)
		else
			for i, info in ipairs(realHoshigamis) do
				local cfg = HoshigamiConfig.instance:getHoshigamiCfg(info.defineId)
				local plans = HoshigamiConfig.instance:getMainPropPlan(cfg.mainPropPlan)
				local plan = plans[info.mainPropId]
				local lvStrenCfgs = HoshigamiConfig.instance:getLvStrenCfg(plan.lvPlan)
				local lvStrenCfg = lvStrenCfgs[info.lv]
				local temp = self:_getAttrWithMainAndSubProperty(lvStrenCfg.mainPropertyApp, info.subPropertyApps)

				AttrMo.addSameAttrs(temp, res)
			end
		end
	end

	return res
end

HoshigamiModel.instance = HoshigamiModel.New()

return HoshigamiModel
