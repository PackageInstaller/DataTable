-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mississi/MississiCustomFmtMo.lua

module("logic.extensions.timelimitedchallenge.view.mississi.MississiCustomFmtMo", package.seeall)

local MississiCustomFmtMo = class("MississiCustomFmtMo", ICustomFmtMo)

function MississiCustomFmtMo:initParams(cfg, viewName1, viewName2, tipsKey)
	self._viewName1 = viewName1
	self._viewName2 = viewName2
	self._tipsKey = tipsKey
	self._stageCfg = cfg

	if self._stageCfg then
		self._creepsCfg = MississiConfig.instance:getCreepsMasterCfg(self._stageCfg.creepsMasterId)
		self._masterList = MississiConfig.instance:getCreepsCfg(self._stageCfg.creepsMasterId)
		self.topTitleStr = self._creepsCfg.name
		self.ruleDescStr = self._creepsCfg.WinDesc

		self:setFormCondition(self._creepsCfg.formCondition)
	end
end

function MississiCustomFmtMo:initFightHandler()
	local function handler()
		BattleFacade.instance:startBattle(GameEnum.MissionType.CYNTHIA)

		local ctrl = MississiController.instance

		BattleFacade.instance:registerResultHandler(GameUtil.handler(ctrl.onBattleEnd, ctrl, self._tipsKey))
		UIJumper.instance:pushOneStack(self._viewName1, true)
		UIJumper.instance:pushOneStack(self._viewName2, true)
		MississiController.instance:startChallenge(self._stageCfg.teamId, self:getCurSimpleForm())
	end

	self:setFightHandler(handler, nil)
end

function MississiCustomFmtMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function MississiCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function MississiCustomFmtMo:getMonsterConfigList()
	return self._masterList
end

function MississiCustomFmtMo:getFmtInfoConfig()
	return self._creepsCfg
end

return MississiCustomFmtMo
