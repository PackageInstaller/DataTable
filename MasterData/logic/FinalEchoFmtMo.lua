-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/finalecho/model/FinalEchoFmtMo.lua

module("logic.extensions.finalecho.model.FinalEchoFmtMo", package.seeall)

local FinalEchoFmtMo = class("FinalEchoFmtMo", BaseCustomFmtMo)

function FinalEchoFmtMo:initParams(activityId, bossId)
	self._activityId = activityId
	self._bossId = bossId
	self._bossCfgs = FinalEchoConfig.instance:getBossCfgsById(self._activityId)

	local creepsMasterId = self._bossCfgs[self._bossId].creepsMasterId

	self._masterData = FinalEchoConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = FinalEchoConfig.instance:getCreepCfgs(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function FinalEchoFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		FinalEchoController.instance:startFight(self._activityId, self._bossId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function FinalEchoFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function FinalEchoFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function FinalEchoFmtMo:getFmtInfoConfig()
	return self._masterData
end

return FinalEchoFmtMo
