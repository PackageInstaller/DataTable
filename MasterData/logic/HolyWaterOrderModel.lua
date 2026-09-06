-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/model/HolyWaterOrderModel.lua

module("logic.extensions.holywaterorder.model.HolyWaterOrderModel", package.seeall)

local HolyWaterOrderModel = class("HolyWaterOrderModel", BaseModel)

HolyWaterOrderModel.SelectPet = 1
HolyWaterOrderModel.LookOverPet = 2
HolyWaterOrderModel.SortKey = "HolyWaterOrderSelectView_SortKey"

function HolyWaterOrderModel:ctor()
	return
end

function HolyWaterOrderModel:onInit()
	self:onReset()
end

function HolyWaterOrderModel:onReset()
	self._activityId = 292001
	self._stages = {}
	self._petInfo = {}
	self._dailyRankIndex = nil
	self._historyMaxStars = 0
	self._battleRes = nil
	self._randomNumber = nil
	self._activityRankInfos = {}
	self._activityMyRank = -1
	self._dailyRankInfos = {}
	self._dailyMyRank = -1
	self._customFmtMo = nil
end

function HolyWaterOrderModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = HolyWaterOrderCustomFmtMo.New()
	end

	return self._customFmtMo
end

function HolyWaterOrderModel:onInfoRes(msg)
	self._stages = GameUtil.pbToTable(msg.stages) or {}
	self._petInfo = GameUtil.pbToTable(msg.petInfo) or {}
	self._dailyRankIndex = msg:HasField("dailyRankIndex") and msg.dailyRankIndex or nil
	self._historyMaxStars = msg.historyMaxStars
end

function HolyWaterOrderModel:onSelectPetsRes(petIds)
	self._petInfo = {}

	if petIds then
		for i, v in ipairs(petIds) do
			local element = {}

			element.petId = v
			element.hp = -1

			table.insert(self._petInfo, element)
		end
	end
end

function HolyWaterOrderModel:onChallengeRes(msg)
	return
end

function HolyWaterOrderModel:onResetRes(msg)
	self._stages = {}
	self._petInfo = {}
end

function HolyWaterOrderModel:onConfirmRecordRes(msg)
	if msg:HasField("battleRes") then
		self._battleRes = msg.battleRes

		if msg.battleRes.win then
			self:_updateStages(msg.battleRes.stageId, msg.battleRes.baseStar, msg.battleRes.extraStar)
			self:_updatePetHps(msg.battleRes.battlePetHps)
		end
	elseif self._battleRes and self._battleRes.win then
		self:_updateStages(self._battleRes.stageId, self._battleRes.baseStar, self._battleRes.extraStar)
		self:_updatePetHps(self._battleRes.battlePetHps)
	end
end

function HolyWaterOrderModel:onNotifyChallengeResultRes(msg)
	if msg:HasField("battleRes") then
		self._battleRes = msg.battleRes
	end

	if msg:HasField("randomNumber") then
		self._randomNumber = msg.randomNumber
	end
end

function HolyWaterOrderModel:onActivityRankRes(msg)
	self._activityRankInfos = GameUtil.pbToTable(msg.rankInfos) or {}
	self._activityMyRank = msg.myRank
end

function HolyWaterOrderModel:onDailyRankRes(msg)
	self._dailyRankInfos = GameUtil.pbToTable(msg.rankInfos) or {}
	self._dailyMyRank = msg.myRank
end

function HolyWaterOrderModel:_updateStages(stageId, baseStar, extraStar)
	local isExist = false

	for i, v in ipairs(self._stages) do
		if v.stageId == stageId then
			isExist = true
			v.star = baseStar or 0
			v.extraStar = extraStar
		end
	end

	if not isExist then
		local element = {}

		element.stageId = stageId
		element.star = baseStar or 0
		element.extraStar = extraStar

		table.insert(self._stages, element)
		table.sort(self._stages, function(a, b)
			return a.stageId < b.stageId
		end)
	end
end

function HolyWaterOrderModel:_updatePetHps(battlePetHps)
	if battlePetHps then
		for i1, v1 in ipairs(battlePetHps) do
			for i2, v2 in ipairs(self._petInfo) do
				if v1.petId == v2.petId then
					v2.hp = v1.hp

					break
				end
			end
		end
	end
end

function HolyWaterOrderModel:getActivityId()
	return self._activityId
end

function HolyWaterOrderModel:getActivityType()
	return GameEnum.ActivityType.HolyWaterOrder
end

function HolyWaterOrderModel:getActivityRanks()
	return self._activityRankInfos
end

function HolyWaterOrderModel:getActivityMyRank()
	return self._activityMyRank
end

function HolyWaterOrderModel:getDailyRanks()
	return self._dailyRankInfos
end

function HolyWaterOrderModel:getDailyMyRank()
	return self._dailyMyRank
end

function HolyWaterOrderModel:getPetInfoList()
	local list = {}

	for i, v in ipairs(self._petInfo) do
		local petMo = BagPetsController.instance:getPet(v.petId)

		if petMo then
			local element = {}

			element.petMo = petMo
			element.hp = v.hp

			table.insert(list, element)
		end
	end

	return list
end

function HolyWaterOrderModel:isSelectedPet()
	return self._petInfo and #self._petInfo > 0
end

function HolyWaterOrderModel:getPassStageNum()
	local count = 0

	for i, v in ipairs(self._stages) do
		if v.star > 0 then
			count = count + 1
		else
			break
		end
	end

	return count
end

function HolyWaterOrderModel:getTotalStarNum()
	local count = 0

	for i, v in ipairs(self._stages) do
		if v.star > 0 then
			count = count + v.star

			if v.extraStar then
				count = count + 1
			end
		else
			break
		end
	end

	return count
end

function HolyWaterOrderModel:getStarNum(stageId)
	local count = 0

	for i, v in ipairs(self._stages) do
		if v.stageId == stageId then
			count = count + v.star

			if v.extraStar then
				count = count + 1
			end

			break
		end
	end

	return count
end

function HolyWaterOrderModel:isStagePass(stageId)
	for i, v in ipairs(self._stages) do
		if v.stageId == stageId then
			return v.star > 0
		end
	end

	return false
end

function HolyWaterOrderModel:isPetLock(petId)
	local isLock = false

	for i, v in ipairs(self._petInfo) do
		if v.petId == petId and v.hp == 0 then
			isLock = true

			break
		end
	end

	return isLock
end

function HolyWaterOrderModel:getPetHp(petId)
	for i, v in ipairs(self._petInfo) do
		if v.petId == petId then
			return v.hp
		end
	end

	return 0
end

function HolyWaterOrderModel:getRandomNumber()
	return self._randomNumber
end

function HolyWaterOrderModel:getBattleResultPetInfos()
	if self._battleRes and self._battleRes.battlePetHps then
		return self._battleRes.battlePetHps
	end

	return {}
end

function HolyWaterOrderModel:getBattleResultStageId()
	if self._battleRes and self._battleRes.stageId then
		return self._battleRes.stageId
	end

	return 0
end

function HolyWaterOrderModel:getBattleResultStars()
	if self._battleRes and self._battleRes.baseStar then
		local num = checknumber(self._battleRes.baseStar)

		if self._battleRes.extraStar then
			num = num + 1
		end

		return num
	end

	return 0
end

function HolyWaterOrderModel:getHistoryMaxStars()
	return self._historyMaxStars
end

function HolyWaterOrderModel:isFirstGetRank()
	return self._dailyRankIndex ~= nil
end

function HolyWaterOrderModel:getDailyRankIndex()
	return self._dailyRankIndex
end

HolyWaterOrderModel.instance = HolyWaterOrderModel.New()

return HolyWaterOrderModel
