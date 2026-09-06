-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/role/model/CardInfoMo.lua

module("logic.extensions.role.model.CardInfoMo", package.seeall)

local CardInfoMo = class("CardInfoMo")

function CardInfoMo:ctor(cardBelong)
	self._cardBelong = cardBelong
	self.userName = ""
	self.userId = 0
	self.zoneId = -1
	self.zoneName = ""
	self.warriorTowerCurPhase = 0
	self.kingRoads = {}
	self.maxZdl = 0
	self.petCount = 0
	self.gender = 0
	self.clothes = {}
	self.illusionCutePetRace = 0
	self.petFullLevelCount = 0
	self.playerMessageSkinId = 0
	self.arenaInfo = {
		rank = 0,
		topGroupId = 0
	}
	self.curTitleId = 0
	self.loginDays = 0
	self.playerExp = 0
	self.maxPlotChapterId = 0
	self.maxPlotStageId = 0
	self.badgeNum = 0
	self.badgeIds = {}
	self.headIconId = 0
	self.headFrameId = 0
	self.vipLv = 0
	self.mountId = 0
	self.moralVal = 100
	self.charmValue = 0
	self.petTitleNum = 0
	self.petTitles = {}
	self.peakTournamentInfo = {
		qualifierLevelId = 0,
		isGlobal = false,
		activityId = 0,
		knockoutRank = 0
	}
	self.location = ""
	self._favourPetIds = {}
	self._favourPetMosOfOther = {}
	self.familyBattleZoneRank = 0
	self.familyBattleSpaceRank = 0
	self.achievementRank = 0
	self.spaceMaxZdlRank = 0
end

function CardInfoMo:setMyCardPetTitles(petTitleIds)
	self.petTitles = petTitleIds
end

function CardInfoMo:setData(msg)
	self.zoneId = msg.zoneId
	self.zoneName = msg.zoneName
	self.warriorTowerCurPhase = msg.warriorTowerCurPhase
	self.kingRoads = {}

	if msg.kingRoads then
		for i, v in ipairs(msg.kingRoads) do
			table.insert(self.kingRoads, v)
		end
	end

	self.maxZdl = msg.maxZdl
	self.petCount = msg.petCount
	self.petFullLevelCount = msg.petFullLevelCount
	self.playerMessageSkinId = checknumber(msg.playerMessageSkinId)
	self.arenaInfo = {
		rank = 0,
		topGroupId = 0
	}

	if msg.arenaInfo then
		self.arenaInfo = {
			topGroupId = msg.arenaInfo.topGroupId,
			rank = msg.arenaInfo.rank
		}
	end

	self.peakTournamentInfo = {
		qualifierLevelId = 0,
		isGlobal = false,
		activityId = 0,
		knockoutRank = 0
	}

	if msg.peakTournamentInfo then
		self.peakTournamentInfo = {
			activityId = msg.peakTournamentInfo.activityId,
			qualifierLevelId = msg.peakTournamentInfo.qualifierLevelId,
			knockoutRank = msg.peakTournamentInfo.knockoutRank,
			isGlobal = msg.peakTournamentInfo.isGlobal
		}
	end

	self.clothes = GameUtil.pbToTable(msg.clothes) or self.clothes
	self.gender = msg.gender
	self.curTitleId = msg.curTitleId
	self.illusionCutePetRace = msg.illusionCutePetRace
	self.loginDays = msg.loginDays
	self.playerExp = msg.playerExp
	self.maxPlotChapterId = msg.maxPlotChapterId
	self.maxPlotStageId = msg.maxPlotStageId
	self.badgeNum = msg.badgeNum
	self.badgeIds = msg.badgeIds
	self.headIconId = msg.headIconId
	self.headFrameId = msg.headFrameId
	self.vipLv = msg.vipLv
	self.mountId = msg.mountId
	self.moralVal = msg.moralVal
	self.charmValue = msg.charmValue
	self.petTitleNum = msg.petTitleNum
	self.petTitles = msg.petTitles
	self.location = msg.location
	self.familyBattleZoneRank = msg.familyBattleZoneRank
	self.familyBattleSpaceRank = msg.familyBattleSpaceRank
	self.kingArenaHistoryBestRank = msg.kingArenaHistoryBestRank
	self.achievementRank = msg.achievementRank
	self.spaceMaxZdlRank = msg.spaceMaxZdlRank

	if self._cardBelong == RoleModel.CardBelong.My then
		for _, v in ipairs(msg.myFavourPetIds) do
			self:setFavourPetIds(v, true)
		end
	elseif self._cardBelong == RoleModel.CardBelong.Other then
		for _, v in ipairs(msg.favourPets) do
			local mo = BagPetMo.New()

			mo:initBaseView(v)

			self._favourPetMosOfOther[v.petId] = mo

			self:setFavourPetIds(v.petId, true)
		end
	end
end

function CardInfoMo:getIsMe()
	return tostring(self.userId) == tostring(LoginModel.instance.userId)
end

function CardInfoMo:getFavourPetCount()
	return #self:getFavourPetIds()
end

function CardInfoMo:getFavourPetIds()
	return self._favourPetIds or {}
end

function CardInfoMo:setFavourPetIds(petId, isAdd)
	local newRaceId = self:getRaceIdOfFavour(petId)

	if self._favourPetIds == nil then
		self._favourPetIds = {}
	end

	if isAdd then
		local isHave = false

		for idx, id in ipairs(self._favourPetIds) do
			local petMoTemp = self:getPetMoOfFavour(id)

			if newRaceId > 0 and (petMoTemp and petMoTemp:getDefineId() or 0) == newRaceId then
				isHave = true
				self._favourPetIds[idx] = petId

				break
			end
		end

		if not isHave then
			table.insert(self._favourPetIds, petId)
		end
	else
		self._favourPetMosOfOther[petId] = nil

		table.removebyvalue(self._favourPetIds, petId)
	end

	local list = {}

	for _, petId in ipairs(self._favourPetIds) do
		local petMo = self:getPetMoOfFavour(petId)

		if petMo == nil or not petMo:isExist() then
			table.insert(list, petId)
		end
	end

	for i, v in ipairs(list) do
		self._favourPetMosOfOther[v] = nil

		table.removebyvalue(self._favourPetIds, v)
	end
end

function CardInfoMo:isHaveFavourPet(petId)
	return table.indexof(self:getFavourPetIds(), petId) ~= false
end

function CardInfoMo:isHaveFavourPetOfRace(raceId)
	local isHave = false
	local petIdList = self:getFavourPetIds()

	for _, petId in ipairs(petIdList) do
		if self:getRaceIdOfFavour(petId) == raceId then
			isHave = true
		end
	end

	return isHave
end

function CardInfoMo:getPetMoOfFavour(petId)
	if self._cardBelong == RoleModel.CardBelong.My then
		return BagModel.instance:getPet(petId)
	elseif self._cardBelong == RoleModel.CardBelong.Other then
		return self._favourPetMosOfOther[petId]
	end
end

function CardInfoMo:getRaceIdOfFavour(petId)
	local petMo = self:getPetMoOfFavour(petId)

	return petMo and petMo:getDefineId() or 0
end

return CardInfoMo
