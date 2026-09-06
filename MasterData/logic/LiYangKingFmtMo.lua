-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/model/LiYangKingFmtMo.lua

module("logic.extensions.liyangking.model.LiYangKingFmtMo", package.seeall)

local LiYangKingFmtMo = class("LiYangKingFmtMo", BaseCustomFmtMo)

function LiYangKingFmtMo:initParams(activityId, creepsMasterId, posId)
	self.activityId = activityId

	local actCfg = LiYangKingConfig.instance:getActCfg(self.activityId)

	self.lockRackId = actCfg.lockRaceId
	self.creepId = creepsMasterId
	self.curPosId = posId
	self.creeps = LiYangKingConfig.instance:getTeamCfg(self.creepId)
	self.masterCfg = LiYangKingConfig.instance:getCreepCfgs(self.creepId)

	self:setFormCondition(self.creeps.formCondition)
end

function LiYangKingFmtMo:getMonsterConfigList()
	return self.masterCfg
end

function LiYangKingFmtMo:getFmtInfoConfig()
	return self.creeps
end

function LiYangKingFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		LiYangKingController.instance:sendPM_PrinceLiyangClgSelfClgReq(self.activityId, self.curPosId, self:getCurSimpleForm())
	end, nil)
end

return LiYangKingFmtMo
