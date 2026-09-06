-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/controller/DefendCarrortWaveMgr.lua

module("logic.extensions.defendcarrot.controller.DefendCarrortWaveMgr", package.seeall)

local DefendCarrortWaveMgr = class("DefendCarrortWaveMgr")

function DefendCarrortWaveMgr:initWave(monsterPlanIds, isLoopState)
	local waveList = {}
	local monsterIds = string.splitToNumber(monsterPlanIds, "#")

	for _, planId in ipairs(monsterIds) do
		local waveCfgs = DefendCarrotConfig.instance:getMonsterWaveCfgs(planId) or {}

		if not waveCfgs.waveGroupList then
			local waveGroupListStr = ""
			local monsterGroupList = string.splitToNumber(waveGroupListStr, "#")
			local waveGroupObj = {}

			waveGroupObj.id = #waveList + 1
			waveGroupObj.currTime = 0
			waveGroupObj.nextBornTimer = 0
			waveGroupObj.waveIdx = 0
			waveGroupObj.isLastWave = false
			waveGroupObj.loopCount = 0
			waveGroupObj.isLoopState = isLoopState or false
			waveGroupObj.groupIdx = 0
			waveGroupObj.monsterIdList = nil
			waveGroupObj.waveMonsterList = {}

			for i, groupId in ipairs(monsterGroupList) do
				local groupCfg = DefendCarrotConfig.instance:getMonsterGroupCfgs(groupId)

				if groupCfg then
					local arr = {}

					for j, cfg in ipairs(groupCfg) do
						table.insert(arr, cfg)
					end

					table.insert(waveGroupObj.waveMonsterList, arr)
				end
			end

			table.insert(waveList, waveGroupObj)
		end
	end

	return waveList
end

function DefendCarrortWaveMgr:initFunc(checkAliveFunc, createMonsterFunc, newWaveFunc)
	self._checkAliveFunc = checkAliveFunc
	self._createMonsterFunc = createMonsterFunc
	self._newWaveFunc = newWaveFunc
end

function DefendCarrortWaveMgr:_startNextWave(waveGroupObj)
	if waveGroupObj.isLastWave and waveGroupObj.isLoopState then
		waveGroupObj.waveIdx = 0
		waveGroupObj.groupIdx = 0
		waveGroupObj.isLastWave = false
		waveGroupObj.loopCount = waveGroupObj.loopCount + 1
	end

	if waveGroupObj.waveIdx + 1 > #waveGroupObj.waveMonsterList then
		waveGroupObj.isLastWave = true

		return
	end

	waveGroupObj.waveIdx = waveGroupObj.waveIdx + 1
	waveGroupObj.groupIdx = 1

	if waveGroupObj.monsterIdList then
		table.clear(waveGroupObj.monsterIdList)
	end

	if waveGroupObj.waveIdx + 1 > #waveGroupObj.waveMonsterList then
		waveGroupObj.isLastWave = true
	end

	GameUtil.callBack(self._newWaveFunc)
end

function DefendCarrortWaveMgr:_checkCurrMonsterAllDead(waveGroupObj, checkAliveFunc)
	local monsterList = waveGroupObj.waveMonsterList[waveGroupObj.waveIdx]

	if monsterList == nil then
		return true
	end

	local cfg = monsterList[waveGroupObj.groupIdx]

	if cfg == nil then
		if waveGroupObj.monsterIdList == nil then
			return true
		end

		if not GameUtil.callBack(checkAliveFunc, DefendCarrotEnum.UnitType.Monster, waveGroupObj.monsterIdList) then
			return true
		end
	end

	return false
end

function DefendCarrortWaveMgr:_createMonster(waveGroupObj, createMonsterFunc)
	if createMonsterFunc then
		local monsterList = waveGroupObj.waveMonsterList[waveGroupObj.waveIdx]

		if monsterList then
			local cfg = monsterList[waveGroupObj.groupIdx]

			if cfg then
				local unit = createMonsterFunc(waveGroupObj.id, cfg)

				if unit then
					local id = unit:getUnitId()

					waveGroupObj.monsterIdList = waveGroupObj.monsterIdList or {}

					table.insert(waveGroupObj.monsterIdList, id)
				end

				waveGroupObj.groupIdx = waveGroupObj.groupIdx + 1
				waveGroupObj.nextBornTimer = cfg.bornInterval
			end
		end
	end
end

function DefendCarrortWaveMgr:_updateWave(waveGroupObj, deltaTime, checkAliveFunc, createMonsterFunc)
	if self:_checkCurrMonsterAllDead(waveGroupObj, checkAliveFunc) then
		self:_startNextWave(waveGroupObj)
	end

	waveGroupObj.nextBornTimer = waveGroupObj.nextBornTimer - deltaTime

	if waveGroupObj.nextBornTimer < 0 then
		self:_createMonster(waveGroupObj, createMonsterFunc)
	end
end

function DefendCarrortWaveMgr:updateWaveList(waveList, deltaTime)
	for i, waveGroupObj in ipairs(waveList) do
		self:_updateWave(waveGroupObj, deltaTime, self._checkAliveFunc, self._createMonsterFunc)
	end
end

function DefendCarrortWaveMgr:checkIsGameOver(waveList)
	local isOver = true

	for i, waveGroupObj in ipairs(waveList) do
		if waveGroupObj.isLoopState then
			return false
		end

		if waveGroupObj.isLastWave and not waveGroupObj.isLoopState then
			if not self:_checkCurrMonsterAllDead(waveGroupObj, self._checkAliveFunc) then
				isOver = false
			end
		else
			isOver = false
		end
	end

	return isOver
end

function DefendCarrortWaveMgr:getCurrMaxWaveCount(waveList)
	local count = 0
	local total = 0

	if waveList then
		for i, waveGroupObj in ipairs(waveList) do
			local temCount = waveGroupObj.loopCount * #waveGroupObj.waveMonsterList + waveGroupObj.waveIdx

			count = math.max(count, temCount)
			total = math.max(total, #waveGroupObj.waveMonsterList)
		end
	end

	return count, total
end

DefendCarrortWaveMgr.instance = DefendCarrortWaveMgr.New()

return DefendCarrortWaveMgr
