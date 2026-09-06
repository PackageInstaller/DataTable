-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/model/TimeWheelStateModel.lua

module("logic.extensions.timewheel.model.TimeWheelStateModel", package.seeall)

local TimeWheelStateModel = class("TimeWheelStateModel")

TimeWheelStateModel.MaxDecomposeNum = 20
TimeWheelStateModel.MaxOverflowNum = 8
TimeWheelStateModel.Pet = 1
TimeWheelStateModel.Item = 2
TimeWheelStateModel.EnumType = {
	Decompose = 1,
	Overflow = 4,
	Reset = 2,
	Revert = 3
}
TimeWheelStateModel._selectTip = {
	string.format("可选择%d只精灵消逝", TimeWheelStateModel.MaxDecomposeNum),
	"可选择1只精灵重置",
	"可选择1只传说精灵倒退",
	"精灵达到满觉醒多余材料可操作"
}
TimeWheelStateModel._txtDesc = {
	"",
	"重置获得",
	"倒退完成后选中的精灵退回初始觉醒等级，再额外获得如下材料："
}
TimeWheelStateModel._maxSelectCount = {
	TimeWheelStateModel.MaxDecomposeNum,
	[2] = 1,
	[3] = 1,
	[4] = TimeWheelStateModel.MaxOverflowNum
}
TimeWheelStateModel._maxSelectTip = {
	string.format("每次只可选择%d只精灵消逝", TimeWheelStateModel.MaxDecomposeNum),
	"每次只可选择1只精灵重置",
	"每次只可选择1只精灵回退",
	string.format("每次只可选择%d个精灵或道具溯源", TimeWheelStateModel.MaxOverflowNum)
}
TimeWheelStateModel._noPetTip = {
	"当前没有可进行消逝的精灵",
	"当前没有可进行重置的精灵",
	"当前没有可进行倒退的传说精灵",
	"当前没有可进行溯源的精灵或道具"
}
TimeWheelStateModel._noSelectTip = {
	"请先选择至少1只精灵，再进行消逝。",
	"请先选择1只符合条件的精灵，再进行重置。",
	"请先选择1只符合条件的传说精灵，再进行倒退。",
	"请先选择至少1只精灵或道具，再进行溯源。"
}
TimeWheelStateModel.lockTip = "是否确定解锁精灵【<color=#eb4642>%s</color>】？"

function TimeWheelStateModel:init()
	self:reset()
end

function TimeWheelStateModel:reset()
	self._curState = 0
	self._selectedPets = {}

	for i = 1, 4 do
		self._selectedPets[i] = {}
	end

	self._overflowPoolDic = {}
	self._awakenRevertStrategy = AwakenRevertStrategy.New()
end

function TimeWheelStateModel:setCurState(enumType)
	printInfo("timewheel 切换tab", enumType)

	self._curState = enumType
end

function TimeWheelStateModel:getCurState()
	return self._curState
end

function TimeWheelStateModel:getSelectedTip()
	return self._selectTip[self._curState]
end

function TimeWheelStateModel:getTxtDesc()
	return self._txtDesc[self._curState]
end

function TimeWheelStateModel:getMaxTopTip()
	return self._maxSelectTip[self._curState]
end

function TimeWheelStateModel:getTxtTipContent()
	local cfg = TimeWheelConfig.instance:getExplainCfg(self._curState)

	if cfg then
		return cfg.tip
	else
		return ""
	end
end

function TimeWheelStateModel:getNoPetTip()
	return self._noPetTip[self._curState]
end

function TimeWheelStateModel:getNoSelectTip()
	return self._noSelectTip[self._curState]
end

function TimeWheelStateModel:getCostDiamondPrice()
	if self._curState == 1 then
		return ""
	elseif self._curState == 2 then
		local cfg = TimeWheelConfig.instance:getResetParamCfg("price")

		return cfg.paramValue
	elseif self._curState == 3 then
		local cfg = TimeWheelConfig.instance:getRevertParamCfg("price")

		return cfg.paramValue
	end
end

function TimeWheelStateModel:isDiamondEnough()
	local num = RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()

	if self._curState == 1 then
		return true
	elseif self._curState == 2 then
		local cfg = TimeWheelConfig.instance:getResetParamCfg("price")

		return num >= checknumber(cfg.paramValue)
	elseif self._curState == 3 then
		local cfg = TimeWheelConfig.instance:getRevertParamCfg("price")

		return num >= checknumber(cfg.paramValue)
	end
end

function TimeWheelStateModel:oneSelectAllPet()
	if self._curState == TimeWheelStateModel.EnumType.Decompose then
		self:clearSelectedPet()

		local petLists = self:getPetList()

		local function sortFunc(a, b)
			local aPower = a:getFightingPower()
			local bPower = b:getFightingPower()
			local aTime = a:getGainTime()
			local bTime = b:getGainTime()

			if aPower == bPower then
				return checknumber(aTime) < checknumber(bTime)
			else
				return aPower < bPower
			end
		end

		table.sort(petLists, sortFunc)

		local count = TimeWheelStateModel.MaxDecomposeNum

		for i, v in ipairs(petLists) do
			if count <= 0 then
				return
			end

			if not v:isLocked() and v.rare ~= GameEnum.PetRare.SSR then
				local cfg = TimeWheelConfig.instance:getPetFilterCfg(v:getDefineId())
				local noOnekeySelected = cfg and cfg.noOnekeySelected

				if not noOnekeySelected then
					self:addPet(v:getPetId())

					count = count - 1
				end
			end
		end
	elseif self._curState == TimeWheelStateModel.EnumType.Overflow then
		self:clearSelectedPet()

		local petAndItemLists = self:getPetList()
		local count = TimeWheelStateModel.MaxOverflowNum

		for i, v in ipairs(petAndItemLists) do
			if count <= 0 then
				return
			end

			if v.matType == TimeWheelStateModel.Pet then
				local bagPetMo = BagModel.instance:getPet(v.id)
				local isNotDestroy = false
				local isLocked = true
				local isEvolved = false

				if bagPetMo then
					isNotDestroy = bagPetMo:checkHasDestroyStarGodPlus()
					isLocked = bagPetMo:isLocked()
					isEvolved = EvolveConfig.instance:getDivineEvolvePlusCfgByNewRaceId(bagPetMo.raceId)
				end

				if not isLocked and not isNotDestroy and not isEvolved then
					self:addPet(v)

					count = count - 1
				end
			else
				self:addPet(v)

				count = count - 1
			end
		end
	end
end

function TimeWheelStateModel:clearAllSelectedPet()
	for i = 1, 4 do
		table.clear(self._selectedPets[i])
	end
end

function TimeWheelStateModel:clearSelectedPet()
	if self._selectedPets[self._curState] then
		table.clear(self._selectedPets[self._curState])
	end
end

function TimeWheelStateModel:isSelectTopLimit()
	if #self._selectedPets[self._curState] >= self._maxSelectCount[self._curState] then
		return true
	end

	return false
end

function TimeWheelStateModel:getSelectedPets()
	return self._selectedPets[self._curState]
end

function TimeWheelStateModel:getDecomposeTipTxt()
	local petIds = self:getSelectedPets()
	local txtList = {}
	local isR = false
	local isSR = false
	local isSSR = false

	for i, v in ipairs(petIds) do
		local bagPetMo = BagModel.instance:getPet(v)

		if bagPetMo.rare == GameEnum.PetRare.R and not isR then
			isR = true

			table.insert(txtList, {
				GameEnum.PetRare.R
			})
		elseif bagPetMo.rare == GameEnum.PetRare.SR and not isSR then
			isSR = true

			table.insert(txtList, {
				GameEnum.PetRare.SR
			})
		elseif bagPetMo.rare == GameEnum.PetRare.SSR and not isSSR then
			isSSR = true

			table.insert(txtList, {
				GameEnum.PetRare.SSR
			})
		end
	end

	table.sort(txtList, function(a, b)
		return a[1] < b[1]
	end)

	local txt = ""
	local isExistNotN = false

	for i, v in ipairs(txtList) do
		if v[1] == GameEnum.PetRare.R then
			txt = txt .. "幻兽"
			isExistNotN = true
		elseif v[1] == GameEnum.PetRare.SR then
			txt = txt .. "超能"
			isExistNotN = true
		else
			txt = txt .. "传说"
			isExistNotN = true
		end

		if i ~= #txtList then
			txt = txt .. "、"
		end
	end

	local result = string.format("你选中的精灵中至少有1只初始品质为<color=#eb4642>%s</color>品质的精灵喔。你确定要<color=#eb4642>继续进行消逝</color>吗？", txt)

	return isExistNotN, result
end

function TimeWheelStateModel:isExistSelectedPets()
	local count = #self._selectedPets[self._curState]

	return count > 0
end

function TimeWheelStateModel:addPet(petId)
	if #self._selectedPets[self._curState] >= self._maxSelectCount[self._curState] then
		printInfo("timewheel 添加一个选中精灵 失败，因为已经达到选择上限")

		return
	end

	table.insert(self._selectedPets[self._curState], petId)
end

function TimeWheelStateModel:removePet(petId)
	local list = self._selectedPets[self._curState]

	for i, v in ipairs(list) do
		if v == petId then
			table.remove(list, i)

			break
		end
	end
end

function TimeWheelStateModel:isPetSelected(petId)
	local list = self._selectedPets[self._curState]

	for k, v in pairs(list) do
		if v == petId then
			return true
		end
	end

	return false
end

function TimeWheelStateModel:isPetSelectedExist(index)
	local count = #self._selectedPets[self._curState]

	if count < index then
		return nil
	end

	return self._selectedPets[self._curState][index]
end

function TimeWheelStateModel:getPetList()
	local resultList = {}
	local tempList = BagModel.instance:getBagPets()

	if self._curState == 1 then
		resultList = self:_filterDecomposePet(tempList)
	elseif self._curState == 2 then
		resultList = self:_filterResetList(tempList)
	elseif self._curState == 3 then
		resultList = self:_filterRevertList(tempList)
	elseif self._curState == TimeWheelStateModel.EnumType.Overflow then
		return self:getOverflowList()
	end

	resultList = self:_filterPowerCrystalPet(resultList)

	return resultList
end

function TimeWheelStateModel:getOverflowElement(matType, id, num)
	self._overflowPoolDic[matType] = self._overflowPoolDic[matType] or {}
	self._overflowPoolDic[matType][id] = self._overflowPoolDic[matType][id] or {}

	if self._overflowPoolDic[matType][id][num] then
		return self._overflowPoolDic[matType][id][num]
	else
		local element = {}

		element.matType = matType
		element.id = id
		self._overflowPoolDic[matType][id][num] = element

		return element
	end
end

function TimeWheelStateModel:getOverflowList()
	local overflowList = {}
	local petDic = {}
	local bagPets = BagModel.instance:getBagPets()
	local isTujianMaxToggle = TimeWheelController.instance:getTujianMaxOverflowIsToggle()

	for i, v in ipairs(bagPets) do
		if not TimeWheelStateModel.instance:isPetFilter(v.raceId, TimeWheelStateModel.EnumType.Overflow) then
			local initRare = CharacterConfig.instance:getInitRare(v:getDefineId())

			if initRare >= GameEnum.PetRare.SSR then
				petDic[v.raceId] = petDic[v.raceId] or {}

				if isTujianMaxToggle then
					local attLevel = HandbookModel.instance:getAttributeLevel(v.raceId)
					local maxLvl = CharacterConfig.instance:getMaxAwaken(v.raceId)

					if maxLvl < attLevel then
						attLevel = maxLvl
					end

					local isTujianMatch = attLevel >= 0 and attLevel == maxLvl

					if not petDic[v.raceId].maxAwakenPetId and isTujianMatch then
						petDic[v.raceId].maxAwakenPetId = v:getPetId()
						petDic[v.raceId].petIdList = petDic[v.raceId].petIdList or {}

						table.insert(petDic[v.raceId].petIdList, v:getPetId())
					else
						petDic[v.raceId].petIdList = petDic[v.raceId].petIdList or {}

						table.insert(petDic[v.raceId].petIdList, v:getPetId())
					end
				elseif not petDic[v.raceId].maxAwakenPetId and v:isAwakenMax() then
					petDic[v.raceId].maxAwakenPetId = v:getPetId()
				else
					petDic[v.raceId].petIdList = petDic[v.raceId].petIdList or {}

					table.insert(petDic[v.raceId].petIdList, v:getPetId())
				end
			end
		end
	end

	for k, v in pairs(petDic) do
		if v.maxAwakenPetId and v.maxAwakenPetId > 0 and v.petIdList then
			for i, petId in ipairs(v.petIdList) do
				table.insert(overflowList, self:getOverflowElement(TimeWheelStateModel.Pet, petId, 1))
			end
		end
	end

	local awakenItemCfgs = ItemConfig.instance:getAwakenItemExtCfgs()

	for i, v in ipairs(awakenItemCfgs) do
		if v.race > 0 and petDic[v.race] and petDic[v.race].maxAwakenPetId and petDic[v.race].maxAwakenPetId > 0 then
			local cfg = ItemConfig.instance:getCfgById(v.id)

			if cfg and cfg.quality >= 4 then
				local num = MaterialModel.instance:getMaterialsNumber(MatType.Item, v.id)

				if num > 0 then
					for i = 1, num do
						table.insert(overflowList, self:getOverflowElement(TimeWheelStateModel.Item, v.id, i))
					end
				end
			end
		end
	end

	return overflowList
end

function TimeWheelStateModel:_filterPowerCrystalPet(list)
	local resultList = {}

	for i, v in ipairs(list) do
		if not BagModel.instance:isPowerCrystalFollower(v:getPetId()) then
			table.insert(resultList, v)
		end
	end

	return resultList
end

function TimeWheelStateModel:isExistCanDecomposePet()
	local resultList = {}
	local tempList = BagModel.instance:getBagPets()

	tempList = self:_filterPowerCrystalPet(tempList)

	for k, v in pairs(tempList) do
		if v.rare == GameEnum.PetRare.N and not v:isLocked() and not self:isPetFilter(v.raceId, TimeWheelStateModel.EnumType.Decompose) then
			table.insert(resultList, v)
		end
	end

	return #resultList > 0
end

function TimeWheelStateModel:_filterDecomposePet(petList)
	local resultList = {}
	local decomposeList = {}

	for k, v in ipairs(petList) do
		if not PetSkinConfig.instance:checkHasJob(v.curFaceId, GameEnum.CareerType.Shenqi) and not self:isPetFilter(v.raceId, TimeWheelStateModel.EnumType.Decompose) and not v:checkHasDestroyStarGodPlus() then
			local raceId = v:getDefineId()
			local initRare = CharacterConfig.instance:getInitRare(raceId)

			if initRare == GameEnum.PetRare.SR or initRare == GameEnum.PetRare.R then
				decomposeList[raceId] = decomposeList[raceId] or {}

				table.insert(decomposeList[raceId], v)
			elseif initRare == GameEnum.PetRare.N then
				table.insert(resultList, v)
			end
		end
	end

	local paramCfg = TimeWheelConfig.instance:getDecomposeParamCfg("needAwakenLv")
	local minLv = checknumber(paramCfg.paramValue)
	local isTujianMaxToggle = TimeWheelController.instance:getTujianMaxDecomposeIsToggle()

	for raceId, list in pairs(decomposeList) do
		local existDic = {}

		if #list >= 2 then
			local isExistStar6 = false
			local matchList = {}

			for i, v in ipairs(list) do
				local lv = v:getAwakenLv()

				if minLv <= lv then
					isExistStar6 = true
				else
					table.insert(matchList, v)
				end
			end

			if isExistStar6 and #matchList > 0 then
				for i, v in ipairs(matchList) do
					existDic[v] = true

					table.insert(resultList, v)
				end
			end
		end

		if isTujianMaxToggle and #list > 0 then
			local attLevel = HandbookModel.instance:getAttributeLevel(raceId)
			local maxLvl = CharacterConfig.instance:getMaxAwaken(raceId)

			if maxLvl < attLevel then
				attLevel = maxLvl
			end

			local isTujianMatch = attLevel >= 0 and attLevel == maxLvl

			if isTujianMatch then
				for i, v in ipairs(list) do
					if not existDic[v] then
						table.insert(resultList, v)
					end
				end
			end
		end
	end

	return resultList
end

function TimeWheelStateModel:_filterResetList(tempList)
	local resultList = {}

	for k, v in ipairs(tempList) do
		if not self:isPetFilter(v.raceId, TimeWheelStateModel.EnumType.Reset) then
			local lv = v:getPetLv()

			if lv > 1 then
				table.insert(resultList, v)
			end
		end
	end

	return resultList
end

function TimeWheelStateModel:_filterRevertList(petList)
	local resultList = {}
	local paramCfg = TimeWheelConfig.instance:getRevertParamCfg("needAwakenLv")
	local minLv = checknumber(paramCfg.paramValue)
	local tempList2 = {}

	for k, v in pairs(petList) do
		if not PetSkinConfig.instance:checkHasJob(v.curFaceId, GameEnum.CareerType.Shenqi) and not self:isPetFilter(v.raceId, TimeWheelStateModel.EnumType.Revert) then
			local raceId = v:getDefineId()
			local cfg = CharacterConfig.instance:getPetCo(raceId)
			local lv = v:getAwakenLv()

			if minLv <= lv and v.rare == GameEnum.PetRare.SSR then
				local raceId = v:getDefineId()

				tempList2[raceId] = tempList2[raceId] or {}

				table.insert(tempList2[raceId], v)
			end
		end
	end

	local function _sort(a, b)
		aLv = a:getAwakenLv()
		bLv = b:getAwakenLv()
		aPower = a:getFightingPower()
		bPower = b:getFightingPower()

		if aLv == bLv then
			return aPower < bPower
		else
			return aLv < bLv
		end
	end

	for kRaceId, v in pairs(tempList2) do
		if #v > 0 then
			table.sort(v, _sort)
			table.insertto(resultList, v, #resultList + 1)
		end
	end

	return resultList
end

function TimeWheelStateModel:_filterOverFlowList(petList)
	return
end

function TimeWheelStateModel:getExpItemStr(expNum, idList)
	local id = 0

	idList = idList or {}

	if expNum >= 5000 then
		id = 3

		local num = expNum / 5000
		local newExp = expNum % 5000

		num = Mathf.Floor(num)

		if idList[id] then
			idList[id] = idList[id] + num or num
		end

		return self:getExpItemStr(newExp, idList)
	elseif expNum >= 1000 then
		id = 2

		local num = expNum / 1000
		local newExp = expNum % 1000

		num = Mathf.Floor(num)

		if idList[id] then
			idList[id] = idList[id] + num or num
		end

		return self:getExpItemStr(newExp, idList)
	else
		if expNum > 0 then
			id = 2

			if idList[2] then
				idList[id] = idList[id] + 1 or 1
			end
		end

		local strs = {}

		for k, v in pairs(idList) do
			table.insert(strs, MaterialMgr.createSerName(MatType.Item, k, v))
		end

		return strs
	end
end

function TimeWheelStateModel:getSelectRare()
	if self._curState == TimeWheelStateModel.EnumType.Decompose then
		return {
			false,
			false,
			false,
			false
		}
	elseif self._curState == TimeWheelStateModel.EnumType.Reset then
		return {
			false,
			false,
			false,
			false
		}
	elseif self._curState == TimeWheelStateModel.EnumType.Revert then
		return {
			false,
			false,
			false,
			true
		}
	end

	return {
		false,
		false,
		false,
		false
	}
end

function TimeWheelStateModel:getActiveRare()
	if self._curState == TimeWheelStateModel.EnumType.Decompose then
		return {
			true,
			true,
			true,
			true
		}
	elseif self._curState == TimeWheelStateModel.EnumType.Reset then
		return {
			true,
			true,
			true,
			true
		}
	elseif self._curState == TimeWheelStateModel.EnumType.Revert then
		return {
			false,
			false,
			false,
			true
		}
	end

	return {
		true,
		true,
		true,
		true
	}
end

function TimeWheelStateModel:getClickableRare()
	if self._curState == TimeWheelStateModel.EnumType.Decompose then
		return {
			true,
			true,
			true,
			true
		}
	elseif self._curState == TimeWheelStateModel.EnumType.Reset then
		return {
			true,
			true,
			true,
			true
		}
	elseif self._curState == TimeWheelStateModel.EnumType.Revert then
		return {
			false,
			false,
			false,
			false
		}
	end

	return {
		true,
		true,
		true,
		true
	}
end

function TimeWheelStateModel:getAwakenReturnNum(awakenLv, raceId)
	self._awakenRevertStrategy:init(awakenLv, raceId)

	local petNum, goldNum = self._awakenRevertStrategy:getResult()

	return petNum, goldNum
end

function TimeWheelStateModel:isPetFilter(raceId, funcType)
	local cfg = TimeWheelConfig.instance:getPetFilterCfg(raceId)

	if cfg then
		if funcType == TimeWheelStateModel.EnumType.Decompose then
			return cfg.decompose
		elseif funcType == TimeWheelStateModel.EnumType.Reset then
			return cfg.reset
		elseif funcType == TimeWheelStateModel.EnumType.Revert then
			return cfg.revert
		elseif funcType == TimeWheelStateModel.EnumType.Overflow then
			return cfg.overflow
		end
	end

	return false
end

TimeWheelStateModel.instance = TimeWheelStateModel.New()

return TimeWheelStateModel
