-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/model/FunCampCustomFmtMo.lua

module("logic.extensions.funcamp.model.FunCampCustomFmtMo", package.seeall)

local FunCampCustomFmtMo = class("FunCampCustomFmtMo", ICustomFmtMo)

function FunCampCustomFmtMo:onReset()
	FunCampCustomFmtMo.super.onReset(self)

	self.isShowBtnCutePet = false
end

function FunCampCustomFmtMo:initFightHandler()
	local function handler()
		local actId = FunCampModel.instance:getActivityId()
		local curFmo = self:getCurFormation()

		FunCampController.instance:sendPM_CB_FightReq(actId, curFmo)
	end

	self:setFightHandler(handler, nil)
end

function FunCampCustomFmtMo:initPetList()
	local petList = FunCampFightMo.instance:GetAllPetList()

	for i, petMo in ipairs(petList) do
		self:addPetToList(petMo)
	end
end

function FunCampCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function FunCampCustomFmtMo:getMonsterConfigList()
	local sceneId = FunCampModel.instance:getCurSceneId()
	local npcId = FunCampModel.instance:getCurId()
	local creepsMasterId = FunCampNpcConfig.instance:getCreepsMasterId(sceneId, npcId)

	return FunCampNpcConfig.instance:getPetCreeps(creepsMasterId)
end

function FunCampCustomFmtMo:getFmtInfoConfig()
	local sceneId = FunCampModel.instance:getCurSceneId()
	local npcId = FunCampModel.instance:getCurId()
	local creepsMasterId = FunCampNpcConfig.instance:getCreepsMasterId(sceneId, npcId)

	return FunCampNpcConfig.instance:getPetCreeps(creepsMasterId)
end

function FunCampCustomFmtMo:initFormationMo()
	self.formationMo = FunCampFightMo.instance:GetCurFormation(FormationMO.New(GameUtil.handler(self.getPetMoById, self)))
end

function FunCampCustomFmtMo:updateData()
	local sceneId = FunCampModel.instance:getCurSceneId()
	local npcId = FunCampModel.instance:getCurId()
	local creepsMasterId = FunCampNpcConfig.instance:getCreepsMasterId(sceneId, npcId)
	local teamData = FunCampNpcConfig.instance:getTeamInfo(creepsMasterId)

	self.isHideFmtZdl = true

	local petList = FunCampFightMo.instance:GetAllPetList()

	self.needUpPetCount = 5
	self.topTitleStr = teamData.name
	self.ruleDescStr = teamData.levelDescription

	self:setFormCondition(teamData.formCondition)
	self:clearAllPetList()
end

return FunCampCustomFmtMo
