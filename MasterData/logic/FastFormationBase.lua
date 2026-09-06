-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/model/FastFormationBase.lua

module("logic.extensions.formation.model.FastFormationBase", package.seeall)

local FastFormationBase = class("FastFormationBase")
local HEROCNT = 3
local MASTERCNT = 3
local YUANCNT = 2
local TOTAL = 6
local CALC_LEN = 15
local co_count = 2000
local co_count_1 = co_count - 1

FastFormationBase.composePool_5 = {}
FastFormationBase.composePool_6 = {}

local tempBackPosList = {
	3,
	4,
	6,
	9,
	7,
	1,
	8,
	5
}
local tempFrontPosList = {
	5,
	8,
	1,
	7,
	9,
	6,
	4,
	3
}
local noEnemyPosList = {
	8,
	5,
	6,
	4,
	2,
	1,
	3,
	7,
	9
}
local notFmtPosList = {
	2,
	4,
	6,
	5,
	8,
	7,
	9,
	1,
	3
}

function FastFormationBase:ctor()
	self.isInitPets = false
	self.petMap = {}
	self.permList = {}
	self.permList[0] = {}
	self.comFrontList = {}
	self.comBackList = {}
	self.comFrontList[0] = {}
	self.comBackList[0] = {}

	for i = 1, TOTAL do
		local list = {}

		for j = 1, i do
			table.insert(list, j)
		end

		local res = {}

		self:perm(list, 1, res)

		self.permList[i] = res

		local res1 = {}

		self:backtrack(res1, 1, i, 6, {})

		self.comFrontList[i] = res1

		local res2 = {}

		self:backtrack(res2, 4, i, 9, {})

		self.comBackList[i] = res2
	end

	self.raceCo = BattleConfig.instance:getPetRace()
	self.isLocking = false
	self._contractSummonLimitLv = checknumber(ContractConfig.instance:getConstValueByKey("SUMMONED_PET_MIN_LVL"))
end

function FastFormationBase:perm(List, k, res)
	if k == #List then
		local tem = {}

		for i = 1, #List do
			tem[i] = List[i]
		end

		table.insert(res, tem)
	else
		for i = k, #List do
			List[k], List[i] = List[i], List[k]

			self:perm(List, k + 1, res)

			List[k], List[i] = List[i], List[k]
		end
	end
end

function FastFormationBase:clean(fixedPosDic)
	if self.isLocking == true then
		return
	end

	local formId = self:_getCurFormId()
	local formCo = BattleConfig.instance:getFormationCo(formId)

	for i = 1, 9 do
		if fixedPosDic then
			if not fixedPosDic[i] then
				local isFixed = false

				if TableUtil.isHad(formCo.posList, i) and not isFixed then
					self:_changePosition(i, 0)
				end
			end
		end
	end

	self:_setPositionFinish()
end

function FastFormationBase.randFunc(a, b)
	return a[1] > b[1]
end

function FastFormationBase:setFormation(isForce, notFilterFunc)
	if self.isLocking == true and not isForce then
		return
	end

	self.isLocking = true

	local ttt = os.clock()

	if isForce or self.isInitPets == false then
		self.isInitPets = true

		local initNeedPets = self:getInitNeedPets()

		self.needPets = self:_getFormationPets(notFilterFunc, initNeedPets)

		local len = #self.needPets

		self._com_list_5 = FastFormationBase.getCompose5ByPool(len)
		self._com_list_6 = FastFormationBase.getCompose6ByPool(len)

		print(">>>>>> 计算 ", isForce)

		self.clickCount = 0
	end

	self.randIdx = 0
	self.lastList = self:getMyCurFormationList()

	local finalList = self.lastList
	local max = 0
	local masterId = 0
	local summonId = 0
	local heroSkillId = 0

	if finalList then
		local cur, temSkId, mId, sId = self:calcFmtPower(finalList, true)

		max = cur
		heroSkillId = temSkId
		masterId = mId
		summonId = sId

		print(">>>>>>>>>>>>>>>>>>>.use timeaaa", cur, temSkId, mId, sId)
	end

	coroutine.start(function()
		local var_6_1

		if self._com_list_5 then
			var_6_1 = #self._com_list_5 or 0

			local var_6_2

			if self._com_list_6 then
				var_6_2 = #self._com_list_6 or 0
			end
		end

		print(">>>>>>>>>>>.use time00000", os.clock() - ttt, max, var_6_1, var_6_2)

		if self._com_list_5 then
			for i, arr in ipairs(self._com_list_5) do
				if i % co_count == co_count_1 then
					coroutine.wait(0)
				end

				local res = {}

				for j, idx in ipairs(arr) do
					local petMo = self.needPets[idx]

					if petMo then
						table.insert(res, petMo)
					end
				end

				local cur, temSkId, mId, sId = self:calcFmtPower(res)

				if cur > max then
					finalList = res
					max = cur
					heroSkillId = temSkId
					masterId = mId
					summonId = sId
				end
			end
		end

		if self._com_list_6 then
			for i, arr in ipairs(self._com_list_6) do
				if i % co_count == co_count_1 then
					coroutine.wait(0)
				end

				local res = {}

				for j, idx in ipairs(arr) do
					local petMo = self.needPets[idx]

					if petMo then
						table.insert(res, petMo)
					end
				end

				local cur, temSkId, mId, sId = self:calcFmtPower(res)

				if cur > max then
					finalList = res
					max = cur
					heroSkillId = temSkId
					masterId = mId
					summonId = sId
				end
			end
		end

		self:SetHeroSkillId(heroSkillId)

		finalList = finalList or {}

		local spiritInvocationPetId = 0

		for i, petMo in ipairs(finalList) do
			local petCo = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId)

			if checknumber(petCo.spiritInvocationSkillId) > 0 then
				spiritInvocationPetId = petMo.petId
			end
		end

		self:setSpiritInvocationPetId(spiritInvocationPetId)
		self:SetSummonInfo(masterId, summonId)
		self:setNewFormation(finalList)

		self.isLocking = false

		print(">>>>>>>>>>>.use time1111", os.clock() - ttt, max, heroSkillId, masterId, summonId)
	end)
	print(">>>>>>>>>>>.use time2222", os.clock() - ttt, max)
end

function FastFormationBase:calcFmtPower(list, isIgnoreNum)
	local teams = {}
	local hireCount = 0
	local total = #list
	local mastList, mastList2, raceMap, petIdMap

	if total > 5 then
		mastList = {}
		mastList2 = {}
		raceMap = {}
		petIdMap = {}
	end

	for i, v in ipairs(list) do
		local petMo = v

		table.insert(teams, petMo)

		if v.isHirePet == true then
			hireCount = hireCount + 1

			if hireCount > 1 then
				return -1, {}
			end
		end

		if total > 5 then
			petIdMap[petMo.petId] = petMo

			if petMo.level >= self._contractSummonLimitLv then
				raceMap[petMo.raceId] = petMo
			end

			if BagPetsController.instance:checkPetIsActiveMaster(v) then
				table.insert(mastList, petMo)
			end

			if not petMo.isMyPackPet and checknumber(petMo.summonedPetId) > 0 then
				table.insert(mastList2, petMo)
			end
		end
	end

	local conList
	local masterId = 0
	local summonId = 0
	local heroSkillId = 0

	if total > 5 then
		for i, petMo in ipairs(mastList) do
			for raceId, v in pairs(raceMap) do
				if ContractConfig.instance:getGroupCfg(petMo.raceId, raceId) then
					local tem = {}

					tem.masterId = petMo.petId
					tem.summonId = v.petId
					conList = conList or {}

					table.insert(conList, tem)
				end
			end
		end

		for i, petMo in ipairs(mastList2) do
			local sMo = petIdMap[checknumber(petMo.summonedPetId)]

			if sMo and ContractConfig.instance:getGroupCfg(petMo.raceId, sMo.raceId) then
				local tem = {}

				tem.masterId = petMo.petId
				tem.summonId = checknumber(petMo.summonedPetId)
				conList = conList or {}

				table.insert(conList, tem)
			end
		end
	end

	if total > 5 and not isIgnoreNum and conList == nil then
		return 0, heroSkillId, masterId, summonId
	end

	local heroSkillIs = FightingPowerFormula.instance:getHeroValidSkills(teams)
	local totalZdl = 0
	local zdl = 0

	if heroSkillIs and #heroSkillIs > 0 then
		for i, v in ipairs(heroSkillIs) do
			if conList then
				for i, tem in ipairs(conList) do
					zdl = FightingPowerFormula.instance:getTeamFightingPower(teams, v, 0, 0, nil, 0, 0, tem.masterId, tem.summonId)

					if totalZdl < zdl then
						totalZdl = zdl
						heroSkillId = v
						masterId = tem.masterId
						summonId = tem.summonId
					end
				end
			else
				zdl = FightingPowerFormula.instance:getTeamFightingPower(teams, v)

				if totalZdl < zdl then
					heroSkillId = v
					totalZdl = zdl
				end
			end
		end
	else
		heroSkillId = 0

		if conList then
			for i, tem in ipairs(conList) do
				zdl = FightingPowerFormula.instance:getTeamFightingPower(teams, heroSkillId, 0, 0, nil, 0, 0, tem.masterId, tem.summonId)

				if totalZdl < zdl then
					totalZdl = zdl
					masterId = tem.masterId
					summonId = tem.summonId
				end
			end
		else
			totalZdl = FightingPowerFormula.instance:getTeamFightingPower(teams, heroSkillId)
		end
	end

	return totalZdl, heroSkillId, masterId, summonId
end

function FastFormationBase:_filterByRace(arr, notFilterFunc, notInList)
	ArraySort.sortOn(arr, {
		"raceId",
		function(x)
			return (x:getFightingPower())
		end,
		"petId"
	}, {
		ArraySort.NUMERIC,
		ArraySort.DESCENDING,
		ArraySort.NUMERIC
	})

	local tem = {}
	local lastId = -1

	for i, v in ipairs(arr) do
		if lastId ~= v.raceId and notInList ~= nil and notInList[v.raceId] == nil then
			if notFilterFunc then
				if notFilterFunc(v) then
					lastId = v.raceId

					table.insert(tem, v)
				end
			elseif self:innerNotFilterFunc(v) then
				lastId = v.raceId

				table.insert(tem, v)
			end
		end
	end

	return tem
end

function FastFormationBase:innerNotFilterFunc(petMo)
	return true
end

function FastFormationBase:getInitNeedPets()
	return nil
end

function FastFormationBase:_getFormationPets(notFilterFunc, initNeedPets)
	self.petMap = {}

	local pets = {}
	local arr = self:_getPets()
	local maxBorrowPetZdl = 0
	local maxBorrowPetId = 0
	local maxBorrowPet

	for k, v in pairs(arr) do
		if v.isHirePet then
			-- block empty
		elseif v.status == BagPetsController.PET_STATUS_BORROW then
			if maxBorrowPetZdl < v:getFightingPower() and not v:isSummonedPet() then
				maxBorrowPetZdl = v:getFightingPower()
				maxBorrowPetId = v.petId
				maxBorrowPet = v
			end
		else
			self.petMap[v.petId] = v

			table.insert(pets, v)
		end
	end

	if maxBorrowPetId > 0 then
		self.petMap[maxBorrowPetId] = maxBorrowPet

		table.insert(pets, maxBorrowPet)
	end

	local needPets = {}
	local tem = {}

	if initNeedPets then
		for k, v in pairs(initNeedPets) do
			tem[v.raceId] = v

			table.insert(needPets, v)
		end
	end

	pets = self:_filterByRace(pets, notFilterFunc, tem)

	ArraySort.sortOn(pets, {
		function(x)
			return (x:getFightingPower())
		end,
		function(x)
			return (CharacterConfig.instance:getRareByAwakenLv(x.awakeLevel, x.raceId))
		end
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING
	})

	local heros = {}
	local masters = {}
	local tanks = {}
	local balances = {}
	local normals = {}
	local pHeroCount = 0
	local pMastersCount = 0
	local pYuanCount = 0

	for i, v in ipairs(pets) do
		v:getTmpFightMo(true)

		local cfg = CharacterConfig.instance:getPetCo(checknumber(v.raceId))

		if cfg then
			local petskinCf = PetSkinConfig.instance:getPetSkinCfg(v.curFaceId)

			if checknumber(petskinCf.heroSkillId) > 0 then
				if #heros < HEROCNT and #needPets > CALC_LEN then
					table.insert(heros, v)
				end

				if #needPets <= CALC_LEN then
					if PetSkinConfig.instance:checkHasEleAttr(v.curFaceId, GameEnum.RaceType.Yuan) then
						if pYuanCount < YUANCNT then
							pYuanCount = pYuanCount + 1
							pHeroCount = pHeroCount + 1

							table.insert(needPets, v)
						end
					else
						pHeroCount = pHeroCount + 1

						table.insert(needPets, v)
					end
				end
			elseif BagPetsController.instance:checkPetIsActiveMaster(v) then
				if #masters < MASTERCNT and #needPets > CALC_LEN then
					table.insert(masters, v)
				end

				if #needPets <= CALC_LEN then
					if PetSkinConfig.instance:checkHasEleAttr(v.curFaceId, GameEnum.RaceType.Yuan) then
						if pYuanCount < YUANCNT then
							pYuanCount = pYuanCount + 1
							pMastersCount = pMastersCount + 1

							table.insert(needPets, v)
						end
					else
						pMastersCount = pMastersCount + 1

						table.insert(needPets, v)
					end
				end
			else
				if PetSkinConfig.instance:checkHasJob(v.curFaceId, GameEnum.CareerType.Dun) then
					table.insert(tanks, v)
				elseif PetSkinConfig.instance:checkHasJob(v.curFaceId, GameEnum.CareerType.Pingheng) then
					table.insert(balances, v)
				else
					table.insert(normals, v)
				end

				if #needPets <= CALC_LEN then
					if PetSkinConfig.instance:checkHasEleAttr(v.curFaceId, GameEnum.RaceType.Yuan) then
						if pYuanCount < YUANCNT then
							pYuanCount = pYuanCount + 1

							table.insert(needPets, v)
						end
					else
						table.insert(needPets, v)
					end
				end
			end
		end
	end

	if pHeroCount == 0 then
		for i, v in ipairs(heros) do
			table.insert(needPets, v)
		end
	end

	if pMastersCount == 0 then
		for i, v in ipairs(masters) do
			table.insert(needPets, v)
		end
	end

	return needPets
end

function FastFormationBase.getCompose5(len)
	local arr = {}

	if len <= 5 then
		local data = {}

		for i = 1, len do
			table.insert(data, i)
		end

		table.insert(arr, data)

		return arr
	end

	for i = 1, len do
		for j = i + 1, len do
			for k = j + 1, len do
				for l = k + 1, len do
					for m = l + 1, len do
						local data = {
							i,
							j,
							k,
							l,
							m
						}

						table.insert(arr, data)
					end
				end
			end
		end
	end

	return arr
end

function FastFormationBase.getCompose5ByPool(len)
	local arr = FastFormationBase.composePool_5[len]

	if arr == nil then
		arr = FastFormationBase.getCompose5(len)
		FastFormationBase.composePool_5[len] = arr
	end

	return arr
end

function FastFormationBase.getCompose6(len)
	local arr = {}

	if len <= 6 then
		local data = {}

		for i = 1, len do
			table.insert(data, i)
		end

		table.insert(arr, data)

		return arr
	end

	for i = 1, len do
		for j = i + 1, len do
			for k = j + 1, len do
				for l = k + 1, len do
					for m = l + 1, len do
						for n = m + 1, len do
							local data = {
								i,
								j,
								k,
								l,
								m,
								n
							}

							table.insert(arr, data)
						end
					end
				end
			end
		end
	end

	return arr
end

function FastFormationBase.getCompose6ByPool(len)
	local arr = FastFormationBase.composePool_6[len]

	if arr == nil then
		arr = FastFormationBase.getCompose6(len)
		FastFormationBase.composePool_6[len] = arr
	end

	return arr
end

function FastFormationBase:backtrack(res, start, num, total, arr)
	if #arr == num then
		local tem = {}

		for i = 1, num do
			table.insert(tem, arr[i])
		end

		table.insert(res, tem)

		return
	end

	for i = start, total do
		table.insert(arr, i)
		self:backtrack(res, i + 1, num, total, arr)
		table.remove(arr, #arr)
	end
end

function FastFormationBase:getMyCurFormationList()
	local list
	local formation = self:_getCurFormation()

	if formation then
		for _, petId in ipairs(formation:GetPositions()) do
			if petId > 0 then
				local pet = self:_getPet(petId)

				if pet then
					list = list or {}

					table.insert(list, pet)
				end
			end
		end
	end

	return list
end

function FastFormationBase:setNewFormation(finalList)
	ArraySort.sortOn(finalList, {
		function(mo)
			return self:_getJobIdx(mo.curFaceId)
		end,
		function(mo)
			return (mo:getFightingPower())
		end
	}, {
		ArraySort.NUMERIC,
		ArraySort.DESCENDING
	})

	local enemyFormations = MissionModel.instance:getEnemyFormations()

	if enemyFormations then
		local fmt
		local frontList = {}
		local backList = {}
		local jisuCount = 0

		for i, v in ipairs(finalList) do
			if PetSkinConfig.instance:checkHasJob(v.curFaceId, GameEnum.CareerType.JiSu) then
				jisuCount = jisuCount + 1
			end

			local cfg = CharacterConfig.instance:getPetInfoCo(v.raceId)

			if cfg.bestPosition == GameEnum.FRONT_PET or cfg.bestPosition == nil then
				if #frontList < TOTAL then
					table.insert(frontList, v)
				elseif #backList < TOTAL then
					table.insert(backList, v)
				end
			elseif #backList < TOTAL then
				table.insert(backList, v)
			elseif #frontList < TOTAL then
				table.insert(frontList, v)
			end
		end

		local lenF = #frontList
		local lenB = #backList
		local enemyCount = table.nums(enemyFormations)

		if enemyCount > 1 then
			if not self.comFrontList[lenF] then
				local comFArr = {}

				if not self.comBackList[lenB] then
					local comBArr = {}
					local frontArr = self:getSubPosList(enemyFormations, frontList, comFArr, nil)
					local frontPool = {}

					for i, v in ipairs(frontArr) do
						frontPool[v] = frontList[i]
					end

					local backArr = self:getSubPosList(enemyFormations, backList, comBArr, frontPool)
					local resList = {}

					for i, v in ipairs(frontArr) do
						resList[v] = {
							p = 1,
							idx = v,
							petMo = frontList[i]
						}
					end

					for i, v in ipairs(backArr) do
						resList[v] = {
							p = 2,
							idx = v,
							petMo = backList[i]
						}
					end

					fmt = resList
				end
			end
		else
			fmt = {}

			for i, v in ipairs(frontList) do
				local pos = tempFrontPosList[i]

				fmt[pos] = {
					petMo = v
				}
			end

			for i, v in ipairs(backList) do
				local pos = tempBackPosList[i]

				fmt[pos] = {
					petMo = v
				}
			end

			if jisuCount == 1 and fmt[4] then
				for i = 1, 9 do
					if fmt[i] and fmt[i].petMo then
						local petMo = fmt[i].petMo

						if PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.JiSu) then
							fmt[4], fmt[i] = fmt[i], fmt[4]

							break
						end
					end
				end
			end
		end

		if fmt then
			local posList = {}
			local petList = {}
			local extPosList = {}

			for i = 1, 9 do
				if fmt[i] and fmt[i].petMo then
					table.insert(posList, i)
					table.insert(petList, fmt[i].petMo)
				else
					table.insert(extPosList, i)
				end
			end

			for i = #extPosList, 1, -1 do
				table.insert(posList, extPosList[i])
			end

			self:setPetAtFixedPos(posList, petList)
		else
			self:setPetAtFixedPos(notFmtPosList, finalList)
		end
	else
		self:setPetAtFixedPos(noEnemyPosList, finalList)
	end

	self:_setPositionFinish()
end

function FastFormationBase:setPetAtFixedPos(posList, petList)
	for i, v in ipairs(posList) do
		local pet = petList[i]

		if pet then
			self:_changePosition(v, pet.petId)
		else
			self:_changePosition(v, 0)
		end
	end
end

function FastFormationBase:getSubPosList(enemyFormations, monList, posList, frontPool)
	local list = {}

	for i, mo in ipairs(monList) do
		local arr = {}
		local petCo = CharacterConfig.instance:getPetCo(mo.raceId)
		local attrIdx = PetSkinConfig.instance:getFisrtEleAttrIdx(mo.curFaceId)
		local eleAttr = PetSkinConfig.instance:getAllElementAttrs(mo.curFaceId) or {}
		local firstEleKey = eleAttr[1]

		if frontPool == nil then
			local cfg = CharacterConfig.instance:getFormationOnekey(firstEleKey, GameEnum.FRONT_PET)

			for i = 1, 6 do
				local base = CharacterConfig.instance:getFormationOnekeyPos(GameEnum.FRONT_PET, i)

				arr[i] = self:getCalcValue(cfg, attrIdx, i, petCo, enemyFormations, base, nil)
			end
		else
			local cfg = CharacterConfig.instance:getFormationOnekey(firstEleKey, GameEnum.BACK_PET)

			for i = 4, 9 do
				local base = CharacterConfig.instance:getFormationOnekeyPos(GameEnum.BACK_PET, i)

				arr[i] = self:getCalcValue(cfg, attrIdx, i, petCo, enemyFormations, base, frontPool)
			end
		end

		table.insert(list, arr)
	end

	local max = -1
	local resPos = {}

	for i, posArr in ipairs(posList) do
		local listIdxArr = self.permList[#posArr]

		for i, idxArr in ipairs(listIdxArr) do
			local temPool = {}

			for ii, idx in ipairs(idxArr) do
				local pos = posArr[idx]

				temPool[pos] = monList[ii]
			end

			local value = 0

			for ii, idx in ipairs(idxArr) do
				local pos = posArr[idx]
				local pp = pos - 3
				local ppp = pos - 6
				local c1, a1 = self:getPosLocationCount(frontPool, GameEnum.ASSIST_PET, pp, ppp)
				local c2, a2 = self:getPosLocationCount(temPool, GameEnum.ASSIST_PET, pp, ppp)
				local ac = a1 + a2
				local cc = c1 + c2
				local p8 = 1

				if cc == 1 and ac == 1 then
					local mo = monList[ii]
					local petCo = CharacterConfig.instance:getPetCo(mo.raceId)
					local eleAttr = PetSkinConfig.instance:getAllElementAttrs(mo.curFaceId) or {}
					local firstEleKey = eleAttr[1]
					local cfg

					p8 = (frontPool and CharacterConfig.instance:getFormationOnekey(firstEleKey, GameEnum.BACK_PET) or CharacterConfig.instance:getFormationOnekey(firstEleKey, GameEnum.FRONT_PET)).p8
				end

				local arr = list[ii]
				local tem = checknumber(arr[pos]) * p8

				value = value + tem
			end

			if max < value then
				max = value

				local tem = {}

				for ii, idx in ipairs(idxArr) do
					local pos = posArr[idx]

					table.insert(tem, pos)
				end

				resPos = tem
			end
		end
	end

	return resPos
end

function FastFormationBase:getMyPetPool()
	local all = {}
	local myFormations = self:_getCurFormation()

	if myFormations then
		local list

		for idx, petId in pairs(myFormations:GetPositions()) do
			if petId > 0 then
				local pet = self:_getPet(petId)

				if pet then
					list = list or {}

					table.insert(list, pet)

					all[idx] = pet
				end
			end
		end
	end

	return all
end

function FastFormationBase:getCurrFmtValue(fromForMations, enemyFormations)
	fromForMations = fromForMations or self:getMyPetPool()
	enemyFormations = enemyFormations or MissionModel.instance:getEnemyFormations()

	if fromForMations and enemyFormations then
		local frontPool = {}
		local all = {}

		for idx, pet in pairs(fromForMations) do
			all[idx] = pet

			local infoCfg = CharacterConfig.instance:getPetInfoCo(pet.raceId)

			if infoCfg == nil then
				printError(">>>>>>>>>>>> 一键布阵出现一只找不到的精灵：", pet.raceId)
			end

			if infoCfg and infoCfg.bestPosition == GameEnum.FRONT_PET then
				frontPool[idx] = pet
			end
		end

		local totalValue = 0
		local res = {}

		for idx, mo in pairs(all) do
			local infoCfg = CharacterConfig.instance:getPetInfoCo(mo.raceId)
			local petCo = CharacterConfig.instance:getPetCo(mo.raceId)
			local eleAttr = PetSkinConfig.instance:getAllElementAttrs(mo.curFaceId) or {}
			local firstEleKey = eleAttr[1]
			local cfg = CharacterConfig.instance:getFormationOnekey(firstEleKey, infoCfg.bestPosition)
			local base = CharacterConfig.instance:getFormationOnekeyPos(infoCfg.bestPosition, idx)
			local attrIdx = PetSkinConfig.instance:getFisrtEleAttrIdx(mo.curFaceId)
			local value, arr = 0

			if infoCfg.bestPosition == GameEnum.FRONT_PET then
				value, arr = self:getCalcValue(cfg, attrIdx, idx, petCo, enemyFormations, base, nil)
			else
				value, arr = self:getCalcValue(cfg, attrIdx, idx, petCo, enemyFormations, base, frontPool)
			end

			arr = arr or {}

			local cc, ac = self:getPosLocationCount(all, GameEnum.ASSIST_PET, idx - 3, idx - 6)

			if cc == 1 and ac == 1 then
				table.insert(arr, "p8")
			end

			totalValue = totalValue + value

			table.insert(res, arr)
		end

		return totalValue, res
	end

	return 0, {}
end

function FastFormationBase:getPosLocationCount(petPool, type, pos1, pos2)
	local cc = 0
	local tc = 0

	if petPool then
		if petPool[pos1] then
			cc = cc + 1

			local pet = petPool[pos1]
			local cfg = CharacterConfig.instance:getPetInfoCo(pet.raceId)

			if cfg.location == type then
				tc = tc + 1
			end
		end

		if petPool[pos2] then
			cc = cc + 1

			local pet = petPool[pos2]
			local cfg = CharacterConfig.instance:getPetInfoCo(pet.raceId)

			if cfg.location == type then
				tc = tc + 1
			end
		end
	end

	return cc, tc
end

function FastFormationBase:getCalcValue(cfg, attrIdx, idx, petCo, enemyFormations, base, frontPool)
	if frontPool and frontPool[idx] then
		return -1, nil
	end

	local arr = {}
	local p1, p2, p3, p4, p5, p6, p7 = 1, 1, 1, 1, 1, 1, 1
	local val1, val2 = 1, 1

	for i = 0, 2 do
		local enemy = enemyFormations[(idx + i * 3) % 9]

		if enemy then
			local enemyType = self:_getRaceIdx(enemy)
			local enemyInfo = CharacterConfig.instance:getPetInfoCo(enemy.raceId)
			local petInfo = CharacterConfig.instance:getPetInfoCo(petCo.raceId)

			val1 = self.raceCo[attrIdx]["attr" .. enemyType]
			val2 = self.raceCo[enemyType]["attr" .. attrIdx]

			local boo = self.raceCo[attrIdx]["attr" .. enemyType] == self.raceCo[enemyType]["attr" .. attrIdx]

			if val1 > 1 then
				p1 = checknumber(cfg.p1) * p1

				table.insert(arr, "p1")
			end

			if val2 > 1 then
				p2 = checknumber(cfg.p2) * p2

				table.insert(arr, "p2")
			end

			if boo then
				p3 = checknumber(cfg.p3) * p3

				table.insert(arr, "p3")
			end

			if petInfo and enemyInfo then
				if petInfo.location or enemyInfo.location then
					if CharacterConfig.instance:getFormationLocKezhi(petInfo.location) == enemyInfo.location then
						p6 = checknumber(cfg.p6) * p3

						table.insert(arr, "p6")
					end

					if CharacterConfig.instance:getFormationLocKezhi(petInfo.location) == enemyInfo.location then
						p7 = checknumber(cfg.p7) * p3

						table.insert(arr, "p7")
					end
				end
			else
				print(">>>>>>>>>>>>>>>>>>> getCalcValue", petCo.raceId, enemy.raceId)
			end
		end
	end

	if idx >= 4 and frontPool then
		local pet1, pet2 = frontPool[idx - 3], frontPool[idx - 6]

		if pet1 and pet2 then
			p5 = cfg.p5

			table.insert(arr, "p5")
		elseif pet1 or pet2 then
			p4 = cfg.p4

			table.insert(arr, "p4")
		end
	end

	local resVal = base * p1 * p2 * p3 * p4 * p5 * p6 * p7

	return resVal, arr
end

function FastFormationBase:calcPower(list, heroSkillId)
	local teams = {}
	local hireCount = 0

	for i, v in ipairs(list) do
		local petMo = v:getTmpFightMo()

		table.insert(teams, petMo)

		if v.isHirePet == true then
			hireCount = hireCount + 1

			if hireCount > 1 then
				return -1, {}
			end
		end
	end

	local heroSkillIs = FightingPowerFormula.instance:getHeroValidSkills(teams)
	local totalZdl = 0
	local zdl = 0

	if heroSkillIs and #heroSkillIs > 0 then
		for i, v in ipairs(heroSkillIs) do
			zdl = FightingPowerFormula.instance:getTeamFightingPower(teams, v)

			if totalZdl < zdl then
				heroSkillId = v
				totalZdl = zdl
			end
		end
	else
		heroSkillId = 0
		totalZdl = FightingPowerFormula.instance:getTeamFightingPower(teams, 0)
	end

	return totalZdl, heroSkillId
end

function FastFormationBase:getRandFmt(idx)
	local tem = self.com_list[idx]
	local res = {}

	for i = 1, 6 do
		local petMo = self.needPets[tem[i]]

		table.insert(res, petMo)
	end

	return res
end

function FastFormationBase:_getJobIdx(skinId)
	return PetSkinConfig.instance:getFirstJobIdx(skinId)
end

function FastFormationBase:_getRaceIdx(enemy)
	return PetSkinConfig.instance:getFisrtEleAttrIdx((enemy.curFaceId > 0 or nil) and enemy.curFaceId)
end

function FastFormationBase:_calcFormationZdl(pets)
	return 0
end

function FastFormationBase:SetHeroSkillId(heroSkillId)
	if heroSkillId and heroSkillId ~= 0 then
		local curFormation = self:_getCurFormation()

		if curFormation then
			curFormation:SetHeroSkillId(heroSkillId)
			GlobalDispatcher:dispatch(GlobalNotify.FormationHeroSkillChanged, heroSkillId)
		end
	end
end

function FastFormationBase:setSpiritInvocationPetId(petId)
	if petId and petId ~= 0 then
		local curFormation = self:_getCurFormation()

		if curFormation then
			curFormation:SetSpiritInvocationPetId(petId)
			GlobalDispatcher:dispatch(GlobalNotify.FormationHeroSkillChanged, petId)
		end
	end
end

function FastFormationBase:SetSummonInfo(masterId, summonId)
	local curFormation = self:_getCurFormation()

	if curFormation then
		curFormation.summonMasterPetId = masterId
		curFormation.summonedPetId = summonId
	end
end

function FastFormationBase:_getCurFormId()
	return 0
end

function FastFormationBase:_getCurFormation()
	return nil
end

function FastFormationBase:_changePosition(pos, value)
	return
end

function FastFormationBase:_getPets()
	return
end

function FastFormationBase:_getPet(id)
	if self.petMap then
		return self.petMap[id]
	end
end

function FastFormationBase:_setPositionFinish()
	return
end

return FastFormationBase
