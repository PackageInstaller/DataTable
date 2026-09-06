-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/model/FbbchallengeModel.lua

module("logic.extensions.fbbchallenge.view.FbbchallengeModel", package.seeall)

local FbbchallengeModel = class("FbbchallengeModel", BaseModel)

function FbbchallengeModel:ctor()
	return
end

function FbbchallengeModel:onInit()
	self:onReset()
end

function FbbchallengeModel:onReset()
	self._clgInfo = nil
	self._startGameServerKey = 0
	self._curFormation = nil
	self._lastBossHP = -1
	self._battleEndShowParams = nil
	self._cacheInfo = {}
end

function FbbchallengeModel:setClgInfo(msg)
	self._clgInfo = msg

	if self._lastBossHP > 0 and self._lastBossHP > self._clgInfo.curHp then
		self._battleEndShowParams = {
			totalDamage = self._clgInfo.bossHp - self._clgInfo.curHp,
			curDamage = self._lastBossHP - self._clgInfo.curHp
		}
	end

	self._lastBossHP = self._clgInfo.curHp
end

function FbbchallengeModel:getClgInfo()
	return self._clgInfo
end

function FbbchallengeModel:getBattleEndShowParams()
	return self._battleEndShowParams
end

function FbbchallengeModel:clearBattleEndShowParams()
	self._battleEndShowParams = nil
end

function FbbchallengeModel:getBestShovelNums()
	return (self._clgInfo or nil) and (self._clgInfo.bestshovelNums or 0)
end

function FbbchallengeModel:prepareGameDatas()
	local testList = {}
	local planId = FbbchallengeConfig.instance:getGamePlanId()
	local pcfgs = FbbchallengeConfig.instance:getGamePlanCfgs(planId)
	local dataList = {
		{},
		{},
		{}
	}

	for stageId, list in ipairs(pcfgs) do
		local totalWeight = 0
		local newList = {}

		for _, v in pairs(list) do
			totalWeight = totalWeight + v.weight

			table.insert(newList, v)
		end

		local randomNum = math.random(1, totalWeight)
		local currNum = 0
		local templateId = 0

		table.sort(newList, function(a, b)
			return a.weight < b.weight
		end)

		for i, v in ipairs(newList) do
			currNum = currNum + v.weight

			if randomNum <= currNum then
				templateId = v.templateId

				break
			end
		end

		if templateId > 0 then
			table.insert(testList, templateId)

			local tcfgs = FbbchallengeConfig.instance:getGameTemplateCfgs(templateId)

			if not tcfgs then
				printError("没有模板id配置！！！", templateId)

				tcfgs = {}
			end

			for i, v in ipairs(tcfgs) do
				if v.isPetCol <= 0 then
					table.insert(dataList[1], v.line1)
					table.insert(dataList[2], v.line2)
					table.insert(dataList[3], v.line3)
				else
					local ptcfgs = FbbchallengeConfig.instance:getPetTemplateCfgs(stageId)
					local tempList = {}
					local totalWeightTemp = 0

					for k, v in pairs(ptcfgs) do
						totalWeightTemp = totalWeightTemp + v.weight

						table.insert(tempList, v)
					end

					table.sort(tempList, function(a, b)
						return a.weight < b.weight
					end)

					local currNum = 0

					for i = 1, 3 do
						currNum = 0

						local randomNumTemp = math.random(1, totalWeightTemp)

						for index, v0 in ipairs(tempList) do
							currNum = currNum + v0.weight

							if randomNumTemp <= currNum then
								table.insert(dataList[i], v0.slotId)
								table.remove(tempList, index)

								totalWeightTemp = totalWeightTemp - v0.weight

								break
							end
						end
					end
				end
			end
		end
	end

	print("=======测试  各阶段id")

	for i, v in ipairs(testList) do
		print("===阶段:", i, "id:", v)
	end

	return dataList
end

function FbbchallengeModel:getAllHelpPets()
	local helpPets = {}
	local supportPlanId = self:getCurrSupportPlanId()
	local supportCfg = FbbchallengeConfig.instance:getSupportCfg(supportPlanId) or {}

	for _, v in pairs(supportCfg) do
		local pet = self:_createPet(v)

		table.insert(helpPets, pet)
	end

	return helpPets
end

function FbbchallengeModel:_createPet(creepCfg)
	if not creepCfg then
		return
	end

	local fPowerPet = FightingPowerPetMo.New()

	fPowerPet:fromChallengeCreepCo(creepCfg)

	local petMo = fPowerPet:toBaseBagPetMo()

	petMo.isSupportedPet = true

	return petMo
end

function FbbchallengeModel:getCurrSupportPlanId()
	local creepsMasterId = self:getCurrCreepsMasterId()
	local cfg = FbbchallengeConfig.instance:getMonsterCfg(creepsMasterId)

	return cfg.supportPlanId
end

function FbbchallengeModel:getCurrCreepsMasterId()
	return 1
end

function FbbchallengeModel:getPetMo(petId)
	if checknumber(petId) <= 0 then
		return
	end

	local pet = BagPetsController.instance:getPet(petId)

	if pet then
		return pet
	end

	local supportPlanId = self:getCurrSupportPlanId()
	local supportCfg = FbbchallengeConfig.instance:getSupportCfg(supportPlanId) or {}
	local creepCfg

	for _, v in pairs(supportCfg) do
		if v.creepsId == petId then
			creepCfg = v

			break
		end
	end

	return self:_createPet(creepCfg)
end

function FbbchallengeModel:setStartGameServerKey(key)
	self._startGameServerKey = key
end

function FbbchallengeModel:getStartGameServerKey()
	return self._startGameServerKey
end

function FbbchallengeModel:getCurFormation()
	self._curFormation = self._curFormation or FormationMO.New()

	return self._curFormation
end

function FbbchallengeModel:buyTimeSuccess()
	if self._clgInfo and self._clgInfo.buyTimes then
		self._clgInfo.buyTimes = self._clgInfo.buyTimes + 1
	end
end

function FbbchallengeModel:getBuffCfg(shovelNums)
	local BUFF_PLAN_ID = FbbchallengeConfig.instance:getDefineValue("BUFF_PLAN_ID", true)
	local pcfgs = FbbchallengeConfig.instance:getBuffPlanCfgs(BUFF_PLAN_ID)

	if shovelNums > #pcfgs then
		return pcfgs[#pcfgs]
	else
		return pcfgs[shovelNums]
	end
end

function FbbchallengeModel:startChallenge()
	self._cacheInfo = {}
	self._cacheInfo.maxProgress = self._clgInfo.bossHp
	self._cacheInfo.totalDamage = self._clgInfo.bossHp - self._clgInfo.curHp
end

function FbbchallengeModel:getCurChallengeCacheInfo()
	return self._cacheInfo
end

FbbchallengeModel.instance = FbbchallengeModel.New()

return FbbchallengeModel
