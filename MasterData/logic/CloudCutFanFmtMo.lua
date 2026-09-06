-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cloudcutfan/model/CloudCutFanFmtMo.lua

module("logic.extensions.cloudcutfan.model.CloudCutFanFmtMo", package.seeall)

local CloudCutFanFmtMo = class("CloudCutFanFmtMo", BaseCustomFmtMo)

function CloudCutFanFmtMo:initParams(activityId, isPreView)
	self.activityId = activityId
	self.isPreView = isPreView

	local actCfg = CloudCutFanConfig.instance:getActCfgByActId(activityId) or {}

	if not actCfg.creepsMasterId then
		local creepsMasterId = 0

		self._masterData = CloudCutFanConfig.instance:getTeamCfg(self.activityId, creepsMasterId)
		self._creepsCfg = CloudCutFanConfig.instance:getCreepCfgs(creepsMasterId)
		self.topTitleStr = self._masterData.name
		self.ruleDescStr = self._masterData.ruleDesc

		self:tryInitPetList()
	end
end

function CloudCutFanFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		CloudCutFanController.instance:bossClg(self.activityId, self.isPreView, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function CloudCutFanFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function CloudCutFanFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function CloudCutFanFmtMo:getFmtInfoConfig()
	return self._masterData
end

return CloudCutFanFmtMo
