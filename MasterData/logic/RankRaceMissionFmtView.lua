-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceMissionFmtView.lua

module("logic.extensions.rankrace.view.RankRaceMissionFmtView", package.seeall)

local RankRaceMissionFmtView = class("RankRaceMissionFmtView", MissionFmtView)

function RankRaceMissionFmtView:_refreshFromation()
	local heroSkillId, fid, flv = self:getheroSkillId()
	local teams, formations = self:getTeamAndFormation()

	self:_createExtParams(formations)
	self:initFormation(formations, teams, heroSkillId, fid, flv)
end

function RankRaceMissionFmtView:getheroSkillId()
	local formationMo = RankRaceChallengerModel.instance:getOpFormation()
	local fid, flv = 0, 0
	local info = formationMo:GetFormStrengthInfo()

	if info and info.formStrengthId then
		fid = info.formStrengthId
		flv = info.formStrengthLv
	end

	return formationMo:GetHeroSkillId(), fid, flv
end

function RankRaceMissionFmtView:getCurElementRelationMap()
	local formationMo = RankRaceChallengerModel.instance:getOpFormation()

	if formationMo then
		return formationMo:getCurElementRelationMap()
	end

	return {}
end

function RankRaceMissionFmtView:_getCutePetInfo()
	local formationMo = RankRaceChallengerModel.instance:getOpFormation()
	local cutePetRaceId, cutePetQuality = formationMo:getCutePetInfo()

	return cutePetRaceId, cutePetQuality
end

function RankRaceMissionFmtView:getTeamAndFormation()
	self._tempMasterId = 0
	self._tempSummonId = 0

	local teams = {}
	local formations = {}
	local formationMo = RankRaceChallengerModel.instance:getOpFormation()
	local formationPoses = formationMo:GetPositions()
	local petsView = RankRaceChallengerModel.instance:getAllOpFormationPetInfos()
	local list = {}

	for i = 1, 9 do
		local petInfo = RankRaceChallengerModel.instance:getOpFormationPetInfo(formationPoses[i])

		if petInfo then
			local petMo = BagPetMo.New()

			petMo:initBaseView(petInfo)

			list[i] = petMo

			if checknumber(petMo.summonMasterId) > 0 then
				self._tempSummonId = checknumber(petMo.petId)
			end

			if checknumber(petMo.summonedPetId) > 0 then
				self._tempMasterId = checknumber(petMo.petId)
			end
		end
	end

	for i = 1, 9 do
		local pet = list[i]

		if pet then
			local fPetMo = pet:toFightingPowerPetMo(list)

			table.insert(teams, fPetMo)

			formations[i] = fPetMo
		end
	end

	return teams, formations
end

function RankRaceMissionFmtView:_createExtParams(formations)
	self:setExtParams(RankRaceChallengerModel.instance:getCurExtParams())

	if self._summonMasterPetId == 0 and self._summonedPetId == 0 and checknumber(self._tempMasterId) > 0 and checknumber(self._tempSummonId) > 0 then
		self._summonMasterPetId = checknumber(self._tempMasterId)
		self._summonedPetId = checknumber(self._tempSummonId)
	end
end

function RankRaceMissionFmtView:_selectItem(index)
	if not self._infoSeats[index] then
		return
	end

	local info = self._infoSeats[index]

	if RankRaceController.instance:getCurViewType() == RankRaceController.MatchTypeClassics then
		CommonTipsMgr.instance:showPetTips(info)
	elseif RankRaceController.instance:getCurViewType() == RankRaceController.MatchTypeLimit then
		CommonTipsMgr.instance:showPetTips(FightingPowerPetMo.getMaxPetMoByData(info))
	end
end

return RankRaceMissionFmtView
