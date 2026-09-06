-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/controller/SummontowerController.lua

module("logic.extensions.summer.controller.SummontowerController", package.seeall)

local SummontowerController = class("SummontowerController", BaseController)

function SummontowerController:onInit()
	self:onReset()
end

function SummontowerController:onReset()
	self.SummerList = {}
	self._lastOpGridId = 0
end

function SummontowerController:hasEverOpenedExchangeShop()
	local key = "summon_torwer_exchangeshop" .. (RoleModel.instance:getUserId() or "")

	return GameUtil.getUserDayData(key) ~= nil
end

function SummontowerController:setOpenedExchangeShop()
	local key = "summon_torwer_exchangeshop" .. (RoleModel.instance:getUserId() or "")

	GameUtil.saveUserDayData(key, 1)
end

function SummontowerController:hasEverOpenedSummonter()
	local key = "summon_torwer_hasopened" .. (RoleModel.instance:getUserId() or "")

	return GameUtil.getUserDayData(key) ~= nil
end

function SummontowerController:setHasOpenedSummonter()
	local key = "summon_torwer_hasopened" .. (RoleModel.instance:getUserId() or "")

	GameUtil.saveUserDayData(key, 1)
end

function SummontowerController:setOpGridId(lastOpGridId)
	self._lastOpGridId = lastOpGridId
end

function SummontowerController:getOpGridId()
	return self._lastOpGridId
end

function SummontowerController:hasEverOpenedSummontower()
	local hasEverOpened = checknumber(UnityEngine.PlayerPrefs.GetInt("summon_torwer_" .. RoleModel.instance:getUserId()))

	return hasEverOpened ~= 0
end

function SummontowerController:setHasOpenedSummontower()
	UnityEngine.PlayerPrefs.SetInt("summon_torwer_" .. RoleModel.instance:getUserId(), 1)
end

function SummontowerController:openActivityView()
	if not self:isActivityOpended() then
		return
	end

	self:setCurrActivityId()
	UIStateManager.instance:push(ViewName.SummontowerStartView)
end

function SummontowerController:isActivityOpended()
	return self:getActivityId() ~= 0
end

function SummontowerController:getActivityId()
	local activities = SummontowerConfig.instance:getActivities()

	for i = 1, #activities do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.Summontower, activities[i].activityId) then
			return activities[i].activityId
		end
	end

	return 0
end

function SummontowerController:setCurrActivityId()
	local currActivityId = self:getActivityId()

	if currActivityId == 0 then
		SummontowerModel.instance:setActivityId(0)
		SummontowerModel.instance:setActivityInfo()

		return
	end

	local activityId = SummontowerModel.instance:getActivityId()

	if activityId == currActivityId then
		return
	end

	SummontowerModel.instance:setActivityId(currActivityId)
end

function SummontowerController:requestActivityInfo()
	local currActivityId = self:getActivityId()

	if currActivityId == 0 then
		SummontowerModel.instance:setActivityId(0)
		SummontowerModel.instance:setActivityInfo()

		return
	end

	local activityId = SummontowerModel.instance:getActivityId()
	local isActivityDataReady = SummontowerModel.instance:isActivityDataReady()

	if activityId == currActivityId and isActivityDataReady then
		return
	end

	SummontowerModel.instance:setActivityId(currActivityId)
	SummonMasterTowerAgent.instance:sendPM_SMTGetActInfoReq(currActivityId)
end

function SummontowerController:onActivityInfo(msg)
	SummontowerModel.instance:setActivityInfo(msg)
	SummonTowerItemsModel.instance:setPlayerExp(msg.playerExp)
	GlobalDispatcher:dispatch(GlobalNotify.OnSommonInfos)
end

function SummontowerController:checkCurMustHandleGrid()
	if not SummontowerModel.instance:isGameInfoReady() then
		return false
	end

	local curMustHandleGridId = SummontowerMapModel.instance:getCurMustHandleGridId()

	if curMustHandleGridId == 0 then
		return false
	end

	return self:executeGridEvent(curMustHandleGridId)
end

function SummontowerController:executeGridEvent(gridId)
	local gridData = SummontowerMapModel.instance:getMapGridData(gridId)

	if not gridData then
		return false
	end

	if gridData.girdStatus == SummomMapNodeMO.gridStatus.Wish then
		if not gridData.wishTrigger then
			gridData.wishTrigger = true

			ViewMgr.instance:open(ViewName.SummontowerWishTriggerView)
		else
			ViewMgr.instance:open(ViewName.SummontowerWishView)
		end

		return true
	end

	if gridData.girdStatus == SummomMapNodeMO.gridStatus.RelivePet then
		ViewMgr.instance:open(ViewName.SummontowRevivalView, gridData)

		return true
	end

	if gridData.girdStatus == SummomMapNodeMO.gridStatus.SwapPet then
		if #gridData.extInfo == 1 then
			ViewMgr.instance:open(ViewName.SummontowerGetMember, gridData.extInfo[1], gridData)
		else
			ViewMgr.instance:open(ViewName.SummontowerGetSolicitsView, gridData)
		end

		return true
	end

	if gridData.gridEventType == SummonGridEvtType.Shop then
		ViewMgr.instance:open(ViewName.SummontowerShopView, gridData)

		return true
	end

	if gridData and gridData.gridEventType == SummonGridEvtType.Guard and gridData.girdStatus == SummomMapNodeMO.gridStatus.Init then
		UIStateManager.instance:push(ViewName.SummontowerMissionView, gridData)

		return true
	end

	if (gridData.gridEventType == SummonGridEvtType.Coin or gridData.gridEventType == SummonGridEvtType.Box) and gridData.girdStatus == SummomMapNodeMO.gridStatus.Init then
		self:nextLevel(gridData.gridId)

		return true
	end

	if gridData.gridEventType == SummonGridEvtType.Door and gridData.girdStatus == SummomMapNodeMO.gridStatus.Init then
		local currStage = SummontowerModel.instance:getCurLevelId()

		if currStage >= SummontowerConfig.instance:getStagesNum() then
			self:nextLevel(gridData.gridId)
		else
			TipsFacade.instance:openPopupWindow(lang("tip"), "确定进入下一关冒险吗？", function()
				self:nextLevel(gridData.gridId)
			end, function()
				return
			end, "确定", "取消")
		end

		return true
	end

	return false
end

function SummontowerController:requestGameInfo()
	local currActivityId = self:getActivityId()

	if currActivityId == 0 then
		return
	end

	if SummontowerModel.instance:isGameInfoReady() then
		return
	end

	SummonMasterTowerAgent.instance:sendPM_SMTGetGameInfoReq(currActivityId)
end

function SummontowerController:onGameInfo(msg)
	if msg.activityId ~= SummontowerModel.instance:getActivityId() then
		return
	end

	SummontowerFmtModel.instance:initFormation()
	SummontowerModel.instance:onGameInfo(msg)
	SummontowerPetsModel.instance:setPets(msg.pets)
	SummonTowerItemsModel.instance:setItems(msg.itemInfos)
	SummontowerMapModel.instance:setMapGridsData(msg.mapInfo)
	GlobalDispatcher:dispatch(GlobalNotify.OnSommonTowerGameInfo)
end

function SummontowerController:requestRankInfo()
	local currActivityId = self:getActivityId()

	if currActivityId == 0 then
		return
	end

	SummonMasterTowerAgent.instance:sendPM_SMTGetRankInfoReq(currActivityId)
end

function SummontowerController:onGetRankInfoMsg(msg)
	SummontowerModel.instance:onGetRankInfoMsg(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnSommonTowerRankInfo)
end

function SummontowerController:requestBuyPlayTimes()
	local activityId = SummontowerModel.instance:getActivityId()

	SummonMasterTowerAgent.instance:sendPM_SMTBuyGameTimesReq(activityId)
end

function SummontowerController:onBuyPlayTimesRespond(msg)
	local activityId = SummontowerModel.instance:getActivityId()

	if msg.activityId ~= activityId then
		return
	end

	SummontowerModel.instance:setBuyTimes(msg.todayGameBuyTimes)

	local currActivityId = self:getActivityId()

	SummonMasterTowerAgent.instance:sendPM_SMTGetActInfoReq(currActivityId)
end

function SummontowerController:requestSweep(boo)
	if boo == nil then
		boo = false
	end

	local activityId = SummontowerModel.instance:getActivityId()

	SummonMasterTowerAgent.instance:sendPM_SMTSweepReq(activityId, boo)
end

function SummontowerController:onSweepRespond(msg)
	local activityId = SummontowerModel.instance:getActivityId()

	if msg.activityId ~= activityId then
		return
	end

	SummontowerModel.instance:costPlayTimes(msg.useGameTimes)
	SummontowerModel.instance:addSweepScore()
	GlobalDispatcher:dispatch(GlobalNotify.OnSommonSweep)
end

function SummontowerController:requestSelectSummonMaster(id)
	local activityId = SummontowerModel.instance:getActivityId()

	SummonMasterTowerAgent.instance:sendPM_SMTChooseSummonMasterReq(activityId, id)
end

function SummontowerController:onSelectSummonMaster(msg)
	local activityId = SummontowerModel.instance:getActivityId()

	if msg.activityId ~= activityId then
		return
	end

	SummontowerPetsModel.instance:setPets(msg.pets)
	SummontowerModel.instance:onSelectSummonMaster(msg)
	SummontowerModel.instance:costPlayTimes(1)
	GlobalDispatcher:dispatch(GlobalNotify.OnSommonMasterSel)
end

function SummontowerController:onGainFirstPassPrize(msg)
	SummontowerModel.instance:onGainFirstPassPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnSommonGainFirstPassPrize)
end

function SummontowerController:buyGameItem(gridId, shopItemId)
	local activityId = SummontowerModel.instance:getActivityId()
	local param = SummonMasterTowerExtension_pb.PM_SMTDoGridEventParam()

	table.insert(param.params, shopItemId)
	SummonMasterTowerAgent.instance:sendPM_SMTDoGridEventReq(activityId, gridId, param)
end

function SummontowerController:startGuardBattle(gridId)
	SummontowerMapModel.instance:saveGridData(gridId)
	BattleFacade.instance:startSummonTower(gridId)

	local activityId = SummontowerModel.instance:getActivityId()
	local param = SummonMasterTowerExtension_pb.PM_SMTDoGridEventParam()

	param.form:ParseFromString(SummontowerFmtModel.instance:toSimpleForm():SerializeToString())
	SummonMasterTowerAgent.instance:sendPM_SMTDoGridEventReq(activityId, gridId, param)
	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.SummonTower)
end

function SummontowerController:passGuardBattle(gridId)
	SummontowerMapModel.instance:clearGridData()

	local activityId = SummontowerModel.instance:getActivityId()
	local param = SummonMasterTowerExtension_pb.PM_SMTDoGridEventParam()

	param.directPass = true

	SummonMasterTowerAgent.instance:sendPM_SMTDoGridEventReq(activityId, gridId, param)
end

function SummontowerController:giveupRevivePet(gridId)
	local activityId = SummontowerModel.instance:getActivityId()
	local param = SummonMasterTowerExtension_pb.PM_SMTDoGridEventParam()

	param.giveUp = true

	SummonMasterTowerAgent.instance:sendPM_SMTDoGridEventReq(activityId, gridId, param)
end

function SummontowerController:openSelectSwapPetView(funCallback)
	TipsFacade.instance:openTipWindowNoX(lang("tip"), SummontowerConfig.instance:getParamsString("PET_NUM_LIMIT_TIP"), function()
		local pets = SummontowerPetsModel.instance:getPets()
		local petList = {}

		for k, v in pairs(pets) do
			if not SummontowerPetsModel.instance:isSummonMasterPet(v.petId) and not SummontowerPetsModel.instance:isSummonedAnimalPet(v.petId) then
				table.insert(petList, v)
			end
		end

		PetSelectController.instance:OpenView(true, "请选择离开队伍的精灵，新加入的精灵不可选择", nil, funCallback, nil, nil, nil, petList, true)
	end, BootstrapLanguage.sure)
end

function SummontowerController:revivePet(gridId, petsList)
	local activityId = SummontowerModel.instance:getActivityId()
	local param = SummonMasterTowerExtension_pb.PM_SMTDoGridEventParam()

	for i = 1, #petsList do
		table.insert(param.params, petsList[i])
	end

	SummonMasterTowerAgent.instance:sendPM_SMTDoGridEventReq(activityId, gridId, param)
end

function SummontowerController:swapPet(gridId, creepsId, petId)
	local activityId = SummontowerModel.instance:getActivityId()
	local param = SummonMasterTowerExtension_pb.PM_SMTDoGridEventParam()

	table.insert(param.params, creepsId)
	table.insert(param.params, petId)
	SummonMasterTowerAgent.instance:sendPM_SMTDoGridEventReq(activityId, gridId, param)
end

function SummontowerController:giveupSwapPet(gridId)
	local activityId = SummontowerModel.instance:getActivityId()
	local param = SummonMasterTowerExtension_pb.PM_SMTDoGridEventParam()

	param.giveUp = true

	SummonMasterTowerAgent.instance:sendPM_SMTDoGridEventReq(activityId, gridId, param)
end

function SummontowerController:wish1Pet(gridId, withType, creepId)
	local activityId = SummontowerModel.instance:getActivityId()
	local param = SummonMasterTowerExtension_pb.PM_SMTDoGridEventParam()

	table.insert(param.params, withType)

	if creepId then
		table.insert(param.params, creepId)
	end

	SummonMasterTowerAgent.instance:sendPM_SMTDoGridEventReq(activityId, gridId, param)
end

function SummontowerController:finishGrid(gridId)
	local activityId = SummontowerModel.instance:getActivityId()

	SummonMasterTowerAgent.instance:sendPM_SMTDoGridEventReq(activityId, gridId, nil)
end

function SummontowerController:nextLevel(gridId)
	local activityId = SummontowerModel.instance:getActivityId()

	SummonMasterTowerAgent.instance:sendPM_SMTDoGridEventReq(activityId, gridId, nil)
end

function SummontowerController:resetGame()
	SummontowerFmtModel.instance:onReset()
	SummontowerPetsModel.instance:onReset()
	SummonTowerItemsModel.instance:onReset()
	SummontowerMapModel.instance:onReset()
	SummontowerModel.instance:onReset()
end

function SummontowerController:onDoGridEvent(msg)
	local activityId = SummontowerModel.instance:getActivityId()

	if msg.activityId ~= activityId then
		return
	end

	if msg:HasField("gainedScore") then
		SummontowerMapModel.instance:setResultScores(msg.gainedScore)
	end

	if msg:HasField("passGame") then
		SummontowerMapModel.instance:setPassGame(msg.passGame)
	end

	local changeMos = SummonTowerItemsModel.instance:gainedItems(msg.itemInfos) or {}
	local delPets

	if #msg.pets > 0 then
		local currPets = SummontowerPetsModel.instance:getAllPetCfg()

		SummontowerPetsModel.instance:setPets(msg.pets)

		if currPets then
			for k, v in pairs(currPets) do
				if not SummontowerPetsModel.instance:getPet(k) then
					local petCo = SummontowerConfig.instance:getPetCo(v.creepsId)

					if petCo and checknumber(petCo.summonMasterId) == 0 then
						delPets = delPets or {}

						table.insert(delPets, v.creepsId)
					end
				end
			end
		end
	end

	if msg:HasField("gridInfo") then
		SummontowerMapModel.instance:updateGrid(msg.gridInfo)
	end

	if msg:HasField("curStage") then
		SummontowerModel.instance:setCurLevelId(msg.curStage)
	end

	if msg:HasField("mapInfo") then
		SummontowerMapModel.instance:setMapGridsData(msg.mapInfo)
	end

	if msg:HasField("curMustHandleGridId") then
		SummontowerMapModel.instance:setCurMustHandleGridId(msg.curMustHandleGridId)
	end

	local gridDataRecord = SummontowerMapModel.instance:getGridRecordData()

	if gridDataRecord then
		if msg:HasField("isReliveSummonMaster") then
			gridDataRecord.isReliveSummonMaster = msg.isReliveSummonMaster
		end

		gridDataRecord.delPets = delPets
	end

	SummontowerMapModel.instance:checkDoorUnlock()
	SummontowerMapModel.instance:checkCoinAndBoxUnlock()
	GlobalDispatcher:dispatch(GlobalNotify.OnSommonTowerDoGrid, self._lastOpGridId, changeMos, getPets, delPets)
end

SummontowerController.instance = SummontowerController.New()

return SummontowerController
