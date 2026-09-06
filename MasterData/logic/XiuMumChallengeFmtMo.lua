-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiumumchallenge/model/XiuMumChallengeFmtMo.lua

module("logic.extensions.xiumumchallenge.model.XiuMumChallengeFmtMo", package.seeall)

local XiuMumChallengeFmtMo = class("XiuMumChallengeFmtMo", ICustomFmtMo)

function XiuMumChallengeFmtMo:initParams(blockId, creepsMasterId, gameViewName)
	self._blockId = blockId
	self._gameViewName = gameViewName
	self._masterList = XiuMumChallengeConfig.instance:getMostersCfgById(creepsMasterId)
	self._creepsCfg = XiuMumChallengeConfig.instance:getFormationCfgById(creepsMasterId)
	self.topTitleStr = self._creepsCfg.name
	self.ruleDescStr = self._creepsCfg.WinDesc
end

function XiuMumChallengeFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(self._gameViewName, true)
		XiuMumChallengeController.instance:startChallenge(self._blockId, self:getCurFormation())
	end

	self:setFightHandler(handler, nil)
end

function XiuMumChallengeFmtMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function XiuMumChallengeFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function XiuMumChallengeFmtMo:getMonsterConfigList()
	return self._masterList
end

function XiuMumChallengeFmtMo:getFmtInfoConfig()
	return self._creepsCfg
end

function XiuMumChallengeFmtMo:checkPetIsForbit(petMo)
	if XiuMumChallengeModel.instance:checkPetHpInfo(petMo.raceId) == 0 then
		return true
	end

	return false
end

return XiuMumChallengeFmtMo
