-- chunkname: @modules/logic/necrologiststory/model/NecrologistV3A5MO.lua

module("modules.logic.necrologiststory.model.NecrologistV3A5MO", package.seeall)

local NecrologistV3A5MO = class("NecrologistV3A5MO", NecrologistStoryGameBaseMO)

function NecrologistV3A5MO:onInit()
	return
end

function NecrologistV3A5MO:onUpdateData()
	local data = self:getData()

	self.nodeDict = {}

	if data.nodeList then
		for _, nodeData in ipairs(data.nodeList) do
			self.nodeDict[nodeData.nodeId] = nodeData.status
		end
	end
end

function NecrologistV3A5MO:onSaveData()
	local data = self:getData()

	data.nodeList = {}

	for nodeId, status in pairs(self.nodeDict) do
		table.insert(data.nodeList, {
			nodeId = nodeId,
			status = status
		})
	end
end

function NecrologistV3A5MO:isNodeFinish(nodeId)
	local status = self:getNodeStatus(nodeId)

	if status == NecrologistStoryEnum.V3A5NodeStatus.None then
		return false
	end

	return true
end

function NecrologistV3A5MO:isNodeStoryFinish(nodeId)
	local config = NecrologistStoryV3A5Config.instance:getBaseConfig(nodeId)

	if config and config.storyId > 0 and not self:isStoryFinish(config.storyId) then
		return false
	end

	return true
end

function NecrologistV3A5MO:setNodeStatus(nodeId, status)
	local beforeBulletCount = self:getBulletCount()

	self.nodeDict[nodeId] = status

	local bulletCount = self:getBulletCount()

	if nodeId == 8 then
		TipDialogController.instance:openTipDialogView(35001, function()
			local config = NecrologistStoryV3A5Config.instance:getBaseConfig(nodeId)

			if config.storyId > 0 then
				if self:isStoryFinish(config.storyId) then
					NecrologistStoryController.instance:openStoryView(config.storyId)
				else
					NecrologistStoryController.instance:openStoryView(config.storyId, self.id)
				end
			end
		end)
	else
		ViewMgr.instance:openView(ViewName.V3A5_RoleStoryBulletView, {
			beforeBulletCount = beforeBulletCount,
			bulletCount = bulletCount,
			nodeId = nodeId
		})
	end

	self:setDataDirty()
end

function NecrologistV3A5MO:getNodeStatus(nodeId)
	local status = self.nodeDict[nodeId]

	return status or NecrologistStoryEnum.V3A5NodeStatus.None
end

function NecrologistV3A5MO:getBulletCount()
	local configList = NecrologistStoryV3A5Config.instance:getBaseList()
	local bulletCount = 0

	for i = 1, #configList do
		local config = configList[i]

		if self:isNodeFinish(config.id) then
			local status = self:getNodeStatus(config.id)

			if status == NecrologistStoryEnum.V3A5NodeStatus.Front then
				if bulletCount > 0 then
					bulletCount = bulletCount - 1
				end
			else
				bulletCount = bulletCount + 1
			end
		end
	end

	return bulletCount
end

function NecrologistV3A5MO:getCurIndex()
	local configList = NecrologistStoryV3A5Config.instance:getBaseList()

	for i = #configList, 1, -1 do
		local config = configList[i]

		if self:isNodeFinish(config.id) then
			return config.id
		end
	end

	return 0
end

function NecrologistV3A5MO:getGameResult(index)
	if index == 1 then
		return NecrologistStoryEnum.V3A5NodeStatus.Back
	end

	local results = {}

	for i = 1, index - 1 do
		local status = self:getNodeStatus(i)

		if status ~= NecrologistStoryEnum.V3A5NodeStatus.None then
			table.insert(results, status)
		end
	end

	local consecutiveBack = 0
	local consecutiveFront = 0

	for _, status in ipairs(results) do
		if status == NecrologistStoryEnum.V3A5NodeStatus.Back then
			consecutiveBack = consecutiveBack + 1
			consecutiveFront = 0
		elseif status == NecrologistStoryEnum.V3A5NodeStatus.Front then
			consecutiveFront = consecutiveFront + 1
			consecutiveBack = 0
		end
	end

	local canChooseBack = consecutiveBack < 2
	local canChooseFront = consecutiveFront < 2
	local resultVal

	if not canChooseBack then
		resultVal = NecrologistStoryEnum.V3A5NodeStatus.Front
	elseif not canChooseFront then
		resultVal = NecrologistStoryEnum.V3A5NodeStatus.Back
	end

	local bulletCount = self:getBulletCount()

	if index == 5 then
		if bulletCount == 1 then
			resultVal = NecrologistStoryEnum.V3A5NodeStatus.Front
		end
	elseif index == 6 then
		if bulletCount == 0 then
			resultVal = NecrologistStoryEnum.V3A5NodeStatus.Front
		end
	elseif index == 7 then
		if bulletCount == 0 then
			resultVal = NecrologistStoryEnum.V3A5NodeStatus.Back
		elseif bulletCount == 2 then
			resultVal = NecrologistStoryEnum.V3A5NodeStatus.Front
		end
	end

	if resultVal == nil then
		resultVal = math.random() < 0.5 and NecrologistStoryEnum.V3A5NodeStatus.Front or NecrologistStoryEnum.V3A5NodeStatus.Back
	end

	return resultVal
end

return NecrologistV3A5MO
