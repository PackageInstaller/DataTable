-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/model/PhantomSpaceEndlessFmtMo.lua

module("logic.extensions.phantomspace.model.PhantomSpaceEndlessFmtMo", package.seeall)

local PhantomSpaceEndlessFmtMo = class("PhantomSpaceEndlessFmtMo", BaseCustomFmtMo)

function PhantomSpaceEndlessFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId
	self._preFormData = PhantomSpaceModel.instance:getEndlessInfoBystageId(activityId, stageId - 1) or {}
	self.useMaxFightPower = true

	self:_setFmo(self._preFormData)

	self.creepsMasterId = PhantomSpaceConfig.instance:getEndlessCreepsMasterId(activityId)
	self.masterCfg = PhantomSpaceConfig.instance:getMonsterCfgById(self.creepsMasterId) or {}

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
end

function PhantomSpaceEndlessFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		PhantomSpaceController.instance:sendPM_PhantomSpaceChallengeEndlessReq(self.activityId, self.stageId, self:getCurSimpleForm())
	end, nil)
end

function PhantomSpaceEndlessFmtMo:_setFmo(preFormData)
	if not preFormData.form then
		if not preFormData.formPetFaceIds then
			local formPetFaceIds = {}

			self._petMapAsRight = {}

			for idx, pair in ipairs(formPetFaceIds) do
				local petId = 0

				petId = pair.left

				if pair.left > 0 then
					local mo = BagPetsController.instance:getPet(petId)

					if mo then
						local petMo = mo:GetClone()

						if self.useMaxFightPower then
							petMo = FightingPowerPetMo.getMaxPetMoByData(petMo)
						end

						petMo.isMyPackPet = false
						self._petMapAsRight[petId] = petMo
					end
				end
			end

			self._formationMoOfEndless = FormationMO.New(GameUtil.handler(self.getPetMoByIdOfEndless, self))

			self._formationMoOfEndless:SetData(preFormData.form)
		end
	end
end

function PhantomSpaceEndlessFmtMo:getPetMoByIdOfEndless(petId)
	return self._petMapAsRight[petId]
end

function PhantomSpaceEndlessFmtMo:getExtParams()
	return self:getFmtInfoConfig()
end

function PhantomSpaceEndlessFmtMo:getMonsterConfigList()
	return {}
end

function PhantomSpaceEndlessFmtMo:getFmtInfoConfig()
	local simpleForm = self._preFormData.form

	return simpleForm.extParams
end

function PhantomSpaceEndlessFmtMo:getTeamAndFormation(creepCfg)
	local fmtMo = self._formationMoOfEndless
	local teams, formations, speed = fmtMo:getTeamAndFormation()

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

return PhantomSpaceEndlessFmtMo
