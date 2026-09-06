-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/model/JumpFloorModel.lua

module("logic.extensions.jumpfloor.model.JumpFloorModel", package.seeall)

local JumpFloorModel = class("JumpFloorModel", BaseModel)

JumpFloorModel.LevelMode = 1
JumpFloorModel.EndlessMode = 2

function JumpFloorModel:ctor()
	return
end

function JumpFloorModel:onInit()
	self:onReset()
end

function JumpFloorModel:onReset()
	self._activityId = 0
	self._dailyFinishNum = 0
	self._finishNum = 0
	self._endlessMaxNum = 0
	self._endlessMaxPercent = 0
	self._encryptedKey = 0
	self._stageId = 0
	self._changeSetId = 0
	self._result = -1
	self._rankList = {}
	self._rankSize = 0
	self._myRank = -1
	self._value = 0
end

function JumpFloorModel:refreshOnChangeDate()
	self._dailyFinishNum = 0
end

function JumpFloorModel:onDancingLionJumpGetInfoRes(msg)
	self._dailyFinishNum = msg.dailyFinishNum
	self._finishNum = msg.finishNum
	self._endlessMaxNum = msg.infiniteValure
	self._endlessMaxPercent = Mathf.Max(msg.infiniteRank, 0)
end

function JumpFloorModel:onDancingLionJumpGameStartRes(msg)
	self._encryptedKey = msg.encryptedKey
end

function JumpFloorModel:onDancingLionJumpGameEndRes(msg)
	self._stageId = msg.stageId or 0
	self._changeSetId = msg.changeSetId or 0
	self._result = msg.result or -1

	if msg:HasField("changeSetId") and msg.changeSetId > 0 then
		self._finishNum = Mathf.Max(self._finishNum, msg.stageId)
		self._dailyFinishNum = self._dailyFinishNum + 1
	end
end

function JumpFloorModel:onDancingLionJumpGetRankRes(msg)
	self._rankList = msg.rankList
	self._rankSize = msg.rankSize
	self._myRank = msg.myRank or -1
	self._value = msg.value or 0
end

function JumpFloorModel:getActivityId()
	if self._activityId == 0 then
		local cfg = ActivityDefineController.instance:getActivityCfgByType(self:getActivityType())

		self._activityId = cfg and cfg.activityId or 235001
	end

	return self._activityId
end

function JumpFloorModel:getActivityType()
	return GameEnum.ActivityType.DANCING_LION_JUMP
end

function JumpFloorModel:getFinishNum()
	return self._finishNum
end

function JumpFloorModel:getDailyFinishNum()
	return self._dailyFinishNum
end

function JumpFloorModel:getEndlessMaxNum()
	return self._endlessMaxNum
end

function JumpFloorModel:getEndlessMaxPercent()
	return self._endlessMaxPercent
end

function JumpFloorModel:isStagePass(stageId)
	local finishNum = self:getFinishNum()

	return stageId <= finishNum
end

function JumpFloorModel:getEncryptedKey()
	return self._encryptedKey
end

function JumpFloorModel:getRankList()
	return self._rankList or {}
end

function JumpFloorModel:getMyRank()
	return self._myRank
end

JumpFloorModel.instance = JumpFloorModel.New()

return JumpFloorModel
