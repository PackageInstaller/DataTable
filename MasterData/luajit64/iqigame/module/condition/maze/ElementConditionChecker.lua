-- chunkname: @IQIGame\\Module\\Condition\\Maze\\ElementConditionChecker.lua

local m = {}

function m.Check(type, subType, params, comparison, targetValue)
	local checkResult = false
	local checkFailedReasonType

	if subType == Constant.ConditionConstant.SUB_TYPE_ELEMENT_EXE_COUNT then
		local currentInteractingElement = MazeDataModule.GetCurrentElement()

		if currentInteractingElement ~= nil then
			if params[1] <= #currentInteractingElement.ExecutionCounts then
				checkResult = ConditionModule.ComparisonValue(currentInteractingElement.ExecutionCounts[params[1]], targetValue, comparison)
				checkFailedReasonType = checkResult and "" or "not enough condition"
			else
				checkResult = false
				checkFailedReasonType = "error: params[1] index out of range."
			end
		else
			checkResult = false
			checkFailedReasonType = "error: current element is not found."
		end
	elseif subType == Constant.ConditionConstant.SUB_TYPE_ELEMENT_COUNT then
		local count = 0

		for i = 1, #MazeDataModule.ElementPODs do
			if MazeDataModule.ElementPODs[i].CID == params[1] and not MazeDataModule.ElementPODs[i].IsRemoved then
				count = count + 1
			end
		end

		checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "not enough condition"
	elseif subType == Constant.ConditionConstant.SUB_TYPE_ELEMENT_COUNT_BY_PARAM then
		local count = 0
		local cid = 0

		if MazeDataModule.PlayerInfo.PlayerParams[params[1]] == nil then
			cid = CfgMazePlayerParamTable[params[1]].Value
		else
			cid = MazeDataModule.PlayerInfo.PlayerParams[params[1]]
		end

		for i = 1, #MazeDataModule.ElementPODs do
			if MazeDataModule.ElementPODs[i].CID == cid and not MazeDataModule.ElementPODs[i].IsRemoved then
				count = count + 1
			end
		end

		checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "not enough condition"
	elseif subType == Constant.ConditionConstant.SUB_TYPE_AREA_ELEMENT_COUNT then
		local count = 0
		local heroAreaIx = MazeModule.MazeScene.Hero.NodeData.AreaIx

		for i = 1, #MazeDataModule.ElementPODs do
			if MazeDataModule.ElementPODs[i].CID == params[1] and not MazeDataModule.ElementPODs[i].IsRemoved then
				local pathNode = MazeDataModule.GetNodeDataById(MazeDataModule.ElementPODs[i].NodeId)

				if pathNode.AreaIx == heroAreaIx then
					count = count + 1
				end
			end
		end

		checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "not enough condition"
	elseif subType == Constant.ConditionConstant.SUB_TYPE_AREA_ELEMENT_COUNT_BY_PARAM then
		local count = 0
		local cid = 0

		if MazeDataModule.PlayerInfo.PlayerParams[params[1]] == nil then
			cid = CfgMazePlayerParamTable[params[1]].Value
		else
			cid = MazeDataModule.PlayerInfo.PlayerParams[params[1]]
		end

		local heroAreaIx = MazeModule.MazeScene.Hero.NodeData.AreaIx

		for i = 1, #MazeDataModule.ElementPODs do
			if MazeDataModule.ElementPODs[i].CID == cid and not MazeDataModule.ElementPODs[i].IsRemoved then
				local pathNode = MazeDataModule.GetNodeDataById(MazeDataModule.ElementPODs[i].NodeId)

				if pathNode.AreaIx == heroAreaIx then
					count = count + 1
				end
			end
		end

		checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "not enough condition"
	elseif subType == Constant.ConditionConstant.SUB_TYPE_PATH_NODE_ELEMENT_COUNT then
		local elementId

		if params[1] == 0 then
			elementId = params[2]
		elseif MazeDataModule.PlayerInfo.PlayerParams[params[2]] == nil then
			elementId = CfgMazePlayerParamTable[params[2]].Value
		else
			elementId = MazeDataModule.PlayerInfo.PlayerParams[params[2]]
		end

		local allNodes = {}

		for i = 3, #params do
			local nodes = MazeDataModule.GetNodeDataByCfgId(params[i])

			if nodes then
				for j = 1, #nodes do
					allNodes[nodes[j].NodeId] = true
				end
			end
		end

		local count = 0

		for i = 1, #MazeDataModule.ElementPODs do
			if MazeDataModule.ElementPODs[i].CID == elementId and not MazeDataModule.ElementPODs[i].IsRemoved and allNodes[MazeDataModule.ElementPODs[i].NodeId] then
				count = count + 1
			end
		end

		checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "not enough condition"
	elseif subType == Constant.ConditionConstant.SUB_TYPE_RELATIVE_PATH_NODE_ELEMENT_COUNT then
		local elementId

		if params[1] == 0 then
			elementId = params[2]
		elseif MazeDataModule.PlayerInfo.PlayerParams[params[2]] == nil then
			elementId = CfgMazePlayerParamTable[params[2]].Value
		else
			elementId = MazeDataModule.PlayerInfo.PlayerParams[params[2]]
		end

		local heroNodeXIndex, heroNodeYIndex = MazeModule.MazeScene.Hero:GetNodeIndex()
		local allNodes = {}

		for i = 3, #params, 2 do
			local node = MazeDataModule.GetNodeDataByIndex(params[i] + heroNodeXIndex, params[i + 1] + heroNodeYIndex)

			if node then
				allNodes[node.NodeId] = true
			end
		end

		local count = 0

		for i = 1, #MazeDataModule.ElementPODs do
			if MazeDataModule.ElementPODs[i].CID == elementId and not MazeDataModule.ElementPODs[i].IsRemoved and allNodes[MazeDataModule.ElementPODs[i].NodeId] then
				count = count + 1
			end
		end

		checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "not enough condition"
	elseif subType == Constant.ConditionConstant.SUB_TYPE_MAZE_PREV_PATH_NODE_DIR then
		local dir = 0
		local heroPrevNodeXIndex, heroPrevNodeYIndex = MazeModule.MazeScene.Hero:GetPrevNodeIndex()
		local heroNodeXIndex, heroNodeYIndex = MazeModule.MazeScene.Hero:GetNodeIndex()
		local xOffset = heroPrevNodeXIndex - heroNodeXIndex
		local yOffset = heroPrevNodeYIndex - heroNodeYIndex

		if xOffset == -1 and yOffset == -1 then
			dir = 1
		elseif xOffset == -1 and yOffset == 0 then
			dir = 2
		elseif xOffset == -1 and yOffset == 1 then
			dir = 3
		elseif xOffset == 0 and yOffset == 1 then
			dir = 4
		elseif xOffset == 1 and yOffset == 1 then
			dir = 5
		elseif xOffset == 1 and yOffset == 0 then
			dir = 6
		elseif xOffset == 1 and yOffset == -1 then
			dir = 7
		elseif xOffset == 0 and yOffset == -1 then
			dir = 8
		end

		checkResult = ConditionModule.ComparisonValue(dir, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "not enough condition"
	elseif subType == Constant.ConditionConstant.SUB_TYPE_TYPE_ELEMENT_COUNT then
		local count = 0

		for i = 1, #MazeDataModule.ElementPODs do
			local eType = CfgElementAllTable[MazeDataModule.ElementPODs[i].CID].ElementType

			if eType == params[1] and not MazeDataModule.ElementPODs[i].IsRemoved then
				count = count + 1
			end
		end

		checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "not enough condition"
	elseif subType == Constant.ConditionConstant.SUB_TYPE_AREA_TYPE_ELEMENT_COUNT then
		local count = 0
		local heroAreaIx = MazeModule.MazeScene.Hero.NodeData.AreaIx

		for i = 1, #MazeDataModule.ElementPODs do
			local eType = CfgElementAllTable[MazeDataModule.ElementPODs[i].CID].ElementType

			if eType == params[1] and not MazeDataModule.ElementPODs[i].IsRemoved then
				local pathNode = MazeDataModule.GetNodeDataById(MazeDataModule.ElementPODs[i].NodeId)

				if pathNode.AreaIx == heroAreaIx then
					count = count + 1
				end
			end
		end

		checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "not enough condition"
	elseif subType == Constant.ConditionConstant.SUB_TYPE_CURR_NODE_ELEMENT then
		local ids = {}
		local heroNodeId = MazeModule.MazeScene.Hero.NodeData.NodeId

		for i = 1, #MazeDataModule.ElementPODs do
			if MazeDataModule.ElementPODs[i].NodeId == heroNodeId and not MazeDataModule.ElementPODs[i].IsRemoved then
				table.insert(ids, MazeDataModule.ElementPODs[i].CID)
			end
		end

		checkResult = ConditionModule.ComparisonValueIn(ids, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "not enough condition"
	else
		logError("error condition type : " .. type .. ", subType : " .. subType)
	end

	return checkResult, checkFailedReasonType
end

return m
