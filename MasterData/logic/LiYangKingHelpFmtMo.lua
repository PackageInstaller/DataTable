-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/model/LiYangKingHelpFmtMo.lua

module("logic.extensions.liyangking.model.LiYangKingHelpFmtMo", package.seeall)

local LiYangKingHelpFmtMo = class("LiYangKingHelpFmtMo", BaseCustomFmtMo)

function LiYangKingHelpFmtMo:initParams(activityId, otherUserId, helpId, positionInfo)
	self.activityId = activityId
	self.otherUserId = otherUserId
	self.helpId = helpId

	local cfgId = positionInfo.id
	local exploreStarCfg = LiYangKingConfig.instance:getChapter3ExploreStarCfg(self.activityId, cfgId)

	self.creepId = exploreStarCfg.creepsMasterId
	self.curPosId = positionInfo.positionId
	self.creeps = LiYangKingConfig.instance:getTeamCfg(self.creepId)
	self.masterCfg = LiYangKingConfig.instance:getCreepCfgs(self.creepId)

	self:setFormCondition(self.creeps.formCondition)
end

function LiYangKingHelpFmtMo:getMonsterConfigList()
	return self.masterCfg
end

function LiYangKingHelpFmtMo:getFmtInfoConfig()
	return self.creeps
end

function LiYangKingHelpFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		LiYangKingController.instance:sendPM_PrinceLiyangClgHelpClgReq(self.activityId, self.otherUserId, self.helpId, self.curPosId, self:getCurSimpleForm())
	end, nil)
end

return LiYangKingHelpFmtMo
