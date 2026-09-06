-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/model/SurvivalKingModel.lua

module("logic.extensions.survivalking.model.SurvivalKingModel", package.seeall)

local SurvivalKingModel = class("SurvivalKingModel", BaseModel)

function SurvivalKingModel:onInit()
	self:onReset()
end

function SurvivalKingModel:onReset()
	self._baseInfoMap = {}
	self._rankInfoMap = {}
	self._prizeInfoMap = {}
	self._defFormInfoMap = {}
	self._defBuffsMap = {}
	self._levelBuffSelectionMap = {}
	self._levelBuffLevelMap = {}
	self._buffNumMap = {}
	self._battleRecordInfoMap = {}
	self._roomInfoMap = {}
end

function SurvivalKingModel:onGetBaseInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._baseInfoMap[activityId] = info

	local buffNumMap = {}

	if not info.buffs then
		for _, buff in ipairs(info.buffs) do
			buffNumMap[buff.buffId] = buff.num
		end

		self._buffNumMap[activityId] = buffNumMap
		self._levelBuffLevelMap[activityId] = checknumber(info.levelBuffLevel) > 0 and checknumber(info.levelBuffLevel) or 1
	end
end

function SurvivalKingModel:onGetRankInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._rankInfoMap[activityId] = info
end

function SurvivalKingModel:onGetPrizeInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._prizeInfoMap[activityId] = info
end

function SurvivalKingModel:onGainPrize(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local prizeInfo = self._prizeInfoMap[activityId]

	if prizeInfo then
		prizeInfo.prizes = {}
	end
end

function SurvivalKingModel:onGetPresetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local defFormInfoMap = {}
	local defBuffsMap = {}
	local levelBuffSelectionMap = {}

	if not info.groups then
		for _, group in ipairs(info.groups) do
			defFormInfoMap[group.groupId] = group.simpleForm

			if not group.buffId then
				local buffIds = {}

				for _, buff in ipairs(buffIds) do
					defBuffsMap[buff.left] = buff.right
				end
			end
		end

		if not info.levelBuffId then
			for _, buff in ipairs(info.levelBuffId) do
				levelBuffSelectionMap[buff.left] = buff.right
			end

			self._defBuffsMap[activityId] = defBuffsMap
			self._levelBuffSelectionMap[activityId] = levelBuffSelectionMap
			self._defFormInfoMap[activityId] = defFormInfoMap
		end
	end
end

function SurvivalKingModel:onSetPresetInfo(msg)
	return
end

function SurvivalKingModel:onGetBattleRecord(msg)
	local info = GameUtil.pbToTable(msg)

	self._battleRecordInfoMap[info.activityId] = info
end

function SurvivalKingModel:onSignUp(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self._baseInfoMap[activityId]

	if baseInfo then
		baseInfo.signUps = info.signUps
	end
end

function SurvivalKingModel:onBuyBuff(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self._baseInfoMap[activityId]

	if baseInfo then
		if not self._buffNumMap[activityId] then
			if not self._buffNumMap[activityId][info.buffId] then
				local buffNum = 0

				buffNum = buffNum + info.num
				self._buffNumMap[activityId][info.buffId] = buffNum
				self._buffNumMap[activityId] = self._buffNumMap[activityId]
			end
		end
	end
end

function SurvivalKingModel:onGetRoomInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local sessionId = info.sessionId
	local roomInfo = info.room

	if not self._roomInfoMap[activityId] then
		self._roomInfoMap[activityId][sessionId] = roomInfo
		self._roomInfoMap[activityId] = self._roomInfoMap[activityId]
	end
end

function SurvivalKingModel:getBaseInfo(activityId)
	return self._baseInfoMap[activityId]
end

function SurvivalKingModel:getRankInfo(activityId)
	return self._rankInfoMap[activityId]
end

function SurvivalKingModel:getPrizeInfo(activityId)
	return self._prizeInfoMap[activityId]
end

function SurvivalKingModel:getDefFormInfos(activityId)
	return self._defFormInfoMap[activityId]
end

function SurvivalKingModel:getDefFormInfo(activityId, groupId)
	local defFormInfoMap = self:getDefFormInfos(activityId)

	if not defFormInfoMap then
		return nil
	end

	return defFormInfoMap[groupId]
end

function SurvivalKingModel:getDefBuffs(activityId)
	local defBuffsMap = self._defBuffsMap[activityId]

	if not defBuffsMap then
		return nil
	end

	return defBuffsMap
end

function SurvivalKingModel:getLevelBuffSelections(activityId)
	return self._levelBuffSelectionMap[activityId] or {}
end

function SurvivalKingModel:getLevelBuffId(activityId, roundId)
	local selectionMap = self:getLevelBuffSelections(activityId)

	return selectionMap[roundId] or 0
end

function SurvivalKingModel:getLevelBuffLevel(activityId)
	return self._levelBuffLevelMap[activityId] or 1
end

function SurvivalKingModel:getBattleRecordInfo(activityId)
	return self._battleRecordInfoMap[activityId]
end

function SurvivalKingModel:getBuffNum(activityId, buffId)
	local buffNumMap = self._buffNumMap[activityId]

	if not buffNumMap then
		return 0
	end

	return buffNumMap[buffId] or 0
end

function SurvivalKingModel:getRoomInfo(activityId, sessionId)
	local roomInfoMap = self._roomInfoMap[activityId]

	if not roomInfoMap then
		return nil
	end

	return roomInfoMap[sessionId]
end

function SurvivalKingModel:isAllEmptyForm(activityId)
	local defFormInfoMap = self:getDefFormInfos(activityId)

	if not defFormInfoMap then
		return true
	end

	for groupId, fromInfo in pairs(defFormInfoMap) do
		if not fromInfo.pos then
			for _, v in ipairs(fromInfo.pos) do
				if v > 0 then
					return false
				end
			end
		end
	end

	return true
end

SurvivalKingModel.instance = SurvivalKingModel.New()

return SurvivalKingModel
