-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/model/SaintKnightTianModel.lua

module("logic.extensions.saintknighttian.model.SaintKnightTianModel", package.seeall)

local SaintKnightTianModel = class("SaintKnightTianModel", BaseModel)

function SaintKnightTianModel:onInit()
	self:onReset()
end

function SaintKnightTianModel:onReset()
	self._challengeId = 44
	self._useGameTime = 0
	self._hasGainGamePrizeIds = nil
	self._curPassStateId = 0
	self._isHasAreaBuff = false
	self._hasCollectPetNum = 0
	self._hasGainPrizeIds = nil
	self._curCustomFmtMo = nil
	self.CiList = nil
end

function SaintKnightTianModel:getCurChallengeId()
	return self._challengeId
end

function SaintKnightTianModel:getUseGameTimes()
	return self._useGameTime
end

function SaintKnightTianModel:isPlayerGameRewardGeted(prizeId)
	self._hasGainGamePrizeIds = self._hasGainGamePrizeIds or {}

	return TableUtil.isHad(self._hasGainGamePrizeIds, prizeId)
end

function SaintKnightTianModel:isPlayerRewardGeted(prizeId)
	self._hasGainPrizeIds = self._hasGainPrizeIds or {}

	return TableUtil.isHad(self._hasGainPrizeIds, prizeId)
end

function SaintKnightTianModel:getIsWithAreaBuff()
	return self._isHasAreaBuff
end

function SaintKnightTianModel:getCurCollectNum()
	return self._hasCollectPetNum
end

function SaintKnightTianModel:getCurPassStage()
	return self._curPassStateId
end

function SaintKnightTianModel:getIsActiveRpChallenge()
	if self._hasGainPrizeIds then
		local actCfg = SaintKnightTianConfig.instance:getActCfg(self._challengeId)
		local cfgs = SaintKnightTianConfig.instance:getPrizeCfgs(actCfg.prizePlanId)

		for stage, cfg in ipairs(cfgs) do
			if stage <= self._curPassStateId and not TableUtil.isHad(self._hasGainPrizeIds, stage) then
				return true
			end
		end
	end

	return self:getDailyOpen(ViewName.SaintKnightTianChallengeView)
end

function SaintKnightTianModel:getIsActiveRdGame()
	if self._hasGainGamePrizeIds then
		local actCfg = SaintKnightTianConfig.instance:getActCfg(self._challengeId)
		local cfgs = SaintKnightTianConfig.instance:getGamePrizeCfgs(actCfg.gamePrizePlanId)
		local curMatNums = MaterialMgr.getMatCount(actCfg.gameItemId)

		if table.nums(self._hasGainGamePrizeIds) < table.nums(cfgs) then
			for id, cfg in ipairs(cfgs) do
				if curMatNums >= cfg.needScore and not TableUtil.isHad(self._hasGainGamePrizeIds, id) then
					return true
				end
			end
		end
	end

	return self:getDailyOpen(ViewName.SaintKnightTianGuideView)
end

function SaintKnightTianModel:getCurFmtMo()
	self._curCustomFmtMo = self._curCustomFmtMo or SaintKnightTianCustomFmtMo.New()

	return self._curCustomFmtMo
end

function SaintKnightTianModel:prepareGameDatas()
	local testList = {}
	local actCfg = SaintKnightTianConfig.instance:getActCfg(self._challengeId)
	local planId = actCfg.gamePlanId
	local pcfgs = SaintKnightTianConfig.instance:getGamePlanCfgs(planId)
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

			local tcfgs = SaintKnightTianConfig.instance:getGameTemplateCfgs(templateId)

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
					local ptcfgs = SaintKnightTianConfig.instance:getPetTemplateCfgs(stageId)
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

function SaintKnightTianModel:onGetInfo(msg)
	self._useGameTime = checkint(msg.gameCount)
	self._hasGainGamePrizeIds = msg.gamePrize or {}
	self._hasGainPrizeIds = msg.prize or {}
	self._hasCollectPetNum = checkint(msg.collectPetBuff)
	self._isHasAreaBuff = checkbool(msg.serverBuff)
	self._curPassStateId = checkint(msg.curStageId)
end

function SaintKnightTianModel:onGetPrize(msg)
	self._hasGainPrizeIds = msg.prize
end

function SaintKnightTianModel:onGetGamePrize(msg)
	self._hasGainGamePrizeIds = msg.gamePrize
end

function SaintKnightTianModel:onStartGame(msg)
	return
end

function SaintKnightTianModel:onSettleGame(msg)
	self._useGameTime = self._useGameTime - 1
	self.CiList = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
end

function SaintKnightTianModel:ShowCI()
	MaterialController.instance:showChangeSetInTemp(checknumber(self.CiList))

	self.CiList = nil
end

function SaintKnightTianModel:getDailyOpen(dataKey)
	return checkint(GameUtil.getUserDayData(dataKey)) <= 0
end

function SaintKnightTianModel:setDailyOpen(dataKey)
	GameUtil.saveUserDayData(dataKey, 1)
	SaintKnightTianController.instance:onRedPointChange()
end

SaintKnightTianModel.instance = SaintKnightTianModel.New()

return SaintKnightTianModel
