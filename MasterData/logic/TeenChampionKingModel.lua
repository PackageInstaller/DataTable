-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/model/TeenChampionKingModel.lua

module("logic.extensions.teenchampionking.model.TeenChampionKingModel", package.seeall)

local TeenChampionKingModel = class("TeenChampionKingModel", BaseModel)

function TeenChampionKingModel:onInit()
	self:onReset()
end

function TeenChampionKingModel:onReset()
	self._globalInfoMap = {}
	self._battleRecordInfoMap = {}
	self._rankInfoMap = {}
	self._petRankInfoMap = {}
	self._qualifierInfoMap = {}
	self._knockoutScheduleInfoMap = {}
	self._myKnockoutInfoMap = {}
	self._knockoutScheduleMap = {}
	self._displayInfoMap = {}
	self._guessRecordInfoMap = {}
	self._championshipGuessRecordInfoMap = {}
	self._inRoomUserIds = {}
end

function TeenChampionKingModel:getGlobalInfo(activityId)
	if not self._globalInfoMap[activityId] then
		print("少年竞技王S2数据未初始化")
	end

	return self._globalInfoMap[activityId]
end

function TeenChampionKingModel:getBattleRecordInfo(activityId)
	if not self._battleRecordInfoMap[activityId] then
		print("少年竞技王S2战报数据未初始化")
	end

	return self._battleRecordInfoMap[activityId]
end

function TeenChampionKingModel:getRankInfo(activityId, stepId, zoneId)
	local key = string.format("%s--%s--%s", activityId, stepId, zoneId)

	if not self._rankInfoMap[key] then
		print("少年竞技王S2排行榜数据未初始化")
	end

	return self._rankInfoMap[key]
end

function TeenChampionKingModel:getPetRankInfo(activityId, stepId, winRank)
	local subId = winRank and 1 or 0
	local key = string.format("%s--%s--%s", activityId, stepId, subId)

	if not self._petRankInfoMap[key] then
		print("少年竞技王S2精灵排行榜数据未初始化")
	end

	return self._petRankInfoMap[key]
end

function TeenChampionKingModel:getQualifierInfo(activityId, stepId)
	local key = string.format("%s--%s", activityId, stepId)

	if not self._qualifierInfoMap[key] then
		print("少年竞技王S2精灵预赛数据未初始化")
	end

	return self._qualifierInfoMap[key]
end

function TeenChampionKingModel:getMyKnockoutInfo(activityId)
	if not self._myKnockoutInfoMap[activityId] then
		print("少年竞技王S2我的賽程数据未初始化")
	end

	return self._myKnockoutInfoMap[activityId]
end

function TeenChampionKingModel:getKnockoutScheduleInfo(activityId, viewGroupId, roundId)
	local key = string.format("%s--%s--%s", activityId, viewGroupId, roundId)

	if not self._knockoutScheduleInfoMap[key] then
		print("少年竞技王S2賽程数据未初始化")
	end

	return self._knockoutScheduleInfoMap[key]
end

function TeenChampionKingModel:getDisplayInfo(activityId)
	if not self._displayInfoMap[activityId] then
		print("少年竞技王S2赛果数据未初始化")
	end

	return self._displayInfoMap[activityId]
end

function TeenChampionKingModel:getKnockoutGuessRecord(activityId, roundId)
	local key = string.format("%s--%s", activityId, roundId)

	if not self._guessRecordInfoMap[key] then
		print("少年竞技王S2应援数据未初始化")
	end

	return self._guessRecordInfoMap[key]
end

function TeenChampionKingModel:getChampionshipGuessRecordInfo(activityId)
	if not self._championshipGuessRecordInfoMap[activityId] then
		print("少年竞技王S2决赛应援数据未初始化")
	end

	return self._championshipGuessRecordInfoMap[activityId]
end

function TeenChampionKingModel:getInRoomUserIds()
	return self._inRoomUserIds
end

function TeenChampionKingModel:resetInRoomUserIds()
	self._inRoomUserIds = {}
end

function TeenChampionKingModel:checkPetIdIsExist(petId)
	if petId > 0 then
		local syspetCfg = TeenChampionKingConfig.instance:getSystemPetByCreepsId(petId)

		if syspetCfg then
			return true
		end

		if BagPetsController.instance:getPet(petId) then
			return true
		end
	end

	return false
end

function TeenChampionKingModel:onGetGlobalInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._globalInfoMap[info.activityId] = info

	if not info.selectPetIds then
		local temPets = {}

		for i, petId in ipairs(info.selectPetIds) do
			if self:checkPetIdIsExist(petId) then
				table.insert(temPets, petId)
			end
		end

		info.selectPetIds = temPets
	end
end

function TeenChampionKingModel:onNotifyStepChange(msg)
	local globalInfo = self:getGlobalInfo(msg.activityId)

	if globalInfo then
		globalInfo.curStepId = msg.curStepId
	end
end

function TeenChampionKingModel:onGetBattleRecord(msg)
	local info = GameUtil.pbToTable(msg)

	self._battleRecordInfoMap[info.activityId] = info
end

function TeenChampionKingModel:onSelectPets(msg)
	local info = GameUtil.pbToTable(msg)
	local globalInfo = self:getGlobalInfo(info.activityId)

	if globalInfo then
		if not info.selectPetIds then
			local temPets = {}

			for i, petId in ipairs(info.selectPetIds) do
				if self:checkPetIdIsExist(petId) then
					table.insert(temPets, petId)
				end
			end

			globalInfo.selectPetIds = temPets
			globalInfo.useSysProperty = info.useSysProperty
		end
	end
end

function TeenChampionKingModel:onGainGuessCoin(msg)
	local globalInfo = self:getGlobalInfo(msg.activityId)

	if globalInfo then
		globalInfo.gainDailyCoin = true
	end
end

function TeenChampionKingModel:onGetQualifierInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local stepId = info.stepId
	local key = string.format("%s--%s", activityId, stepId)

	self._qualifierInfoMap[key] = info
end

function TeenChampionKingModel:onUpdateRankView(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local zoneId = info.zoneId
	local stepId = info.stepId
	local key = string.format("%s--%s--%s", activityId, stepId, zoneId)

	self._rankInfoMap[key] = info
end

function TeenChampionKingModel:onUpdatePetRankView(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local stepId = info.stepId
	local subId = info.winRank and 1 or 0
	local key = string.format("%s--%s--%s", activityId, stepId, subId)

	self._petRankInfoMap[key] = info
end

function TeenChampionKingModel:onGetMyKnockoutInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._myKnockoutInfoMap[activityId] = info
end

function TeenChampionKingModel:onGetKnockoutSchedule(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local viewGroupId = info.viewGroupId
	local roundId = info.roundId
	local key = string.format("%s--%s--%s", activityId, viewGroupId, roundId)

	self._knockoutScheduleInfoMap[key] = info
end

function TeenChampionKingModel:onGetDisplayInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._displayInfoMap[activityId] = info
end

function TeenChampionKingModel:onGetKnockoutGuessRecord(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local roundId = info.roundId
	local key = string.format("%s--%s", activityId, roundId)

	self._guessRecordInfoMap[key] = info
end

function TeenChampionKingModel:onChangeGuessRank(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	if not self._championshipGuessRecordInfoMap[activityId] then
		if not info.guessPlayerIds then
			self._championshipGuessRecordInfoMap[activityId].guessRankPlayerIds = {}
			self._championshipGuessRecordInfoMap[activityId] = self._championshipGuessRecordInfoMap[activityId]
		end
	end
end

function TeenChampionKingModel:onGetChampionshipGuessRecord(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._championshipGuessRecordInfoMap[activityId] = info
end

function TeenChampionKingModel:onGetKnockoutJoinRoomInfo(msg)
	local info = GameUtil.pbToTable(msg)

	if not info.inRoomUserIds then
		self._inRoomUserIds = {}

		for _, userId in ipairs(info.inRoomUserIds) do
			table.insert(self._inRoomUserIds, checknumber(userId))
		end
	end
end

function TeenChampionKingModel:onknockoutJoinRoom(msg)
	local myUserId = checknumber(RoleModel.instance:getUserId())

	self._inRoomUserIds = self._inRoomUserIds or {}

	table.insert(self._inRoomUserIds, myUserId)
end

function TeenChampionKingModel:onKnockoutLeaveRoom(msg)
	self._inRoomUserIds = self._inRoomUserIds or {}

	local myUserId = checknumber(RoleModel.instance:getUserId())

	table.removebyvalue(self._inRoomUserIds, myUserId, true)
end

function TeenChampionKingModel:onNotifyYCKKnockoutOpJoinRoom(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local myKnockoutInfo = self:getMyKnockoutInfo(activityId)

	if myKnockoutInfo then
		local opUserId = checknumber(myKnockoutInfo.knockoutInfo.opponent.headInfo.headInfo.userId)

		if info.join then
			table.insert(self._inRoomUserIds, opUserId)
		else
			table.removebyvalue(self._inRoomUserIds, opUserId, true)
		end
	end
end

TeenChampionKingModel.instance = TeenChampionKingModel.New()

return TeenChampionKingModel
