-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/model/IslandStationModel.lua

module("logic.extensions.islandstation.model.IslandStationModel", package.seeall)

local IslandStationModel = class("IslandStationModel", BaseModel)

function IslandStationModel:ctor()
	return
end

function IslandStationModel:onInit()
	self:onReset()
end

function IslandStationModel:onReset()
	self._infos = {}
	self._bossInfos = {}
	self._shopInfo = {}
	self._girlInfo = {}
	self._stuffInfos = {}
	self._foodInfos = {}
	self._clientKeys = {}
	self._serverKeys = {}
	self._customFmtMoPool = {}
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._hasChallengeBodss = false
end

function IslandStationModel:setChallengeBoss(isChallenge)
	self._hasChallengeBodss = isChallenge
end

function IslandStationModel:getInfo(activityId)
	return self._infos[activityId]
end

function IslandStationModel:getBossInfo(activityId)
	return self._bossInfos[activityId]
end

function IslandStationModel:getShopInfo(activityId)
	return self._shopInfo[activityId]
end

function IslandStationModel:getShelfInfo(activityId, shopId, posId)
	local shopInfoDic = self._shopInfo[activityId]
	local shopInfo = shopInfoDic[shopId]

	return shopInfo.shelfPosInfo[posId]
end

function IslandStationModel:getShopInfoByShopId(activityId, shopId)
	return self._shopInfo[activityId] and self._shopInfo[activityId][shopId]
end

function IslandStationModel:getGrilInfo(activityId)
	return self._girlInfo[activityId]
end

function IslandStationModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = IslandStationFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function IslandStationModel:handlePM_IslandStationInfoRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._infos[msg.activityId] = pb
	self._shopInfo[msg.activityId] = self._shopInfo[msg.activityId] or {}
	self._girlInfo[msg.activityId] = self._girlInfo[msg.activityId] or {}
	self._stuffInfos[msg.activityId] = self._stuffInfos[msg.activityId] or {}
	self._foodInfos[msg.activityId] = self._foodInfos[msg.activityId] or {}

	if pb.shopInfo then
		local shopInfoDic = self._shopInfo[msg.activityId]

		for i, info in ipairs(pb.shopInfo) do
			info.shelfPosInfo = info.shelfPosInfo or {}
			shopInfoDic[info.shopId] = info

			if info.shelfPosInfo then
				local shelfPosInfoDic = {}

				for i, shelfInfo in pairs(info.shelfPosInfo) do
					shelfPosInfoDic[shelfInfo.posId] = shelfInfo
				end

				shopInfoDic[info.shopId].shelfPosInfo = shelfPosInfoDic
			end
		end
	end

	if pb.girlInfo then
		if not self._girlInfo[msg.activityId] then
			do
				local grilInfoDic = {}

				for i, info in ipairs(pb.girlInfo) do
					info.curDialogueAnswers = info.curDialogueAnswers or {}
					grilInfoDic[info.girlId] = info
				end
			end

			local curFoodDic = self._foodInfos[msg.activityId]

			if pb.foodInfo then
				for i, pair in ipairs(pb.foodInfo.idAndNum) do
					curFoodDic[pair.left] = pair.right
				end
			end

			local curStuffDic = self._stuffInfos[msg.activityId]

			if pb.stuffInfo then
				for i, pair in ipairs(pb.stuffInfo.idAndNum) do
					curStuffDic[pair.left] = pair.right
				end
			end
		end
	end
end

function IslandStationModel:handlePM_IslandStationOneKeyFullFillRes(msg)
	local shopInfoDic = self._shopInfo[msg.activityId]
	local shopInfo = shopInfoDic[msg.shopId]

	if msg.posInfo then
		for k, posInfo in pairs(msg.posInfo) do
			local shelfPosId = posInfo.posId

			if shelfPosId then
				if posInfo.deleted then
					shopInfo.shelfPosInfo[shelfPosId] = nil
				else
					shopInfo.shelfPosInfo[shelfPosId] = posInfo
				end
			end
		end
	end
end

function IslandStationModel:handlePM_IslandStationPutOrChangeFoodRes(msg)
	local pb = GameUtil.pbToTable(msg)
	local info = self._infos[pb.activityId]
	local shopInfoDic = self._shopInfo[pb.activityId]
	local shopInfo = shopInfoDic[pb.shopId]

	info.foodChangeSet = pb.foodChangeSet

	local shelfPosId = pb.posInfo.posId

	shopInfo.shelfPosInfo[shelfPosId] = pb.posInfo
end

function IslandStationModel:handlePM_IslandStationMakeFoodRes(msg)
	local curFoodDic = self._foodInfos[msg.activityId]
	local curStuffDic = self._stuffInfos[msg.activityId]

	if msg.decStuffInfo.idAndNum then
		for k, pair in pairs(msg.decStuffInfo.idAndNum) do
			if pair.left and pair.right then
				curStuffDic[pair.left] = checknumber(curStuffDic[pair.left]) + pair.right
			end
		end
	end

	if msg.incFoodInfo.idAndNum then
		for k, pair in pairs(msg.incFoodInfo.idAndNum) do
			if pair.left and pair.right then
				curFoodDic[pair.left] = checknumber(curFoodDic[pair.left]) + pair.right
			end
		end
	end
end

function IslandStationModel:handlePM_IslandStationStartGameRes(msg)
	self._serverKeys[msg.activityId] = msg.serverKey
end

function IslandStationModel:handlePM_IslandStationEndGameRes(msg)
	local pb = GameUtil.pbToTable(msg)
	local info = self._infos[msg.activityId]
	local curStuffDic = self._stuffInfos[msg.activityId]

	info.todayGameTimes = msg.todayGameTimes

	if pb.stuffPrizeInfo then
		local items = {}

		for k, pair in pairs(pb.stuffPrizeInfo.idAndNum) do
			local hasNum = checknumber(curStuffDic[pair.left])

			curStuffDic[pair.left] = hasNum + pair.right

			local cfg = IslandStationConfig.instance:getFoodStuffCfgById(msg.activityId, pair.left)
			local arr = string.split(cfg.materialStr, ":")
			local matType = checknumber(arr[1])
			local matId = checknumber(arr[2])
			local matNum = checknumber(arr[#arr])
			local itemMo = MaterialMo.New()

			itemMo:initData(matType, matId, matNum * pair.right)
			MaterialModel.instance:UpdateMaterial(matType, matId, itemMo:GetCount())
			table.insert(items, {
				materialType = matType,
				id = matId,
				num = itemMo:GetCount()
			})
		end

		if #items > 0 then
			local obj = {}

			obj.items = items

			UIStateManager.instance:open(ViewName.ItemGet, obj)
		end
	end
end

function IslandStationModel:handlePM_IslandStationGetBossInfoRes(msg)
	self._bossInfos[msg.activityId] = GameUtil.pbToTable(msg)
end

function IslandStationModel:handlePM_Notify_IslandStationChallengeResult(msg)
	local pb = GameUtil.pbToTable(msg)

	self._bossInfos[msg.activityId] = pb

	local curStuffDic = self._stuffInfos[msg.activityId]

	if pb.stuffPrizeInfo and pb.stuffPrizeInfo.idAndNum then
		for i, pair in ipairs(pb.stuffPrizeInfo.idAndNum) do
			if pair.left and pair.right then
				curStuffDic[pair.left] = checknumber(curStuffDic[pair.left]) + pair.right
			end
		end
	end
end

function IslandStationModel:handlePM_IslandStationSelectAnswerRes(msg)
	if checknumber(msg.curFetter) ~= 0 then
		self._girlInfo[msg.activityId][msg.girlId] = self._girlInfo[msg.activityId][msg.girlId] or {}
		self._girlInfo[msg.activityId][msg.girlId].fetter = checknumber(msg.curFetter)
	end
end

function IslandStationModel:handlePM_IslandStationGainCollectSkinPrizeRes(msg)
	local info = self._infos[msg.activityId]

	info.gainCollectSkinPrize = true
end

function IslandStationModel:getClientKey(activityId)
	local clientKey = math.random(1, ServerTime.now()) + activityId
	local info = self:getInfo(activityId)

	self._clientKeys[activityId] = clientKey

	return clientKey
end

function IslandStationModel:getEncryptedKey(activityId, stageId, score)
	local info = self:getInfo(activityId)
	local serverKey = self._serverKeys[activityId]

	return (GameUtil.getClientEncryptedKey(self._clientKeys[activityId], serverKey, {
		activityId,
		stageId,
		score
	}))
end

function IslandStationModel:getSellingFoodIdList(activityId, shopId)
	local shopInfo = self._shopInfo[activityId][shopId]
	local shelfInfos = shopInfo and shopInfo.shelfPosInfo
	local foodIdList = {}

	if shelfInfos then
		for i, shelfInfo in ipairs(shelfInfos) do
			table.insert(foodIdList, shelfInfo.foodId)
		end
	end

	return foodIdList
end

function IslandStationModel:getFoodNumDic(activityId)
	return self._foodInfos[activityId]
end

function IslandStationModel:getStuffNum(activityId, stuffId)
	local stuffNumDic = self._stuffInfos[activityId]

	if stuffNumDic then
		return checknumber(stuffNumDic[stuffId])
	end

	return 0
end

function IslandStationModel:getGirlFetter(activityId, girlId)
	local girlInfoDic = self._girlInfo[activityId]

	if girlInfoDic then
		for infoGirlId, info in pairs(girlInfoDic) do
			if infoGirlId == girlId then
				return checknumber(info.fetter)
			end
		end
	end

	return 0
end

function IslandStationModel:getGoddessShopMo(activityId)
	self._moPool[activityId] = self._moPool[activityId] or IslandStationMo.New(activityId)

	return self._moPool[activityId]
end

IslandStationModel.instance = IslandStationModel.New()

return IslandStationModel
