-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/model/FastSupportFormation.lua

module("logic.extensions.formation.model.FastSupportFormation", package.seeall)

local FastSupportFormation = class("FastSupportFormation", FastFormation)

function FastSupportFormation:_getCurFormation()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation()
end

function FastSupportFormation:_getPets()
	return BagPetsController.instance:getFightBagPet()
end

function FastSupportFormation:_getSupportCfgs()
	return nil
end

function FastSupportFormation:_getCurFormId()
	return 10
end

function FastSupportFormation:clean(fixedPosDic)
	self.position = nil

	local formId = self:_getCurFormId()
	local formCo = BattleConfig.instance:getFormationCo(formId)
	local suppportCfg = self:_getSupportCfgs()

	for i = 1, 9 do
		local isFixedSupport = false

		for k, v in pairs(suppportCfg) do
			if i == v.posId and v.isFixedPos == true then
				isFixedSupport = true
			end
		end

		if not isFixedSupport then
			if fixedPosDic then
				if not fixedPosDic[i] then
					local isFixed = false

					if TableUtil.isHad(formCo.posList, i) and not isFixed then
						self:_changePosition(i, 0)
					end
				end
			end
		end
	end

	self:_setPositionFinish()
end

function FastSupportFormation:innerNotFilterFunc(petMo)
	local supportCfgs = self:_getSupportCfgs()

	for k, v in pairs(supportCfgs) do
		local temPetMo = self:_getPet(v.creepsId)

		if v.isFixedPos == true and petMo.raceId == temPetMo.raceId then
			return false
		end
	end

	return true
end

function FastSupportFormation:getMyCurFormationList()
	local supportCfgs = self:_getSupportCfgs()
	local list
	local formation = self:_getCurFormation()

	for _, petId in ipairs(formation:GetPositions()) do
		if petId > 0 then
			local pet = self:_getPet(petId)
			local isSupportPet = false

			if pet then
				for k, v in pairs(supportCfgs) do
					if v.isFixedPos == true then
						local tempId = v.creepsId
						local temPetMo = self:_getPet(tempId)

						if pet.petId == temPetMo.petId then
							isSupportPet = true
						end
					end
				end
			end

			if not isSupportPet then
				list = list or {}

				table.insert(list, pet)
			end
		end
	end

	return list
end

function FastSupportFormation:getFinalePosList(posList, finalList)
	local tempList = {}

	for i, v in ipairs(posList) do
		local pet = finalList[i]

		if pet then
			table.insert(tempList, pet)
		end
	end

	local supportCfgs = self:_getSupportCfgs()
	local idToPosMap = {}
	local notIncludePet = {}
	local summonCount = 0

	for k, v in pairs(supportCfgs) do
		if v.isFixedPos == true then
			local tempId = v.creepsId

			idToPosMap[tempId] = v.posId

			local mo = self:_getPet(tempId)

			if table.indexof(tempList, mo) == false then
				table.insert(notIncludePet, mo)
			end

			if mo:isSummonedPet() then
				summonCount = summonCount + 1
			end
		end
	end

	if summonCount > 0 then
		for k, mo in pairs(finalList) do
			if mo and mo:isSummonedPet() and table.indexof(notIncludePet, mo) == false then
				finalList[k] = nil
			end
		end
	end

	if #notIncludePet > 0 then
		local count = 1

		for i = 1, 9 do
			if finalList[i] == nil then
				finalList[i] = notIncludePet[count]
				count = count + 1

				if count > #notIncludePet then
					break
				end
			end
		end
	end

	for i, v in pairs(finalList) do
		if idToPosMap[v.petId] ~= nil and posList[i] ~= idToPosMap[v.petId] then
			for j, pos in ipairs(posList) do
				if pos == idToPosMap[v.petId] then
					posList[i], posList[j] = posList[j], posList[i]

					break
				end
			end
		end
	end

	return posList, finalList
end

FastSupportFormation.instance = FastSupportFormation.New()

return FastSupportFormation
