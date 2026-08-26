-- chunkname: @modules/logic/guide/controller/exception/GuideExceptionChecker.lua

module("modules.logic.guide.controller.exception.GuideExceptionChecker", package.seeall)

local GuideExceptionChecker = _M

function GuideExceptionChecker.checkCurrency(guideId, stepId, param)
	local temp = string.split(param, "_")
	local currencyId = tonumber(temp[1])
	local count = tonumber(temp[2])
	local currencyMO = CurrencyModel.instance:getCurrency(currencyId)
	local hasCount = currencyMO and currencyMO.quantity

	return count <= hasCount
end

function GuideExceptionChecker.checkDungeonUsePower(guideId, stepId, param)
	local episodeId = HeroGroupModel.instance.episodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local costs = string.split(episodeConfig.cost, "|")
	local cost1 = string.split(costs[1], "#")
	local value = tonumber((not cost1[3] or nil) and 0)
	local power = CurrencyModel.instance:getPower()

	return value <= power
end

function GuideExceptionChecker.checkBuildingPut(guideId, stepId, param)
	local buildingId = tonumber(param)
	local mo = RoomMapBuildingModel.instance:getBuildingMoByBuildingId(buildingId)

	if mo and mo:isInMap() then
		return false
	end

	return not RoomInventoryBuildingModel.instance:checkBuildingPut(buildingId)
end

function GuideExceptionChecker.checkBuildingPutMatchStep(guideId, stepId, param)
	local guideMO = GuideModel.instance:getById(guideId)

	if not guideMO then
		return true
	end

	local step = tonumber(param)
	local buildingList = RoomMapBuildingModel.instance:getBuildingMOList()

	if #buildingList > 0 and guideMO.serverStepId ~= step then
		return false
	end

	return true
end

function GuideExceptionChecker.checkViewShow(guideId, stepId, param)
	local view = ViewMgr.instance:getContainer(param)

	return not view or not view._isVisible
end

function GuideExceptionChecker.checkViewNotShow(guideId, stepId, param)
	local view = ViewMgr.instance:getContainer(param)

	return view and view._isVisible
end

function GuideExceptionChecker.checkViewExist(guideId, stepId, param)
	local view = ViewMgr.instance:getContainer(param)

	return not view
end

function GuideExceptionChecker.checkViewNotExist(guideId, stepId, param)
	return (ViewMgr.instance:getContainer(param))
end

function GuideExceptionChecker.noRemainStars()
	local mapInfo = WeekWalkModel.instance:getCurMapInfo()

	if not mapInfo or mapInfo.isFinish <= 0 then
		return
	end

	local cur, total = mapInfo:getCurStarInfo()

	return cur ~= total
end

function GuideExceptionChecker.checkHeroTalent(guideId, stepId, param)
	local level = tonumber(param)
	local heroId = CharacterController.instance:getTalentHeroId()
	local heroMO = HeroModel.instance:getByHeroId(heroId)
	local limit = level <= heroMO.talent

	return not limit
end

function GuideExceptionChecker.checkSummon(guideId, stepId, param)
	local heroMOList = HeroModel.instance:getList()
	local hasSummon = heroMOList and #heroMOList > 1

	return not hasSummon
end

function GuideExceptionChecker.checkAllEquipLevel(guideId, stepId, param)
	local maxLevel = tonumber(param)
	local list = EquipModel.instance:getEquips()
	local limit = false

	for i, v in ipairs(list) do
		if maxLevel <= v.level then
			limit = true

			break
		end
	end

	return not limit
end

function GuideExceptionChecker.noPointReward()
	local lastConfig = lua_chapter_point_reward.configList[#lua_chapter_point_reward.configList]
	local rewards = DungeonMapModel.instance:canGetRewardsList(lastConfig.chapterId)

	return rewards and #rewards > 0
end

function GuideExceptionChecker.checkScene(guideId, stepId, param)
	local sceneType = SceneType[param]
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	logError("sceneType = " .. sceneType .. ", curSceneType = " .. curSceneType)

	return sceneType == curSceneType
end

function GuideExceptionChecker.checkMaterial(guideId, stepId, param)
	local temp = string.split(param, "_")
	local type = tonumber(temp[1])
	local id = tonumber(temp[2])
	local quantity = tonumber(temp[3])
	local hasQuantity = ItemModel.instance:getItemQuantity(type, id)

	return quantity <= hasQuantity
end

function GuideExceptionChecker.checkMaterialNotEnough(guideId, stepId, param)
	local temp = string.split(param, "_")
	local type = tonumber(temp[1])
	local id = tonumber(temp[2])
	local quantity = tonumber(temp[3])
	local hasQuantity = ItemModel.instance:getItemQuantity(type, id)

	return hasQuantity < quantity
end

function GuideExceptionChecker.findTalentFirstChess()
	local container = ViewMgr.instance:getContainer(ViewName.CharacterTalentChessView)

	if not container then
		return true
	end

	local viewGo = container.viewGO
	local chessContainer = gohelper.findChild(viewGo, "chessboard/#go_chessContainer")

	if not chessContainer then
		return true
	end

	local childCount = chessContainer.transform.childCount

	return childCount <= 0
end

function GuideExceptionChecker.checkTaskFinish(guideId, stepId, param)
	local taskId = tonumber(param)

	if taskId then
		local taskMO = TaskModel.instance:getTaskById(taskId)

		if taskMO then
			return TaskModel.instance:isTaskFinish(taskMO.type, taskId)
		else
			return false
		end
	else
		logError("异常处理checkRoomTaskFinish参数错误：" .. guideId .. "_" .. stepId)

		return false
	end
end

function GuideExceptionChecker.checkTaskNotFinish(guideId, stepId, param)
	return not GuideExceptionChecker.checkTaskFinish(guideId, stepId, param)
end

function GuideExceptionChecker.checkBlockCountGE(guideId, stepId, param)
	local count = tonumber(param)
	local fullBlockCount = RoomMapBlockModel.instance:getFullBlockCount()

	return count <= fullBlockCount
end

function GuideExceptionChecker.checkBlockCountL(guideId, stepId, param)
	local count = tonumber(param)
	local fullBlockCount = RoomMapBlockModel.instance:getFullBlockCount()

	return fullBlockCount < count
end

function GuideExceptionChecker.checkRoomCanGetRes(guideId, stepId, param)
	local partId = tonumber(param)
	local requestLineIdList = RoomProductionHelper.getCanGainLineIdList(partId)

	return #requestLineIdList > 0
end

function GuideExceptionChecker.check1_2DungeonHasNotCollectNote(guideId, stepId, param)
	return not VersionActivity1_2NoteModel.instance:isCollectedAllNote()
end

function GuideExceptionChecker.check1_2DungeonBonusFinish(guideId, stepId, param)
	local storyId = tonumber(param)

	return not VersionActivity1_2NoteModel.instance:getBonusFinished(storyId)
end

function GuideExceptionChecker.check1_2DungeonHasNotBonusFinisd(guideId, stepId, param)
	return not VersionActivity1_2NoteModel.instance:isAllBonusFinished()
end

function GuideExceptionChecker.checkRoleStoryCanExchange(guideId, stepId, param)
	local cost = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost)
	local cur = RoleStoryModel.instance:getLeftNum()

	return RoleStoryModel.instance:checkTodayCanExchange() and cost <= cur
end

function GuideExceptionChecker.checkCurBgmGearStateEqual(guideId, stepId, param)
	local gearState = tonumber(param)
	local curGearState = BGMSwitchModel.instance:getMechineGear()

	return gearState == curGearState
end

function GuideExceptionChecker.checkCurBgmDeviceNotShowingPPT(guideId, stepId, param)
	local showing = BGMSwitchModel.instance:getEggIsTrigger()

	return not showing
end

function GuideExceptionChecker.checkCan174EnoughHpToBet(guideId, stepId, param)
	local act174Info = Activity174Model.instance:getActInfo()
	local gameInfo = act174Info:getGameInfo()

	return gameInfo.hp > 1
end

function GuideExceptionChecker.checkRouge2AlreadyHaveAlchemy(guideId, stepId, param)
	local haveAlchemy = Rouge2_AlchemyModel.instance:haveAlchemyInfo()

	return not haveAlchemy
end

function GuideExceptionChecker.checkCanRouge2EnoughMaterialToAlchemy(guideId, stepId, param)
	if string.nilorempty(param) then
		return true
	end

	local dataList = string.splitToNumber(param, "_")
	local formulaId = dataList[1]
	local formulaConfig = Rouge2_OutSideConfig.instance:getFormulaConfig(formulaId)

	if formulaConfig then
		local needMaterial = string.split(formulaConfig.mainIdNum, "|")

		for _, singleParam in ipairs(needMaterial) do
			local singleMaterial = string.splitToNumber(singleParam, "#")
			local num = Rouge2_AlchemyModel.instance:getMaterialNum(singleMaterial[1])

			if num < singleMaterial[2] then
				return false
			end
		end
	end

	for i = 2, #dataList do
		local materialId = dataList[i]
		local num = Rouge2_AlchemyModel.instance:getMaterialNum(materialId)

		if num <= 0 then
			return false
		end
	end

	return true
end

function GuideExceptionChecker.checkRouge2TalentEnoughToActive(guideId, stepId, param)
	if string.nilorempty(param) then
		return false
	end

	local needCheckTalentIds = string.splitToNumber(param, "_")
	local needCount = 0

	for _, talentId in ipairs(needCheckTalentIds) do
		local talentTypeConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByTalentId(talentId)

		needCount = needCount + talentTypeConfig.pointCost
	end

	return needCount <= Rouge2_TalentModel.instance:getTalentPoint()
end

function GuideExceptionChecker.checkRouge2TalentIsActive(guideId, stepId, param)
	if string.nilorempty(param) then
		return true
	end

	local needCheckTalentIds = string.splitToNumber(param, "_")

	for _, talentId in ipairs(needCheckTalentIds) do
		if Rouge2_TalentModel.instance:isTalentActive(talentId) then
			return false
		end
	end

	return true
end

function GuideExceptionChecker.checkReturnFalse()
	return false
end

return GuideExceptionChecker
