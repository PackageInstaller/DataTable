-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/controller/RecommendFmtController.lua

module("logic.extensions.recommendfmt.controller.RecommendFmtController", package.seeall)

local RecommendFmtController = class("RecommendFmtController", BaseController)

RecommendFmtController.PetSummaryClickPet = "petsummaryclickpet"

function RecommendFmtController:ctor()
	RecommendFmtController.super.ctor(self)
end

function RecommendFmtController:onInit()
	self:onReset()
end

function RecommendFmtController:onReset()
	return
end

function RecommendFmtController:sendGetInfo()
	RecommendFormAgent.instance:sendPM_RecommendFormGetInfoReq()
end

function RecommendFmtController:onRecommendFormGetInfo(msg)
	RecommendFmtModel.instance:onRecommendFormGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RecommendFormGetInfo)
end

function RecommendFmtController:sendGetRank()
	RecommendFormAgent.instance:sendPM_RecommendFormViewRankReq(1, 100)
end

function RecommendFmtController:onRecommendFormGetRank(msg)
	RecommendFmtModel.instance:onRecommendFormGetRank(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RecommendFormGetInfo)
	GlobalDispatcher:dispatch(GlobalNotify.RecommendFormGetRank)
end

function RecommendFmtController:getFakeFmtPetRaceId(petId)
	if petId > 0 then
		local petMo = RecommendFmtModel.instance:getPetMax(petId)

		if petMo then
			return petMo.raceId
		end
	end

	return 0
end

function RecommendFmtController:getBagPetRaceId(petId)
	if petId > 0 then
		local petMo = BagModel.instance:getBagPetById(petId)

		if petMo then
			return petMo.raceId
		end
	end

	return 0
end

function RecommendFmtController:sendCheckMaxFmt()
	local actid = RecommendFmtModel.instance.activityId
	local posList = RecommendFmtModel.instance.posList
	local tmpList = {}
	local allPets = BagPetsController.instance:getBagPets()

	for k, v in pairs(posList) do
		local raceId = v.raceId

		for i, v in pairs(allPets) do
			if v.raceId == raceId then
				table.insert(tmpList, v)
			end
		end
	end

	ArraySort.sortOn(tmpList, "getFightingPower", ArraySort.DESCENDING)

	local hasNoPet = true
	local map = {}
	local teams = {}
	local simpleForm = FormationExtension_pb.PM_SimpleForm()

	for i = 1, 9 do
		local petMo = posList[i]
		local bagPetId = 0
		local summonRaceId = 0
		local masterRaceId = 0

		if petMo then
			local isSummonMaster = petMo.summonedPetId > 0

			summonRaceId = self:getFakeFmtPetRaceId(petMo.summonedPetId)

			local isSummonPet = petMo.summonMasterId > 0

			masterRaceId = self:getFakeFmtPetRaceId(petMo.summonMasterId)

			local isHasPet = false

			for ii, p in ipairs(tmpList) do
				local sRaceId = self:getBagPetRaceId(p.summonedPetId)
				local mRaceId = self:getBagPetRaceId(p.summonMasterId)

				if p.raceId == petMo.raceId and map[p.petId] == nil then
					isHasPet = true

					if isSummonPet and masterRaceId == mRaceId or isSummonPet == false and mRaceId == 0 then
						map[p.petId] = true

						table.insert(teams, p)

						bagPetId = p.petId

						RecommendFmtModel.instance:updatePetLv(i, p.petId, p.level)

						break
					end
				end
			end

			if isHasPet and bagPetId == 0 then
				local na = MaterialMgr.getMaterialsName(MatType.Pet, petMo.raceId)

				if isSummonPet then
					local na2 = MaterialMgr.getMaterialsName(MatType.Pet, masterRaceId)

					TipsFacade.instance:openCommonTips(langPara("%s必须是契约精灵并且与%s契约关系才能参与检测", na, na2))
				end

				if isSummonMaster == false and isSummonPet == false then
					TipsFacade.instance:openCommonTips(langPara("%s不能作为契约精灵参与检测", na))
				end
			end
		end

		if bagPetId > 0 then
			hasNoPet = false
		end

		simpleForm.pos:append(bagPetId)
	end

	simpleForm.formId = 0

	local heroSkillIs = FightingPowerFormula.instance:getHeroValidSkills(teams)
	local heroID = RecommendFmtModel.instance.curHeroSkillId

	simpleForm.extParams.heroSkillId = heroSkillIs and #heroSkillIs > 0 and (table.indexof(heroSkillIs, heroID) ~= false and heroID or heroSkillIs[1]) or 0

	if hasNoPet then
		TipsFacade.instance:openCommonTips(lang("recommendfmtcontroller__2"))
	end

	RecommendFormAgent.instance:sendPM_RecommendFormUpdateZdlReq(actid, simpleForm)
end

function RecommendFmtController:onUpdateCheckFmt(msg)
	local lastZdl = RecommendFmtModel.instance.curMaxZdl
	local lastRank = RecommendFmtModel.instance.myRank

	RecommendFmtModel.instance:onUpdateCheckFmt(msg)

	if msg.newZdl > checknumber(lastZdl) then
		SurveyController.instance:reportBehavior(200475)
		GlobalDispatcher:dispatch(GlobalNotify.RecommendFormUpdateView, lastZdl, lastRank)
	else
		TipsFacade.instance:openCommonTips(lang("recommendfmtcontroller__3"))
	end
end

RecommendFmtController.instance = RecommendFmtController.New()

return RecommendFmtController
