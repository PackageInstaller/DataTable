-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/model/HalloweenGuestModel.lua

module("logic.extensions.halloweenguest.model.HalloweenGuestModel", package.seeall)

local HalloweenGuestModel = class("HalloweenGuestModel", BaseModel)

function HalloweenGuestModel:ctor()
	self.monsterActType = 82
	self.monsterActId = nil
	self._bossOpenInfo = {
		actType = 83
	}
	self._monsterInfo = nil
	self._bossInfo = nil
	self._bossBattleDamage = nil
end

function HalloweenGuestModel:onInit()
	HalloweenGuestModel.super.onInit(self)
	self:onReset()
end

function HalloweenGuestModel:onReset()
	self._bossOpenInfo = {
		actType = 83
	}
	self._monsterInfo = nil
	self._bossInfo = nil
	self._bossBattleDamage = nil
end

function HalloweenGuestModel:getHalloweenMonsterInfo()
	if self._monsterInfo == nil then
		self._monsterInfo = {
			isActivateDailyBuff = false,
			totalChallengedNum = 0,
			dailyChallengedNum = 0,
			activityId = self.monsterActId,
			sceneInfos = {},
			gainedPrizeIds = {}
		}
	end

	return self._monsterInfo
end

function HalloweenGuestModel:getHalloweenBossInfo()
	if self._bossInfo == nil then
		self._bossInfo = {
			dailyMaxDamage = 0,
			totalDamage = 0,
			isGainDailyPrize = false,
			activityId = self._bossOpenInfo.actId,
			gainedDamagePrizeIds = {}
		}
	end

	return self._bossInfo
end

function HalloweenGuestModel:getBossOpenInfo()
	return self._bossOpenInfo
end

function HalloweenGuestModel:setBossOpenInfo(actId, openId, planId)
	self._bossOpenInfo.actId = actId
	self._bossOpenInfo.openId = openId
	self._bossOpenInfo.planId = planId
end

function HalloweenGuestModel:getAllSceneMonsters()
	if self._monsterInfo == nil or self._monsterInfo.sceneInfos == nil then
		return
	end

	local targetList = {}
	local data
	local actCfg = HalloweenGuestConfig.instance:getActMonsterCfg(self.monsterActId)

	for _, info in pairs(self._monsterInfo.sceneInfos) do
		if info and checknumber(info.sceneConfigId) > 0 and info.positionIds then
			for _, id in pairs(info.positionIds) do
				if id and checknumber(id) > 0 then
					data = {
						isChall = false,
						scId = info.sceneConfigId,
						posId = id,
						planId = actCfg.scenePlanId
					}
					data.isChall = self:_isPositionIdChallenge(id, info.challengedPositionIds)

					table.insert(targetList, data)
				end
			end
		end
	end

	local allCount = actCfg.dailyRefreshSceneNum * actCfg.sceneRefreshPositionNum

	if allCount ~= #targetList then
		printError("sr---捣蛋鬼   HalloweenGuestModel:getAllSceneMonsters()    为撒下发的数量不是配置个数！！")
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			if a.scId == b.scId then
				return a.posId < b.posId
			end

			return a.scId < b.scId
		end)
	end

	return targetList
end

function HalloweenGuestModel:_isPositionIdChallenge(posId, list)
	if list == nil then
		return false
	end

	for _, id in pairs(list) do
		if id and checknumber(id) == posId then
			return true
		end
	end

	return false
end

function HalloweenGuestModel:getCurrentBossDamagePrize(planId)
	local allCfgs = HalloweenGuestConfig.instance:getBossDamagesCfg(planId)

	if allCfgs == nil or #allCfgs == 0 then
		return
	end

	local cfg
	local damage = self._bossInfo and checknumber(self._bossInfo.totalDamage) or 0

	for i = 1, #allCfgs do
		if allCfgs[i] and damage < allCfgs[i].damage then
			cfg = allCfgs[i]

			break
		end
	end

	if cfg and damage >= cfg.damage then
		cfg = nil
	end

	return cfg
end

function HalloweenGuestModel:getBossRankPrizeByPrize(planId, prizeId)
	prizeId = checknumber(prizeId)

	if prizeId <= 0 then
		return nil
	end

	planId = checknumber(planId)

	local allCfgs = HalloweenGuestConfig.instance:getBossRanksCfg(planId)

	if allCfgs == nil or #allCfgs == 0 then
		return nil
	end

	local cfg

	for i = 1, #allCfgs do
		if allCfgs[i] and allCfgs[i].rankPrizePlanId == planId and allCfgs[i].id == prizeId then
			cfg = allCfgs[i]

			break
		end
	end

	if cfg and not string.nilorempty(cfg.prize) then
		return string.split(cfg.prize, "#")
	end

	return nil
end

function HalloweenGuestModel:getBossRankPrizeByRank(planId, rankId)
	rankId = checknumber(rankId)

	if rankId <= 0 then
		return nil
	end

	planId = checknumber(planId)

	local allCfgs = HalloweenGuestConfig.instance:getBossRanksCfg(planId)

	if allCfgs == nil or #allCfgs == 0 then
		return nil
	end

	local cfg

	for i = 1, #allCfgs do
		if allCfgs[i] and allCfgs[i].rankPrizePlanId == planId and rankId <= allCfgs[i].top and (cfg == nil or cfg.top > allCfgs[i].top) then
			cfg = allCfgs[i]
		end
	end

	if cfg and rankId <= cfg.top and not string.nilorempty(cfg.prize) then
		return string.split(cfg.prize, "#")
	end

	return nil
end

function HalloweenGuestModel:initAllSceneNpcShow(oldId, nowId)
	oldId = checknumber(oldId)
	nowId = checknumber(nowId)

	if checknumber(nowId) > 0 then
		local actCfg = HalloweenGuestConfig.instance:getActMonsterCfg(nowId)

		if actCfg == nil or checknumber(actCfg.scenePlanId) <= 0 then
			return
		end

		local sceneCfgs = HalloweenGuestConfig.instance:getHalloweenSceneCfg(actCfg.scenePlanId)
		local posCfgs

		for _, item in pairs(sceneCfgs or {}) do
			if item and item.scenePositionPlanId then
				for _, cfg in pairs(HalloweenGuestConfig.instance:getHalloweenMonsterCfg(item.scenePositionPlanId) or {}) do
					if cfg and checknumber(cfg.npcId) > 0 then
						SceneNpcsMgr.instance:createNpc(cfg.npcId)
					end
				end
			end
		end
	end

	if oldId == nowId then
		return
	end

	if checknumber(oldId) > 0 then
		local actCfg = HalloweenGuestConfig.instance:getActMonsterCfg(oldId)

		if actCfg == nil or checknumber(actCfg.scenePlanId) <= 0 then
			return
		end

		local sceneCfgs = HalloweenGuestConfig.instance:getHalloweenSceneCfg(actCfg.scenePlanId)
		local posCfgs

		for _, item in pairs(sceneCfgs or {}) do
			if item and item.scenePositionPlanId then
				for _, cfg in pairs(HalloweenGuestConfig.instance:getHalloweenMonsterCfg(item.scenePositionPlanId) or {}) do
					if cfg and checknumber(cfg.npcId) > 0 then
						SceneNpcsMgr.instance:removeNpc(cfg.npcId)
					end
				end
			end
		end
	end
end

function HalloweenGuestModel:setSceneNpcTransform(npcId)
	npcId = checknumber(npcId)

	if npcId <= 0 then
		return
	end

	SceneNpcsMgr.instance:removeNpc(npcId)
	SceneNpcsMgr.instance:createNpc(npcId)
end

function HalloweenGuestModel:isHalloweenNpsPass(npcId)
	npcId = checknumber(npcId)

	if npcId <= 0 then
		return false
	end

	if self._monsterInfo == nil or self._monsterInfo.sceneInfos == nil then
		return true
	end

	local actCfg = HalloweenGuestConfig.instance:getActMonsterCfg(self.monsterActId)

	if actCfg == nil then
		return true
	end

	local posId, posPlanId = self:_getPositionIdBuyNpcId(npcId)

	if checknumber(posId) <= 0 or checknumber(posPlanId) <= 0 then
		return true
	end

	local isPass = true
	local sceneCfg

	for _, info in pairs(self._monsterInfo.sceneInfos) do
		if info and checknumber(info.sceneConfigId) > 0 then
			sceneCfg = HalloweenGuestConfig.instance:getHalloweenSceneCfg(actCfg.scenePlanId, info.sceneConfigId)

			if sceneCfg and checknumber(sceneCfg.scenePositionPlanId) == posPlanId then
				local var_16_0, var_16_1 = self:_isHaveAndPassNpc(posId, info.positionIds, info.challengedPositionIds)

				isPass = var_16_1

				if var_16_0 then
					return var_16_1
				end
			end
		end
	end

	return true
end

function HalloweenGuestModel:_isHaveAndPassNpc(posId, haveList, passList)
	if haveList == nil then
		return false, false
	end

	local isHave = false

	for _, id in pairs(haveList) do
		if id and checknumber(id) == posId then
			isHave = true

			break
		end
	end

	if isHave and passList then
		for _, id in pairs(passList) do
			if id and checknumber(id) == posId then
				return isHave, true
			end
		end
	end

	return isHave, false
end

function HalloweenGuestModel:_getPositionIdBuyNpcId(npcId)
	local scene = SceneMgr.instance:getCurScene()
	local sceneId = checknumber(scene:getSceneId())

	if checknumber(sceneId) <= 0 then
		return nil
	end

	local actCfg = HalloweenGuestConfig.instance:getActMonsterCfg(self.monsterActId)

	if actCfg == nil or checknumber(actCfg.scenePlanId) <= 0 then
		return nil
	end

	local sceneCfgs = HalloweenGuestConfig.instance:getHalloweenSceneCfg(actCfg.scenePlanId)
	local posCfgs

	for _, item in pairs(sceneCfgs or {}) do
		if item and item.scenePositionPlanId and item.sceneId == sceneId then
			for _, cfg in pairs(HalloweenGuestConfig.instance:getHalloweenMonsterCfg(item.scenePositionPlanId) or {}) do
				if cfg and checknumber(cfg.npcId) == npcId then
					return cfg.id, cfg.scenePositionPlanId
				end
			end
		end
	end

	return nil
end

function HalloweenGuestModel:getHalloweenNpsLocation(npcId)
	npcId = checknumber(npcId)

	local scene = SceneMgr.instance:getCurScene()
	local cfg = HalloweenGuestConfig.instance:getActMonsterCfg(self.monsterActId)

	if cfg == nil or scene == nil then
		return false
	end

	local sceneId = checknumber(scene:getSceneId())
	local allCfgs = HalloweenGuestConfig.instance:getHalloweenSceneCfg(cfg.scenePlanId)
	local info

	for _, item in pairs(allCfgs or {}) do
		if item and item.sceneId == sceneId then
			info = {
				actId = self.monsterActId,
				sceneId = item.id,
				posPlanId = item.scenePositionPlanId
			}

			break
		end
	end

	if info then
		local npcCfgs = HalloweenGuestConfig.instance:getHalloweenMonsterCfg(info.posPlanId)

		for _, item in pairs(npcCfgs or {}) do
			if item and item.npcId == npcId then
				info.baseId = item.creepsMasterId
				info.posId = item.id

				FuncOpenController.instance:openFuncByViewName(ViewName.HalloweenMission, info)

				return true
			end
		end
	end

	return false
end

function HalloweenGuestModel:getHalloweenBuffInfo()
	if checknumber(self.monsterActId) <= 0 then
		return nil, nil
	end

	if self._monsterInfo == nil or self._monsterInfo.dailyChallengedNum == nil then
		return nil, nil
	end

	local actCfg = HalloweenGuestConfig.instance:getActMonsterCfg(self.monsterActId)

	if actCfg == nil or string.nilorempty(actCfg.buffMaterial) then
		return nil, nil
	end

	local allCount = actCfg.dailyRefreshSceneNum * actCfg.sceneRefreshPositionNum

	if allCount > self._monsterInfo.dailyChallengedNum then
		return nil, nil
	end

	local buff = string.split(actCfg.buffMaterial, ":")
	local time = ServerTime.nowDateServerLook()
	local endTime = os.time({
		hour = 5,
		min = 0,
		sec = 0,
		year = time.year,
		month = time.month,
		day = time.day
	})

	if endTime < ServerTime.now() then
		endTime = endTime + 86400 - 1
	end

	local cfgTimedItem = TimedItemConfig.instance:getTimedItemCfg(checknumber(buff[2]))
	local buffId

	return checknumber((cfgTimedItem or nil) and cfgTimedItem.buffId), {
		expiredTimeMillis = endTime * 1000
	}
end

function HalloweenGuestModel:getHalloweenRedpoint(isBoss)
	if not isBoss and RedPointModel.instance:isActiveByServer(RedPointModel.ID_HALLOWEEN2) then
		return true
	end

	if not HalloweenGuestConfig.instance:isSetBossOpenInfo() then
		return false
	end

	if RedPointModel.instance:isActiveByServer(RedPointModel.ID_HALLOWEEN3) then
		return true
	end

	local value = GameUtil.getUserDayData("HalloweenBossRedpoint")

	return checknumber(value) ~= 1
end

function HalloweenGuestModel:getSceneNpcRedpoint(sBaseId, allNum)
	allNum = allNum or 3

	if self._monsterInfo == nil or self._monsterInfo.sceneInfos == nil then
		return false
	end

	for _, info in pairs(self._monsterInfo.sceneInfos) do
		if info and info.sceneConfigId == checknumber(sBaseId) then
			if info.challengedPositionIds == nil or #info.challengedPositionIds ~= allNum then
				return true
			end

			return false
		end
	end

	return false
end

function HalloweenGuestModel:getProgPrizeRedpoint()
	return false
end

function HalloweenGuestModel:getDailyPrizeRedpoint()
	if self._bossInfo == nil or self._bossInfo.isGainDailyPrize or checknumber(self._bossInfo.dailyMaxDamage) <= 0 then
		return false
	end

	return true
end

function HalloweenGuestModel:getDamagePrizeRedpoint(planId)
	if self._bossInfo == nil or checknumber(self._bossInfo.totalDamage) <= 0 then
		return false
	end

	local allCfgs = HalloweenGuestConfig.instance:getBossDamagesCfg(planId)

	if allCfgs == nil or #allCfgs == 0 then
		return false
	end

	for i = 1, #allCfgs do
		if allCfgs[i] and self._bossInfo.totalDamage >= checknumber(allCfgs[i].damage) and (self._bossInfo.gainedDamagePrizeIds == nil or not table.indexof(self._bossInfo.gainedDamagePrizeIds, allCfgs[i].id)) then
			return true
		end
	end

	return false
end

function HalloweenGuestModel:scSendHalloweenSceneMonsterGetInfo(msg)
	self._monsterInfo = {}
	self._monsterInfo.activityId = msg.activityId
	self._monsterInfo.sceneInfos = GameUtil.pbToTable(msg.sceneInfos) or {}
	self._monsterInfo.dailyChallengedNum = checknumber(msg.dailyChallengedNum)
	self._monsterInfo.totalChallengedNum = checknumber(msg.totalChallengedNum)
	self._monsterInfo.gainedPrizeIds = msg.gainedPrizeIds or {}
	self._monsterInfo.isActivateDailyBuff = msg.isActivateDailyBuff

	GlobalDispatcher:dispatch(GlobalNotify.HalloweenMonsterInfo)
end

function HalloweenGuestModel:scSendMonsterNotifyChallengeEnd(msg)
	if msg == nil or not msg.isWin then
		return
	end

	local actCfg = HalloweenGuestConfig.instance:getActMonsterCfg(msg.activityId)

	if actCfg then
		local sceneCfg = HalloweenGuestConfig.instance:getHalloweenSceneCfg(actCfg.scenePlanId, msg.sceneConfigId)

		if sceneCfg then
			local posCfg = HalloweenGuestConfig.instance:getHalloweenMonsterCfg(sceneCfg.scenePositionPlanId, msg.positionId)

			if posCfg and checknumber(posCfg.npcId) > 0 then
				self:setSceneNpcTransform(posCfg.npcId)
			end
		end
	end

	if self._monsterInfo == nil or self._monsterInfo.sceneInfos == nil then
		return
	end

	self._monsterInfo.dailyChallengedNum = checknumber(self._monsterInfo.dailyChallengedNum) + 1
	self._monsterInfo.totalChallengedNum = checknumber(self._monsterInfo.totalChallengedNum) + 1

	for _, info in pairs(self._monsterInfo.sceneInfos) do
		if info and info.sceneConfigId == msg.sceneConfigId then
			info.challengedPositionIds = info.challengedPositionIds or {}

			table.insert(info.challengedPositionIds, msg.positionId)

			return
		end
	end
end

function HalloweenGuestModel:scSendHalloweenSceneMonsterGainPrize(msg)
	if self._monsterInfo == nil or msg == nil or msg.prizeId == nil then
		return
	end

	self._monsterInfo.gainedPrizeIds = self._monsterInfo.gainedPrizeIds or {}

	for _, id in pairs(self._monsterInfo.gainedPrizeIds) do
		if id and checknumber(id) == msg.prizeId then
			return
		end
	end

	table.insert(self._monsterInfo.gainedPrizeIds, msg.prizeId)
	GlobalDispatcher:dispatch(GlobalNotify.HalloweenMonsterPrize)
end

function HalloweenGuestModel:scSendHalloweenBossChallengeGetInfo(msg)
	self._bossInfo = {}
	self._bossInfo.activityId = msg.activityId
	self._bossInfo.dailyMaxDamage = checknumber(msg.dailyMaxDamage)
	self._bossInfo.totalDamage = checknumber(msg.totalDamage)
	self._bossInfo.gainedDamagePrizeIds = msg.gainedDamagePrizeIds or {}
	self._bossInfo.isGainDailyPrize = msg.isGainDailyPrize
	self._bossInfo = msg

	GlobalDispatcher:dispatch(GlobalNotify.HalloweenBossInfo)
end

function HalloweenGuestModel:scSendBossNotifyChallengeEnd(msg)
	self._bossBattleDamage = msg and checknumber(msg.damage) or 0
end

function HalloweenGuestModel:scSendHalloweenBossChallengeGainDailyPrize(msg)
	self._bossInfo = self._bossInfo or {}
	self._bossInfo.isGainDailyPrize = true

	GlobalDispatcher:dispatch(GlobalNotify.HalloweenDailyPrize)
end

function HalloweenGuestModel:scSendHalloweenBossChallengeGainDamagePrize(msg)
	if self._bossInfo == nil or msg == nil or msg.damgePrizeId == nil then
		return
	end

	for _, id in pairs(self._bossInfo.gainedDamagePrizeIds) do
		if id and checknumber(id) == msg.damgePrizeId then
			return
		end
	end

	table.insert(self._bossInfo.gainedDamagePrizeIds, msg.damgePrizeId)
	GlobalDispatcher:dispatch(GlobalNotify.HalloweenDamagePrize)
end

function HalloweenGuestModel:scSendHalloweenBossChallengeRank(msg)
	if msg == nil or msg.rankInfos == nil then
		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.HalloweenRankInfo, msg.rankInfos, msg.myRank)
end

HalloweenGuestModel.instance = HalloweenGuestModel.New()

return HalloweenGuestModel
