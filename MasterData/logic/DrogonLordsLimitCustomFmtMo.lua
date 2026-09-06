-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/model/DrogonLordsLimitCustomFmtMo.lua

module("logic.extensions.dragonlords.model.DrogonLordsLimitCustomFmtMo", package.seeall)

local DrogonLordsLimitCustomFmtMo = class("DrogonLordsLimitCustomFmtMo", ICustomFmtMo)

function DrogonLordsLimitCustomFmtMo:onReset()
	DrogonLordsLimitCustomFmtMo.super.onReset(self)
end

function DrogonLordsLimitCustomFmtMo:initFightHandler()
	local function handler()
		local actId = DrogonLordsModel.instance:getActivityId()
		local curFmo = self:getCurFormation()

		DragonLordsController.instance:sendPM_ExtremeChallengeReq(actId, curFmo)
	end

	self:setFightHandler(handler, nil)
end

function DrogonLordsLimitCustomFmtMo:initPetList()
	local petList = DrogonLordsFightMo.instance:getLimitAllPetList()

	for i, petMo in ipairs(petList) do
		self:addPetToList(petMo)
	end
end

function DrogonLordsLimitCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function DrogonLordsLimitCustomFmtMo:getMonsterConfigList()
	local index = DrogonLordsModel.instance:getCurLimitStage()
	local cfg = DragonLordsConfig.instance:getLimitChallengeCfg(index)

	return DragonLordsConfig.instance:getCreepsMasterById(cfg.creepsMasterId)
end

function DrogonLordsLimitCustomFmtMo:getFmtInfoConfig()
	local index = DrogonLordsModel.instance:getCurLimitStage()
	local cfg = DragonLordsConfig.instance:getLimitChallengeCfg(index)

	return DragonLordsConfig.instance:getCreepsMasterById(cfg.creepsMasterId)
end

function DrogonLordsLimitCustomFmtMo:updateCellTop(cell, petMo)
	local luaCls = TiredView
	local url = TiredView.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local lockPetIds = DrogonLordsModel.instance:getLockPetIds()

		proxy.binder:isTired(table.indexof(lockPetIds, petMo:getPetId()) and true or false)
	end
end

function DrogonLordsLimitCustomFmtMo:clearCellTop(cell)
	DrogonLordsLimitCustomFmtMo.super.clearCellTop(self, cell)
end

function DrogonLordsLimitCustomFmtMo:checkPetIsForbit(petMo)
	local lockPetIds = DrogonLordsModel.instance:getLockPetIds()

	return not not table.indexof(lockPetIds, petMo:getPetId())
end

function DrogonLordsLimitCustomFmtMo:updateData()
	local index = DrogonLordsModel.instance:getCurLimitStage()
	local cfg = DragonLordsConfig.instance:getLimitChallengeCfg(index)
	local teamData = DragonLordsConfig.instance:getTeamData(cfg.creepsMasterId)

	self.isHideFmtZdl = true

	local petList = DrogonLordsFightMo.instance:getLimitAllPetList()

	self.needUpPetCount = 5
	self.ruleDescStr = teamData.levelDescription

	self:setFormCondition(teamData.formCondition)
	self:clearAllPetList()
	self:initFormationMo()
	DrogonLordsFightMo.instance:onReset()
end

return DrogonLordsLimitCustomFmtMo
