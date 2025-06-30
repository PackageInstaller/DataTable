-- chunkname: @IQIGame\\Module\\Condition\\Maze\\PlayerAttrConditionChecker.lua

local m = {}

function m.Check(type, subType, params, comparison, targetValue)
	local checkResult = false
	local checkFailedReasonType

	if subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_LV then
		checkResult = ConditionModule.ComparisonValue(MazeDataModule.PlayerInfo.BaseInfo.pLv, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_USE_LV_TOO_LOW, targetValue)
	elseif subType == Constant.ConditionConstant.SUB_TYPE_PASS_LEVEL then
		checkResult = ConditionModule.ComparisonValueIn(MazeDataModule.PlayerInfo.FinishMazes, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_MAZE_NOT_PASS, targetValue)
	elseif subType == Constant.ConditionConstant.SUB_TYPE_FINISH_QUEST then
		checkResult = ConditionModule.ComparisonValueIn(MazeDataModule.PlayerInfo.FinishQuests, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_NOT_FIND_FINISH_QUEST, targetValue)
	elseif subType == Constant.ConditionConstant.SUB_TYPE_UNLOCK_SOUL then
		checkResult = ConditionModule.ComparisonValueIn(MazeDataModule.PlayerInfo.UnlockSouls, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_CONDITION_UNLOCK_SOUL, targetValue)
	elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_HAS_QUEST then
		checkResult = ConditionModule.ComparisonValueIn(MazeDataModule.PlayerInfo.MainQuests, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_NOT_FIND_HAS_QUEST, targetValue)
	elseif subType == Constant.ConditionConstant.SUB_TYPE_UNLOCK_EVENT then
		checkResult = ConditionModule.ComparisonValueIn(MazeDataModule.PlayerInfo.UnlockedEvents, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_NOT_FIND_UNLOCK_EVENT, targetValue)
	elseif subType == Constant.ConditionConstant.SUB_TYPE_MAZE_PLAYER_PARAMS then
		local value = 0

		for i = 1, #params do
			if MazeDataModule.PlayerInfo.PlayerParams[params[i]] == nil then
				value = value + CfgMazePlayerParamTable[params[i]].Value
			else
				value = value + MazeDataModule.PlayerInfo.PlayerParams[params[i]]
			end
		end

		checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "Params is not fit , value = " .. value .. ", targetValue=" .. targetValue .. ", comparison=" .. comparison
	elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_BUFF then
		local buffs = {}

		for i = 1, #MazeDataModule.PlayerInfo.Buffs do
			buffs[i] = MazeDataModule.PlayerInfo.Buffs[i].CID
		end

		checkResult = ConditionModule.ComparisonValueIn(buffs, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_CONDITION_BUFF, targetValue)
	elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_BUFF_COUNT then
		local count = 0
		local isDebuff = params[1] == 2

		for i = 1, #MazeDataModule.PlayerInfo.Buffs do
			local buffCfg = CfgBuffTable[MazeDataModule.PlayerInfo.Buffs[i].CID]

			if buffCfg.DebuffType ~= 3 and isDebuff == (buffCfg.DebuffType == 2) then
				count = count + 1
			end
		end

		checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_CONDITION_BUFF, targetValue)
	elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_RUNE_COUNT then
		local lType = params[1]
		local qua = params[2]
		local feature = params[3]
		local count = 0

		for i = 1, #MazeDataModule.PlayerInfo.Runes do
			local mazeRunePOD = MazeDataModule.PlayerInfo.Runes[i]
			local cfg = CfgRuneTable[mazeRunePOD.CID]

			if lType ~= -1 and cfg.Type ~= lType then
				-- block empty
			elseif qua ~= -1 and cfg.Quality ~= qua then
				-- block empty
			elseif feature ~= -1 and cfg.Feature ~= feature then
				-- block empty
			else
				count = count + 1
			end
		end

		checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "Params is not fit, targetValue=" .. targetValue .. ", comparison=" .. comparison
	elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ITEM_DROP_COUNT then
		local ret = 1

		for i = 1, #params, 2 do
			local id = params[i]
			local num = params[i + 1]
			local hasNum = MazeDataModule.PlayerInfo.ItemDropGetCnts[id] or 0

			if hasNum < num then
				ret = 0

				break
			end
		end

		checkResult = ConditionModule.ComparisonValue(ret, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "Params is not fit, targetValue=" .. targetValue .. ", comparison=" .. comparison
	elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_HAS_SERVICE_STATEFUL then
		local mazeHero = MazeModule.MazeScene.Hero

		checkResult = not mazeHero:IsMoving() and mazeHero.GatherCid == 0
		checkFailedReasonType = checkResult and "" or "player has state"
	else
		logError("error condition type : " .. type .. ", subType : " .. subType)
	end

	return checkResult, checkFailedReasonType
end

return m
