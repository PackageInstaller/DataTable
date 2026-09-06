-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/model/DoushouqiModel.lua

module("logic.extensions.doushouqi.view.DoushouqiModel", package.seeall)

local DoushouqiModel = class("DoushouqiModel", BaseModel)

function DoushouqiModel:ctor()
	return
end

function DoushouqiModel:onInit()
	self:onReset()
end

function DoushouqiModel:onReset()
	self._typeInfos = {}
	self._mySideId = -1
	self._nextMapInfo = nil
end

function DoushouqiModel:setBaseInfo(msg)
	msg = GameUtil.pbToTable(msg)
	self._baseInfo = msg
	self._typeInfos = {}

	self:setMySkillId(msg.skillId)

	for i, v in ipairs(msg.types) do
		v.gainedPrizeIds = v.gainedPrizeIds or {}
		self._typeInfos[v.typeId] = v
	end
end

function DoushouqiModel:getBaseInfo()
	return self._baseInfo
end

function DoushouqiModel:getTypeInfo(chessType)
	return self._typeInfos[chessType]
end

function DoushouqiModel:setMySkillId(skillId)
	self._mySkillId = checknumber(skillId)
end

function DoushouqiModel:getMySkillId()
	return self._mySkillId
end

function DoushouqiModel:setGameStartInfo(msg)
	self._isRobot = msg.isRobot
	self._opSkillId = checknumber(msg.opSkillId)
	self._opHeadInfo = msg.opHeadInfo

	self:setMapInfo(msg.map)
	self:setCurActionId(msg.actionId)
end

function DoushouqiModel:setMapInfo(mapInfo)
	self._mySideId = -1
	self._mapInfo = mapInfo

	local userId = checknumber(RoleModel.instance:getUserId())

	for i, v in ipairs(mapInfo.players) do
		if checknumber(v.userId) == userId then
			self._mySideId = v.side

			break
		end
	end
end

function DoushouqiModel:getMapInfo()
	return self._mapInfo
end

function DoushouqiModel:setCurActionId(actionId)
	self._curActionId = actionId
end

function DoushouqiModel:getCurActionId()
	return self._curActionId
end

function DoushouqiModel:getOpHeadInfo()
	return self._opHeadInfo
end

function DoushouqiModel:getIsRobot()
	return self._isRobot
end

function DoushouqiModel:getOpSkillId()
	return self._opSkillId
end

function DoushouqiModel:setCurChessType(chessType)
	self._curChessType = chessType
end

function DoushouqiModel:getCurChessType()
	return self._curChessType
end

function DoushouqiModel:setNextMapInfo(mapInfo)
	self._nextMapInfo = mapInfo
end

function DoushouqiModel:getNextMapInfo()
	return self._nextMapInfo
end

function DoushouqiModel:setNextMapInfoToCur()
	if self._nextMapInfo then
		printInfo("doushouqi 更新地图数据")
		self:setMapInfo(self._nextMapInfo)

		self._nextMapInfo = nil
	end
end

function DoushouqiModel:getMySideId()
	return self._mySideId
end

function DoushouqiModel:useSkillSuccess()
	local mapInfo = self:getMapInfo()
	local userId = checknumber(RoleModel.instance:getUserId())

	for i, v in ipairs(mapInfo.players) do
		if checknumber(v.userId) == userId then
			v.usedSkill = true

			break
		end
	end
end

function DoushouqiModel:onFinishNewHand(chessType)
	local info = self:getTypeInfo(chessType)

	info.finishNewHand = true
end

function DoushouqiModel:isGainPrize(activityId, chessType, prizeId)
	local info = self:getTypeInfo(chessType)

	for i, v in ipairs(info.gainedPrizeIds) do
		if v == prizeId then
			return true
		end
	end
end

function DoushouqiModel:isCanGainPrize(activityId, chessType, prizeId)
	local info = self:getTypeInfo(chessType)
	local cfg = DoushouqiConfig.instance:getPrizeCfg(activityId, chessType, prizeId)

	return info.score >= cfg.needScore
end

function DoushouqiModel:onGainPrize(activityId, chessType, prizeId)
	local info = self:getTypeInfo(chessType)

	if not table.indexof(info.gainedPrizeIds, prizeId) then
		table.insert(info.gainedPrizeIds, prizeId)
	end
end

function DoushouqiModel:resetBeforeStartGame()
	self._mySideId = -1
	self._nextMapInfo = nil
end

DoushouqiModel.instance = DoushouqiModel.New()

return DoushouqiModel
