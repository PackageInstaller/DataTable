-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/controller/TreasureRaiderController.lua

module("logic.extensions.treasureraider.controller.TreasureRaiderController", package.seeall)

local TreasureRaiderController = class("TreasureRaiderController", BaseController)

TreasureRaiderController.RankAfterGetInfo = 1
TreasureRaiderController.RecordAfterGetInfo = 2
TreasureRaiderController.TotalResourceAfterGetInfo = 3

function TreasureRaiderController:ctor()
	return
end

function TreasureRaiderController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._checkRefreshTime, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderSelectPos, self._onSelectGrid, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderClickProduce, self._onClickProduce, self)
	self:onReset()
end

function TreasureRaiderController:onReset()
	self._sceneId = 0
	self._cacheIsRandom = nil
	self._cacheSetAttackFormationData = nil
	self._cacheAction = nil

	removetimer(self._checkRedDot, self)

	self._startTickCheck = false
end

function TreasureRaiderController:_onSelectGrid(posX, posY, gridX, gridY)
	if not TREditorController.instance:isInState(TREditorController.EMode_EditorMode) then
		self:_doOpenOperateGrid(posX, posY, gridX, gridY)
	end
end

function TreasureRaiderController:_onClickProduce(posX, posY, gridX, gridY)
	if not TREditorController.instance:isInState(TREditorController.EMode_EditorMode) then
		local id = TreasureRaiderSceneModel.instance:grid2Id(gridX, gridY)

		TRPopMenuController.instance:preOpHandler(posX, posY, gridX, gridY, id)
	end
end

function TreasureRaiderController:_doOpenOperateGrid(posX, posY, gridX, gridY)
	local id = TreasureRaiderSceneModel.instance:grid2Id(gridX, gridY)

	printInfo("TreasureraidersceneView:_onSelectGrid....................", gridX, gridY, id)

	if not TRPopMenuController.instance:isOpViewShowing(gridX, gridY) then
		ViewMgr.instance:close(ViewName.TreasuresceneoperateView)

		local opTypes = TRPopMenuController.instance:getOpGroups(posX, posY, gridX, gridY, id)

		if opTypes then
			local len = #opTypes

			if len == 1 then
				TRPopMenuController.instance:handle(opTypes[1], posX, posY, gridX, gridY, id)
			elseif len ~= 0 then
				ViewMgr.instance:open(ViewName.TreasuresceneoperateView, opTypes, posX, posY, gridX, gridY, id)
			end
		end
	end
end

function TreasureRaiderController:_checkRefreshTime()
	if self._sceneId ~= 0 then
		local activityId = TreasureRaiderConfig.instance:getActivityId()

		if activityId > 0 then
			RichManAgent.instance:sendPM_RichManGetInfoReq(activityId)
		end
	end
end

function TreasureRaiderController:leaveScene()
	if self._sceneId ~= 0 then
		SceneStatusMgr.instance:popStatus(ViewName.MainUI)
		TilingSceneMgr.instance:clearTilingSceneConfig(self._sceneId)
		self:setSceneId(0)
	end
end

function TreasureRaiderController:setSceneId(sceneId)
	self._sceneId = sceneId

	if self._sceneId == 0 then
		TreasureRaiderSceneModel.instance:onReset()
		TREnterSceneSequenceController.instance:onReset()
	end
end

function TreasureRaiderController:tryRandomMove()
	self._cacheIsRandom = true

	local sceneMo = TreasureRaiderModel.instance:getCurSceneMo()
	local activityId = TreasureRaiderConfig.instance:getActivityId()

	if sceneMo:isMyScene() then
		RichManAgent.instance:sendPM_RichManWalkReq(activityId, 0)
	else
		RichManAgent.instance:sendPM_RichManAttackWalkReq(0)
	end
end

function TreasureRaiderController:tryFixMove(value)
	self._cacheIsRandom = false

	local sceneMo = TreasureRaiderModel.instance:getCurSceneMo()
	local activityId = TreasureRaiderConfig.instance:getActivityId()

	if sceneMo:isMyScene() then
		RichManAgent.instance:sendPM_RichManWalkReq(activityId, value)
	else
		RichManAgent.instance:sendPM_RichManAttackWalkReq(value)
	end
end

function TreasureRaiderController:reqAttackMatch()
	local matchModel = BountyPkCompeteMatchModel.New()

	function matchModel._reqStartMatchFunc()
		local activityId = TreasureRaiderConfig.instance:getActivityId()

		RichManAgent.instance:sendPM_RichManAttackMatchReq(activityId)
	end

	matchModel._hideCancelBtn = true
	matchModel._maxMatchTime = 30

	UIStateManager.instance:push(ViewName.TreasureraidermatchView, matchModel)
end

function TreasureRaiderController:reqSetDefendFormation(req)
	RichManAgent.instance:sendPM_RichManDefendSetFormReq(req)
end

function TreasureRaiderController:reqSetAttackFormation(req)
	RichManAgent.instance:sendPM_RichManAttackSetFormReq(req)
end

function TreasureRaiderController:reqAttack(form, gridId)
	local req = RichManExtension_pb.PM_RichManAttackFightReq()

	req.form:ParseFromString(form:SerializeToString())

	req.buildingGrid = gridId
	self._cacheSetAttackFormationData = req.form

	RichManAgent.instance:sendPM_RichManAttackFightReq(req)
end

function TreasureRaiderController:reqRevenge(activityId, userId)
	RichManAgent.instance:sendPM_RichManRevengeReq(activityId, userId)
end

function TreasureRaiderController:showAttackPrize()
	local changeSetId = TreasureRaiderModel.instance:getCurSceneMo().myPlayerMo:getChangeSetIdAndReset()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function TreasureRaiderController:reqRichManAction(activityId, buildingGrid, action, newBuildingCfgId)
	self._cacheAction = action

	RichManAgent.instance:sendPM_RichManActionReq(activityId, buildingGrid, action, newBuildingCfgId)
end

function TreasureRaiderController:onRichManGetInfoRes(status, msg)
	if status == 0 then
		TreasureRaiderModel.instance:onRichManGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderMyPlayerMoInfoUpdated)
	end

	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderAfterGetInfo, status)
end

function TreasureRaiderController:onRichManEditMapRes(status, msg)
	if status == 0 then
		TreasureRaiderModel.instance:onRichManEditMapRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderMyMapInfoUpdated)
		GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderCloseEditMapView)
	end
end

function TreasureRaiderController:onRichManWalkRes(status, msg)
	if status == 0 then
		TreasureRaiderModel.instance:onRichManWalkRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderMyPlayerMoInfoUpdated)
		GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderPlayDice, msg.point, self._cacheIsRandom)
	end
end

function TreasureRaiderController:onRichManAttackWalkRes(status, msg)
	if status == 0 then
		TreasureRaiderModel.instance:onRichManAttackWalkRes(msg, self._cacheIsRandom)
		GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderMyPlayerMoInfoUpdated)
		GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderPlayDice, msg.point, self._cacheIsRandom)
	end
end

function TreasureRaiderController:onRichManDefendSetFormRes(status, msg)
	if status == 0 then
		TreasureRaiderModel.instance.mySceneMo:updateOneFormation(msg.form.cfgId, msg.form.form)
	end
end

function TreasureRaiderController:onRichManActionRes(status, msg)
	if status == 0 then
		TreasureRaiderModel.instance:onRichManActionRes(msg, self._cacheAction)

		if self._cacheAction then
			if TreasureRaiderConst.ServerAction_Upgrade == self._cacheAction then
				FloatWordMgr.instance:show(lang("升级成功"))
			elseif TreasureRaiderConst.ServerAction_Reconstruct == self._cacheAction then
				FloatWordMgr.instance:show(lang("改建成功"))
			elseif TreasureRaiderConst.ServerAction_Construct == self._cacheAction then
				FloatWordMgr.instance:show(lang("已完成建筑部署"))
			end
		end
	end

	self._cacheAction = nil
end

function TreasureRaiderController:onRichManAttackMatchRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.BPK_NotifyGameStartRes, status, msg)
end

function TreasureRaiderController:onRichManGetRankRes(status, msg)
	if status == 0 then
		self:localNotify(TreasureRaiderController.RankAfterGetInfo, msg)
	end
end

function TreasureRaiderController:onRichManResourcePrizeRes(status, msg)
	TreasureRaiderModel.instance:onRichManResourcePrizeRes(msg)
	self:startTickCheckRedDot()
end

function TreasureRaiderController:onRichManAttackSetFormRes(status, msg)
	if status == 0 then
		TreasureRaiderModel.instance:onRichManAttackSetFormRes(msg.form)
	end
end

function TreasureRaiderController:onRichManAttackFightRes(status, msg)
	if status == 0 then
		TreasureRaiderModel.instance:onRichManAttackFightRes(self._cacheSetAttackFormationData)
	end
end

function TreasureRaiderController:onNotifyRichManFightResultRes(status, msg)
	if status == 0 then
		TreasureRaiderModel.instance:onNotifyRichManFightResultRes(msg)

		local buildingId = msg.buildingGrid.cfgId
		local sceneMo = TreasureRaiderModel.instance:getCurSceneMo()

		if sceneMo:isFormationEmpty(buildingId) then
			FloatWordMgr.instance:show(lang("对手没有设置守军，成功掠夺"))
			TreasureRaiderController.instance:showAttackPrize()
			GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderMyPlayerMoInfoUpdated)
		end
	end
end

function TreasureRaiderController:onRichManGetRecordRes(status, msg)
	if status == 0 then
		self:localNotify(TreasureRaiderController.RecordAfterGetInfo, msg)
	end
end

function TreasureRaiderController:onRichManRevengeRes(status, msg)
	if status == 0 then
		TreasureRaiderModel.instance:onOpMapGetInfoRes(msg, true)
		TREnterSceneSequenceController.instance:onReset()
		TREnterSceneSequenceController.instance:enterScene()
	end
end

function TreasureRaiderController:onOpMapGetInfoFail()
	TreasureRaiderModel.instance:onOpMapGetInfoFail()
	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderMyPlayerMoInfoUpdated)
end

function TreasureRaiderController:onRichManGetTotalResourceRes(status, msg)
	if status == 0 then
		self:localNotify(TreasureRaiderController.TotalResourceAfterGetInfo, msg)
	end
end

function TreasureRaiderController:startTickCheckRedDot()
	if self._startTickCheck then
		return
	end

	self._startTickCheck = true

	settimer(605, self._checkRedDot, self, true)
end

function TreasureRaiderController:_checkRedDot()
	local sceneMo = TreasureRaiderModel.instance:getMySceneMo()
	local myPlayerMo = sceneMo.myPlayerMo

	if myPlayerMo:isClientServerSameGrid() then
		local buildings = sceneMo:getBuildings()

		if buildings then
			for _, tRBuildingMo in pairs(buildings) do
				if tRBuildingMo:getProduceCount() > 0 then
					RedPointController.instance:setRedPointInfo(RedPointModel.ID_Treasureraider_10Min, true)
					removetimer(self._checkRedDot, self)

					self._startTickCheck = false

					return
				end
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_Treasureraider_10Min, false)
end

function TreasureRaiderController:getProduceRates()
	local activityId = TreasureRaiderConfig.instance:getActivityId()
	local actCfg = TreasureRaiderConfig.instance:getActivityConfig(activityId)
	local allBuilds = TreasureRaiderConfig.instance:getBuildingConfigs(actCfg.PlanId)
	local sceneMo = TreasureRaiderModel.instance:getMySceneMo()
	local buildings = sceneMo:getBuildings() or {}
	local list = {}
	local map = {}

	for i, v in ipairs(allBuilds) do
		if v.srcPlanId > 0 then
			for i, tRBuildingMo in pairs(buildings) do
				if tRBuildingMo.buildingId == v.bid and tRBuildingMo:hasProduceRate() then
					local itemKey = tRBuildingMo:getProduceItemKey()

					if map[itemKey] then
						for i, v in ipairs(list) do
							if v.itemKey == itemKey then
								v.rateOneHour = v.rateOneHour + tRBuildingMo:getProduceRateOneHour()

								break
							end
						end
					else
						local d = {
							itemKey = itemKey,
							rateOneHour = tRBuildingMo:getProduceRateOneHour()
						}

						table.insert(list, d)
					end

					map[v.itemKey] = true
				end
			end

			if not map[v.itemKey] then
				local d = {
					rateOneHour = 0,
					itemKey = v.itemKey
				}

				table.insert(list, d)
			end

			map[v.itemKey] = true
		end
	end

	for i, v in ipairs(list) do
		v.rateDesc = string.format("+%s/时", v.rateOneHour)
	end

	return list
end

TreasureRaiderController.instance = TreasureRaiderController.New()

return TreasureRaiderController
