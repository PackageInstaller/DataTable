-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/customfmt/controller/CustomFmtController.lua

module("logic.extensions.customfmt.controller.CustomFmtController", package.seeall)

local CustomFmtController = class("CustomFmtController")
local CustomMissionTabs = {
	funcamp = FunCampCustomFmtMo
}
local BuffViewName = {
	ViewName.BuffChooseViewBlue,
	ViewName.BuffChooseViewNoBg
}

CustomFmtController.Buffviewtype_Blue = 1
CustomFmtController.Buffviewtype_NoBg = 2

function CustomFmtController:ctor()
	return
end

function CustomFmtController:onInit()
	self:onReset()
end

function CustomFmtController:onReset()
	self._tempCustomFmtMo = nil
end

function CustomFmtController:getTempFmtMo()
	return self._tempCustomFmtMo
end

function CustomFmtController:setTempFmtMo(customFmtMo)
	self._tempCustomFmtMo = customFmtMo
end

function CustomFmtController:createFormPb(formationMo, formPb)
	return (formationMo:createFormPb(formPb))
end

function CustomFmtController:getMoName(moName)
	if CustomMissionTabs[moName] then
		return CustomMissionTabs[moName]
	end

	printError("CustomFmtController----CustomMissionTabs 里没有" .. moName .. "这个类名")
end

function CustomFmtController:showMissionView(customFmtMo)
	UIStateManager.instance:push(ViewName.CustomMissionView, customFmtMo)
end

function CustomFmtController:showMissionFormationView(customFmtMo)
	UIStateManager.instance:push(ViewName.CustomFormationView, customFmtMo)
end

function CustomFmtController:showCommonPassViewWithJump(changeSetId)
	if changeSetId then
		MaterialController.instance:saveChangeSetToTemp(changeSetId)
	end

	UIJumper.instance:pushOneStack(ViewName.ChallengePassView, true, changeSetId)
end

function CustomFmtController:getMaxStrengthInfo()
	if ICustomFmtMo.max_strength_info == nil then
		local fsMap = {}

		for i = 1, 8 do
			local _maxlv = BattleConfig.instance:getFormStrengthMaxLv(i)

			fsMap[i] = {
				formStrengthId = i,
				formStrengthLv = _maxlv
			}
		end

		ICustomFmtMo.max_strength_info = fsMap
	end

	return ICustomFmtMo.max_strength_info
end

function CustomFmtController:extraPetAtFormation(needUpCount, needPets, petList, posList, formationMo)
	local num = 0
	local hasSummon = false
	local petMap = {}

	for k, v in pairs(petList) do
		if v.petId ~= formationMo:GetSummonPetId() then
			num = num + 1
		else
			hasSummon = true
		end

		petMap[v.petId] = true
	end

	local count = needUpCount - num

	if needUpCount == 9 and hasSummon then
		count = count - 1
	end

	if count > 0 then
		for i, petMo in ipairs(needPets) do
			if not petMap[petMo.petId] then
				table.insert(petList, petMo)

				count = count - 1

				if count <= 0 then
					break
				end
			end
		end
	end

	return posList, petList
end

function CustomFmtController:getFinalFmoListAsFixPos(formationMo, posList, petList, needPets, fixPosList, fixPetMoList, maxPetCount)
	local posMap = {}

	for i, v in ipairs(fixPosList) do
		posMap[v] = true
	end

	for i, pos in ipairs(posList) do
		if not posMap[pos] then
			table.insert(fixPosList, pos)
		end
	end

	local raceMap = {}
	local petIdMap = {}
	local count = 0
	local summonId = formationMo.summonedPetId
	local masterPetId = formationMo.summonMasterPetId

	for i, mo in ipairs(fixPetMoList) do
		raceMap[mo.raceId] = mo
		petIdMap[mo.petId] = mo

		if mo.petId ~= summonId then
			count = count + 1
		end
	end

	local list = {}

	for i, mo in ipairs(petList) do
		if mo.petId == masterPetId or mo.petId == summonId then
			if raceMap[mo.raceId] == nil and petIdMap[mo.petId] == nil and count < maxPetCount then
				raceMap[mo.raceId] = mo
				petIdMap[mo.petId] = mo

				table.insert(fixPetMoList, mo)

				if mo.petId ~= summonId then
					count = count + 1
				end
			end
		else
			table.insert(list, mo)
		end
	end

	for i, mo in ipairs(list) do
		if raceMap[mo.raceId] == nil and petIdMap[mo.petId] == nil and count < maxPetCount then
			raceMap[mo.raceId] = mo
			petIdMap[mo.petId] = mo

			table.insert(fixPetMoList, mo)

			count = count + 1
		end
	end

	return fixPosList, fixPetMoList
end

function CustomFmtController:getMatchBondCfgOnForm(petMoList, allPetList)
	local matchCfgs
	local petIdList = {}

	if petMoList and #petMoList > 0 then
		for i, mo in ipairs(petMoList) do
			table.insert(petIdList, mo.petId)
		end

		for i, mo in ipairs(petMoList) do
			matchCfgs = matchCfgs or {}

			local cfgs = self:getMatchBondCfgOnFormByRaceId(mo, petMoList, allPetList, petIdList) or {}

			for _1, v1 in ipairs(cfgs) do
				table.insert(matchCfgs, v1)
			end
		end

		return matchCfgs, petIdList
	end

	return {}, petIdList
end

function CustomFmtController:getMatchBondCfgOnFormByRaceId(mo, petMoList, allPetList, petIdList)
	local cfgs = CharacterConfig.instance:getBondCfgsOnForm(mo.raceId)
	local matchCfgs = {}

	if cfgs and #cfgs > 0 and petMoList and #petMoList > 0 then
		for _, v in ipairs(cfgs) do
			local isMatch = false

			for _1, v1 in ipairs(v.relativeRaceIds) do
				local has = false

				for _2, mo in ipairs(petMoList) do
					if mo.raceId == v1 then
						has = true

						break
					end
				end

				if has then
					isMatch = true

					break
				end
			end

			if isMatch then
				table.insert(matchCfgs, v)
			elseif self:checkHas4StarInBag(mo, v, petMoList, allPetList, petIdList) then
				table.insert(matchCfgs, v)
			end
		end

		return matchCfgs
	end

	return {}
end

function CustomFmtController:checkHas4StarInBag(petMo, cfg, petMoList, allPetList, petIdList)
	if petMo and petMo.isMyPackPet and not petMo.isSupportedPet and not petMo.isHirePet and cfg then
		local activeNeedAwakenLv = checknumber(cfg.activeNeedAwakenLv)

		if petMo.awakeLevel > 0 and activeNeedAwakenLv <= petMo.awakeLevel then
			local relativeRaceIds = cfg.relativeRaceIds
			local isAll = false

			for i, v in ipairs(relativeRaceIds) do
				local boo = self:checkRaceInBag(v, activeNeedAwakenLv, allPetList, petIdList)

				if boo then
					isAll = true

					return true
				end
			end

			return isAll
		end
	end

	return false
end

function CustomFmtController:checkRaceInBag(raceId, awakelv, allPetList, petIdList)
	for i, petMo in pairs(allPetList or {}) do
		if petMo:isExist() and petMo.raceId == raceId and petMo.awakeLevel > 0 and awakelv <= petMo.awakeLevel then
			table.insert(petIdList, petMo.petId)

			return true
		end
	end

	return false
end

function CustomFmtController:openBuffViewByType(viewType, hasBuffIds, buffCfgs, callBackFunc, selectBuffId, tipsStr, emptyStr)
	local viewName = BuffViewName[viewType]

	if enableDebug then
		if type(viewType) ~= "number" then
			printError("传错了，viewType不是number类型")
		end

		if callBackFunc ~= nil and type(callBackFunc) ~= "function" then
			printError("传错了，callBackFunc不是function类型")
		end

		if not viewName then
			printError("传入的viewType不正确")

			return
		end
	end

	self:openBuffView(viewName, hasBuffIds, buffCfgs, callBackFunc, selectBuffId, tipsStr, emptyStr)
end

function CustomFmtController:openBuffView(viewName, hasBuffIds, buffCfgs, callBackFunc, selectBuffId, tipsStr, emptyStr)
	if enableDebug then
		if hasBuffIds ~= nil and type(hasBuffIds) ~= "table" then
			printError("传错了，hasBuffIds不是table类型")
		end

		if type(buffCfgs) ~= "table" then
			printError("传错了，buffCfgs不是table类型")
		end
	end

	UIStateManager.instance:push(viewName, hasBuffIds, buffCfgs, callBackFunc, selectBuffId, tipsStr, emptyStr)
end

CustomFmtController.instance = CustomFmtController.New()

return CustomFmtController
