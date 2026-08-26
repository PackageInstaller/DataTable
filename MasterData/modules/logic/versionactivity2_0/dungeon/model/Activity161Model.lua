-- chunkname: @modules/logic/versionactivity2_0/dungeon/model/Activity161Model.lua

module("modules.logic.versionactivity2_0.dungeon.model.Activity161Model", package.seeall)

local Activity161Model = class("Activity161Model", BaseModel)

function Activity161Model:onInit()
	self:reInit()
end

function Activity161Model:reInit()
	self.graffitiInfoMap = {}
	self.curHasGetRewardMap = {}
	self.curActId = 0
	self.isNeedRefreshNewElement = false
end

function Activity161Model:getActId()
	return VersionActivity2_0Enum.ActivityId.DungeonGraffiti
end

function Activity161Model:setGraffitiInfo(msg)
	if not msg.graffitiInfos then
		for _, info in ipairs(msg.graffitiInfos) do
			local config = Activity161Config.instance:getGraffitiCo(msg.activityId, info.id)

			if config then
				local mo = self.graffitiInfoMap[info.id]

				if not mo then
					mo = Activity161MO.New()

					mo:init(info, config)

					self.graffitiInfoMap[info.id] = mo
				else
					mo:updateInfo(info)
				end
			end
		end

		self:setHasGetRewardInfo(msg)
	end
end

function Activity161Model:setHasGetRewardInfo(msg)
	if GameUtil.getTabLen(self.curHasGetRewardMap) == 0 then
		local rewardConfig = Activity161Config.instance:getAllRewardCos(msg.activityId)

		for _, config in pairs(rewardConfig) do
			self.curHasGetRewardMap[config.rewardId] = false
		end
	end

	if not msg.gainedRewardIds then
		local gainedRewardIds = {}

		for _, hasGetId in ipairs(gainedRewardIds) do
			self.curHasGetRewardMap[hasGetId] = true
		end
	end
end

function Activity161Model:getFinalRewardHasGetState()
	if #self.curHasGetRewardMap > 0 then
		return self.curHasGetRewardMap[#self.curHasGetRewardMap]
	end

	return false
end

function Activity161Model:getCurPaintedNum()
	local paintedNum = 0

	for index, mo in pairs(self.graffitiInfoMap) do
		if mo.state == Activity161Enum.graffitiState.IsFinished then
			paintedNum = paintedNum + 1
		end
	end

	return paintedNum
end

function Activity161Model:setRewardInfo(msg)
	for _, rewardId in ipairs(msg.rewardIds) do
		self.curHasGetRewardMap[rewardId] = true
	end
end

function Activity161Model:getItemsByState(state)
	local items = {}

	for index, mo in pairs(self.graffitiInfoMap) do
		if mo.state == state then
			table.insert(items, mo)
		end
	end

	return items
end

function Activity161Model:getInCdGraffiti()
	local inCdGraffitiMoList = {}

	for index, mo in pairs(self.graffitiInfoMap) do
		local graffitiCo = Activity161Config.instance:getGraffitiCo(self:getActId(), mo.id)
		local isPreMainElementFinish = Activity161Config.instance:isPreMainElementFinish(graffitiCo)
		local isHaveCd = graffitiCo.mainElementCd > 0

		if isHaveCd and mo:isInCdTime() and isPreMainElementFinish then
			table.insert(inCdGraffitiMoList, mo)
		end
	end

	return inCdGraffitiMoList
end

function Activity161Model:getArriveCdGraffitiList(oldCdList, newCdList)
	local arriveCdList = tabletool.copy(oldCdList)
	local inCdStateMap = {}

	for _, newCdMo in pairs(newCdList) do
		inCdStateMap[newCdMo.id] = true
	end

	for i = #arriveCdList, 1, -1 do
		if inCdStateMap[arriveCdList[i].id] then
			table.remove(arriveCdList, i)
		end
	end

	return arriveCdList
end

function Activity161Model:setNeedRefreshNewElementsState(state)
	self.isNeedRefreshNewElement = state
end

function Activity161Model:setGraffitiState(elementId, state)
	local mo = self.graffitiInfoMap[elementId]

	if mo then
		mo.state = state
	else
		logError("graffitiMO is not exit, graffitiId: " .. elementId)
	end
end

function Activity161Model:isUnlockState(mo)
	if mo.state == Activity161Enum.graffitiState.Normal or mo.state == Activity161Enum.graffitiState.IsFinished then
		return 1
	else
		return 0
	end
end

function Activity161Model:ishaveUnGetReward()
	local curHasGetRewardMap = self.curHasGetRewardMap
	local curPaintedNum = self:getCurPaintedNum()
	local allRewardCoList = Activity161Config.instance:getAllRewardCos(self:getActId())
	local canGetRewardList = {}

	for _, rewardCo in ipairs(allRewardCoList) do
		if not curHasGetRewardMap[rewardCo.rewardId] and curPaintedNum >= rewardCo.paintedNum then
			table.insert(canGetRewardList, rewardCo)
		end
	end

	if #canGetRewardList > 0 then
		return true, canGetRewardList
	end

	return false
end

Activity161Model.instance = Activity161Model.New()

return Activity161Model
