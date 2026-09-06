-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/model/RankRaceChallengerModel.lua

module("logic.extensions.rankrace.model.RankRaceChallengerModel", package.seeall)

local RankRaceChallengerModel = class("RankRaceChallengerModel", BaseModel)

function RankRaceChallengerModel:onInit()
	self:onReset()
end

function RankRaceChallengerModel:onReset()
	self._rankingMatchInfo = nil
	self._formation = nil
end

function RankRaceChallengerModel:notifyBeginGame(info)
	self._rankingMatchInfo = info
	self._matchType = info.matchType

	local pool = {}
	local list = {}

	if info.opFormationView and info.opFormationView.petSimpleView then
		for i, v in ipairs(info.opFormationView.petSimpleView) do
			local bagPet = BagPetMo.New()

			bagPet:initBaseView(v)
			table.insert(list, bagPet)

			pool[bagPet.petId] = bagPet
		end
	end

	self._formation = FormationMO.New(function(petId)
		return pool[petId]
	end)

	self._formation:SetData(info.opFormationView.curForm)
end

function RankRaceChallengerModel:getOpUserId()
	if self._rankingMatchInfo then
		return self._rankingMatchInfo.opUserId
	end
end

function RankRaceChallengerModel:getOpUserName()
	if self._rankingMatchInfo then
		return self._rankingMatchInfo.opHeadInfo.userName
	end
end

function RankRaceChallengerModel:getOpStar()
	if self._rankingMatchInfo then
		return self._rankingMatchInfo.opStar
	end
end

function RankRaceChallengerModel:getOpDefenseBuffId()
	if self._rankingMatchInfo then
		return self._rankingMatchInfo.opDefenseBuffId
	end
end

function RankRaceChallengerModel:getHeadInfo()
	return self._rankingMatchInfo.opHeadInfo
end

function RankRaceChallengerModel:getOpIconId()
	if self._rankingMatchInfo then
		return self._rankingMatchInfo.opHeadInfo.headIconId
	end
end

function RankRaceChallengerModel:getOpFrameId()
	if self._rankingMatchInfo then
		return self._rankingMatchInfo.opHeadInfo.headFrameId
	end
end

function RankRaceChallengerModel:getVipLv()
	if self._rankingMatchInfo then
		return self._rankingMatchInfo.opHeadInfo.vipLv
	end
end

function RankRaceChallengerModel:getOpFormationView()
	if self._rankingMatchInfo then
		return self._rankingMatchInfo.opFormationView
	end
end

function RankRaceChallengerModel:getOpFormationPetInfo(petId)
	if not petId or petId == 0 then
		return
	end

	local formationView = self:getOpFormationView()

	if not formationView then
		return
	end

	if not formationView.petSimpleView then
		return
	end

	for i = 1, #formationView.petSimpleView do
		if formationView.petSimpleView[i].petId == petId then
			return formationView.petSimpleView[i]
		end
	end
end

function RankRaceChallengerModel:getAllOpFormationPetInfos()
	local formationView = self:getOpFormationView()

	if not formationView then
		return
	end

	return formationView.petSimpleView
end

function RankRaceChallengerModel:getCurExtParams()
	local formationView = self:getOpFormationView()

	return (formationView and formationView.curForm and formationView.curForm.extParams or nil) and formationView.curForm.extParams
end

function RankRaceChallengerModel:getOpFormation()
	return self._formation
end

function RankRaceChallengerModel:getMatchType()
	if self._rankingMatchInfo then
		return self._rankingMatchInfo.matchType
	end
end

RankRaceChallengerModel.instance = RankRaceChallengerModel.New()

return RankRaceChallengerModel
