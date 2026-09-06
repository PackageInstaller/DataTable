-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/model/XiaYinCustomFmtMo.lua

module("logic.extensions.xiayin.model.XiaYinCustomFmtMo", package.seeall)

local XiaYinCustomFmtMo = class("XiaYinCustomFmtMo", BaseCustomFmtMo)

function XiaYinCustomFmtMo:initParams(activityId, curTier, creepsMasterId, levelIndex, tagView)
	self._activityId = activityId
	self._curTier = curTier
	self._creepsMasterId = creepsMasterId
	self._levelIndex = levelIndex
	self._monsterCfg = XiaYinConfig.instance:getMonsterCfg(creepsMasterId)
	self._creepsCfgs = XiaYinConfig.instance:getCreeps(creepsMasterId)
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.WinDesc

	self:setFormCondition(self._monsterCfg.formCondition)

	self._tagView = tagView
end

function XiaYinCustomFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		BattleFacade.instance:startXiaYinBattle(self._activityId, self._creepsMasterId)
		XiaYinAgent.instance:sendPM_XiaYinChallengeReq(self._activityId, self._curTier, self._levelIndex, form)
	end

	self:setFightHandler(handler, nil)
end

function XiaYinCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function XiaYinCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function XiaYinCustomFmtMo:getExtendViewName()
	return self._tagView
end

function XiaYinCustomFmtMo:getCreepsMasterId()
	return self._creepsMasterId
end

return XiaYinCustomFmtMo
