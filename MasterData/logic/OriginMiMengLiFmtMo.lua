-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmimengli/model/OriginMiMengLiFmtMo.lua

module("logic.extensions.originmimengli.model.OriginMiMengLiFmtMo", package.seeall)

local OriginMiMengLiFmtMo = class("OriginMiMengLiFmtMo", BaseCustomFmtMo)

function OriginMiMengLiFmtMo:initParams(activityId, stageCfg)
	self.activityId = activityId
	self.stageCfg = stageCfg
	self.stageId = stageCfg.stageId

	local creepsMasterId = self.stageCfg.creepsMasterId

	self._masterData = OriginMiMengLiConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = OriginMiMengLiConfig.instance:getCreepCfgs(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
	self.validatorDescStr = self.stageCfg.fmtTipsDesc or ""

	self:tryInitPetList()
	self:clearAllFixedEffects()

	local actCfg = OriginMiMengLiConfig.instance:getActCfgByActId(self.activityId) or {}

	if not actCfg.dreamEffPath then
		local dreamEffPath = ""

		if not GameUtil.isEmptyString(dreamEffPath) then
			local trueDreamEffPath = dreamEffPath .. ".prefab"

			if not self.stageCfg.DreamPosIds then
				local dreamPosIds = {}

				for _, posId in ipairs(dreamPosIds) do
					self:setFixedEffect(posId, trueDreamEffPath)
				end
			end
		end

		if not actCfg.memoryEffPath then
			local memoryEffPath = ""

			if not GameUtil.isEmptyString(memoryEffPath) then
				local trueMemoryEffPath = memoryEffPath .. ".prefab"

				if not self.stageCfg.MemoryPosIds then
					for _, posId in ipairs(self.stageCfg.MemoryPosIds) do
						self:setFixedEffect(posId, trueMemoryEffPath)
					end
				end
			end
		end
	end
end

function OriginMiMengLiFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginMiMengLiController.instance:challenge(self.activityId, simpleForm, self.stageId)
	end

	self:setFightHandler(handler, nil)
end

function OriginMiMengLiFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function OriginMiMengLiFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginMiMengLiFmtMo:getFmtInfoConfig()
	return self._masterData
end

return OriginMiMengLiFmtMo
