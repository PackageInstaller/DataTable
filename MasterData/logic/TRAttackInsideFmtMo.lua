-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/model/mo/TRAttackInsideFmtMo.lua

module("logic.extensions.treasureraider.model.mo.TRAttackInsideFmtMo", package.seeall)

local TRAttackInsideFmtMo = class("TRAttackInsideFmtMo", ICustomFmtMo)

function TRAttackInsideFmtMo:onReset()
	TRAttackInsideFmtMo.super.onReset(self)
end

function TRAttackInsideFmtMo:initParams(gridId, formationData, buildingMo, sceneMo)
	self._gridId = gridId
	self._buildingMo = buildingMo
	self._sceneMo = sceneMo
	self._formationData = formationData

	self.formationMo:SetData(formationData)
	self:clearAllPetList()
end

function TRAttackInsideFmtMo:initPetList()
	self:clearAllPetList()

	if self._formationData and self._formationData.pos then
		for posId, petId in ipairs(self._formationData.pos) do
			if checknumber(petId) > 0 then
				local petMo = BagPetsController.instance:getPet(petId)

				self:addPetToList(petMo)
			end
		end
	end
end

function TRAttackInsideFmtMo:getMonsterConfigList()
	return {}
end

function TRAttackInsideFmtMo:getFmtInfoConfig()
	local jumpBattleTime = TreasureRaiderConfig.instance:getCommonValue("JumpBattle", true)

	return {
		skipTime = jumpBattleTime
	}
end

function TRAttackInsideFmtMo:getTeamAndFormation(creepCfg)
	local teams = {}
	local formations = {}
	local formationData = self._sceneMo:getFormationByBuildingId(self._buildingMo.buildingId)

	if formationData and formationData.pos then
		for posId, petId in ipairs(formationData.pos) do
			if checknumber(petId) > 0 then
				local petMo = self._sceneMo:getPetFromOwnerPetMoMap(petId)

				if petMo then
					local petMoFightingMo = petMo:toFightingPowerPetMo()

					table.insert(teams, petMoFightingMo)

					formations[posId] = petMoFightingMo
				end
			end
		end
	end

	return teams, formations
end

function TRAttackInsideFmtMo:initFightHandler()
	local function handler()
		TreasureRaiderController.instance:reqAttack(self:getCurSimpleForm(), self._gridId)
	end

	self:setFightHandler(handler, nil)
end

function TRAttackInsideFmtMo:initSaveHandler()
	return
end

return TRAttackInsideFmtMo
