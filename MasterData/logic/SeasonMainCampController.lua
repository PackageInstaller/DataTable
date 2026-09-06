-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/controller/SeasonMainCampController.lua

module("logic.extensions.season.controller.SeasonMainCampController", package.seeall)

local SeasonMainCampController = class("SeasonMainCampController", BaseController)

function SeasonMainCampController:onInit()
	self:onReset()
end

function SeasonMainCampController:onReset()
	self._mainCampRpCache = nil
	self._totemRpCache = nil
end

function SeasonMainCampController:sendGetSeasonMainCampInfo(otherUserId)
	if SeasonConfig.instance:getInTimeSeasonConfig() ~= nil then
		self._userId_SMPVEGetMainCampInfo = otherUserId

		SeasonModePveAgent.instance:sendPM_SMPVEGetMainCampInfoReq(otherUserId)
	end
end

function SeasonMainCampController:getEntranceLockConfig(buildId)
	local model = SeasonModel.instance
	local seasonId = model:getSeasonId()
	local config = SeasonMainCampConfig.instance:getCampEntranceConfig(seasonId)
	local unlockLv = config[buildId].needLv
	local jumpTo = config[buildId].jumpTo

	return unlockLv, jumpTo
end

function SeasonMainCampController:tryOpenEntrance(buildId)
	local unlockLv, jumpTo = self:getEntranceLockConfig(buildId)
	local curLv = checknumber(SeasonMainCampModel.instance:getCampLv())

	if curLv < checknumber(unlockLv) then
		TipsFacade.instance:openCommonTips(langPara("主营地%d级解锁", unlockLv))
	elseif not string.nilorempty(jumpTo) then
		GotoMgr.gotoByString(jumpTo)
	end
end

function SeasonMainCampController:toAttrList(res)
	local result = {}

	for k, v in pairs(res) do
		if k ~= AttrMo.KEY_DIRECT_ZDL then
			table.insert(result, {
				type = k,
				value = v
			})
		end
	end

	ArraySort.sortOn(result, "type")

	local array = {}

	for _, v in ipairs(result) do
		if v.value > 0 then
			table.insert(array, langPara("%s+%s", ConstString.Attr[v.type], v.value))
		else
			table.insert(array, langPara("%s+%s", ConstString.Attr[v.type], v.value))
		end
	end

	return array
end

function SeasonMainCampController:sendGetBudgeInfo()
	SeasonModePveAgent.instance:sendPM_SMPVEGetBudgeInfoReq()
end

function SeasonMainCampController:handleSMPVEGetBudgeInfoRes(status, msg)
	if status == 0 then
		SeasonBadgeModel.instance:handleInit(msg)
		SeasonTeamsModel.instance:onUpdateBadgeIds(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonBadgeInfoUpdated)
	end
end

function SeasonMainCampController:sendActiviteBudge(budgeId)
	SeasonModePveAgent.instance:sendPM_SMPVEActiviteBudgeReq(budgeId)
end

function SeasonMainCampController:handleSMPVEActiviteBudgeRes(status, msg)
	if status == 0 then
		SeasonBadgeModel.instance:handleActiveBadgeIds(msg)
		SeasonTeamsModel.instance:onUpdateBadgeIds(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonBadgeInfoUpdated)
	end
end

function SeasonMainCampController:sendGetTotemInfo(userId)
	self._userId_SMPVEGetTotemPoleInfo = userId

	if self._userId_SMPVEGetTotemPoleInfo == RoleModel.instance:getUserId() then
		SeasonModePveAgent.instance:sendPM_SMPVEGetTotemPoleInfoReq()
	else
		SeasonModePveAgent.instance:sendPM_SMPVEGetTotemPoleInfoReq(userId)
	end
end

function SeasonMainCampController:handleSMPVEGetTotemPoleInfoRes(status, msg)
	if status == 0 then
		if self._userId_SMPVEGetTotemPoleInfo then
			SeasonMainCampModel.instance:updateAllTotemPoleInfo(self._userId_SMPVEGetTotemPoleInfo, msg)
			SeasonTeamsModel.instance:onUpdateAllTotemPoleInfo(msg)
		end

		self._userId_SMPVEGetTotemPoleInfo = nil

		GlobalDispatcher:dispatch(GlobalNotify.SeasonTotemInfoUpdated)
	end
end

function SeasonMainCampController:handleSMPVEUpgradeTotemPoleItemRes(status, msg)
	if status == 0 then
		local userId = RoleModel.instance:getUserId()

		SeasonMainCampModel.instance:updateOneTotemPoleInfo(userId, msg.info)
		SeasonTeamsModel.instance:onUpdateTotemPoleInfo(msg.info)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonTotemInfoUpdated)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonTotemPropertyEffectUpdate)

		self._totemRpCache = nil
	end
end

function SeasonMainCampController:handleSMPVEUpgradeMainTotemPoleRes(status, msg)
	if status == 0 then
		local userId = RoleModel.instance:getUserId()

		SeasonMainCampModel.instance:updateOneTotemPoleInfo(userId, msg.info)
		SeasonTeamsModel.instance:updateTotemPoleAttr(msg.info)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonTotemInfoUpdated)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonTotemPropertyEffectUpdate)

		self._totemRpCache = nil
	end
end

function SeasonMainCampController:handleSMPVEGetMainCampInfoRes(status, msg)
	if status == 0 then
		if self._userId_SMPVEGetMainCampInfo then
			SeasonMainCampModel.instance:updateMainCampInfoOther(msg)
		else
			SeasonMainCampModel.instance:updateMainCampInfo(msg)
		end

		self._userId_SMPVEGetMainCampInfo = nil

		GlobalDispatcher:dispatch(GlobalNotify.SeasonMainCampInfoUpdated)
	end
end

function SeasonMainCampController:handleSMPVEUpgradeCampLvRes(status, msg)
	if status == 0 then
		SeasonMainCampModel.instance:updateMainCampLevel(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonMainCampInfoUpdated)

		self._mainCampRpCache = nil

		GlobalDispatcher:dispatch(GlobalNotify.SeasonMainCampLevelUpEffectUpdate)
	end
end

function SeasonMainCampController:handleSMPVEGainHangingPrizeRes(status, msg)
	if status == 0 then
		MaterialFacade.instance:popAndShowChangeSetItems(msg.changeSetId)
		SeasonMainCampModel.instance:handleGainHangingPrize(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonMainCampInfoUpdated)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonMainCampBoxEffectUpdate)
	end
end

function SeasonMainCampController:trySendTriggerHangingStartTime()
	if SeasonMainCampModel.instance:isHasInitMainCampInfo() and not SeasonMainCampModel.instance:hasTriggerHangingStartTime() then
		SeasonModePveAgent.instance:sendPM_SMPVETriggerHangingStartTimeReq()
	end
end

function SeasonMainCampController:handlePSMPVETriggerHangingStartTimeRes(status, msg)
	if status == 0 then
		SeasonMainCampModel.instance:handleTriggerHangingStartTime(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonMainCampInfoUpdated)
	end
end

function SeasonMainCampController:handleSMPVEChangePetGuardRes(status, msg)
	if status == 0 then
		SeasonMainCampModel.instance:handleChangePetGuardRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonMainCampInfoUpdated)
	end
end

function SeasonMainCampController:checkTrainRed(teamMo)
	if teamMo == nil then
		return false
	end

	local seasonId = SeasonModel.instance:getSeasonId()
	local campLv = checknumber(SeasonMainCampModel.instance:getCampLv())
	local tgCfg = SeasonMainCampConfig.instance:getTrainingGroundConfig(seasonId)
	local teamPlanId = tgCfg.teamPlanId
	local isAllEnough = false
	local lvl = teamMo.teamLv
	local maxLvPlanId = 0
	local teamUpgradePlanId = 0

	if lvl > 0 and tgCfg and campLv >= checknumber(tgCfg.campLv) then
		local teamCfg = SeasonMainCampConfig.instance:getTeamConfig(teamPlanId, teamMo.teamId)

		if teamCfg and campLv >= checknumber(teamCfg.campLv) then
			maxLvPlanId = teamCfg.maxLvPlanId
			teamUpgradePlanId = teamCfg.teamUpgradePlanId

			local maxList = SeasonMainCampConfig.instance:getTeamMaxLvlCfgList(teamCfg.maxLvPlanId)
			local lvlCfg = SeasonMainCampConfig.instance:getNearTeamLvlConfig(maxLvPlanId, campLv)

			if lvlCfg and maxList then
				local maxUpLvl = lvlCfg.maxLv

				if lvl < maxUpLvl then
					local nextCostCfg = SeasonMainCampConfig.instance:getUpgradeConfig(teamUpgradePlanId, lvl + 1)

					if nextCostCfg then
						isAllEnough = MaterialFacade.instance:isMatsEnough(nextCostCfg.cost)
					end
				end
			end
		end
	end

	return isAllEnough
end

function SeasonMainCampController:checkTrainMainRed()
	local teams = SeasonTeamsModel.instance:getTeams() or {}
	local trainRed = false

	for i, teamMo in ipairs(teams) do
		trainRed = SeasonMainCampController.instance:checkTrainRed(teamMo)

		if trainRed == true then
			break
		end
	end

	return trainRed
end

function SeasonMainCampController:checkTotemTabRed(selectTabId)
	local userId = SeasonModel.instance:getTeammateId()
	local totemInfo = SeasonMainCampModel.instance:getTotemPoleInfoByRaceType(userId, selectTabId)

	if totemInfo then
		local configList = SeasonMainCampConfig.instance:getTotemPoleItemList(totemInfo.totemItemPlanId) or {}

		for k, v in pairs(configList) do
			local level = totemInfo:getSubItemLv(k)
			local nextConfig = SeasonMainCampConfig.instance:getTotemPoleItemConfig(totemInfo.totemItemPlanId, k, level + 1)
			local isGray = totemInfo:isSmallTotemCanUpgrade(k)

			if isGray and nextConfig then
				local cost = nextConfig.cost

				if not string.nilorempty(cost) then
					local isAllEnough = MaterialFacade.instance:isMatsEnough(cost)

					if isAllEnough then
						return true
					end
				end
			end
		end

		if totemInfo:isMainTotemCanUpgrade() then
			local level = totemInfo.mainTotemPoleLv
			local nextConfig = SeasonMainCampConfig.instance:getMainTotemConfig(totemInfo.mainTotemPlanId, level + 1) or {}
			local needCampLv = checknumber(nextConfig.campLv)

			if needCampLv <= SeasonMainCampModel.instance:getCampLv() then
				local cost = nextConfig.cost

				if not string.nilorempty(cost) then
					local isAllEnough = MaterialFacade.instance:isMatsEnough(cost)

					if isAllEnough then
						return true
					end
				else
					return true
				end
			end
		end
	end

	return false
end

function SeasonMainCampController:checkTotemMainRed()
	if self._totemRpCache then
		return self._totemRpCache
	end

	local seasonId = SeasonModel.instance:getSeasonId()
	local cfgs = SeasonMainCampConfig.instance:getTotemPoleConfig(seasonId)
	local totemTabIndexList = SeasonMainCampConfig.instance:getTotemPoleRaceTypeConfigs(cfgs.totemPoleRaceTypePlanId)

	self._totemRpCache = false

	for i, v in ipairs(totemTabIndexList) do
		self._totemRpCache = self:checkTotemTabRed(v.index)

		if self._totemRpCache == true then
			break
		end
	end

	return self._totemRpCache
end

function SeasonMainCampController:checkMainCampRed()
	if self._mainCampRpCache then
		return self._mainCampRpCache
	end

	local campLv = SeasonMainCampModel.instance:getCampLv()
	local seasonId = SeasonModel.instance:getSeasonId()
	local mainCampConfig = SeasonMainCampConfig.instance:getMainCampConfig(seasonId)
	local levelUpConfigs = SeasonMainCampConfig.instance:getMainCampUpgradeConfig(mainCampConfig.upgradePlanId)
	local nextConfig = levelUpConfigs[campLv + 1]

	self._mainCampRpCache = false

	if nextConfig and not string.nilorempty(nextConfig.cost) then
		local costArray = string.split(nextConfig.cost, "#")

		self._mainCampRpCache = true

		for i, cfgStr in ipairs(costArray) do
			local type, id, num = MaterialMgr.getMatParams(cfgStr)

			if not MaterialModel.instance:IsEnough(type, id, num) then
				self._mainCampRpCache = false

				break
			end
		end
	end

	return self._mainCampRpCache
end

SeasonMainCampController.instance = SeasonMainCampController.New()

return SeasonMainCampController
