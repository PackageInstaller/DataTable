-- chunkname: @modules/logic/dispatch/model/DispatchModel.lua

module("modules.logic.dispatch.model.DispatchModel", package.seeall)

local DispatchModel = class("DispatchModel", BaseModel)

local function getDispatchInfo(serverData)
	serverData = serverData or {}

	local dispatchInfo = {
		elementId = serverData.elementId,
		dispatchId = serverData.dispatchId,
		endTime = serverData.endTime
	}
	local heroIdList = {}

	if serverData.heroIds then
		for _, heroId in ipairs(serverData.heroIds) do
			heroIdList[#heroIdList + 1] = heroId
		end
	end

	dispatchInfo.heroIdList = heroIdList

	return dispatchInfo
end

function DispatchModel:onInit()
	self.dispatchedHeroDict = {}
	self.needCheckDispatchInfoList = {}
end

function DispatchModel:reInit()
	self:onInit()
end

function DispatchModel:initDispatchInfos(serverDispatchInfoList)
	self:clear()

	if not serverDispatchInfoList then
		return
	end

	for _, serverDispatchInfo in ipairs(serverDispatchInfoList) do
		local dispatchMo = DispatchInfoMo.New()
		local newDispatchInfo = getDispatchInfo(serverDispatchInfo)

		dispatchMo:init(newDispatchInfo)
		self:addAtLast(dispatchMo)

		local isRunning = dispatchMo:isRunning()

		if isRunning then
			for _, heroId in ipairs(dispatchMo.heroIdList) do
				self.dispatchedHeroDict[heroId] = true
			end

			table.insert(self.needCheckDispatchInfoList, dispatchMo)
		end
	end
end

function DispatchModel:addDispatch(serverData)
	if not serverData then
		return
	end

	local dispatchInfo = getDispatchInfo(serverData)
	local id = dispatchInfo.elementId
	local dispatchMo = self:getDispatchMo(id)

	if dispatchMo then
		dispatchMo:updateMO(dispatchInfo)
	else
		dispatchMo = DispatchInfoMo.New()

		dispatchMo:init(dispatchInfo)
		self:addAtLast(dispatchMo)
	end

	local isRunning = dispatchMo:isRunning()

	if isRunning then
		for _, heroId in ipairs(dispatchInfo.heroIdList) do
			self.dispatchedHeroDict[heroId] = true
		end

		table.insert(self.needCheckDispatchInfoList, dispatchMo)
	end

	local dispatchId = dispatchInfo.dispatchId

	DispatchController.instance:dispatchEvent(DispatchEvent.AddDispatchInfo, dispatchId)
end

function DispatchModel:removeDispatch(serverData)
	if not serverData then
		return
	end

	local id = serverData.elementId
	local dispatchMo = self:getDispatchMo(id)

	if dispatchMo then
		for _, heroId in ipairs(dispatchMo.heroIdList) do
			self.dispatchedHeroDict[heroId] = nil
		end

		tabletool.removeValue(self.needCheckDispatchInfoList, dispatchMo)
		self:remove(dispatchMo)
	end

	local dispatchId = dispatchMo.dispatchId

	DispatchController.instance:dispatchEvent(DispatchEvent.RemoveDispatchInfo, dispatchId)
end

function DispatchModel:getDispatchMo(elementId, dispatchId)
	local result

	if not elementId then
		return result
	end

	local dispatchMo = self:getById(elementId)

	if dispatchMo then
		local getDispatchId = dispatchMo:getDispatchId()

		if not dispatchId or dispatchId == getDispatchId then
			result = dispatchMo
		else
			logError(string.format("DispatchModel.getDispatchMo error, dispatchId not equal,%s %s", dispatchId, getDispatchId))
		end
	end

	return result
end

function DispatchModel:getDispatchMoByDispatchId(dispatchId)
	return
end

function DispatchModel:getDispatchStatus(elementId, dispatchId)
	local dispatchMo = self:getDispatchMo(elementId, dispatchId)
	local dispatchStatus = DispatchEnum.DispatchStatus.NotDispatch

	if dispatchMo then
		local isFinish = dispatchMo:isFinish()

		dispatchStatus = isFinish and DispatchEnum.DispatchStatus.Finished or DispatchEnum.DispatchStatus.Dispatching
	end

	return dispatchStatus
end

function DispatchModel:getDispatchTime(elementId)
	local result = string.format("%02d : %02d : %02d", 0, 0, 0)
	local dispatchId = DungeonConfig.instance:getElementDispatchId(elementId)

	if elementId and dispatchId then
		local dispatchMo = self:getDispatchMo(elementId, dispatchId)

		if dispatchMo then
			result = dispatchMo:getRemainTimeStr()
		end
	end

	return result
end

function DispatchModel:isDispatched(heroId)
	return self.dispatchedHeroDict and self.dispatchedHeroDict[heroId]
end

function DispatchModel:checkDispatchFinish()
	if self.needCheckDispatchInfoList then
		if not #self.needCheckDispatchInfoList then
			local len = 0

			if len <= 0 then
				return
			end

			local needDispatchEvent = false

			for index = len, 1, -1 do
				local dispatchMo = self.needCheckDispatchInfoList[index]
				local isFinish = dispatchMo:isFinish()

				if isFinish then
					needDispatchEvent = true

					for _, heroId in ipairs(dispatchMo.heroIdList) do
						self.dispatchedHeroDict[heroId] = nil
					end

					table.remove(self.needCheckDispatchInfoList, index)
				end
			end

			if needDispatchEvent then
				DispatchController.instance:dispatchEvent(DispatchEvent.OnDispatchFinish)
				RedDotRpc.instance:sendGetRedDotInfosRequest({
					RedDotEnum.DotNode.V1a8FactoryMapDispatchFinish
				})
			end
		end
	end
end

DispatchModel.instance = DispatchModel.New()

return DispatchModel
