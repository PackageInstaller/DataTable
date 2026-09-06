-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/model/GoodFeelModel.lua

module("logic.extensions.goodfeel.view.GoodFeelModel", package.seeall)

local GoodFeelModel = class("GoodFeelModel", BaseModel)

GoodFeelModel.OnAddNewMsg = "GoodFeelModel.OnAddNewMsg"
GoodFeelModel.DoSendGiftAni = "GoodFeelModel.DoSendGiftAni"
GoodFeelModel.ChangePetShow = "GoodFeelModel.ChangePetShow"

function GoodFeelModel:ctor()
	return
end

function GoodFeelModel:onInit()
	self:onReset()
end

function GoodFeelModel:onReset()
	self._todayInteractCount = 0
	self._infoList = {}
	self._infoList_KV = {}
	self._historyChatGroups = {}
	self._historyChatDatas = {}
	self._newIntroduceChatGroup = nil
	self._jumpMainTab = false
	self._currUnlockData = nil
	self._slowAddMsgList = nil
	self._unlockStoryIds = {}
	self._randomBubbleList = {}
	self._randomLvupList = {}
	self._todaySelfChatCount = 0
	self._currPetShowSkinId = 0
	self._raceId2UnlockLv = {}

	removetimer(self._onAddNewMsg, self)

	self._cachePetInfo = {}
end

function GoodFeelModel:setGoodFeelingInfoFromServer(list)
	for i, v in ipairs(list or {}) do
		self._raceId2UnlockLv[v.raceId] = v.level
	end

	self:_updateAddAttrs()
end

function GoodFeelModel:setChatInfo(msg)
	self:_setHistoryChatGroups(msg.historyChatGroup)
	self:_setNewIntroduceChatGroup(msg.newIntroduceChatGroup)

	self._todaySelfChatCount = msg.todaySelfChatCount
end

function GoodFeelModel:_setHistoryChatGroups(groups)
	self._historyChatGroups = groups

	self:_parseHistoryChatDatas()
end

function GoodFeelModel:_setNewIntroduceChatGroup(group)
	self:_perareSlowAddMsgList(group)
end

function GoodFeelModel:getTodaySelfChatCount()
	return self._todaySelfChatCount
end

function GoodFeelModel:_perareSlowAddMsgList(group)
	self._slowAddMsgList = self._slowAddMsgList or {}

	self:_addOneChatGroup(group, self._slowAddMsgList)
end

function GoodFeelModel:startPlaySlowMsg()
	if self._slowAddMsgList and #self._slowAddMsgList > 0 then
		self:_onAddNewMsg()
		settimer(1, self._onAddNewMsg, self, true)
	else
		removetimer(self._onAddNewMsg, self)
	end
end

function GoodFeelModel:_onAddNewMsg()
	local data

	if self._slowAddMsgList then
		data = table.remove(self._slowAddMsgList, 1)
	else
		removetimer(self._onAddNewMsg, self)

		return
	end

	if data then
		table.insert(self._historyChatDatas, data)
		GlobalDispatcher:dispatch(GoodFeelModel.OnAddNewMsg, data)
	else
		removetimer(self._onAddNewMsg, self)
	end
end

function GoodFeelModel:clearSlowAddMsgList()
	self._slowAddMsgList = nil
end

function GoodFeelModel:hasSlowChatDatas()
	return self._slowAddMsgList
end

function GoodFeelModel:_addOneChatGroup(group, baseList)
	self._historyChatDatas = self._historyChatDatas or {}
	baseList = baseList or self._historyChatDatas

	if group.ids then
		local chatTxt, iconResName

		for _, raceId in ipairs(group.ids) do
			local isMe = false

			if group.groupType == 2 then
				local cfg = GoodFeelConfig.instance:getSelfChatCfg(raceId)

				chatTxt = cfg.chatText
				isMe = true
			else
				local cfg = HandbookConfig.instance:getPetDetailsCfgById(raceId)
				local pcfg = CharacterConfig.instance:getPetCo(raceId)
				local ccfg = CharacterConfig.instance:getModelCo(raceId)

				iconResName = ccfg.headName
				chatTxt = string.format(cfg.selfDesc, pcfg.name)
			end

			table.insert(baseList, {
				chatPlan = group.chatPlan,
				raceId = raceId,
				groupId = group.groupId,
				groupType = group.groupType,
				chatTxt = chatTxt,
				isMe = isMe,
				iconResName = iconResName
			})
		end
	end

	if group.chatRaceIds then
		local pCfg = GoodFeelConfig.instance:getReplyPlanCfg(group.chatPlan)

		for index, raceId in ipairs(group.chatRaceIds) do
			local ccfg = CharacterConfig.instance:getModelCo(raceId)

			iconResName = ccfg.headName

			if pCfg[index] then
				table.insert(baseList, {
					chatPlan = group.chatPlan,
					raceId = raceId,
					groupId = group.groupId,
					groupType = group.groupType,
					chatTxt = pCfg[index].replyText,
					iconResName = iconResName
				})
			end
		end
	end

	if group.groupType == 3 then
		local cfgs = GoodFeelConfig.instance:getSheduleChatCfgs(group.chatPlan)

		for i, v in ipairs(cfgs) do
			local ccfg = CharacterConfig.instance:getModelCo(v.reqRaceId)

			table.insert(baseList, {
				chatPlan = group.chatPlan,
				raceId = v.reqRaceId,
				groupId = group.groupId,
				groupType = group.groupType,
				chatTxt = v.replyText,
				iconResName = ccfg.headName
			})
		end
	end
end

function GoodFeelModel:getHistoryChatDatas()
	return self._historyChatDatas
end

function GoodFeelModel:_parseHistoryChatDatas()
	self._historyChatDatas = {}

	if self._historyChatGroups then
		table.sort(self._historyChatGroups, function(a, b)
			return a.groupId < b.groupId
		end)

		for i, v in ipairs(self._historyChatGroups) do
			self:_addOneChatGroup(v)
		end
	end
end

function GoodFeelModel:getSelfchatids()
	local cfgs = GoodFeelConfig.instance:getSelfChatCfgs()
	local lv = MofangModel.instance:getCurLv()
	local list = {}
	local resList = {}

	for i, v in ipairs(cfgs) do
		if lv >= v.playerLvInterval[1] and lv <= v.playerLvInterval[2] then
			table.insert(list, v)
		end
	end

	local weight = 0
	local maxWeight = 0
	local ignoreIds = {}
	local tempList = {}

	local function cal()
		tempList = {}

		for i, v in ipairs(list) do
			if not ignoreIds[v.chatId] then
				maxWeight = weight + v.weight

				table.insert(tempList, {
					id = v.chatId,
					minWeight = weight + 1,
					maxWeight = maxWeight
				})

				weight = weight + v.weight
			end
		end
	end

	cal()

	local count = 0
	local repeatTime = 0

	while count < 3 and repeatTime < 100 do
		local resWeight = math.random(1, weight)

		for i, v in ipairs(tempList) do
			if resWeight >= v.minWeight and resWeight <= v.maxWeight then
				ignoreIds[v.id] = true
				count = count + 1

				table.insert(resList, v.id)
				cal()
			end
		end

		repeatTime = repeatTime + 1
	end

	return resList
end

function GoodFeelModel:onSelfChatRes(msg)
	self._todaySelfChatCount = msg.todaySelfChatCount

	self:_onAddHistoryGroup(msg.chatGroup)
end

function GoodFeelModel:_onAddHistoryGroup(group)
	self:_perareSlowAddMsgList(group)
	self:startPlaySlowMsg()
end

function GoodFeelModel:setRaceBookInfo(msg)
	self._infoList = msg.infoList

	for i, v in ipairs(self._infoList) do
		self._infoList_KV[v.raceId] = v
	end

	self._todayInteractCount = msg.todayInteractCount

	self:_calAndSaveStoryIds()
	self:_calAdressItemsDot()
end

function GoodFeelModel:updateBookInfo(newInfos)
	for i, v in ipairs(newInfos) do
		local oldInfo = self._infoList_KV[v.raceId]

		if oldInfo then
			oldInfo.prizeGainBit = v.prizeGainBit
		end
	end

	self:_calAndSaveStoryIds()
	self:_calAdressItemsDot()
end

function GoodFeelModel:getRaceBookInfoList()
	return self._infoList
end

function GoodFeelModel:getPetGoodFeelLv(raceId, goodFeelExp)
	goodFeelExp = goodFeelExp or self:getGoodFeelExp(raceId)

	return GoodFeelConfig.instance:getLvByGoodFeelExp(goodFeelExp)
end

function GoodFeelModel:isMaxLv(raceId, goodFeelExp)
	local lv = GoodFeelModel.instance:getPetGoodFeelLv(raceId, goodFeelExp)
	local cfgs = GoodFeelConfig.instance:getGoodFeelExpCfgs()

	return lv >= #cfgs
end

function GoodFeelModel:getGoodFeelExp(raceId)
	local info = self:getInfo(raceId)

	return (info or nil) and info.goodFeelingExp
end

function GoodFeelModel:realSetAddExp(msg)
	local extraParams = msg.req.extraParams
	local list = GameUtil.jsonToTable(extraParams)
	local raceId = checknumber(list.ri)
	local info = self:getInfo(raceId)

	if info then
		local cfg = MaterialConfig.instance:getCfgByMatAndId(msg.req.materialType, msg.req.materialId)
		local addExp = cfg and checknumber(cfg.content) * msg.req.num or 0

		info.goodFeelingExp = info.goodFeelingExp + addExp
	end

	self:_calAndSaveStoryIds()
	self:_calUnlockLvAttrs()
end

function GoodFeelModel:fixSetAddExp(raceId, addExp)
	local info = self:getInfo(raceId)

	if info then
		info.goodFeelingExp = info.goodFeelingExp + addExp
	end

	self:_calAndSaveStoryIds()
	self:_calUnlockLvAttrs()
end

function GoodFeelModel:getTodayInteractLeftCount()
	return GoodFeelConfig.instance:getTodayInteractCount() - self._todayInteractCount
end

function GoodFeelModel:getTodayInteractUseCount()
	return self._todayInteractCount
end

function GoodFeelModel:getPetCount()
	return #self._infoList
end

function GoodFeelModel:getInfoLists()
	return self._infoList
end

function GoodFeelModel:getInfo(raceId)
	return self._infoList_KV[raceId]
end

function GoodFeelModel:getSendGiftList()
	if not self._sendGiftList then
		self._sendGiftList = {}

		local cfgs = ItemConfig.instance:getCfgs()

		for k, v in pairs(cfgs) do
			if v.subType == MatType.Item_GoodFeel then
				local matStr = string.format("%s:%s", MatType.Item, v.id)

				table.insert(self._sendGiftList, v)
			end
		end
	end

	return self._sendGiftList
end

function GoodFeelModel:getPrizeGainBit(raceId)
	local info = self:getInfo(raceId)

	return (info or nil) and info.prizeGainBit
end

function GoodFeelModel:getStoryViewBit(raceId)
	local info = self:getInfo(raceId)

	return (info or nil) and info.storyViewBit
end

function GoodFeelModel:setJumpMainViewTab(tab)
	self._jumpMainTab = tab
end

function GoodFeelModel:getJumpMainViewTab()
	return self._jumpMainTab
end

function GoodFeelModel:setGainPrizeRes(raceId, newPrizeGainBit)
	local info = self:getInfo(raceId)

	if info then
		info.prizeGainBit = newPrizeGainBit
	end
end

function GoodFeelModel:setViewStoryRes(msg)
	local info = self:getInfo(msg.raceId)

	if info then
		info.storyViewBit = msg.newStoryViewBit
	end

	self:_calAndSaveStoryIds()
	self:_calUnlockLvAttrs()
end

function GoodFeelModel:setPetShowViewCurrRaceId(raceId)
	self._currPetShowRaceId = raceId

	local petList = {}
	local pets = BagModel.instance:getPets()

	for k, pet in pairs(pets) do
		if pet:getDefineId() == raceId then
			local power = pet:getFightingPower()

			table.insert(petList, {
				pet = pet,
				power = power
			})
		end
	end

	table.sort(petList, function(a, b)
		return a.power > b.power
	end)

	local maxPowerPet = petList[1]

	if maxPowerPet then
		self._currPetShowSkinId = maxPowerPet.pet.curFaceId
	end
end

function GoodFeelModel:getPetShowViewCurrRaceId()
	return self._currPetShowRaceId, self._currPetShowSkinId
end

function GoodFeelModel:setPetShowViewCurrRaceIdList(raceIdList)
	self._petShowRaceIdList = raceIdList
end

function GoodFeelModel:getPetShowViewCurrRaceIdList()
	return self._petShowRaceIdList
end

function GoodFeelModel:changeSetPetShowViewCurrRaceId(raceId)
	self:setPetShowViewCurrRaceId(raceId)
end

function GoodFeelModel:afterHandleEventRes(msg)
	local info = self:getInfo(msg.raceId)

	if info then
		info.goodFeelingExp = msg.newGoodFeelingExp
	end

	local changeSetId = msg.changeSetId

	self._todayInteractCount = msg.todayInteractCount

	MaterialController.instance:saveChangeSetToTemp(changeSetId)

	if self._clienAnswerData then
		UIStateManager.instance:push(ViewName.GoodfeelanswerresaultView, self._clienAnswerData, changeSetId)

		self._clienAnswerData = nil
	else
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end

	self:_calUnlockLvAttrs()
end

function GoodFeelModel:afterHandleEventResByXiaoNuoAssistant(msg)
	local info = self:getInfo(msg.raceId)

	if info then
		info.goodFeelingExp = msg.newGoodFeelingExp
	end

	self._todayInteractCount = msg.todayInteractCount
end

function GoodFeelModel:setClientAnswer(isRight, selectTxt, rightTxt)
	self._clienAnswerData = {
		isRight = isRight,
		selectTxt = selectTxt,
		rightTxt = rightTxt
	}
end

function GoodFeelModel:setUnlockData(raceId, lv, skinId)
	if not raceId then
		self._currUnlockData = nil

		return
	end

	self._currUnlockData = {
		raceId = raceId,
		lv = lv,
		skinId = skinId
	}
end

function GoodFeelModel:getUnlockData()
	return self._currUnlockData
end

function GoodFeelModel:checkCanGainLvReward(raceId, calAll)
	local dot = false
	local cfg = HandbookConfig.instance:getPetDetailsCfgById(raceId)
	local list = GoodFeelConfig.instance:getPrizePlan(cfg.prizePlan)

	for i, v in ipairs(list) do
		dot = dot or self:checkCanGainLvRewardByLv(raceId, v.lv)

		if dot and not calAll then
			break
		end
	end

	local key = self:getRewardRedPointKey(raceId)

	RedPointController.instance:setRedPointInfo(key, dot, false)

	return dot
end

function GoodFeelModel:getRewardRedPointKey(raceId)
	return string.format("%s_%s_%s", RedPointModel.ID_GOODFEEL_PRE, GameEnum.GFRedType.LvReward, raceId)
end

function GoodFeelModel:checkCanGainLvRewardByLv(raceId, lv)
	local dot = false
	local info = self:getInfo(raceId)

	if info then
		local currLv = GoodFeelModel.instance:getPetGoodFeelLv(raceId, info.goodFeelingExp)
		local canGain = lv <= currLv
		local isGain = GameUtil.isBitOpenByDigit(info.prizeGainBit, lv - 1)

		dot = not isGain and canGain
	end

	local key = self:getLvRewardRedPointKey(raceId, lv)

	RedPointController.instance:setRedPointInfo(key, dot, false)

	return dot
end

function GoodFeelModel:getLvRewardRedPointKey(raceId, lv)
	return string.format("%s_%s_%s_%s", RedPointModel.ID_GOODFEEL_PRE, GameEnum.GFRedType.LvReward, raceId, lv)
end

function GoodFeelModel:checkHasNewStory(raceId)
	local dot = false
	local info = self:getInfo(raceId)

	if info then
		local currLv = GoodFeelModel.instance:getPetGoodFeelLv(raceId, info.goodFeelingExp)
		local cfg = HandbookConfig.instance:getPetDetailsCfgById(raceId)
		local cfgs = GoodFeelConfig.instance:getStroyCfgsByPlantId(cfg.storyPlan)
		local bitNum = GoodFeelModel.instance:getStoryViewBit(raceId)

		for i, v in ipairs(cfgs or {}) do
			local hasShowNewIcon = GameUtil.isBitOpenByDigit(bitNum, v.unlockLv - 1)

			if not hasShowNewIcon and currLv >= v.unlockLv then
				dot = true

				break
			end
		end
	end

	local key = self:getStoryRedPointKey(raceId)

	RedPointController.instance:setRedPointInfo(key, dot, false)

	return dot
end

function GoodFeelModel:getStoryRedPointKey(raceId)
	return string.format("%s_%s_%s", RedPointModel.ID_GOODFEEL_PRE, GameEnum.GFRedType.Stroy, raceId)
end

function GoodFeelModel:_calAdressItemsDot()
	local raceId
	local key

	for i, v in ipairs(self._infoList) do
		RedPointController.instance:setRedPointInfo(self:getAdressItemRedPointKey(v.raceId), self:checkHasNewStory(v.raceId) or self:checkCanGainLvReward(v.raceId), false)
	end
end

function GoodFeelModel:getAdressItemRedPointKey(raceId)
	return string.format("%s_%s_%s", RedPointModel.ID_GOODFEEL_PRE, GameEnum.GFRedType.AdressBookItem, raceId)
end

function GoodFeelModel:_calAndSaveStoryIds()
	self._unlockStoryIds = self._unlockStoryIds or {}

	for i, v in ipairs(self._infoList) do
		local lv = self:getPetGoodFeelLv(v.raceId, v.goodFeelingExp)
		local cfg = HandbookConfig.instance:getPetDetailsCfgById(v.raceId)
		local planCfgs = GoodFeelConfig.instance:getStroyCfgsByPlantId(cfg.storyPlan)

		if planCfgs then
			for k, v1 in pairs(planCfgs) do
				if lv >= v1.unlockLv and not self._unlockStoryIds[v1.storyId] then
					local bitNum = v.storyViewBit
					local hasShowNewIcon = GameUtil.isBitOpenByDigit(bitNum, v1.unlockLv - 1)

					if hasShowNewIcon then
						self._unlockStoryIds[v1.storyId] = true
					end
				end
			end
		end
	end
end

function GoodFeelModel:_calUnlockLvAttrs()
	self._raceId2UnlockLv = self._raceId2UnlockLv or {}

	local hasLvUp = false

	for i, v in ipairs(self._infoList) do
		local lv = self:getPetGoodFeelLv(v.raceId, v.goodFeelingExp)

		if not hasLvUp and (not self._raceId2UnlockLv[v.raceId] or lv > self._raceId2UnlockLv[v.raceId]) then
			local minLv, maxLv = GoodFeelConfig.instance:getMinAndMaxPropLvByRaceId(v.raceId)

			if minLv <= lv and lv <= maxLv + 5 then
				hasLvUp = true
			end
		end

		self._raceId2UnlockLv[v.raceId] = lv
	end

	if hasLvUp then
		self:_updateAddAttrs()
	end
end

function GoodFeelModel:_updateAddAttrs()
	self:calcGoodFeelingAttrs()
	BagPetsController.instance:calcAllPetGoodfellingAttr()
	GlobalDispatcher:dispatch(GoodFeelController.UpdateUnlockStory)
end

function GoodFeelModel:calcGoodFeelingAttrs()
	local res = {}

	for raceId, unlockLv in pairs(self._raceId2UnlockLv) do
		local attrs = self:_getOneAttrs(raceId, unlockLv)

		res = AttrMo.addSameAttrs(attrs, res)
	end

	self._cacheAllGoodFeelingAttrs = res

	return res
end

function GoodFeelModel:getCacheCalcGoodFeelingAttrs()
	return self._cacheAllGoodFeelingAttrs
end

function GoodFeelModel:calcOtherGoodFeelingAttrs(petMo)
	local res = {}

	if petMo and petMo.goodFeelingInfos then
		for i, v in ipairs(petMo.goodFeelingInfos) do
			local attrs = self:_getOneAttrs(v.raceId, v.level)

			res = AttrMo.addSameAttrs(attrs, res)
		end
	end

	return res
end

function GoodFeelModel:_getOneAttrs(raceId, unlockLv)
	self._oneAttrCaceh_raceId_unlockLv = self._oneAttrCaceh_raceId_unlockLv or {}

	local key = raceId .. "@" .. unlockLv
	local res = self._oneAttrCaceh_raceId_unlockLv[key]

	if res then
		return res
	end

	res = {}

	local attrs = {}
	local detailCfg = HandbookConfig.instance:getPetDetailsCfgById(raceId)
	local cfgs = GoodFeelConfig.instance:getLvPropCfgs(detailCfg.propertyPlan) or {}

	for k, v in pairs(cfgs) do
		if unlockLv >= v.unlockLv then
			self._propertyAppCache = self._propertyAppCache or {}
			attrs = self._propertyAppCache[v.propertyApp]

			if not self._propertyAppCache[v.propertyApp] then
				attrs = FightingPowerFormula.instance:parseAttrValues(v.propertyApp)
				self._propertyAppCache[v.propertyApp] = attrs
			end

			res = AttrMo.addSameAttrs(attrs, res)
		end
	end

	self._oneAttrCaceh_raceId_unlockLv[key] = res

	return res
end

function GoodFeelModel:getMaxUnlockPropLv(raceId)
	return self._raceId2UnlockLv[raceId] or 0
end

function GoodFeelModel:getRandomBubbleList(raceId, skinId)
	local list = self._randomBubbleList[skinId]

	if not list then
		list = {}

		local cvCfgs = CharacterConfig.instance:getPetCvCfg(skinId) or {}

		for k, v in pairs(cvCfgs) do
			if v.isGoodFeelTouch == 1 then
				table.insert(list, v)
			end
		end

		if #list <= 0 then
			local cvCfgs = CharacterConfig.instance:getPetCvCfg(raceId) or {}

			for k, v in pairs(cvCfgs) do
				if v.isGoodFeelTouch == 1 then
					table.insert(list, v)
				end
			end

			self._randomBubbleList[raceId] = list
		else
			self._randomBubbleList[skinId] = list
		end
	end

	return list
end

function GoodFeelModel:getRandomLvupList(raceId, skinId)
	local list = self._randomLvupList[skinId]

	if not list then
		list = {}

		local cvCfgs = CharacterConfig.instance:getPetCvCfg(skinId) or {}

		for k, v in pairs(cvCfgs) do
			if v.isGoodFeelLvUp == 1 then
				table.insert(list, v)
			end
		end

		if #list <= 0 then
			local cvCfgs = CharacterConfig.instance:getPetCvCfg(raceId) or {}

			for k, v in pairs(cvCfgs) do
				if v.isGoodFeelLvUp == 1 then
					table.insert(list, v)
				end
			end

			self._randomLvupList[raceId] = list
		else
			self._randomLvupList[skinId] = list
		end
	end

	return list
end

function GoodFeelModel:getLvAttrValueByAttrType(attrId)
	local value = 0

	for raceId, unlockLv in pairs(self._raceId2UnlockLv) do
		value = value + (self:_getOneAttrs(raceId, unlockLv)[attrId] or 0)
	end

	return value
end

function GoodFeelModel:setCachePetInfo(raceId, list, addExp)
	self._cachePetInfo.raceId = raceId
	self._cachePetInfo.list = list
	self._cachePetInfo.addExp = addExp
end

function GoodFeelModel:getCachePetInfo()
	return self._cachePetInfo
end

GoodFeelModel.instance = GoodFeelModel.New()

return GoodFeelModel
