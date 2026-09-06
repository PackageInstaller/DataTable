-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originorderdragonclg/model/OriginOrderDragonClgFmtMo.lua

module("logic.extensions.originorderdragonclg.model.OriginOrderDragonClgFmtMo", package.seeall)

local OriginOrderDragonClgFmtMo = class("OriginOrderDragonClgFmtMo", BaseCustomFmtMo)

function OriginOrderDragonClgFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId
	self.stageCfg = OriginOrderDragonClgConfig.instance:getStageCfgById(self.activityId, self.stageId)

	local creepsMasterId = self.stageCfg.creepsMasterId

	self._masterData = OriginOrderDragonClgConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = OriginOrderDragonClgConfig.instance:getCreepCfgs(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
	self._lockedPetMap = {}

	local infoMap = OriginOrderDragonClgModel.instance:getStageInfoMap(self.activityId) or {}

	for _, stageInfo in pairs(infoMap) do
		if stageInfo.stageId ~= self.stageId then
			if not stageInfo.raceIds then
				for i, raceId in ipairs(stageInfo.raceIds) do
					self._lockedPetMap[checknumber(raceId)] = true
				end
			end
		end
	end

	self:tryInitPetList()
end

function OriginOrderDragonClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginOrderDragonClgController.instance:fight(self.activityId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginOrderDragonClgFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function OriginOrderDragonClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginOrderDragonClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginOrderDragonClgFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedPetMap[petMo.raceId])
end

function OriginOrderDragonClgFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已被锁定")
end

return OriginOrderDragonClgFmtMo
