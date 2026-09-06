-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolve/controller/DivineEvolveController.lua

module("logic.extensions.divineevolve.controller.DivineEvolveController", package.seeall)

local DivineEvolveController = class("DivineEvolveController", BaseController)

DivineEvolveController.DivineLookItemClick = "divinelookitemclick"
DivineEvolveController.MainItemClick = "mainitemclick"
DivineEvolveController.UpdateEvolveCondition = "updateevolvecondition"
DivineEvolveController.PetListItemClick = "petlistitemclick"

function DivineEvolveController:ctor()
	self._changeSetId = -1
	self._postEvolveRaceId = nil
end

function DivineEvolveController:onInit()
	GlobalDispatcher:addListener(PetAgent.PM_DivineEvolveRes, self._onDivineEvolveRes, self)
	GlobalDispatcher:addListener(PetAgent.PM_GetDivineEvolveInfoRes, self._onGetDivineEvolveInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.DivineEvolveAnimationEnd, self._onDivineEvolveAnimationEnd, self)
end

function DivineEvolveController:loadInfoOnLogin()
	DivineEvolveController.instance:sendPM_GetDivineEvolveInfoReq()
end

function DivineEvolveController:tryShowEnterPopup()
	if DivineEvolveModel.instance:hasReadEnterPopup() then
		return
	end

	local powerLimit = EvolveConfig.instance:getDivineEnterPopupPowerLimit()

	if powerLimit <= 0 then
		return
	end

	if powerLimit <= RoleModel.instance:getMaxPower() then
		return
	end

	local tips = EvolveConfig.instance:getDivineEnterPopupTips()

	if string.nilorempty(tips) then
		return
	end

	DivineEvolveModel.instance:saveEnterPopupReadFlag()
	TipsFacade.instance:openTipWindowNoX(langPara("精灵进化"), langPara(tips), nil, langPara("知道了"), UnityEngine.TextAnchor.UpperLeft)
end

function DivineEvolveController:_onDivineEvolveRes(status, msg)
	if status == 0 then
		printInfo("test _onDivineEvolveRes 神启进化成功 postRaceId = ", self._postEvolveRaceId)

		self._changeSetId = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(self._changeSetId)

		local newPetMo = BagModel.instance:getPet(msg.newPetId)

		GlobalDispatcher:dispatch(GlobalNotify.DivineEvolveRes, self._preEvolveRaceId, self._postEvolveRaceId, self._oldPetMo, newPetMo)
	end

	self._preEvolveRaceId = nil
	self._postEvolveRaceId = nil
	self._oldPetMo = nil
end

function DivineEvolveController:_onGetDivineEvolveInfoRes(status, msg)
	if status == 0 then
		DivineEvolveModel.instance:onGetDivineEvolveInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GetDivineEvolveInfoRes)
	end
end

function DivineEvolveController:sendPM_DivineEvolveReq(petId, petIds, preEvolveRaceId, postEvolveRaceId)
	PetAgent.instance:sendPM_DivineEvolveReq(petId, petIds)

	self._preEvolveRaceId = preEvolveRaceId
	self._postEvolveRaceId = postEvolveRaceId

	local oldPetMo = BagModel.instance:getPet(petId)

	if oldPetMo then
		self._oldPetMo = oldPetMo:GetClone()
	end
end

function DivineEvolveController:sendPM_GetDivineEvolveInfoReq()
	PetAgent.instance:sendPM_GetDivineEvolveInfoReq()
end

function DivineEvolveController:_onDivineEvolveAnimationEnd(postEvolveRaceId, oldPetMo, newPetMo)
	local function callback()
		MaterialController.instance:setChangeSetPopup(self._changeSetId)
		MaterialController.instance:showChangeSetInTemp(self._changeSetId)

		self._changeSetId = -1
	end

	local petId = newPetMo.petId

	UIStateManager.instance:updateParms(ViewName.DivineEvolveMainView, {
		petId
	})
	UIStateManager.instance:push(ViewName.DivineEvolveDisplayView, oldPetMo, newPetMo, callback)
end

function DivineEvolveController:getDivineList()
	local list = {}
	local petCfgs = CharacterConfig.instance:getPetCfg()

	if petCfgs then
		for i, v in pairs(petCfgs) do
			if PetSkinConfig.instance:checkHasJob(v.raceId, GameEnum.CareerType.Shenqi) then
				table.insert(list, v)
			end
		end
	end

	return list
end

function DivineEvolveController:getDivineMainList()
	local preDivineList = {}
	local postDivineList = {}
	local raceIdAndPreListDic = {}
	local postDivineDic = {}
	local petMos = BagModel.instance:getBagPets()

	for i, v in ipairs(petMos) do
		if PetSkinConfig.instance:checkHasJob(v.curFaceId, GameEnum.CareerType.Shenqi) then
			local cfgDivine = EvolveConfig.instance:getDivineEvolveCfgByNewRaceId(v.raceId)

			if cfgDivine then
				postDivineDic[cfgDivine.raceId] = true
			end

			table.insert(postDivineList, v)
		elseif self:isCanDivine(v.raceId) then
			raceIdAndPreListDic[v.raceId] = raceIdAndPreListDic[v.raceId] or {}

			if #raceIdAndPreListDic[v.raceId] > 0 then
				local originMo = raceIdAndPreListDic[v.raceId][1]
				local isInsertFirst = self:_comparePriority(v, originMo)

				if isInsertFirst then
					table.insert(raceIdAndPreListDic[v.raceId], 1, v)
				else
					table.insert(raceIdAndPreListDic[v.raceId], v)
				end
			else
				table.insert(raceIdAndPreListDic[v.raceId], v)
			end
		end
	end

	for raceId, preList in pairs(raceIdAndPreListDic) do
		if preList and #preList > 0 then
			table.insert(preDivineList, preList[1])
		end
	end

	local newPreDivineList = {}

	for i, v in ipairs(preDivineList) do
		if not postDivineDic[v.raceId] then
			table.insert(newPreDivineList, v)
		end
	end

	local resultList = {}

	table.insertto(resultList, postDivineList)
	table.insertto(resultList, newPreDivineList)
	table.sort(resultList, function(a, b)
		local numA = PetSkinConfig.instance:checkHasJob(a.curFaceId, GameEnum.CareerType.Shenqi) and 1 or 0
		local numB = PetSkinConfig.instance:checkHasJob(b.curFaceId, GameEnum.CareerType.Shenqi) and 1 or 0

		if numA == numB then
			if a:getAwakenLv() == b:getAwakenLv() then
				if a:getPetLv() == b:getPetLv() then
					return a.petId < b.petId
				else
					return a:getPetLv() > b:getPetLv()
				end
			else
				return a:getAwakenLv() > b:getAwakenLv()
			end
		else
			return numB < numA
		end
	end)

	local notExistList = {}
	local evolveCfgs = EvolveConfig.instance:getAvailableTimeEvolveCfgList()

	for i, vCfg in ipairs(evolveCfgs) do
		local preRaceId = vCfg.raceId

		if not postDivineDic[preRaceId] then
			local isExistInMyBag = true

			isExistInMyBag = raceIdAndPreListDic[preRaceId]

			if raceIdAndPreListDic[preRaceId] then
				if #raceIdAndPreListDic[preRaceId] <= 0 then
					isExistInMyBag = false
				end

				if not isExistInMyBag then
					table.insert(notExistList, vCfg.raceId)
				end
			end
		end
	end

	local finalResultList = {}

	for i, v in ipairs(resultList) do
		local element = {}

		element.isExistInBag = true
		element.petMo = v
		element.raceId = v.raceId

		table.insert(finalResultList, element)
	end

	for i, v in ipairs(notExistList) do
		local element = {}

		element.isExistInBag = false
		element.raceId = v

		table.insert(finalResultList, element)
	end

	return finalResultList
end

function DivineEvolveController:isCanDivine(raceId)
	return EvolveConfig.instance:isCanDivine(raceId)
end

function DivineEvolveController:_comparePriority(firstMo, secondMo)
	if firstMo:getAwakenLv() == secondMo:getAwakenLv() then
		if firstMo:getPetLv() == secondMo:getPetLv() then
			return firstMo:getId() < secondMo:getId()
		else
			return firstMo:getPetLv() > secondMo:getPetLv()
		end
	else
		return firstMo:getAwakenLv() > secondMo:getAwakenLv()
	end
end

function DivineEvolveController:playEvolveAnimation(preRaceId, postRaceId, oldPetMo, newPetMo)
	GlobalModel.instance:setUIInteractable(false)
	printInfo("test 开始播放")
	AnimatorEffect.instance:onPlayEffect(preRaceId, postRaceId, "storyconfig/animations/donghua_shenqijinhua.txt", function()
		GlobalModel.instance:setUIInteractable(true)
		printInfo("test 播放完成")
		GlobalDispatcher:dispatch(GlobalNotify.DivineEvolveAnimationEnd, postRaceId, oldPetMo, newPetMo)
	end)
end

function DivineEvolveController:getAttrs(conditionStr)
	local conditionList = string.split(conditionStr, "&")
	local race, initRare, awakenLevel, level, raceType

	for i, v in ipairs(conditionList) do
		local arr = string.split(v, "$")
		local type = arr[1]

		if type == "Race" then
			race = checknumber(arr[2])
		elseif type == "InitRare" then
			local str = arr[2]
			local tem = string.split(str, ",")

			initRare = checknumber(tem[2])
		elseif type == "AwakenLevel" then
			local str = arr[2]
			local tem = string.split(str, ",")

			awakenLevel = checknumber(tem[2])
		elseif type == "Level" then
			local str = arr[2]
			local tem = string.split(str, ",")

			level = checknumber(tem[2])
		elseif type == "RaceType" then
			raceType = arr[2]
		end
	end

	return race, initRare, awakenLevel, level, raceType
end

DivineEvolveController.instance = DivineEvolveController.New()

return DivineEvolveController
