-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkmissionFmtView.lua

module("logic.extensions.pk.view.PkmissionFmtView", package.seeall)

local PkmissionFmtView = class("PkmissionFmtView", MissionFmtView)

function PkmissionFmtView:_refreshFromation()
	local monsterCo = self:_getMonsterCo()
	local teams, formations = self:getTeamAndFormation()

	self:_createExtParams(formations)

	local heroSkillId = self:getheroSkillId(monsterCo, teams)
	local fid, flvl = self:GetFormStrengthIdAndLv()

	self:initFormation(formations, teams, heroSkillId, fid, flvl)
end

function PkmissionFmtView:_createExtParams(formations)
	PkmissionFmtView.super._createExtParams(self, formations)

	local fmo = TraincampqiecuoModel.instance:getDefenseForm()

	self._summonMasterPetId = fmo:GetSummonMasterPetId()
	self._summonedPetId = fmo:GetSummonPetId()
end

function PkmissionFmtView:getCurElementRelationMap()
	return TraincampqiecuoModel.instance:getDefenseForm():getCurElementRelationMap()
end

function PkmissionFmtView:getTeamAndFormation()
	local teams = {}
	local formations = {}
	local formationPoses = TraincampqiecuoModel.instance:getDefenseForm():GetPositions()
	local petsView = TraincampqiecuoModel.instance:getDefensePetSimple()

	for i = 1, 9 do
		local petInfo

		for j, pet in ipairs(petsView) do
			if pet.petId == formationPoses[i] then
				petInfo = pet

				break
			end
		end

		if petInfo then
			local petMo = BagPetMo.New()

			petMo:initBaseView(petInfo)

			local petCo = CharacterConfig.instance:getPetCo(petMo.raceId)

			petMo.creepName = petCo.name
			petMo.position = i

			table.insert(teams, petMo)

			formations[i] = petMo
		end
	end

	return teams, formations
end

function PkmissionFmtView:_onClickPsychicSkill()
	local skillId = self:_getPsychicedSkillId()

	if checknumber(skillId) == 0 then
		FloatWordMgr.instance:show(lang("阵上没有通灵师"))

		return
	end

	local petDatas = {}
	local formationPoses = TraincampqiecuoModel.instance:getDefenseForm():GetPositions()
	local petsView = TraincampqiecuoModel.instance:getDefensePetSimple()

	for i = 1, 9 do
		local petInfo

		for j, pet in ipairs(petsView) do
			if pet.petId == formationPoses[i] then
				petInfo = pet

				break
			end
		end

		if petInfo then
			local petCo = PetSkinConfig.instance:getPetSkinCfg(petInfo.curFaceId)

			if petCo.psychicSkillId == skillId then
				local bagPet = BagPetMo.New()

				bagPet:initBaseView(petInfo)
				table.insert(petDatas, bagPet)

				break
			end
		end
	end

	ViewMgr.instance:open(ViewName.MissionPsychicsedSkills, skillId, petDatas, true)
end

function PkmissionFmtView:_getMonsterCo()
	return TraincampqiecuoModel.instance:getDefenseFormExtParams()
end

function PkmissionFmtView:GetFormStrengthIdAndLv()
	local fid = 0
	local flvl = 0
	local info = TraincampqiecuoModel.instance:getDefenseForm():GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flvl = info.formStrengthLv
	end

	return fid, flvl
end

return PkmissionFmtView
