-- chunkname: @modules/logic/sp02/atomic/model/AtomicTalentViewModel.lua

module("modules.logic.sp02.atomic.model.AtomicTalentViewModel", package.seeall)

local AtomicTalentViewModel = class("AtomicTalentViewModel", ListScrollModel)

function AtomicTalentViewModel:onInit()
	self:reInit()
end

function AtomicTalentViewModel:reInit()
	return
end

function AtomicTalentViewModel:initDatas(viewParam)
	viewParam = viewParam or {}
	self.jumpNodeId = viewParam.nodeId
	self.selectSlot = nil
	self.talentMo = self:getTalentMo()

	local branchList = AtomicConfig.instance:getBranchList()
	local unlockBranch

	for i, v in ipairs(branchList) do
		if self:isBranchUnlocked(v.id) then
			unlockBranch = v.id

			break
		end
	end

	if self.jumpNodeId then
		local nodeId = self.jumpNodeId
		local config = AtomicConfig.instance:getTalentConfig(nodeId)

		if config then
			self:trySelectNodeId(nodeId)
			self:trySelectBranch(config.branchId)
		end
	end

	if unlockBranch and self.selectBranchId == nil then
		self:trySelectBranch(unlockBranch)
	else
		self:refreshNodeList()
	end
end

function AtomicTalentViewModel:clear()
	AtomicTalentViewModel.super.clear(self)

	self.selectBranchId = nil
	self.talentMo = nil
end

function AtomicTalentViewModel:getTalentMo()
	if self.talentMo then
		return self.talentMo
	end

	local atomicMo = AtomicModel.instance:getData()

	return atomicMo:getTalentInfo()
end

function AtomicTalentViewModel:refreshNodeList()
	local branchId = self.selectBranchId
	local list = {}
	local talentList = AtomicConfig.instance:getTalentList(branchId)
	local posDict = {}
	local maxRow = 0

	for i, v in ipairs(talentList) do
		local point = string.splitToNumber(v.point, "#")
		local row = 3 - point[2]
		local col = 3 + point[1]

		posDict[row] = posDict[row] or {}
		posDict[row][col] = {
			row = row,
			col = col,
			config = v
		}
		maxRow = math.max(maxRow, row)
	end

	self.nodePosDict = posDict

	for row = 1, maxRow do
		local rowData = {}

		rowData.row = row
		rowData.nodeList = posDict[row] or {}

		table.insert(list, rowData)
	end

	self:setList(list)
end

function AtomicTalentViewModel:trySelectBranch(branchId)
	if not self:isBranchUnlocked(branchId) then
		return false
	end

	if self:isBranchSelected(branchId) then
		return false
	end

	self.selectBranchId = branchId

	local talentList = AtomicConfig.instance:getTalentList(branchId)

	for i, v in ipairs(talentList) do
		if string.nilorempty(v.preNodes) then
			self:trySelectNodeId(v.id)

			break
		end
	end

	self.selectSlot = nil

	local equipList = self:getTalentEquipList()

	for i, v in ipairs(equipList) do
		local config = AtomicConfig.instance:getTalentConfig(v)

		if config and config.branchId == branchId then
			self.selectSlot = i

			break
		end
	end

	self:refreshNodeList()

	return true
end

function AtomicTalentViewModel:trySelectNodeId(nodeId)
	if self:isNodeSelected(nodeId) then
		return false
	end

	self.selectNodeId = nodeId

	return true
end

function AtomicTalentViewModel:trySelectSlot(slot)
	local equipList = self:getTalentEquipList()
	local nodeId = equipList[slot]

	if nodeId then
		::label_9_0::

		local config = AtomicConfig.instance:getTalentConfig(nodeId)

		if not config then
			return false
		end

		if self:isSlotSelected(slot) and self:isBranchSelected(config.branchId) and self:isNodeSelected(nodeId) then
			return false
		end

		self.selectSlot = slot

		self:trySelectBranch(config.branchId)
		self:trySelectNodeId(nodeId)

		return true
	end
end

function AtomicTalentViewModel:isBranchUnlocked(branchId)
	return self:getTalentMo():isBranchUnlocked(branchId)
end

function AtomicTalentViewModel:isBranchSelected(branchId)
	return self.selectBranchId == branchId
end

function AtomicTalentViewModel:isBranchCanLight(branchId)
	local talentList = AtomicConfig.instance:getTalentList(branchId)

	if not talentList then
		return false
	end

	for i, v in ipairs(talentList) do
		if self:isCanUnlockTalent(v.id) then
			return true
		end
	end

	return false
end

function AtomicTalentViewModel:isNodeUnlocked(nodeId)
	return self:getTalentMo():isTalentUnlocked(nodeId)
end

function AtomicTalentViewModel:isNodeSelected(nodeId)
	return self.selectNodeId == nodeId
end

function AtomicTalentViewModel:isNodeSelectedByJump(nodeId)
	return self.jumpNodeId == nodeId and not self:isNodeInstalled(nodeId)
end

function AtomicTalentViewModel:isSlotSelected(slot)
	return self.selectSlot == slot
end

function AtomicTalentViewModel:hasSelectedSlot()
	return self.selectSlot ~= nil
end

function AtomicTalentViewModel:getCurSlot()
	return self.selectSlot
end

function AtomicTalentViewModel:getNodeDataByPos(row, col)
	local dict = self.nodePosDict[row]

	if not dict then
		return
	end

	return dict[col]
end

function AtomicTalentViewModel:getCurNodeId()
	if not self.selectNodeId then
		return
	end

	local config = AtomicConfig.instance:getTalentConfig(self.selectNodeId)

	if not config or not self:isBranchSelected(config.branchId) then
		return nil
	end

	return self.selectNodeId
end

function AtomicTalentViewModel:isNodeInstalled(nodeId)
	return self:getTalentMo():isTalentEquipped(nodeId)
end

function AtomicTalentViewModel:isNodePreUnlock(nodeId)
	local config = AtomicConfig.instance:getTalentConfig(nodeId)

	if not config then
		return false
	end

	local preNodes = string.splitToNumber(config.preNodes, "#")

	for _, preNodeId in ipairs(preNodes) do
		if not self:isNodeUnlocked(preNodeId) then
			return false
		end
	end

	return true
end

function AtomicTalentViewModel:equipTalent(nodeId, slot)
	local list = self:getTalentMo():getEquipList()

	list[slot] = nodeId

	return list
end

function AtomicTalentViewModel:removeTalent(nodeId)
	local list = self:getTalentMo():getEquipList()

	for slot, installedNodeId in pairs(list) do
		if installedNodeId == nodeId then
			list[slot] = 0

			break
		end
	end

	return list
end

function AtomicTalentViewModel:isNodeCanTalent(nodeId)
	local config = AtomicConfig.instance:getTalentConfig(nodeId)

	if not config then
		return false
	end

	return config.mark
end

function AtomicTalentViewModel:getTalentSlotCount()
	return self:getTalentMo().slotCount
end

function AtomicTalentViewModel:getTalentEquipList()
	return self:getTalentMo():getEquipList()
end

function AtomicTalentViewModel:isCanUnlockTalent(nodeId, needTips)
	local isUnlock = self:isNodeUnlocked(nodeId)

	if isUnlock then
		return false
	end

	local isPreUnlock = self:isNodePreUnlock(nodeId)

	if not isPreUnlock then
		return false
	end

	local config = AtomicConfig.instance:getTalentConfig(nodeId)

	if not config then
		return false
	end

	local cost = string.splitToNumber(config.cost, "#")
	local currencyMO = CurrencyModel.instance:getCurrency(cost[2])

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0
			local needQuantity = cost[3]
			local costEnough = needQuantity <= quantity

			if not costEnough and needTips then
				GameFacade.showToast(ToastEnum.AtomicTalentCostTip)
			end

			return costEnough
		end
	end
end

function AtomicTalentViewModel:getEmptyOrDefaultSlot()
	local slot, isDefault = self:getTalentMo():getEmptyOrDefaultSlot()

	return (isDefault and self:hasSelectedSlot() or nil) and nil
end

function AtomicTalentViewModel:isBranchCanReset(branchId)
	local talentList = AtomicConfig.instance:getTalentList(branchId)

	if not talentList then
		return false
	end

	for i, v in ipairs(talentList) do
		if self:isNodeUnlocked(v.id) then
			return true
		end
	end

	return false
end

function AtomicTalentViewModel:tryAutoInstallTalent()
	local key = "AtomicTalentAutoInstall"
	local prefsVal = AtomicController.instance:getPlayerPrefs(key, 0)
	local hasInstallVal = 1
	local hasAutoInstall = prefsVal == hasInstallVal

	if hasAutoInstall then
		return
	end

	local list = lua_atomic_talent.configList
	local unlockList = {}

	for i, v in ipairs(list) do
		if v.mark and self:isNodeUnlocked(v.id) then
			table.insert(unlockList, v.id)
		end
	end

	local unlockCount = #unlockList

	if unlockCount == 2 then
		local installList = {}

		for _, id in ipairs(unlockList) do
			local isInstalled, index = self:isNodeInstalled(id)

			if isInstalled then
				installList[index] = id
			else
				for i = 1, 2 do
					if not installList[i] then
						installList[i] = id

						break
					end
				end
			end
		end

		AtomicController.instance:setPlayerPrefs(key, hasInstallVal)
		AtomicRpc.instance:sendAtomicTalentSkillChooseRequest(installList)

		return true
	end
end

function AtomicTalentViewModel:isTalentCanLight()
	local list = lua_atomic_talent.configList

	if not list then
		return false
	end

	for i, v in ipairs(list) do
		if self:isCanUnlockTalent(v.id) then
			return true
		end
	end

	return false
end

function AtomicTalentViewModel:getResetIds(branchId, nodeId)
	local ids = {}
	local installIds = self:getTalentEquipList()
	local idDict = {}

	if nodeId == 0 or nodeId == nil then
		local talentList = AtomicConfig.instance:getTalentList(branchId)

		if talentList then
			for i, v in ipairs(talentList) do
				if self:isNodeUnlocked(v.id) then
					table.insert(ids, v.id)

					idDict[v.id] = true
				end
			end
		end
	else
		table.insert(ids, nodeId)

		idDict[nodeId] = true

		local queue = {
			nodeId
		}

		while #queue > 0 do
			local currentLevel = {}

			for i, currentNodeId in ipairs(queue) do
				table.insert(currentLevel, currentNodeId)
			end

			queue = {}

			for i, currentNodeId in ipairs(currentLevel) do
				local nextIds = self:getNextIds(currentNodeId)

				if nextIds then
					for j, nextNodeId in ipairs(nextIds) do
						if not idDict[nextNodeId] and self:isNodeUnlocked(nextNodeId) then
							table.insert(ids, nextNodeId)

							idDict[nextNodeId] = true

							table.insert(queue, nextNodeId)
						end
					end
				end
			end
		end
	end

	for k, v in pairs(installIds) do
		if idDict[v] then
			installIds[k] = nil
		end
	end

	return ids, installIds
end

function AtomicTalentViewModel:getNextIds(nodeId)
	local config = AtomicConfig.instance:getTalentConfig(nodeId)

	if not config then
		return
	end

	local nextIds
	local talentList = AtomicConfig.instance:getTalentList(config.branchId)

	for i, v in ipairs(talentList) do
		local preNodeId = tonumber(v.preNodes)

		if preNodeId == nodeId then
			nextIds = nextIds or {}

			table.insert(nextIds, v.id)
		end
	end

	return nextIds
end

AtomicTalentViewModel.instance = AtomicTalentViewModel.New()

return AtomicTalentViewModel
