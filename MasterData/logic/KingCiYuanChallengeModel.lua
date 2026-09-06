-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/model/KingCiYuanChallengeModel.lua

module("logic.extensions.kingciyuanchallenge.model.KingCiYuanChallengeModel", package.seeall)

local KingCiYuanChallengeModel = class("KingCiYuanChallengeModel", BaseModel)

function KingCiYuanChallengeModel:ctor()
	self:onReset()
end

function KingCiYuanChallengeModel:onInit()
	self:onReset()
end

function KingCiYuanChallengeModel:onReset()
	self._todayBossBuff = nil
	self._bossPrizeIdMap = nil
	self._bossChallenge = nil
	self._bossBuyNum = nil
	self._bossMaxDamage = nil
	self._jxPassStageId = 0
	self._jxBuffs = {}
	self._jxSelectBuffs = {}
	self._petHpMap = {}
	self._tempPetHpMap = {}
	self._oldSuitBuffMap = nil
	self._buffMap = nil
	self._oldSuitBuffMap = {}
	self._lastStageId = nil
	self.limitFmtMo = KCYCLimitFmtMo.New()
	self.bossFmtMo = KCYCBossFmtMo.New()
end

function KingCiYuanChallengeModel:handleKingCiYuanGetInfoRes(msg)
	self._todayBossBuff = checknumber(msg.todayBossBuff)

	if not msg.bossInfo then
		self._bossPrizeIdMap = {}

		for i, v in ipairs(msg.bossInfo.prizeId or {}) do
			self._bossPrizeIdMap[v] = true
		end

		self._bossChallenge = checknumber(msg.bossInfo.challenge)
		self._bossBuyNum = checknumber(msg.bossInfo.buyNum)
		self._bossMaxDamage = checknumber(msg.bossInfo.maxDamage)

		self:_setHp(msg, true)
		self:_setStageInfo(msg)
	end
end

function KingCiYuanChallengeModel:getTodayBossBuff()
	return self._todayBossBuff
end

function KingCiYuanChallengeModel:isJxStagePass(stageId)
	return stageId <= self._jxMaxPassStage
end

function KingCiYuanChallengeModel:getJxPassStageId()
	return self._jxPassStageId
end

function KingCiYuanChallengeModel:getLastStageId()
	return self._lastStageId
end

function KingCiYuanChallengeModel:resetLastStageId()
	self._lastStageId = self._jxPassStageId
end

function KingCiYuanChallengeModel:getJxBuffs()
	return self._jxBuffs
end

function KingCiYuanChallengeModel:getJxSelectBuffs()
	return self._jxSelectBuffs
end

function KingCiYuanChallengeModel:getJXPetHpByPetId(petId)
	local percent = self._petHpMap[petId]

	if percent ~= nil then
		return percent / 10000
	else
		return 1
	end
end

function KingCiYuanChallengeModel:getJXPetHpMap()
	return self._petHpMap
end

function KingCiYuanChallengeModel:getJXPetHpMapMerge()
	local petHpMap = {}

	for petId, value in pairs(self._tempPetHpMap or {}) do
		petHpMap[petId] = value
	end

	return petHpMap
end

function KingCiYuanChallengeModel:getBossMaxDamage()
	return self._bossMaxDamage
end

function KingCiYuanChallengeModel:isProgressPrizeGain(id)
	return self._bossPrizeIdMap[id]
end

function KingCiYuanChallengeModel:isProgressPrizeCanGain(id, needDamage)
	if not self:isProgressPrizeGain(id) then
		return needDamage <= self:getBossMaxDamage()
	end
end

function KingCiYuanChallengeModel:getBossChallengeRemain()
	local free = KingCiYuanChallengeConfig.instance:getCommonValue("BossFreeCount", true)

	return free + self._bossBuyNum - self._bossChallenge
end

function KingCiYuanChallengeModel:getHasBuyBossChallenge()
	return self._bossBuyNum
end

function KingCiYuanChallengeModel:handleKingCiYuanBossGetPrizeRes(prizeId)
	self._bossPrizeIdMap[prizeId] = true
end

function KingCiYuanChallengeModel:handleKingCiYuanBossChallengeRes()
	self._bossChallenge = self._bossChallenge + 1
end

function KingCiYuanChallengeModel:handleKingCiYuanBossBuyCountRes(msg)
	self._bossBuyNum = self._bossBuyNum + 1
end

function KingCiYuanChallengeModel:handleKingCiYuanStageActionRes(msg)
	if checknumber(msg.changeSetId) > 0 then
		self._changeSetId = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(self._changeSetId)
	end

	if msg.stageInfo and checknumber(msg.stageInfo.passStageId) > 0 then
		self:_setStageInfo(msg)
	end
end

function KingCiYuanChallengeModel:_setStageInfo(msg)
	if msg.stageInfo then
		if not msg.stageInfo then
			self._jxPassStageId = checknumber(msg.stageInfo.passStageId)
			self._jxBuffs = {}

			for i, v in ipairs(msg.stageInfo.buffRecord) do
				table.insert(self._jxBuffs, {
					buffId = v.buffId,
					count = v.count
				})
			end

			self._jxSelectBuffs = GameUtil.pbToTable(msg.stageInfo.stageBuffs or {})
			self._jxMaxPassStage = checknumber(msg.stageInfo.maxPassStage)

			if self._lastStageId == nil then
				self._lastStageId = self._jxPassStageId
			end
		end
	end

	self:updateExtFightBuffRed()
end

function KingCiYuanChallengeModel:_setHp(msg, bNeedClear)
	if msg.petHp then
		if bNeedClear then
			self._petHpMap = {}
		end

		for i, v in ipairs(msg.petHp) do
			self._petHpMap[v.id] = v.hpRatio
		end
	end
end

function KingCiYuanChallengeModel:_setTempHp(msg)
	if msg.petHp then
		self._tempPetHpMap = {}

		for i, v in ipairs(msg.petHp) do
			self._tempPetHpMap[v.id] = v.hpRatio
		end
	end
end

function KingCiYuanChallengeModel:handleKingCiYuanStageResetRes(msg)
	self._oldSuitBuffMap = nil
	self._buffMap = nil

	self:_setStageInfo(msg)

	self._petHpMap = {}
	self._tempPetHpMap = {}
end

function KingCiYuanChallengeModel:handleKingCiYuanStageChangeBuffRes(msg)
	self:_setStageInfo(msg)
end

function KingCiYuanChallengeModel:handleKingCiYuanBossChallengeEndRes(msg)
	self._bossMaxDamage = math.max(self._bossMaxDamage, checknumber(msg.damage))
end

function KingCiYuanChallengeModel:handleKingCiYuanStageActionEndRes(msg)
	self._changeSetId = msg.changeSetId

	if self._changeSetId then
		MaterialController.instance:saveChangeSetToTemp(self._changeSetId)
	end

	self:_setStageInfo(msg)
end

function KingCiYuanChallengeModel:handleKingCiYuanResultConfirmRes(msg)
	self:_setHp(msg, false)

	self._changeSetId = msg.changeSetId

	if self._changeSetId then
		MaterialController.instance:saveChangeSetToTemp(self._changeSetId)
	end

	self:_setStageInfo(msg)
end

function KingCiYuanChallengeModel:handleKingCiYuanStageFightRes(msg)
	self:_setTempHp(msg, false)
end

function KingCiYuanChallengeModel:getChangeSetId()
	return self._changeSetId
end

function KingCiYuanChallengeModel:updateExtFightBuffRed(bNeedClearSuitRed)
	local buffs = self:getJxBuffs()
	local normalBuffMap = {}
	local suitBuffMap = {}
	local buffMap = {}

	for _, data in ipairs(buffs) do
		normalBuffMap[data.buffId] = data.count
		buffMap[data.buffId] = data.count
	end

	local suitConfigs = KingCiYuanChallengeConfig.instance:getSuitConfigs()

	for _, config in ipairs(suitConfigs) do
		local curSuitConfigs = KingCiYuanChallengeConfig.instance:getTagConfigs(config.tagId)

		for i = #curSuitConfigs, 0, -1 do
			local curSuitConfig = curSuitConfigs[i]

			if curSuitConfig then
				local unlock = curSuitConfig.unlock

				if unlock ~= nil and #unlock > 0 then
					local isActive = true

					for _, strUnlockGroup in ipairs(unlock) do
						local arr = string.splitToNumber(strUnlockGroup, "#")
						local needBuffId = arr[1]
						local needCount = arr[2]

						if needCount > checknumber(normalBuffMap[needBuffId]) then
							isActive = false

							break
						end
					end

					if isActive then
						suitBuffMap[curSuitConfig.tagId] = curSuitConfig.level
						buffMap[curSuitConfig.tagId] = curSuitConfig.level

						break
					end
				end
			end
		end
	end

	local bRed = false

	if bNeedClearSuitRed then
		self._oldSuitBuffMap = suitBuffMap
	end

	if self._oldSuitBuffMap then
		for buffId, level in pairs(suitBuffMap) do
			if level > checknumber(self._oldSuitBuffMap[buffId]) then
				bRed = true

				break
			end
		end
	end

	if self._oldSuitBuffMap == nil then
		self._oldSuitBuffMap = suitBuffMap
	end

	local bInited = true

	if self._buffMap == nil then
		self._buffMap = {}
		bInited = false
	end

	if bInited then
		for buffId, level in pairs(buffMap) do
			if self._buffMap[buffId] == nil then
				self._buffMap[buffId] = {
					isClick = false,
					level = level
				}
			else
				local rdInfo = self._buffMap[buffId]

				if level > rdInfo.level then
					self._buffMap[buffId] = {
						isClick = false,
						level = level
					}
				end
			end
		end
	else
		for buffId, level in pairs(buffMap) do
			self._buffMap[buffId] = {
				isClick = true,
				level = level
			}
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_KCYC_EXT_BUFF, bRed)
end

function KingCiYuanChallengeModel:isBuffRed(buffId)
	local rdInfo = self._buffMap[buffId]

	if rdInfo then
		return not rdInfo.isClick
	end

	return false
end

function KingCiYuanChallengeModel:setBuffClick(buffId)
	local rdInfo = self._buffMap[buffId]

	if rdInfo then
		rdInfo.isClick = true
	end
end

function KingCiYuanChallengeModel:addViewInfo(viewName, ...)
	self._viewInfo = self._viewInfo or {}

	local info = {}

	info.viewName = viewName
	info.params = {
		...
	}

	table.insert(self._viewInfo, info)
end

function KingCiYuanChallengeModel:getViewInfos()
	return self._viewInfo or {}
end

function KingCiYuanChallengeModel:clearViewInfos()
	self._viewInfo = {}
end

KingCiYuanChallengeModel.instance = KingCiYuanChallengeModel.New()

return KingCiYuanChallengeModel
