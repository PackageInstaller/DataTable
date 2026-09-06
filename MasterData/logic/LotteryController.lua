-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/controller/LotteryController.lua

module("logic.extensions.lottery.controller.LotteryController", package.seeall)

local LotteryController = class("LotteryController", BaseController)

LotteryController.OpenPoolType = {
	BackDay = 3,
	OpenTime = 1,
	PlayerCreate = 4,
	StartDay = 2
}

function LotteryController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.OnTenDrawResult, self.ShowTenDrawResultView, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.CSRequestLotteryInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.RoleInfoPushed, self._onRoleInfoPushed, self)
	LotteryAgent.instance:addHandler(LotteryAgent.LotteryDrawRes, self.handleLotteryDrawRes, self)
end

function LotteryController:onReset()
	self._needSendGetInfo = false
	self._petIdListForResolve = nil
	self.drawCardNum = nil
	self._choPoolId = nil
	self._choPosInfo = nil
	self.groupId = nil
	self.currShowItems = nil
	self._lotteryBgEffectType = 0

	self:stopDrawBgmMusic()
	self:clearAllDataForEffectView()
	GlobalDispatcher:removeListener(GlobalNotify.OnTenDrawResult, self.ShowTenDrawResultView, self)
	LotteryAgent.instance:removeHandler(LotteryAgent.LotteryDrawRes, self.handleLotteryDrawRes)
end

function LotteryController:playDrawBgmMusic()
	if self._drawBgmEvent then
		return
	end

	local audioId = 30401

	self._drawBgmEvent = AudioPlayerEx.instance:playEffect(audioId)
	self._musicVolume = AudioPlayerEx.instance:getMusicVolume()
	self._currMusicVolume = self._musicVolume
	self._currDrawBgmVolume = 0

	FmodAudioMgr.Instance:SetEventInstanceVolume(self._drawBgmEvent, self._currDrawBgmVolume)

	if self._musicVolume ~= 0 then
		AudioPlayerEx.instance:setMusicVolume(0)
	end

	if self._drawBgmEvent then
		FmodAudioMgr.Instance:SetEventInstanceVolume(self._drawBgmEvent, 1)
	end
end

function LotteryController:_tweenPlayBgmMuisc()
	self._currMusicVolume = math.max(0, self._currMusicVolume - 0.05)
	self._currDrawBgmVolume = math.min(1, self._currDrawBgmVolume + 0.05)

	AudioPlayerEx.instance:setMusicVolume(self._currMusicVolume)
	FmodAudioMgr.Instance:SetEventInstanceVolume(self._drawBgmEvent, self._currDrawBgmVolume)

	if self._currMusicVolume <= 0 and self._currDrawBgmVolume >= 1 then
		removetimer(self._tweenPlayBgmMuisc, self)
	end
end

function LotteryController:startStopDrawBgmMusic()
	if self._musicVolume ~= nil then
		AudioPlayerEx.instance:setMusicVolume(self._musicVolume)

		self._musicVolume = nil
	end

	if self._drawBgmEvent then
		FmodAudioMgr.Instance:SetEventInstanceVolume(self._drawBgmEvent, 0)
		AudioPlayerEx.instance:stopEvent(self._drawBgmEvent)

		self._drawBgmEvent = nil
	end

	self._currMusicVolume = nil
	self._currDrawBgmVolume = nil
end

function LotteryController:stopDrawBgmMusic()
	removetimer(self._tweenPlayBgmMuisc, self)
	removetimer(self._tweenStopBgmMuisc, self)

	if self._musicVolume ~= nil then
		AudioPlayerEx.instance:setMusicVolume(self._musicVolume)

		self._musicVolume = nil
	end

	if self._drawBgmEvent then
		AudioPlayerEx.instance:stopEvent(self._drawBgmEvent)

		self._drawBgmEvent = nil
	end

	self._currMusicVolume = nil
	self._currDrawBgmVolume = nil
end

function LotteryController:_tweenStopBgmMuisc()
	self._currMusicVolume = math.min(self._musicVolume, self._currMusicVolume + 0.05)
	self._currDrawBgmVolume = math.max(0, self._currDrawBgmVolume - 0.05)

	AudioPlayerEx.instance:setMusicVolume(math.max(0, self._currMusicVolume))
	FmodAudioMgr.Instance:SetEventInstanceVolume(self._drawBgmEvent, math.min(1, self._currDrawBgmVolume))

	if self._currMusicVolume >= self._musicVolume and self._currDrawBgmVolume <= 0 then
		self:stopDrawBgmMusic()
	end
end

function LotteryController:_onRoleInfoPushed()
	LotteryAgent.instance:addHandler(LotteryAgent.LotteryDrawRes, self.handleLotteryDrawRes, self)
	GlobalDispatcher:addListener(GlobalNotify.OnTenDrawResult, self.ShowTenDrawResultView, self)
end

function LotteryController:ShowTenDrawResultView()
	local show_result = LotteryController.instance:GetTenDrawCardNeedShow()

	if show_result then
		LotteryController.instance:SetTenDrawCardNeedShow(nil)
		UIStateManager.instance:push("drawcardresultview")
	end
end

function LotteryController:CSRequestLotteryInfo()
	LotteryAgent.instance:sendLotteryInfoReq(function(msg)
		local poolInfo = msg.pools

		LotteryModel.instance:SetUseZhaohuanCount(poolInfo, msg.freeInfos, msg.groupInfos)
	end)
end

function LotteryController:getOldPetRactId()
	self.all_pets = nil

	local _userOwnedRaceIdMap = HandbookModel.instance:getUserOwnedRaceIdMap()

	if _userOwnedRaceIdMap then
		self.all_pets = TableUtil.deepcopy(_userOwnedRaceIdMap)
	end
end

function LotteryController:CSRequestLuckDraw(num, poolId, groupId, substituteTimes, discountSubId)
	if num > 1 then
		self:getOldPetRactId()
	end

	self._choPoolId = poolId or 3
	self.drawCardNum = num or 1
	groupId = groupId or -1

	LotteryAgent.instance:sendLotteryDrawReq(groupId, self._choPoolId, self.drawCardNum, checknumber(substituteTimes), checknumber(discountSubId))
end

function LotteryController:____CSRequestLuckDrawXiaoNuo(num, poolId, groupId, substituteTimes, discountSubId)
	if num > 1 then
		self:getOldPetRactId()
	end

	self._choPoolId = poolId or 3
	self.drawCardNum = nil
	self._needSendGetInfo = true
	groupId = groupId or -1

	LotteryAgent.instance:sendLotteryDrawReq(groupId, self._choPoolId, num or 1, checknumber(substituteTimes), checknumber(discountSubId))
end

function LotteryController:CSRequestUnlockGroup(groupId)
	self.groupId = groupId

	LotteryAgent.instance:sendPM_UnlockLotteryPoolInGroupReq(groupId)
end

function LotteryController:SCAcceptUnlockGroup()
	LotteryModel.instance:SCAcceptUnlockGroup(self.groupId, true)

	self.groupId = nil
end

function LotteryController:handleLotteryDrawRes(msg)
	if self._needSendGetInfo == true then
		self._needSendGetInfo = false

		self:CSRequestLotteryInfo()
	end

	if not msg or not self.drawCardNum then
		return
	end

	local poolId = msg.poolId
	local selfSelectInfo = msg.selfSelectInfo

	LotteryModel.instance:scSendLotterySelectPrizeDrawResult(msg.selectPrizeResult, poolId)
	LotteryModel.instance:UpdataZhaohuanCount(poolId, self.drawCardNum, msg.lastSSR)
	LotteryModel.instance:updataSelfSelectInfo(poolId, selfSelectInfo)

	local isSSR = false
	local changesetid = msg.changeSetId
	local items = MaterialFacade.instance:getItemsByChangeSetId(changesetid)

	self._petIdListForResolve = {}

	local rareList = {}
	local skipAnim = LotteryModel.instance:getPoolSkipAnim(poolId)

	if self.drawCardNum > 1 then
		local petList = {}

		LotteryController.instance:SetTenDrawCardNeedShow(true)

		if items then
			local tem

			for k, mo in pairs(items) do
				local isNew = false

				if mo.type == MatType.Pet then
					local pet = BagModel.instance:getPet(mo.id)

					table.insert(self._petIdListForResolve, pet.petId)

					if self.all_pets[pet.raceId] == nil then
						isNew = true
					end

					if pet.rare == GameEnum.PetRare.N or pet.rare == GameEnum.PetRare.R then
						if isNew then
							tem = tem or {}

							table.insert(tem, mo)
						end
					else
						tem = tem or {}

						table.insert(tem, mo)
					end

					if pet.rare == GameEnum.PetRare.SSR then
						isSSR = true
					end

					table.insert(petList, {
						raceid = pet.raceId,
						new_pet = isNew,
						petId = mo.id
					})
					table.insert(rareList, pet.rare)
					LotteryModel.instance:SetLotterySixPool(self._choPoolId, pet.rare)
				elseif mo.type == MatType.Coin then
					LotteryModel.instance.buyGoldInfo = {
						count = mo.num,
						poolId = self._choPoolId
					}
				end
			end

			self:SetPetCurFaceList(petList)
			self:SetPetRareList(rareList)

			self.currShowItems = tem

			if skipAnim then
				LotteryController.instance:clearLottery()
			else
				UIStateManager.instance:push(ViewName.LotteryeffectView, tem)
			end
		else
			error("items is nil-1")
		end
	else
		if items then
			for k, mo in pairs(items) do
				if mo.type == MatType.Pet then
					local pet = BagModel.instance:getPet(mo.id)

					table.insert(self._petIdListForResolve, pet.petId)
					table.insert(rareList, pet.rare)

					if pet.rare == GameEnum.PetRare.SSR then
						isSSR = true
					end

					LotteryModel.instance:SetLotterySixPool(self._choPoolId, pet.rare)
				end
			end
		end

		self:SetPetRareList(rareList)

		self.currShowItems = items

		if skipAnim then
			LotteryController.instance:showPetItemGet()
			LotteryController.instance:SetInLotteryLogicOneAndTen(nil)
		else
			UIStateManager.instance:push(ViewName.LotteryeffectView, items)
		end
	end

	if poolId ~= 3 and poolId ~= 4 then
		local needPop = LotteryModel.instance:getUseCountByPoolId(poolId) <= 30

		if needPop and isSSR then
			ViewAutoShowController.instance:trySetAutoEvaluation(0.25, ViewAutoShowController.TAPTAP_FUNC_3)
		end
	end

	self.drawCardNum = nil
	self._choPoolId = nil

	GlobalDispatcher:dispatch(LotteryModel.ZhaohuanSelectPetUpdate)
end

function LotteryController:showPetItemGet()
	if self.currShowItems then
		local items = self.currShowItems

		if LotteryController.instance:GetInLotteryLogic() then
			ArraySort.sortOn(items, function(mo)
				local pet = MaterialMgr.getModel(mo.type, mo.id)

				if pet then
					return pet.rare
				end

				return 0
			end, ArraySort.DESCENDING)
			MaterialController.instance:showChangeSetItemMo(items)
		else
			local list = MaterialController.instance:getList(MaterialController.TYPE_PET)
			local tem = {}
			local count = 0

			for k, mo in pairs(items) do
				if mo.type == MatType.Coin and mo.id == MatType.Coin_Gold then
					count = count + mo.num
				elseif mo.type == MatType.Pet then
					table.insert(list, mo)
					table.insert(tem, mo)
				else
					table.insert(tem, mo)
				end
			end

			local obj = {}

			obj.items = tem

			UIStateManager.instance:open(ViewName.ItemGet, obj, count)
			MaterialController.instance:setList(MaterialController.TYPE_PET, list)
			MaterialController.instance:popupPet()
			GlobalDispatcher:dispatch(GlobalNotify.LotteryEndForResolve)
		end
	elseif LotteryController.instance:GetInLotteryLogic() then
		GlobalDispatcher:dispatch(GlobalNotify.OnTenDrawResult)
	end

	self.currShowItems = nil
end

function LotteryController:getPetIdListForResolve()
	return self._petIdListForResolve
end

function LotteryController:clearPetIdListForResolve()
	self._petIdListForResolve = nil
end

function LotteryController:SetRecordNeedCount(need)
	self.record_need = need
end

function LotteryController:GetRecordNeedCount()
	return self.record_need
end

function LotteryController:setLotteryBgEffectType(_type)
	self._lotteryBgEffectType = _type
end

function LotteryController:getLotteryBgEffectType()
	return self._lotteryBgEffectType
end

function LotteryController:SetPetRareList(_petRareList)
	self._petRareList = _petRareList
end

function LotteryController:GetPetRareList()
	return self._petRareList
end

function LotteryController:SetPetCurFaceList(_petCurFaceIdList)
	self._petCurFaceIdList = _petCurFaceIdList
end

function LotteryController:GetPetCurFaceList()
	return self._petCurFaceIdList
end

function LotteryController:SetTenDrawCardNeedShow(tag)
	self.ten_draw_card_needshow = tag
end

function LotteryController:GetTenDrawCardNeedShow()
	return self.ten_draw_card_needshow
end

function LotteryController:SetInLotteryLogic(tag)
	self._inLotteryLogic = tag
end

function LotteryController:GetInLotteryLogic()
	return self._inLotteryLogic
end

function LotteryController:SetInLotteryLogicOneAndTen(tag)
	self._inLotteryLogicOat = tag
end

function LotteryController:GetInLotteryLogicOneAndTen()
	return self._inLotteryLogicOat
end

function LotteryController:clearLottery()
	if ViewMgr.instance:isOpen(ViewName.DrawView) then
		ViewMgr.instance:close(ViewName.DrawView)
	end

	if LotteryController.instance:GetTenDrawCardNeedShow() then
		local pet_face_list = LotteryController.instance:GetPetCurFaceList()
		local pet_rare_list = LotteryController.instance:GetPetRareList()

		if pet_face_list and pet_rare_list then
			GlobalDispatcher:dispatch(GlobalNotify.OnTenDrawResult)
		end

		LotteryController.instance:SetInLotteryLogic(nil)
	end

	LotteryController.instance:SetInLotteryLogicOneAndTen(nil)
end

function LotteryController:setGoIntoFight(tag)
	self._goIntoTag = tag
end

function LotteryController:getGoIntoFight()
	return self._goIntoTag
end

function LotteryController:clearAllDataForEffectView()
	LotteryController.instance:SetInLotteryLogic(nil)
	LotteryController.instance:SetInLotteryLogicOneAndTen(nil)
	LotteryController.instance:SetTenDrawCardNeedShow(nil)
	LotteryController.instance:SetPetCurFaceList(nil)
	LotteryController.instance:SetPetRareList(nil)
end

function LotteryController:CSGetLotteryComShopInfoReq()
	LotteryAgent.instance:sendLotteryShopInfoReq(function(msg)
		LotteryModel.instance:SetAllShopInfoDatas(msg, nil)
	end)
end

function LotteryController:CSLotteryBuyCommonShopReq(goodsId)
	LotteryAgent.instance:sendLotteryCommonShopBuyReq(goodsId, function()
		LotteryModel.instance:SetSingleShopInfoData(goodsId, nil)
	end)
end

function LotteryController:CSGetLotteryGodShopInfoReq(poolId)
	LotteryAgent.instance:sendLotteryGodShopInfoReq(poolId, function(msg)
		LotteryModel.instance:SetAllShopInfoDatas(msg, poolId)
	end)
end

function LotteryController:CSLotteryBuyGodShopReq(goodsId, poolId)
	LotteryAgent.instance:sendLotteryGodShopBuyReq(goodsId, poolId, function()
		LotteryModel.instance:SetSingleShopInfoData(goodsId, poolId)
	end)
end

function LotteryController:CSLotterySelectWishPetReq(poolId, wishPetId)
	LotteryAgent.instance:sendLotterySelectWishPetReq(poolId, wishPetId, function()
		LotteryModel.instance:UpdataWishPetsList(poolId, wishPetId)
	end)
end

function LotteryController:csGetLotterySelectPrizeInfoReq(poolId)
	local data = LotteryConfig.instance:getPoolSelectPrizeCfgs(poolId)

	if data == nil then
		return
	end

	LotteryAgent.instance:sendPM_LotterySelectPrizeInfoReq(poolId)
end

function LotteryController:scSendLotterySelectPrizeInfo(msg)
	LotteryModel.instance:scSendLotterySelectPrizeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LotteryGetPrizeInfo)
end

function LotteryController:csGetLotterySelectPrizeSetPosReq(poolId, posInfo)
	self._choPoolId = poolId
	self._choPosInfo = posInfo

	LotteryAgent.instance:sendPM_LotterySelectPrizeSetPosReq(poolId, posInfo)
end

function LotteryController:scSendLotterySelectPrizeSetPos(msg)
	if checknumber(self._choPoolId) <= 0 or self._choPosInfo == nil or #self._choPosInfo == 0 then
		return
	end

	LotteryModel.instance:scSendLotterySelectPrizeSetPos(self._choPoolId, self._choPosInfo)
	GlobalDispatcher:dispatch(GlobalNotify.LotterySetPrizeInfo)

	self._choPoolId = nil
	self._choPosInfo = nil
end

function LotteryController:csGetLotterySelectPrizeResetReq(poolId)
	self._choPoolId = poolId

	LotteryAgent.instance:sendPM_LotterySelectPrizeResetReq(poolId)
end

function LotteryController:scSendLotterySelectPrizeReset(msg)
	if checknumber(self._choPoolId) <= 0 then
		return
	end

	LotteryModel.instance:scSendLotterySelectPrizeReset(self._choPoolId)
	GlobalDispatcher:dispatch(GlobalNotify.LotteryResetPrizeInfo)

	self._choPoolId = nil
end

function LotteryController:sendSelfSelectPetUp(poolId, groupId, gridId, raceId)
	self._tmpSUPoolId = poolId
	self._tmpSUGridId = gridId
	self._tmpSURaceId = raceId

	LotteryAgent.instance:sendPM_LotterySelectUpPetReq(poolId, groupId, gridId, raceId)
end

function LotteryController:handleSelfSelectPetUp(msg)
	LotteryModel.instance:updateSelfSelectPet(self._tmpSUPoolId, self._tmpSUGridId, self._tmpSURaceId)
	GlobalDispatcher:dispatch(LotteryModel.ZhaohuanSelectPetUpdate)
end

function LotteryController:sendResetSelfSelectPetUp(poolId, groupId)
	self._tmpSUPoolId = poolId

	LotteryAgent.instance:sendPM_LotteryResetUpPetReq(poolId, groupId)
end

function LotteryController:handleResetSelfSelectPetUp(msg)
	LotteryModel.instance:updateOneInfo(msg.poolInfo)
	GlobalDispatcher:dispatch(LotteryModel.UpdataZhaohuanTimes)
end

function LotteryController:checkHasSelectPet(poolId)
	local info = LotteryModel.instance:getSelfSelectInfo(poolId)

	if info then
		if not info.selfSelectPets then
			local selfSelectPets = {}
			local nums = table.nums(selfSelectPets)

			if nums == 4 then
				return true
			end
		end
	end

	return false
end

function LotteryController:checkMustPickPet(poolId, groupId)
	local poolId = checknumber(poolId)
	local times = LotteryModel.instance:getSelfSelectTimes(poolId)

	if times > 0 then
		local info = LotteryModel.instance:getSelfSelectInfo(poolId) or {}

		if not info.selfSelectPets then
			local selfSelectPets = {}
			local strList = {}

			for i, petPb in ipairs(selfSelectPets) do
				local str = MaterialMgr.createSerName(MatType.Pet, petPb.raceId, 1, 1)

				table.insert(strList, str)
			end

			local content = "请先选择累计召唤奖励，才能继续进行"

			UIStateManager.instance:push(ViewName.RewardselectcommonView, strList, function(selectIdx)
				if not selfSelectPets[selectIdx] then
					local pb = {}
					local raceId = pb.raceId

					self._tmpSUPoolId = poolId

					LotteryAgent.instance:sendPM_LotterySelectUpPrizeReq(poolId, groupId, raceId)
				end
			end, content)

			return true
		end
	end

	return false
end

function LotteryController:handleSelfSelectPetTimes(msg)
	LotteryModel.instance:updateSelfSelectTimes(self._tmpSUPoolId)

	self._tmpSUPoolId = 0

	GlobalDispatcher:dispatch(LotteryModel.ZhaohuanSelectPetUpdate)
end

function LotteryController:getLotteryNeedConsume(lotteryNum, cfg)
	local infos = string.split(cfg.consume, ":")
	local matType = checknumber(infos[1])
	local matId = checknumber(infos[2])
	local matNum = checknumber(infos[3])
	local zkStr, zk = LotteryModel.instance:getPoolConsumePlan(cfg)

	if not string.nilorempty(zkStr) then
		matNum = checknumber(zk)
	end

	local needNum = lotteryNum * math.max(matNum, 1)
	local haveNum = MaterialModel.instance:getMaterialsNumber(matType, matId) or 0

	if needNum <= haveNum then
		return true, matType, matId, matNum, 0, 0
	end

	if string.nilorempty(cfg.consumeSubstitute) then
		return false, matType, matId, matNum, needNum - haveNum, 0
	end

	local temp = lotteryNum - math.floor(haveNum / matNum)

	if temp == 0 then
		return true, matType, matId, matNum, 0, 0
	end

	local sttts = string.split(cfg.consumeSubstitute, ":")
	local stttType = checknumber(sttts[1])
	local stttId = checknumber(sttts[2])
	local stttNum = checknumber(sttts[3])
	local stttNeedNum = temp * math.max(stttNum, 1)
	local stttHaveNum = MaterialModel.instance:getMaterialsNumber(stttType, stttId) or 0

	if haveNum > 0 then
		if stttNeedNum <= stttHaveNum then
			return true, matType, matId, matNum, 0, temp
		else
			local st = math.floor(stttHaveNum / stttNum)

			needNum = (temp - st) * math.max(matNum, 1)

			return false, matType, matId, matNum, needNum, st
		end
	elseif stttNeedNum <= stttHaveNum then
		return true, stttType, stttId, stttNum, 0, temp
	else
		return false, stttType, stttId, stttNum, stttNeedNum - stttHaveNum, temp
	end
end

function LotteryController:getGroupIdByPoolId(poolId)
	local allCfgs = LotteryConfig.instance:GetAllPoolGroupCfgs()

	for i, v in ipairs(allCfgs) do
		if GameUtil.checkIsInTimePeriod(v.openTime, v.endTime) then
			for _, pId in ipairs(v.poolIds) do
				if pId == poolId then
					return v.groupId
				end
			end
		end
	end

	return -1
end

function LotteryController:getTabNameList()
	local tabNameCfg = LotteryConfig.instance:GetCommonPrizeCfgByKey("TAB_NAME")

	if not tabNameCfg.value then
		local tabNameStr = ""
		local arr = string.split(tabNameStr, "#")
		local list = {}

		for i, v in ipairs(arr) do
			table.insert(list, v)
		end

		return list
	end
end

function LotteryController:hasSelectPrize(poolId, posId, id)
	local bigPrizeInfo = LotteryModel.instance:getBigPrizeInfo(poolId)

	if bigPrizeInfo then
		if not bigPrizeInfo.posInfo then
			local posInfo = {}
			local info = posInfo[posId]

			if info then
				return id == info.prizeId
			end

			return false
		end
	end
end

LotteryController.instance = LotteryController.New()

return LotteryController
