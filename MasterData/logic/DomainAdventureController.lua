-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/controller/DomainAdventureController.lua

module("logic.extensions.domainadventure.controller.DomainAdventureController", package.seeall)

local DomainAdventureController = class("DomainAdventureController", BaseController)

function DomainAdventureController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("opendomainadventure", self._openDomainAdventure, self)
end

function DomainAdventureController:onReset()
	self._curSceneId = 0
end

function DomainAdventureController:sendPM_DomainAdventureGetInfoReq(activityId)
	DomainAdventureAgent.instance:sendPM_DomainAdventureGetInfoReq(activityId)
end

function DomainAdventureController:handlePM_DomainAdventureGetInfoRes(status, msg)
	local activityId = msg.activityId
	local mo = self:getDomAdvMo(activityId)

	mo:handlePM_DomainAdventureGetInfoRes(msg)
	self:updateRedInGlobalPrize(activityId)

	local costItem = DomainAdventureConfig.instance:getCostItem(activityId)

	if string.nilorempty(costItem) then
		printError(string.format("配置缺失，活动id:%s, costItem为nil( export_活动配置  in  l-领域冒险.xlsx )", activityId))
	else
		local matType, matId, matNum = MaterialMgr.getMatParams(costItem)

		MaterialFacade.instance:UpdateMaterial(matType, matId, msg.curStrength)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DomainAdventureGetInfoRes, status, msg)
end

function DomainAdventureController:sendPM_DomainAdventureLoadMapReq(activityId, blockIds, startIdx, endIdx)
	DomainAdventureAgent.instance:sendPM_DomainAdventureLoadMapReq(activityId, blockIds, startIdx, endIdx)
end

function DomainAdventureController:handlePM_DomainAdventureLoadMapRes(msg)
	local mo = self:getDomAdvMo(msg.activityId)

	mo:handlePM_DomainAdventureLoadMapRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DomainAdventureLoadMapRes)
end

function DomainAdventureController:sendPM_DomainAdventureActionReq(activityId, blockId, extParam, simpleForm)
	DomainAdventureAgent.instance:sendPM_DomainAdventureActionReq(activityId, blockId, extParam, simpleForm)
end

function DomainAdventureController:handlePM_DomainAdventureActionRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DomainAdventureActionRes, status, msg)
end

function DomainAdventureController:sendPM_DomainAdventureGainGlobalPrizeReq(activityId, prizeId)
	DomainAdventureAgent.instance:sendPM_DomainAdventureGainGlobalPrizeReq(activityId, prizeId)
end

function DomainAdventureController:handlePM_DomainAdventureGainGlobalPrizeRes(msg)
	local mo = self:getDomAdvMo(msg.activityId)

	mo:handlePM_DomainAdventureGainGlobalPrizeRes(msg)
	self:updateRedInGlobalPrize(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DomainAdventureGainGlobalPrizeRes)
end

function DomainAdventureController:sendPM_DomainAdventureRankViewReq(activityId, type)
	DomainAdventureAgent.instance:sendPM_DomainAdventureRankViewReq(activityId, type)
end

function DomainAdventureController:handlePM_DomainAdventureRankViewRes(msg)
	local mo = self:getDomAdvMo(msg.activityId)

	mo:handlePM_DomainAdventureRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DomainAdventureRankViewRes, msg)
end

function DomainAdventureController:handlePM_DomainAdventureNotifyActionRes(msg)
	local activityId = msg.actionParam.activityId
	local mo = self:getDomAdvMo(activityId)

	mo:handlePM_DomainAdventureNotifyActionRes(msg)
	self:updateRedInGlobalPrize(activityId)

	local costItem = DomainAdventureConfig.instance:getCostItem(activityId)
	local matType, matId, matNum = MaterialMgr.getMatParams(costItem)

	MaterialFacade.instance:UpdateMaterial(matType, matId, msg.curStrength)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DomainAdventureNotifyActionRes, msg)
end

function DomainAdventureController:handlePM_DomainAdventureOccupiedChangesRes(msg)
	local mo = self:getDomAdvMo(msg.activityId)

	mo:handlePM_DomainAdventureOccupiedChangesRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DomainAdventureOccupiedChangesRes)
end

function DomainAdventureController:getDomAdvMo(activityId)
	return DomainAdventureModel.instance:getDomAdvMo(activityId)
end

function DomainAdventureController:getActivityIdByTime()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function DomainAdventureController:getActivityType()
	return GameEnum.ActivityType.DomainAdventure
end

function DomainAdventureController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function DomainAdventureController:loadDomainAdventure()
	local activityId = self:getActivityIdByTime()

	if not self:isInActivityTime(activityId) then
		return
	end

	DomainAdventureController.instance:sendPM_DomainAdventureGetInfoReq(activityId)
end

function DomainAdventureController:updateRedInGlobalPrize(activityId)
	local isHave = self:isHaveGlobalPrizeCanGet(activityId)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DOMADV_GLOBAL_PRIZE, isHave)
end

function DomainAdventureController:getCurSceneId()
	return self._curSceneId
end

function DomainAdventureController:createSceneId()
	self._curSceneId = TilingSceneMgr.instance:createTilingSceneId()

	return self._curSceneId
end

function DomainAdventureController:getCurActivityId()
	local sceneId = self:getCurSceneId()

	return DomainAdventureModel.instance:getActivityIdBySceneId(sceneId)
end

function DomainAdventureController:getStoryIdInEnterScene()
	return checknumber(self._storyIdInEnterScene)
end

function DomainAdventureController:_openDomainAdventure(params)
	self:enterDomainAdventureScene()
end

function DomainAdventureController:enterDomainAdventureScene()
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.DomainAdventure then
		return
	end

	local activityId = DomainAdventureController.instance:getActivityIdByTime()

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动时间范围内")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.HandlePM_DomainAdventureGetInfoRes, self._enterDomainAdventureScene, self)
	DomainAdventureController.instance:sendPM_DomainAdventureGetInfoReq(activityId)
end

function DomainAdventureController:_enterDomainAdventureScene(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_DomainAdventureGetInfoRes, self._enterDomainAdventureScene, self)

	if status ~= 0 then
		return
	end

	local activityId = msg.activityId
	local sceneId = DomainAdventureController.instance:createSceneId()

	DomainAdventureModel.instance:setActivityId(sceneId, activityId)
	DomAdvPathFindingDataModel.instance:reload(activityId)

	self._storyIdInEnterScene = nil

	local actData = DomainAdventureConfig.instance:getActData(activityId)
	local storyId = actData.firstSceneStoryId

	if storyId > 0 then
		local key = string.format("DomainAdventure_First_Scene_Storys_%s", activityId)

		local function firstCallback()
			self._storyIdInEnterScene = storyId
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end

	local mapDataName = DomainAdventureConfig.instance:getMapDataName(activityId)

	TilingSceneMgr.instance:enterDomainAdventureScene(sceneId, mapDataName)
end

function DomainAdventureController:_onEndStory(storyId, isAllEnd)
	if not isAllEnd then
		return
	end

	local activityId = DomainAdventureController.instance:getCurActivityId()
	local actData = DomainAdventureConfig.instance:getActData(activityId)

	if actData then
		if not actData.firstSceneStoryId then
			local sId = 0

			if sId ~= storyId then
				return
			end

			GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onEndStory, self)

			local sceneId = self:getCurSceneId()
			local mapDataName = DomainAdventureConfig.instance:getMapDataName(activityId)

			TilingSceneMgr.instance:enterDomainAdventureScene(sceneId, mapDataName)
		end
	end
end

function DomainAdventureController:exitDomainAdventureScene()
	if self._curSceneId == 0 then
		return
	end

	UIJumper.instance:clear()
	UIStateManager.instance:clear(false)
	SceneStatusMgr.instance:popStatus(ViewName.MainUI)
	TilingSceneMgr.instance:clearTilingSceneConfig(self._curSceneId)
	DomainAdventureModel.instance:setActivityId(self._curSceneId, 0)

	self._curSceneId = 0
end

function DomainAdventureController:isBuffGrid(activityId, blockId)
	local buffId = DomainAdventureConfig.instance:getBuffIdInGrid(activityId, blockId)

	return buffId > 0
end

function DomainAdventureController:triggerGridEvent(activityId, blockId, gridState)
	local eventType = DomainAdventureConfig.instance:getEventType(activityId, blockId)

	if eventType == DomAdvEnum.EventType_Empty then
		-- block empty
	elseif eventType == DomAdvEnum.EventType_Fight then
		if gridState:isOccupied() then
			FloatWordMgr.instance:show("该地块已被占领")
		else
			UIStateManager.instance:push(ViewName.DomAdvEventFightView, activityId, blockId)
		end
	elseif eventType == DomAdvEnum.EventType_SolveForm then
		if gridState:isOccupied() then
			FloatWordMgr.instance:show("该地块已被占领")
		else
			UIStateManager.instance:push(ViewName.DomAdvEventSolveFormView, activityId, blockId)
		end
	elseif eventType == DomAdvEnum.EventType_Dispatch then
		if gridState:isOccupied() then
			FloatWordMgr.instance:show("该地块已被占领")
		else
			UIStateManager.instance:push(ViewName.DomAdvEventDispatchView, activityId, blockId)
		end
	elseif eventType == DomAdvEnum.EventType_Game then
		UIStateManager.instance:push(ViewName.DomAdvEventGameView, activityId, blockId)
	elseif eventType == DomAdvEnum.EventType_Boss then
		UIStateManager.instance:push(ViewName.DomAdvEventBossView, activityId, blockId)
	elseif eventType == DomAdvEnum.EventType_EliteFight then
		if gridState:isOccupied() then
			FloatWordMgr.instance:show("该地块已被占领")
		else
			UIStateManager.instance:push(ViewName.DomAdvEventEliteFightView, activityId, blockId)
		end
	end
end

function DomainAdventureController:enterBattle(activityId, blockId)
	local customFmtMo = DomainAdventureModel.instance:getDomAdvCustomFmtMo()

	customFmtMo:updateCfg(activityId, blockId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DomainAdventureController:enterBattleWithSystem(activityId, blockId)
	local customFmtMo = DomainAdventureModel.instance:getDomAdvSystemCustomFmtMo()

	customFmtMo:updateCfg(activityId, blockId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DomainAdventureController:enterBattleWithBoss(activityId, blockId, mode)
	local customFmtMo = DomainAdventureModel.instance:getDomAdvBossCustomFmtMo()

	customFmtMo:updateCfg(activityId, blockId, mode)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DomainAdventureController:getEventData(activityId, eventType, eventId)
	local data

	if eventType == DomAdvEnum.EventType_Fight then
		data = DomainAdventureConfig.instance:getClgEventData(activityId, eventId)
	elseif eventType == DomAdvEnum.EventType_SolveForm then
		data = DomainAdventureConfig.instance:getSolveFormData(activityId, eventId)
	elseif eventType == DomAdvEnum.EventType_Dispatch then
		data = DomainAdventureConfig.instance:getDispatchData(activityId, eventId)
	elseif eventType == DomAdvEnum.EventType_Game then
		data = DomainAdventureConfig.instance:getGameEventData(activityId, eventId)
	elseif eventType == DomAdvEnum.EventType_Boss then
		data = DomainAdventureConfig.instance:getBossEventData(activityId, eventId)
	elseif eventType == DomAdvEnum.EventType_EliteFight then
		data = DomainAdventureConfig.instance:getClgEventData(activityId, eventId)
	end

	return data
end

function DomainAdventureController:isHaveGlobalPrizeCanGet(activityId)
	local cfg = DomainAdventureConfig.instance:getGlobalPrizeCfg(activityId)

	if cfg then
		for _, data in pairs(cfg) do
			if self:isCanGetGlobalPrize(activityId, data.prizeId) then
				return true
			end
		end
	end

	return false
end

function DomainAdventureController:isCanGetGlobalPrize(activityId, prizeId)
	local result, tips = self:getTryGetGlobalPrizeResultAndTips(activityId, prizeId)

	return result == GameEnum.ResultCode.Success
end

function DomainAdventureController:getTryGetGlobalPrizeResultAndTips(activityId, prizeId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif not self:isEnoughCostStrengthInPrize(activityId) then
		result = GameEnum.ResultCode.Error

		local costItem = DomainAdventureConfig.instance:getCostItem(activityId)
		local maxCost = DomainAdventureController.instance:getMaxCostStrengthInPirze(activityId)
		local matName = MaterialMgr.getMaterialsNameByCfg(costItem)

		tips = string.format("需要累计消耗%s点%s后领取", maxCost, matName)
	elseif self:isHasGainGlobalPrize(activityId, prizeId) then
		result = GameEnum.ResultCode.Error
		tips = "已领取"
	elseif not self:isEnoughGetGlobalPrize(activityId, prizeId) then
		result = GameEnum.ResultCode.Error
		tips = "未满足占领地块数量"
	end

	return result, tips
end

function DomainAdventureController:isEnoughCostStrengthInPrize(activityId)
	local max = self:getMaxCostStrengthInPirze(activityId)
	local cur = self:getTotalCostStrength(activityId)

	return max <= cur
end

function DomainAdventureController:getMaxCostStrengthInPirze(activityId)
	return DomainAdventureConfig.instance:getUnlockGlobalPrizeCostStrength(activityId)
end

function DomainAdventureController:getTotalCostStrength(activityId)
	local domAdvMo = self:getDomAdvMo(activityId)

	return domAdvMo:getTotalCostStrength()
end

function DomainAdventureController:isHasGainGlobalPrize(activityId, prizeId)
	local domAdvMo = self:getDomAdvMo(activityId)

	return domAdvMo:isGainGlobalPrize(prizeId)
end

function DomainAdventureController:isEnoughGetGlobalPrize(activityId, prizeId)
	local data = DomainAdventureConfig.instance:getGlobalPrizeData(activityId, prizeId)

	if data then
		if not data.occupiedGridCount then
			local need = 0
			local cur = self:getCurProgressGlobalPrize(activityId)

			return need <= cur
		end
	end
end

function DomainAdventureController:getCurProgressGlobalPrize(activityId)
	local domAdvMo = self:getDomAdvMo(activityId)

	return domAdvMo:getOccupiedGlobalBlockNum()
end

DomainAdventureController.instance = DomainAdventureController.New()

return DomainAdventureController
