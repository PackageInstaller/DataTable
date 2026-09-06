-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/controller/TimeWheelController.lua

module("logic.extensions.timewheel.controller.TimeWheelController", package.seeall)

local TimeWheelController = class("TimeWheelController", BaseController)
local TuJianMaxDecomposeKey = "timewheelview_tujianmaxdecompose"
local TuJianMaxOverflowKey = "timewheelview_tujianmaxoverflow"

function TimeWheelController:ctor()
	return
end

function TimeWheelController:onInit()
	GlobalDispatcher:addListener(TimeWheelAgent.PM_TimeWheelDecomposeRes, self._onTimeWheelDecomposeRes, self)
	GlobalDispatcher:addListener(TimeWheelAgent.PM_TimeWheelResetRes, self._onTimeWheelResetRes, self)
	GlobalDispatcher:addListener(TimeWheelAgent.PM_TimeWheelRevertRes, self._onTimeWheelRevertRes, self)
	GlobalDispatcher:addListener(TimeWheelAgent.PM_TimeWheelGetResetStrengthenInfoRes, self._onGetResetCount, self)
	GlobalDispatcher:addListener(TimeWheelAgent.PM_DecomposeOverFlowPetRes, self._onDecomposeOverFlowPetRes, self)
	GlobalDispatcher:addListener(TimeWheelAgent.PM_DecomposeOverFlowItemRes, self._onDecomposeOverFlowItemRes, self)
	GlobalDispatcher:addListener(TimeWheelAgent.PM_DecomposeOverFlowPetBatchRes, self._onDecomposeOverFlowPetBatchRes, self)
	TimeWheelAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.showChangeSet, self))
	GlobalDispatcher:addListener(LotteryAgent.LotteryDrawRes, self._onLotteryDrawRes, self)
	GlobalDispatcher:addListener(GlobalNotify.LotteryEndForResolve, self._onLotteryEndForResolve, self)

	self._isFirstShowOverflowRed = true
end

function TimeWheelController:onReset()
	self._isFirstShowOverflowRed = true
end

function TimeWheelController:sendPM_TimeWheelSetDecomposeWhenLotteryReq(rare, isDecompose)
	TimeWheelAgent.instance:sendPM_TimeWheelSetDecomposeWhenLotteryReq(rare, isDecompose)
end

function TimeWheelController:handlePM_TimeWheelSetDecomposeWhenLotteryRes(msg)
	TimeWheelModel.instance:handlePM_TimeWheelSetDecomposeWhenLotteryRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TimeWheelSetDecomposeWhenLottery, msg)
end

function TimeWheelController:_onTimeWheelDecomposeRes(status, msg)
	if status == 0 then
		TimeWheelModel.instance:setDecomposeChangeSetId(msg.extraItemCsi, msg.strengthenItemCsi)
		GlobalDispatcher:dispatch(GlobalNotify.TimeWheelDecompose, msg)
	end
end

function TimeWheelController:_onTimeWheelResetRes(status, msg)
	if status == 0 then
		TimeWheelModel.instance:setResetChangeSetId(msg.changeSetId)
		TimeWheelModel.instance:setResetCount(msg.curDailyCount)
		TimeWheelModel.instance:setEndTimestampOnResetCD(msg.curResetCD, msg.CDEffective)
		GlobalDispatcher:dispatch(GlobalNotify.TimeWheelReset, msg)
	end
end

function TimeWheelController:_onTimeWheelRevertRes(status, msg)
	if status == 0 then
		TimeWheelModel.instance:setRevertChangeSetId(msg.awakenItemCsi, msg.strengthenItemCsi)
		GlobalDispatcher:dispatch(GlobalNotify.TimeWheelRevert, msg)
	end
end

function TimeWheelController:handlePM_TimeWheelGetDecomposeWhenLotteryRes(msg)
	TimeWheelModel.instance:handlePM_TimeWheelGetDecomposeWhenLotteryRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TimeWheelGetDecomposeWhenLottery, msg)
end

function TimeWheelController:_onGetResetCount(status, msg)
	if status == 0 then
		TimeWheelModel.instance:setResetCount(msg.todayUsedCount)
		TimeWheelModel.instance:setEndTimestampOnResetCD(msg.curResetCD, msg.CDEffective)
		GlobalDispatcher:dispatch(GlobalNotify.TimeWheelResetCount)
	end
end

function TimeWheelController:_onDecomposeOverFlowPetRes(status, msg)
	if status == 0 then
		TimeWheelModel.instance:setOverflowPetChangeSetId(msg.scoreItemCsi, msg.strengthenItemCsi)

		local isSuccess = true

		GlobalDispatcher:dispatch(GlobalNotify.PM_DecomposeOverFlowPetRes, isSuccess)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PM_DecomposeOverFlowPetRes, false, status)
	end
end

function TimeWheelController:_onDecomposeOverFlowItemRes(status, msg)
	if status == 0 then
		TimeWheelModel.instance:setOverflowItemChangeSetId(msg.changeSetId)
		GlobalDispatcher:dispatch(GlobalNotify.PM_DecomposeOverFlowItemRes)
	end
end

function TimeWheelController:_onDecomposeOverFlowPetBatchRes(status, msg)
	if status == 0 then
		TimeWheelModel.instance:setOverflowPetChangeSetId(msg.scoreItemCsi, msg.strengthenItemCsi)

		local isSuccess = true

		GlobalDispatcher:dispatch(GlobalNotify.PM_DecomposeOverFlowPetBatchRes, isSuccess)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PM_DecomposeOverFlowPetBatchRes, false, status)
	end
end

function TimeWheelController:showChangeSet(changeSetId, msgName)
	if msgName == "handlePM_TimeWheelDecomposeRes" or msgName == "handlePM_TimeWheelResetRes" or msgName == "handlePM_TimeWheelRevertRes" or msgName == "handlePM_DecomposeOverFlowPetRes" or msgName == "handlePM_DecomposeOverFlowItemRes" or msgName == "handlePM_DecomposeOverFlowPetBatchRes" then
		-- block empty
	else
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
	end
end

function TimeWheelController:popReward()
	local changeSetId1, changeSetId2 = TimeWheelModel.instance:getDecomposeChangeSetId()

	ItemGetController.instance:setTitleType(changeSetId1, ItemGetController.TITLE_XIAOSHI)
	ItemGetController.instance:setTitleType(changeSetId2, ItemGetController.TITLE_RETURNMAT)
	MaterialFacade.instance:popAndShowChangeSetItems(changeSetId1)
	MaterialFacade.instance:popAndShowChangeSetItems(changeSetId2)
end

function TimeWheelController:_onLotteryDrawRes(status, msg)
	if status == 0 then
		self._changeSetId1 = msg.decomposeExtraCsi
		self._changeSetId2 = msg.decomposeStrengthenCsi
	end
end

function TimeWheelController:_onLotteryEndForResolve()
	local changeSetId1 = self._changeSetId1
	local changeSetId2 = self._changeSetId2

	self._changeSetId1 = nil
	self._changeSetId2 = nil

	if changeSetId1 and changeSetId1 ~= -1 then
		ItemGetController.instance:setTitleType(changeSetId1, ItemGetController.TITLE_XIAOSHI)
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId1)
	end

	if changeSetId2 and changeSetId2 ~= -1 then
		ItemGetController.instance:setTitleType(changeSetId2, ItemGetController.TITLE_RETURNMAT)
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId2)
	end
end

function TimeWheelController:getTimeInternal()
	local timeEnd = TimeWheelModel.instance:getEndTimestampOnResetCD()
	local timeNow = ServerTime.now()
	local internal = timeEnd - timeNow

	if internal <= 0 then
		TimeWheelModel.instance:setCdNotAvailable()
	end

	return internal
end

function TimeWheelController:getPetListAndItemList()
	local resultPetIdList = {}
	local resultItemIdList = {}
	local petDic = {}
	local bagPets = BagModel.instance:getBagPets()

	for i, v in ipairs(bagPets) do
		if not TimeWheelStateModel.instance:isPetFilter(v.raceId, TimeWheelStateModel.EnumType.Overflow) then
			local initRare = CharacterConfig.instance:getInitRare(v:getDefineId())

			if initRare >= GameEnum.PetRare.SSR then
				petDic[v.raceId] = petDic[v.raceId] or {}

				if not petDic[v.raceId].maxAwakenPetId and v:isAwakenMax() then
					petDic[v.raceId].maxAwakenPetId = v:getPetId()
				else
					petDic[v.raceId].petIdList = petDic[v.raceId].petIdList or {}

					table.insert(petDic[v.raceId].petIdList, v:getPetId())
				end
			end
		end
	end

	for k, v in pairs(petDic) do
		if v.maxAwakenPetId and v.maxAwakenPetId > 0 and v.petIdList then
			table.insertto(resultPetIdList, v.petIdList)
		end
	end

	local awakenItemCfgs = ItemConfig.instance:getAwakenItemExtCfgs()

	for i, v in ipairs(awakenItemCfgs) do
		if v.race > 0 and petDic[v.race] and petDic[v.race].maxAwakenPetId and petDic[v.race].maxAwakenPetId > 0 then
			local cfg = ItemConfig.instance:getCfgById(v.id)

			if cfg and cfg.quality >= 4 then
				local num = MaterialModel.instance:getMaterialsNumber(MatType.Item, v.id)

				if num > 0 then
					table.insert(resultItemIdList, v.id)
				end
			end
		end
	end

	return resultPetIdList, resultItemIdList
end

function TimeWheelController:getExchangeCfgsList()
	return PayShopConfig.instance:getGoodsCfgsByShopTypeAndShowType(GameEnum.PayShopShopType.PetOverflow, 20) or {}
end

function TimeWheelController:isShowOverflowRedPoint(isSetBool)
	local list1, list2 = self:getPetListAndItemList()

	if self._isFirstShowOverflowRed then
		if #list1 > 0 or #list2 > 0 then
			if isSetBool then
				self._isFirstShowOverflowRed = false
			end

			return true
		else
			return false
		end
	else
		return false
	end
end

function TimeWheelController:isShowTimeWheelRedPoint()
	local isExist = TimeWheelStateModel.instance:isExistCanDecomposePet()

	if isExist then
		return true
	end

	local isShowOverflow = self:isShowOverflowRedPoint(false)

	if isShowOverflow then
		return true
	end

	return false
end

function TimeWheelController:updateRedPoint()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_TIME_WHEEL, (FuncOpenModel.instance:getFuncIsOpen(65) or nil) and self:isShowTimeWheelRedPoint())
end

function TimeWheelController:getTujianMaxDecomposeIsToggle()
	return (GameUtil.getUserData(TuJianMaxDecomposeKey))
end

function TimeWheelController:setTujianMaxDecomposeToggle(isToggle)
	GameUtil.saveUserData(TuJianMaxDecomposeKey, isToggle)
end

function TimeWheelController:getTujianMaxOverflowIsToggle()
	return (GameUtil.getUserData(TuJianMaxOverflowKey))
end

function TimeWheelController:setTujianMaxOverflowToggle(isToggle)
	GameUtil.saveUserData(TuJianMaxOverflowKey, isToggle)
end

function TimeWheelController:openUnlockPopupView(bagPetMo)
	if bagPetMo then
		local text = string.format(TimeWheelStateModel.lockTip, bagPetMo:getName())
		local petId = bagPetMo:getPetId()
		local isLock

		local function okFunc()
			BagPetsController.instance:changePetLockState(petId, false, function()
				GlobalDispatcher:dispatch(GlobalNotify.TimeWheelViewRefreshPetlist)
			end)
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
	end
end

TimeWheelController.instance = TimeWheelController.New()

return TimeWheelController
