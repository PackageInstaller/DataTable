-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalholydragon/controller/EternalholydragonController.lua

module("logic.extensions.eternalholydragon.controller.EternalholydragonController", package.seeall)

local EternalholydragonController = class("EternalholydragonController", BaseController)

EternalholydragonController.MaxCol = 9
EternalholydragonController.MaxRow = 5
EternalholydragonController.GotoNextBattle = "EternalholydragonController.GotoNextBattle"
EternalholydragonController.GridType = {
	Land = 0,
	Water = 1
}

function EternalholydragonController:ctor()
	return
end

function EternalholydragonController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
	GlobalDispatcher:addListener("eternalholydragonchallenge", self._enterEternalHolyDragonChallenge, self)
end

function EternalholydragonController:onReset()
	self:clearRecordItem()

	self._passStage = false
end

function EternalholydragonController:enterMission(row, col, creepsMasterId, isLand)
	local customFmtMo = EternalholydragonModel.instance:getRiverCustomFmtMo()
	local petInfos_kv = EternalholydragonModel.instance:getPetInfos()
	local position = customFmtMo:getCurFormation():GetPositions()

	for i, petId in ipairs(position) do
		if petId > 0 and petInfos_kv[petId] and petInfos_kv[petId].value <= 0 then
			customFmtMo:getCurFormation():SetPosition(i, 0)
		end
	end

	customFmtMo:initParams(row, col, creepsMasterId, isLand)
	CustomFmtController:showMissionView(customFmtMo)
end

function EternalholydragonController:getStartPos(mapCfgs)
	local col = 0

	while col < EternalholydragonController.MaxCol do
		for row = 0, 4 do
			local rowCfg = mapCfgs[row]
			local rolKey = "c" .. col
			local value = rowCfg[rolKey]

			if value > 0 then
				local up = 0
				local down = 0
				local right = 0
				local upRow = row - 1
				local downRow = row + 1
				local righCol = col + 1
				local righColKey = "c" .. righCol

				if mapCfgs[upRow] and mapCfgs[upRow][rolKey] then
					up = mapCfgs[upRow][rolKey]
					up = self:_modCheckStartPosValue(rowCfg.mapId, mapCfgs[upRow][rolKey])
				end

				if mapCfgs[downRow] and mapCfgs[downRow][rolKey] then
					down = mapCfgs[downRow][rolKey]
					down = self:_modCheckStartPosValue(rowCfg.mapId, mapCfgs[downRow][rolKey])
				end

				if mapCfgs[row] and mapCfgs[row][righColKey] then
					right = mapCfgs[row][righColKey]
					right = self:_modCheckStartPosValue(rowCfg.mapId, mapCfgs[row][righColKey])
				end

				if up == 0 and down == 0 or (up == 0 or down == 0) and right == 0 then
					return row, col
				end
			end
		end

		col = col + 1
	end
end

function EternalholydragonController:_modCheckStartPosValue(mapId, gridId)
	if gridId > 0 then
		local gridCfg = EternalholydragonConfig.instance:getGridCfg(mapId, gridId)

		if not gridCfg then
			return gridId
		end

		if gridCfg.gridType == 0 then
			return 0
		end
	end

	return gridId
end

function EternalholydragonController:getEndPos(mapCfgs)
	local col = EternalholydragonController.MaxCol - 1

	while col >= 0 do
		for row = 0, 4 do
			local rowCfg = mapCfgs[row]
			local rolKey = "c" .. col
			local value = rowCfg[rolKey]

			if value > 0 then
				local up = 0
				local down = 0
				local right = 0
				local upRow = row - 1
				local downRow = row + 1
				local righCol = col - 1
				local righColKey = "c" .. righCol

				if mapCfgs[upRow] and mapCfgs[upRow][rolKey] then
					up = mapCfgs[upRow][rolKey]
					up = self:_modCheckStartPosValue(rowCfg.mapId, mapCfgs[upRow][rolKey])
				end

				if mapCfgs[downRow] and mapCfgs[downRow][rolKey] then
					down = mapCfgs[downRow][rolKey]
					down = self:_modCheckStartPosValue(rowCfg.mapId, mapCfgs[downRow][rolKey])
				end

				if mapCfgs[row] and mapCfgs[row][righColKey] then
					right = mapCfgs[row][righColKey]
					right = self:_modCheckStartPosValue(rowCfg.mapId, mapCfgs[row][righColKey])
				end

				if up == 0 and down == 0 or (up == 0 or down == 0) and right == 0 then
					return row, col
				end
			end
		end

		col = col - 1
	end
end

function EternalholydragonController:recordItem(activityId, creepsMasterId)
	local info = EternalholydragonModel.instance:getInfo()
	local stageCfg = EternalholydragonConfig.instance:getStageCfg(activityId, info.clgProgress + 1)
	local creepCfg = EternalholydragonConfig.instance:getCreepCfg(creepsMasterId)

	self._isRecordItem = true
	self._hasItemNum = #EternalholydragonModel.instance:getOwnedItem()
	self._maxItemNum = stageCfg.itemMaxOwnCount
	self._getItemNum = creepCfg.itemDropCount
	self._newGainedItem = nil
end

function EternalholydragonController:clearRecordItem()
	self._isRecordItem = false
end

function EternalholydragonController:hasRecordItem()
	return self._isRecordItem
end

function EternalholydragonController:isItemMax()
	return self._getItemNum > 0 and self._hasItemNum >= self._maxItemNum
end

function EternalholydragonController:getNewGainedItem()
	return self._newGainedItem
end

function EternalholydragonController:onNotifyFightRiverMonsterRes(msg)
	self._passStage = false

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.Eternalholydragon)
	EternalholydragonModel.instance:onNotifyFightRiverMonsterRes(msg)

	self._newGainedItem = msg.newGainedItem

	if msg.passStage then
		self._passStage = true
	end
end

function EternalholydragonController:onNotifyFightLandMonsterRes(msg)
	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.Eternalholydragon)
	EternalholydragonModel.instance:onNotifyFightLandMonsterRes(msg)
end

function EternalholydragonController:getPassStage()
	return self._passStage
end

function EternalholydragonController:clearPassStage()
	self._passStage = nil
end

function EternalholydragonController:isClearLandMonsterItemId(itemPlanId, itemId)
	local list = EternalholydragonConfig.instance:getClearLandItemIds(itemPlanId)

	return list[itemId]
end

function EternalholydragonController:_onStartEnterGame()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.EHolyDragon)

	if activityId <= 0 then
		return
	end

	local actCfg = EternalholydragonConfig.instance:getActivityCfg(activityId)

	PetverifyController.instance:getVerifyInfo(actCfg.petVerifyPlanId, function()
		self:checkVerifyRedDot()
	end)
end

function EternalholydragonController:checkVerifyRedDot()
	local isRed = false
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.EHolyDragon)
	local actCfg = EternalholydragonConfig.instance:getActivityCfg(activityId)
	local verifyCfg = PetverifyController.instance:getCurrPlanBuff(actCfg.petVerifyPlanId)
	local hasBuff = verifyCfg ~= nil

	if not hasBuff then
		local verifyPlanCfg = PetVerifyBuffConfig.instance:getPlanCfgById(actCfg.petVerifyPlanId)

		if verifyPlanCfg then
			local raceIds = string.split(verifyPlanCfg.validator, ",")
			local raceIds_kv = {}

			for i, v in ipairs(raceIds) do
				raceIds_kv[checknumber(v)] = true
			end

			local pets = BagModel.instance:getPets()

			for i, v in ipairs(pets) do
				if raceIds_kv[v.raceId] then
					isRed = true

					break
				end
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ETER_HOLYDRAGON_VERIFY, isRed)
end

function EternalholydragonController:_enterEternalHolyDragonChallenge(params)
	self:enterEternalHolyDragonChallenge(checknumber(params[1]))
end

function EternalholydragonController:enterEternalHolyDragonChallenge(activityId)
	if checknumber(activityId) <= 0 then
		activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.EHolyDragon)
	end

	local isInActivityTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.EHolyDragon, activityId)

	if not isInActivityTime then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.EHolyDragon, activityId)

		if result ~= GameEnum.ResultCode.Success then
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			return
		end
	end

	UIStateManager.instance:push(ViewName.EternalholydragonmainView, activityId)
end

EternalholydragonController.instance = EternalholydragonController.New()

return EternalholydragonController
